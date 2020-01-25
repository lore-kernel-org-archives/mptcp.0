Content-Type: multipart/mixed; boundary="===============1569663291361755330=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] mptcp: do not inherit inet proto ops
Date: Sat, 25 Jan 2020 08:14:53 +0100
Message-ID: <20200125.081453.329018046256576212.davem@davemloft.net>
In-Reply-To: 20200125000403.251894-2-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3510

--===============1569663291361755330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Fri, 24 Jan 2020 16:04:02 -0800

> From: Florian Westphal <fw(a)strlen.de>
> =

> We need to initialise the struct ourselves, else we expose tcp-specific
> callbacks such as tcp_splice_read which will then trigger splat because
> the socket is an mptcp one:
> =

> BUG: KASAN: slab-out-of-bounds in tcp_mstamp_refresh+0x80/0xa0 net/ipv4/t=
cp_output.c:57
> Write of size 8 at addr ffff888116aa21d0 by task syz-executor.0/5478
> =

> CPU: 1 PID: 5478 Comm: syz-executor.0 Not tainted 5.5.0-rc6 #3
> Call Trace:
>  tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp_output.c:57
>  tcp_rcv_space_adjust+0x72/0x7f0 net/ipv4/tcp_input.c:612
>  tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
>  tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
>  do_splice+0x1259/0x1560 fs/splice.c:1205
> =

> To prevent build error with ipv6, add the recv/sendmsg function
> declaration to ipv6.h.  The functions are already accessible "thanks"
> to retpoline related work, but they are currently only made visible
> by socket.c specific INDIRECT_CALLABLE macros.
> =

> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Applied.
--===============1569663291361755330==--
