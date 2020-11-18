Content-Type: multipart/mixed; boundary="===============3733571836877041731=="
MIME-Version: 1.0
From: syzbot <syzbot+42aa53dafb66a07e5a24 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 13:58:05 -0800
Message-ID: <000000000000ba4a0805b468b464@google.com>
In-Reply-To: 9f4392dd8cb285774b8558b2dce6d5e391be72a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6794

--===============3733571836877041731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any=
 issue:

Reported-and-tested-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspotmail=
.com

Tested on:

commit:         2b8473d2 Documentation: Remove the deleted "framerelay" do..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-=
next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df9f2db0042d65d21
dashboard link: https://syzkaller.appspot.com/bug?extid=3D42aa53dafb66a07e5=
a24
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16b5865e5000=
00

Note: testing is done by a robot and is best-effort only.
--===============3733571836877041731==--
