# 🌍 Terraform Multi-State Project

This repository demonstrates how to manage AWS resources using **Terraform** with two different approaches:  
- **count** → used for creating multiple resources in bulk (by index).  
- **for_each** → used for creating resources from maps (key/value pairs).  

The goal is to help understand when to use **count** vs **for_each** while working with AWS infrastructure in Terraform.  

---

## 📂 Project Structure

tf-multi-state/
│
├── count/
│ ├── main.tf
│ ├── providers.tf
│ ├── variables.tf
│ └── terraform.tfvars
│
└── for_each/
├── main.tf
├── providers.tf
├── variables.tf
└── terraform.tfvars

markdown
Copy code

---

## ⚙️ Requirements

- Terraform >= 1.5  
- AWS CLI configured (`aws configure`)  
- AWS account with permissions to create **VPC, Subnets, and EC2 instances**  
- Region used → `ap-south-1`

---

## 🛠️ How It Works

### 🔹 `count` Folder
- Creates **1 VPC**  
- Creates **2 subnets** using `count`  
- Launches **4 EC2 instances** (AMI & instance type from `terraform.tfvars`)  
- Subnet allocation is balanced using `element()`  

➡ Example resource naming:  
- `project-01-subnet-1`  
- `project-01-instance-1`  

---

### 🔹 `for_each` Folder
- Creates **1 VPC**  
- Subnets are created using a **map** (`subnet_map`)  
- EC2 instances are created using a **map** (`ec2_map`)  
- Each resource is named dynamically based on keys in the maps  

➡ Example subnet map from `terraform.tfvars`:  

```hcl
subnet_map = {
  "public_subnet" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  },
  "private_subnet" = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
}
🚀 Usage
1️⃣ Initialize Terraform
bash
Copy code
cd count   # or for_each
terraform init
2️⃣ Validate Code
bash
Copy code
terraform validate
3️⃣ Plan Infrastructure
bash
Copy code
terraform plan
4️⃣ Apply Changes
bash
Copy code
terraform apply -auto-approve
5️⃣ Destroy Resources
bash
Copy code
terraform destroy -auto-approve
🔍 Difference Between count vs for_each
Feature	count	for_each
Use case	Bulk resources with index	Map/dictionary based resources
Indexing	Numerical (count.index)	Key-based (each.key)
Flexibility	Less flexible, tied to order	More flexible, stable keys
Example	count = 2	for_each = var.subnet_map

📌 Outputs
Subnet IDs are exported in the count example.

You can extend this project to add more outputs (EC2 IDs, VPC ID, etc.).

📖 Learning Goals
✅ Understand the difference between count and for_each
✅ Practice Infrastructure as Code (IaC) with AWS
✅ Learn dynamic resource creation with Terraform

🏷️ Tags
Terraform AWS VPC EC2 DevOps IaC for_each count
