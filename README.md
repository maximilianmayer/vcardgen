# vcardgen
Generate a simple Vcard


## required data

To generate a vcard you need to provide vcard data via YAML file. The structure can be taken from the example vcard.yaml. 

```yaml
card:
  name: Your Name
  email: your.mail@address.tld
  tel:
    mobile: '+491710001111'
    fax: '+49890000000'
  company: Your company Ltd.
  department: Department of Department
  title: CEO
  Address: 'Musterweg 123, 99999 Musterdorf, Deutschland'
  url: https://your.website.here

```

# Usage

To generate a vcard provide the vcard data as yaml file.

```bash
 ./vcard.rb <vcard.yaml> 
```


