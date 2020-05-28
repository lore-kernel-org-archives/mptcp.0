Content-Type: multipart/mixed; boundary="===============9081079835454581590=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 979e8edfb9 ("[DO-NOT-MERGE]
 mptcp: enabled by default") (fwd)
Date: Thu, 28 May 2020 09:04:25 -0700
Message-ID: <alpine.OSX.2.22.394.2005280903580.19117@jhli-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4531

--===============9081079835454581590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Latest self test results - there is an mptcp_join.sh failure in this one.

---------- Forwarded message ----------
Date: Wed, 27 May 2020 22:59:56
From: kernel test robot <lkp(a)intel.com>
To: mathew.j.martineau(a)linux.intel.com
Subject: [kselftest UNSTABLE] mptcp/export 979e8edfb9
     ("[DO-NOT-MERGE] mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/122/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 979e8edfb9a5bcb4eb1e756e140190ff8c681ba0
subject: [DO-NOT-MERGE] mptcp: enabled by default
date   : 2020-05-28 09:07:20 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of 979e8edfb9a5bcb4eb1e756e140190ff8c681ba0 (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-------------------------+------+------+----------+------+---+------------+=
-----+
|                                                                          =
                         | pass | fail | unstable | skip | - | regression |=
 fix |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests                     | 2    | 1    |          |      |   | N/A        |=
 N/A |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts                       | 1588 | 16   |          | 4    |   | N/A        |=
 N/A |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests       | 33   | 8    |          | 1    |   | N/A       =
 | N/A |
| kselftests-netfilter-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/=
x86_64-rhel-7.6-kselftests | 7    | 1    |          |      |   | N/A       =
 | N/A |
| kselftests-cpufreq-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests   | 1    |      |          |      |   |           =
 | N/A |
| kselftests-firmware-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x=
86_64-rhel-7.6-kselftests  | 1    |      |          |      |   |           =
 | N/A |
| kselftests-kvm-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests       | 21   |      |          | 1    |   |           =
 | N/A |
+--------------------------------------------------------------------------=
-------------------------+------+------+----------+------+---+------------+=
-----+

Fails
=3D=3D=3D=3D=3D
kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts
---
- kernel-selftests.net/mptcp.mptcp_join.sh.fail

kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.bpf_iter.fail
- kernel-selftests.bpf.test_progs.bpf_verif_scale.fail
- kernel-selftests.bpf.test_progs.cls_redirect.fail
- kernel-selftests.bpf.test_progs.link_pinning.fail
- kernel-selftests.bpf.test_progs.pinning.fail
- kernel-selftests.bpf.test_progs.test_lsm.fail
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_progs-no_alu32.bpf_iter.fail
- kernel-selftests.bpf.test_progs-no_alu32.link_pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_lsm.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_offload.py.fail
- kernel-selftests.bpf.test_lwt_ip_encap.sh.fail
- kernel-selftests.bpf.test_tc_edt.sh.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.fib_nexthops.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail

kselftests-netfilter-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests
---
- kernel-selftests.netfilter.nft_concat_range.sh.fail


--===============9081079835454581590==--
