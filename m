Content-Type: multipart/mixed; boundary="===============2527250173969078169=="
MIME-Version: 1.0
From: syzbot <syzbot+d7cface3f90b13edf5b0 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in sock_recvmsg
Date: Mon, 25 May 2020 03:54:03 -0700
Message-ID: <000000000000174d2405a676cc64@google.com>
In-Reply-To: f82cedb30d32f24f962360f96d7bef633792a401.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4481

--===============2527250173969078169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger cra=
sh:

Reported-and-tested-by: syzbot+d7cface3f90b13edf5b0(a)syzkaller.appspotmail=
.com

Tested on:

commit:         98790bba Merge tag 'efi-urgent-2020-05-24' of git://git.ke..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc33c7f7c5471fd39
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7cface3f90b13edf=
5b0
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/=
 c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14fe60161000=
00

Note: testing is done by a robot and is best-effort only.
--===============2527250173969078169==--
