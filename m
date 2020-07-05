Content-Type: multipart/mixed; boundary="===============6902301390297632749=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/3] mptcp: add
 REUSEADDR/REUSEPORT/V6ONLY setsockopt support
Date: Sat, 04 Jul 2020 17:57:24 -0700
Message-ID: <20200704.175724.1724928333689332249.davem@davemloft.net>
In-Reply-To: 20200704233017.20831-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4919

--===============6902301390297632749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>
Date: Sun,  5 Jul 2020 01:30:14 +0200

> restarting an mptcp-patched sshd yields following error:
> =

>   sshd: error: Bind to port 22 on 0.0.0.0 failed: Address already in use.
>   sshd: error: setsockopt IPV6_V6ONLY: Operation not supported
>   sshd: error: Bind to port 22 on :: failed: Address already in use.
>   sshd: fatal: Cannot bind any address.
> =

> This series adds support for the needed setsockopts:
> =

> First patch skips the generic SOL_SOCKET handler for MPTCP:
> in mptcp case, the setsockopt needs to alter the tcp socket, not the mptcp
> parent socket.
> =

> Second patch adds minimal SOL_SOCKET support: REUSEPORT and REUSEADDR.
> Rest is still handled by the generic SOL_SOCKET code.
> =

> Last patch adds IPV6ONLY support.  This makes ipv6 work for openssh:
> It creates two listening sockets, before this patch, binding the ipv6
> socket will fail because the port is already bound by the ipv4 one.

Series applied, thanks Florian.
--===============6902301390297632749==--
