Content-Type: multipart/mixed; boundary="===============7994207805263380829=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 323e395f19 ("Merge
 git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next")
Date: Thu, 30 Apr 2020 12:28:19 +0800
Message-ID: <5eaa53e3.FkZuf78egcpcmyqu%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4280

--===============7994207805263380829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 323e395f197fd0bc1bf7a7a7e4c67d3d7410f24f
subject: Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
date   : 2020-04-30 05:14:44 +0800
author : David S. Miller <davem(a)davemloft.net>


Test status of 323e395f197fd0bc1bf7a7a7e4c67d3d7410f24f (compared to v5.6)
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
ts                     | 43   | 5    |          | 3    |   |            |  =
   |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 33   | 8    |          | 1    |   |            |=
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
- kernel-selftests.bpf.test_lwt_ip_encap.sh.fail

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


--===============7994207805263380829==--
