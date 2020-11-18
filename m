Content-Type: multipart/mixed; boundary="===============4363840889610894002=="
MIME-Version: 1.0
From: syzbot <syzbot+42aa53dafb66a07e5a24 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 08:30:05 -0800
Message-ID: <000000000000b71b2a05b4641fef@google.com>
In-Reply-To: 89d3320227621447393b2ad33890770b6b7711af.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6778

--===============4363840889610894002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
can't find file to patch at input line 5
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
|index 8df013daea88..aeda4357de9a 100644
|--- a/net/mptcp/protocol.c
|+++ b/net/mptcp/protocol.c
--------------------------
No file to patch.  Skipping patch.
1 out of 1 hunk ignored



Tested on:

commit:         4ba5a1c4 Merge branch 'net-next/master'
git tree:       https://github.com/multipath-tcp/mptcp_net-next.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=3D42aa53dafb66a07e5=
a24
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16cb71ee5000=
00

--===============4363840889610894002==--
