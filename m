Content-Type: multipart/mixed; boundary="===============0589639444476417650=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Fri, 02 Oct 2020 15:35:15 -0700
Message-ID: <20201002.153515.522963285806177264.davem@davemloft.net>
In-Reply-To: 867cc806e4dfeb200e84b37addff2e2847f44c0e.1601635086.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6172

--===============0589639444476417650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri,  2 Oct 2020 12:39:44 +0200

> If a syn-cookies request socket don't pass MPTCP-level
> validation done in syn_recv_sock(), we need to release
> it immediately, or it will be leaked.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in =
use")
> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thank you.
--===============0589639444476417650==--
