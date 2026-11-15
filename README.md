# sim-dsp-infra

Synthetic test fixture. This repository simulates the infrastructure repository of
a fictional ad-tech demand-side platform. The Terraform here has never been applied,
declares no real accounts, and holds no secrets.

It is the unprotected variant used to test a read-only posture product:

- the default branch has no protection at all;
- the Terraform carries deliberate defects (an unencrypted, publicly readable
  bucket; SSH open to the internet; a storage bucket without uniform access);
- the workflow uses mutable action tags and long-lived cloud keys from repository
  secrets, and runs only on manual dispatch, so it never executes by itself.

The secrets the workflow names do not exist.
