Content-Type: multipart/mixed; boundary="===============9202495976064350973=="
MIME-Version: 1.0
From: syzbot <syzbot+c6bfc3db991edc918432 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in selinux_socket_recvmsg
Date: Sun, 24 May 2020 11:12:03 -0700
Message-ID: <000000000000a1a76d05a668ccbb@google.com>
In-Reply-To: 00000000000054221d05a64b7ed8@google.com
X-Status: 
X-Keywords:                  
X-UID: 4467

--===============9202495976064350973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this bug to:

commit 263e1201a2c324b60b15ecda5de9ebf1e7293e31
Author: Paolo Abeni <pabeni(a)redhat.com>
Date:   Thu Apr 30 13:01:51 2020 +0000

    mptcp: consolidate synack processing.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12a5254a1000=
00
start commit:   051143e1 Merge tag 'apparmor-pr-2020-05-21' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D11a5254a1000=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a5254a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc6bfc3db991edc918=
432
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13eeacba100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D167163e6100000

Reported-by: syzbot+c6bfc3db991edc918432(a)syzkaller.appspotmail.com
Fixes: 263e1201a2c3 ("mptcp: consolidate synack processing.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
--===============9202495976064350973==--
