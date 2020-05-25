Content-Type: multipart/mixed; boundary="===============8237665034617381664=="
MIME-Version: 1.0
From: syzbot <syzbot+c6bfc3db991edc918432 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in selinux_socket_recvmsg
Date: Mon, 25 May 2020 03:38:02 -0700
Message-ID: <000000000000c96ea805a676926f@google.com>
In-Reply-To: 724312f087f459f0318e3edb862e415b3e8b94f6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4479

--===============8237665034617381664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger cra=
sh:

Reported-and-tested-by: syzbot+c6bfc3db991edc918432(a)syzkaller.appspotmail=
.com

Tested on:

commit:         98790bba Merge tag 'efi-urgent-2020-05-24' of git://git.ke..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc6bfc3db991edc918=
432
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D127e60161000=
00

Note: testing is done by a robot and is best-effort only.
--===============8237665034617381664==--
