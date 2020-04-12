Content-Type: multipart/mixed; boundary="===============5427961790493477010=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING: bad unlock balance in mptcp_listen
Date: Sun, 12 Apr 2020 10:32:01 +0200
Message-ID: <20200412083201.GB5795@breakpoint.cc>
In-Reply-To: 000000000000d754eb05a312bd8f@google.com
X-Status: 
X-Keywords:                  
X-UID: 4157

--===============5427961790493477010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot <syzbot+ffec3741d41140477097(a)syzkaller.appspotmail.com> wrote:
> syzbot found the following crash on:
> =

> HEAD commit:    5b8b9d0c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1712bdb3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D23c5a352e32a1=
944
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dffec3741d411404=
77097
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> =

> Unfortunately, I don't have any reproducer for this crash yet.
> =

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ffec3741d41140477097(a)syzkaller.appspotmail.com
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: bad unlock balance detected!
> 5.6.0-syzkaller #0 Not tainted
> -------------------------------------
> syz-executor.0/25417 is trying to release lock (sk_lock-AF_INET6) at:
> [<ffffffff87c65063>] mptcp_listen+0x1c3/0x2e0 net/mptcp/protocol.c:1783
> but there are no more locks to release!

#syz dup: WARNING: bad unlock balance in mptcp_poll
--===============5427961790493477010==--
