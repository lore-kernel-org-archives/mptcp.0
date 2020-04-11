Content-Type: multipart/mixed; boundary="===============0045266046410040107=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING: bad unlock balance in mptcp_shutdown
Date: Sun, 12 Apr 2020 00:43:37 +0200
Message-ID: <20200411224337.GA5795@breakpoint.cc>
In-Reply-To: 000000000000adb83a05a30aaa04@google.com
X-Status: 
X-Keywords:                  
X-UID: 4154

--===============0045266046410040107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17a5dbfbe00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca75979eeebf0=
6c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6ebb6d4830e8f88=
15623
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> =

> Unfortunately, I don't have any reproducer for this crash yet.
> =

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6ebb6d4830e8f8815623(a)syzkaller.appspotmail.com
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: bad unlock balance detected!
> 5.6.0-syzkaller #0 Not tainted
> -------------------------------------
> syz-executor.5/2215 is trying to release lock (sk_lock-AF_INET6) at:
> [<ffffffff87c5203b>] mptcp_shutdown+0x38b/0x550 net/mptcp/protocol.c:1889
> but there are no more locks to release!
> =

> other info that might help us debug this:
> 1 lock held by syz-executor.5/2215:
>  #0: ffff88804a22eda0 (slock-AF_INET6){+.-.}-{2:2}, at: spin_lock_bh incl=
ude/linux/spinlock.h:358 [inline]
>  #0: ffff88804a22eda0 (slock-AF_INET6){+.-.}-{2:2}, at: release_sock+0x1b=
/0x1b0 net/core/sock.c:2974

I think this is same issue as the other report, so:

#syz dup: WARNING: bad unlock balance in mptcp_poll
--===============0045266046410040107==--
