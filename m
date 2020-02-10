Content-Type: multipart/mixed; boundary="===============0851788584508072744=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH next] mptcp: make the symbol 'mptcp_sk_clone_lock'
 static
Date: Mon, 10 Feb 2020 10:24:58 +0100
Message-ID: <20200210.102458.1980916355586297612.davem@davemloft.net>
In-Reply-To: 20200210082759.12157-1-chenwandun@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 3606

--===============0851788584508072744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Chen Wandun <chenwandun(a)huawei.com>
Date: Mon, 10 Feb 2020 16:27:59 +0800

> Fix the following sparse warning:
> net/mptcp/protocol.c:646:13: warning: symbol 'mptcp_sk_clone_lock' was no=
t declared. Should it be static?
> =

> Fixes: b0519de8b3f1 ("mptcp: fix use-after-free for ipv6")
> Signed-off-by: Chen Wandun <chenwandun(a)huawei.com>

Applied.
--===============0851788584508072744==--
