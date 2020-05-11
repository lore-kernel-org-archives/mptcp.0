Content-Type: multipart/mixed; boundary="===============5438283903185601761=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/7] mptcp: remove inner wait loop from
 mptcp_sendmsg_frag
Date: Mon, 11 May 2020 13:55:37 +0200
Message-ID: <20200511115538.6015-7-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4365

--===============5438283903185601761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

previous patches made sure we only call into this function
when these prerequisites are met, so no need to wait on the
subflow socket anymore.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/7
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e91abcfb9db..da5f2a1c465d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -510,20 +510,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	 * fooled into a warning if we don't init here
 	 */
 	pfrag =3D sk_page_frag(sk);
-	while ((!retransmission && !mptcp_page_frag_refill(ssk, pfrag)) ||
-	       !mptcp_ext_cache_refill(msk)) {
-		ret =3D sk_stream_wait_memory(ssk, timeo);
-		if (ret)
-			return ret;
-
-		/* if sk_stream_wait_memory() sleeps snd_una can change
-		 * significantly, refresh the rtx queue
-		 */
-		mptcp_clean_una(sk);
-
-		if (unlikely(__mptcp_needs_tcp_fallback(msk)))
-			return 0;
-	}
 	if (!retransmission) {
 		write_seq =3D &msk->write_seq;
 		page =3D pfrag->page;
-- =

2.26.2

--===============5438283903185601761==--
