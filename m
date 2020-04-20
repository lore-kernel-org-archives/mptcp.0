Content-Type: multipart/mixed; boundary="===============8353298785301506994=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 474ece0829 ("tcp: mptcp:
 use mptcp receive buffer space to select rcv window")
Date: Mon, 20 Apr 2020 11:57:24 +0800
Message-ID: <5e9d1da4.WQ32FM8bUCcmWFcM%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4206

--===============8353298785301506994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 474ece0829efb6a3ff213b7258706cc8f0cda3e1
subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
date   : 2020-04-20 09:06:52 +0800
author : Florian Westphal <fw(a)strlen.de>


Test status of 474ece0829efb6a3ff213b7258706cc8f0cda3e1 (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+
|                                                                          =
     | pass | fail | unstable | skip | - | regression | fix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts   | 42   | 6    |          | 3    |   |            |     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests | 3    |      |          |      |   |            |     |
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_tcpbpf_user.fail
- kernel-selftests.bpf.test_btf.fail
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail


--===============8353298785301506994==--
