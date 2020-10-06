Content-Type: multipart/mixed; boundary="===============6504565371153259183=="
MIME-Version: 1.0
From: syzbot <syzbot+fcf8ca5817d6e92c6567 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 18:17:05 -0700
Message-ID: <0000000000006d9e4305b0f65ba6@google.com>
In-Reply-To: 003589e3dce1ed8d9b9970bbf8ed1661ced8d2cc.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6207

--===============6504565371153259183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any=
 issue:

Reported-and-tested-by: syzbot+fcf8ca5817d6e92c6567(a)syzkaller.appspotmail=
.com

Tested on:

commit:         f4f9dcc3 net: phy: marvell: Use phy_read_paged() instead o..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e6c5266df853ae
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca5817d6e92c6=
567
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14f6da579000=
00

Note: testing is done by a robot and is best-effort only.
--===============6504565371153259183==--
