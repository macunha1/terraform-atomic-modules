# Terraform Atomic Modules

Implementation of Terraform modules following the [Atomic Design methodology](https://bradfrost.com/blog/post/atomic-web-design)

## Available modules

Ideally, inside each module there is a README containing the description and at
least one usage example.

### AWS (Amazon Web Services)

```
├── atoms
│   └─── aws
│        └── vpn_route
└── molecules
    └── aws
        └── rds_aurora_cluster
```

### GCP (Google Cloud Platform)

```
└── molecules
    └── gcp
        ├── vm
        └── vpc
```

## Contributing

Suggestions, issues and pull requests are welcome!
