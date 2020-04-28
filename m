Content-Type: multipart/mixed; boundary="===============8491166507871281869=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 2ac757e415 ("net: ethernet:
 ti: fix return value check in k3_cppi_desc_pool_create_name()")
Date: Tue, 28 Apr 2020 11:53:41 +0800
Message-ID: <5ea7a8c5.zYyjjKZt00B0iLBp%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4256

--===============8491166507871281869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 2ac757e4152e3322a04a6dfb3d1fa010d3521abf
subject: net: ethernet: ti: fix return value check in k3_cppi_desc_pool_cre=
ate_name()
date   : 2020-04-28 04:27:59 +0800
author : Wei Yongjun <weiyongjun1(a)huawei.com>


Test status of 2ac757e4152e3322a04a6dfb3d1fa010d3521abf (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+
|                                                                          =
                       | pass | fail | unstable | skip | - | regression | f=
ix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts                     | 44   | 4    |          | 3    |   |            |  =
   |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 34   | 7    |          | 1    |   |            |=
     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests                   | 3    |      |          |      |   |            |  =
   |
| kselftests-cpufreq-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests | 1    |      |          |      |   |            |=
     |
| kselftests-kvm-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 20   |      |          | 1    |   |            |=
     |
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail


--===============8491166507871281869==--
