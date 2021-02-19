Content-Type: multipart/mixed; boundary="===============5123187338961481637=="
MIME-Version: 1.0
From: syzbot <syzbot+409b0354a6ba83a86aaf at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in mptcp_sendmsg_frag
Date: Fri, 19 Feb 2021 12:25:08 -0800
Message-ID: <00000000000096022805bbb63f35@google.com>
In-Reply-To: 000000000000e29ec405bb8b9251@google.com
X-Status: 
X-Keywords:                  
X-UID: 7869

--===============5123187338961481637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 40947e13997a1cba4e875893ca6e5d5e61a0689d
Author: Florian Westphal <fw(a)strlen.de>
Date:   Fri Feb 12 23:59:56 2021 +0000

    mptcp: schedule worker when subflow is closed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1541a434d000=
00
start commit:   773dc50d Merge branch 'Xilinx-axienet-updates'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1741a434d000=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1341a434d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddbc1ca9e55dc1f9f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D409b0354a6ba83a86=
aaf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16548404d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D150c2914d00000

Reported-by: syzbot+409b0354a6ba83a86aaf(a)syzkaller.appspotmail.com
Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
--===============5123187338961481637==--
