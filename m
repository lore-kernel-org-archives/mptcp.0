Content-Type: multipart/mixed; boundary="===============6562929218538892779=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: do nonce initialization at
 subflow creation time
Date: Tue, 30 Jun 2020 13:38:18 -0700
Message-ID: <20200630.133818.337808463839879472.davem@davemloft.net>
In-Reply-To: cc811b8707d488492fb8e33ed651aab456de6f72.1593527763.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4876

--===============6562929218538892779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Tue, 30 Jun 2020 16:38:26 +0200

> This clean-up the code a bit, reduces the number of
> used hooks and indirect call requested, and allow
> better error reporting from __mptcp_subflow_connect()
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks.
--===============6562929218538892779==--
