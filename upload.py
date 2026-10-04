import os
import getpass
import snowflake.connector

pwd = getpass.getpass("Enter Snowflake password for DEEPDBT: ")

conn = snowflake.connector.connect(
    user='DEEPDBT',
    password=pwd,
    account='XTZPFNS-SXC25261',
    warehouse='COMPUTE_WH',
    database='MAVEN_CANDY_ANALYTICS',
    schema='SILVER'
)

cursor = conn.cursor()

# 1. Clean existing stage contents
print("Clearing stage...")
cursor.execute("REMOVE @MAVEN_CANDY_ANALYTICS.SILVER.dbt_project_stage;")

# 2. Iterate through all files in the project and upload
project_dir = r"C:\Users\DEEPAK\maven_candy_analytics\maven_candy_dbt"

print("Uploading project files to Snowflake stage...")

for root, dirs, files in os.walk(project_dir):
    # Skip target and logs folders to save stage space
    if 'target' in root or 'logs' in root or 'dbt_packages' in root:
        continue
    for file in files:
        if file.endswith('.pyc') or file == 'upload.py':
            continue
            
        full_path = os.path.join(root, file).replace('\\', '/')
        relative_path = os.path.relpath(root, project_dir).replace('\\', '/')
        
        stage_target = "@MAVEN_CANDY_ANALYTICS.SILVER.dbt_project_stage"
        if relative_path != ".":
            stage_target += f"/{relative_path}"
            
        put_sql = f"PUT 'file://{full_path}' {stage_target} AUTO_COMPRESS=FALSE OVERWRITE=TRUE;"
        cursor.execute(put_sql)

print("Upload completed successfully!")

cursor.close()
conn.close()