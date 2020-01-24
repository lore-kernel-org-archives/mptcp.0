Content-Type: multipart/mixed; boundary="===============8779543039042939043=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: slab-out-of-bounds Write in
 tcp_mstamp_refresh
Date: Fri, 24 Jan 2020 18:55:50 +0100
Message-ID: <20200124175550.GX795@breakpoint.cc>
In-Reply-To: 20200124171916.GH60524@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3501

--===============8779543039042939043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> One more:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in tcp_mstamp_refresh+0x80/0xa0 net/ipv4/t=
cp_output.c:57
> Write of size 8 at addr ffff888116aa21d0 by task syz-executor.0/5478

Ugh.

>  tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp_output.c:57
>  tcp_rcv_space_adjust+0x72/0x7f0 net/ipv4/tcp_input.c:612
>  tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
>  __tcp_splice_read net/ipv4/tcp.c:749 [inline]
>  tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
>  sock_splice_read+0xb9/0x120 net/socket.c:962
>  do_splice_to+0x111/0x160 fs/splice.c:892
>  do_splice+0x1259/0x1560 fs/splice.c:1205
>  __do_sys_splice fs/splice.c:1447 [inline]
>  __se_sys_splice fs/splice.c:1427 [inline]
>  __x64_sys_splice+0x2b7/0x320 fs/splice.c:1427
>  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294

mptcp allows calls into tcp proto ops on mptcp socket.

I'm trying a fix shortly.
--===============8779543039042939043==--
