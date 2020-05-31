Content-Type: multipart/mixed; boundary="===============2591973709219842723=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix NULL ptr dereference in
 MP_JOIN error path
Date: Sat, 30 May 2020 21:54:15 -0700
Message-ID: <20200530.215415.180552611360986513.davem@davemloft.net>
In-Reply-To: 1fc1fd4512e4709d1fbeb7f008f38b273ee1d798.1590767183.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4567

--===============2591973709219842723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri, 29 May 2020 17:49:18 +0200

> When token lookup on MP_JOIN 3rd ack fails, the server
> socket closes with a reset the incoming child. Such socket
> has the 'is_mptcp' flag set, but no msk socket associated
> - due to the failed lookup.
> =

> While crafting the reset packet mptcp_established_options_mp()
> will try to dereference the child's master socket, causing
> a NULL ptr dereference.
> =

> This change addresses the issue with explicit fallback to
> TCP in such error path.
> =

> Fixes: 729cd6436f35 ("mptcp: cope better with MP_JOIN failure")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thank you.
--===============2591973709219842723==--
