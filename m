Content-Type: multipart/mixed; boundary="===============3727762101456333280=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 5/7] mptcp: fill skb page frag cache
 outside of mptcp_sendmsg_frag
Date: Wed, 06 May 2020 15:02:26 +0200
Message-ID: <20200506130228.1478-6-fw@strlen.de>
In-Reply-To: 20200506130228.1478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4324

--===============3727762101456333280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp_sendmsg_frag helper contains a loop that will wait on the
subflow sk.

It seems preferrable to only wait in mptcp_sendmsg() when blocking io is
requested.  mptcp_sendmsg already has such a wait loop that is used when
no subflow socket is available for transmission.

This is another preparation patch that makes sure we call
mptcp_sendmsg_frag only if the page frag cache has been refilled.

Followup patch will remove the wait loop from mptcp_sendmsg_frag().

The retransmit worker doesn't need to do this refill as it won't
transmit new mptcp-level data.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b3141ecfced..06c77f16bf38 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,6 +739,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 {
 	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct page_frag *pfrag;
 	struct socket *ssock;
 	size_t copied =3D 0;
 	struct sock *ssk;
@@ -767,12 +768,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

+	pfrag =3D sk_page_frag(sk);
 restart:
 	mptcp_clean_una(sk);
 =

 	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_send(msk);
-	while (!sk_stream_memory_free(sk) || !ssk) {
+	while (!sk_stream_memory_free(sk) ||
+	       !ssk ||
+	       !mptcp_page_frag_refill(ssk, pfrag)) {
 		ret =3D sk_stream_wait_memory(sk, &timeo);
 		if (ret)
 			goto out;
@@ -822,6 +826,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		if (!tx_ok)
 			break;
 		if (!sk_stream_memory_free(ssk) ||
+		    !mptcp_page_frag_refill(ssk, pfrag) ||
 		    !mptcp_ext_cache_refill(msk)) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
 				 tcp_sk(ssk)->nonagle, size_goal);
-- =

2.26.2

--===============3727762101456333280==--
