Content-Type: multipart/mixed; boundary="===============6150575656800853191=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Wed, 25 Nov 2020 13:37:14 -0800
Message-ID: <20201125133714.12245f6a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 5370c0ae03449239e3d1674ddcfb090cf6f20abe.1606253206.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6940

--===============6150575656800853191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Nov 2020 22:51:24 +0100 Paolo Abeni wrote:
> We can enter the main mptcp_recvmsg() loop even when
> no subflows are connected. As note by Eric, that would
> result in a divide by zero oops on ack generation.
> =

> Address the issue by checking the subflow status before
> sending the ack.
> =

> Additionally protect mptcp_recvmsg() against invocation
> with weird socket states.
> =

> v1 -> v2:
>  - removed unneeded inline keyword - Jakub
> =

> Reported-and-suggested-by: Eric Dumazet <eric.dumazet(a)gmail.com>
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks!
--===============6150575656800853191==--
