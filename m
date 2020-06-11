Content-Type: multipart/mixed; boundary="===============0921458521864673186=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: drop MP_JOIN request sock on syn cookies
Date: Thu, 11 Jun 2020 19:20:57 +0200
Message-ID: <ba394e20f65fb338e27e952bf1128b23b5552506.1591895765.git.pabeni@redhat.com>
In-Reply-To: cover.1591895765.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4653

--===============0921458521864673186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently any MPTCP socket using syn cookies will fallback to
TCP at 3rd ack time. In case of MP_JOIN requests, the RFC mandate
closing the child and sockets, but the existing error paths
do not handle the syncookie scenario correctly.

Address the issue always forcing the child shutdown in case of
MP_JOIN fallback.

Fixes: ae2dd7164943 ("mptcp: handle tcp fallback when using syn cookies")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8367d93e2f5c..339c9226c6ee 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -393,22 +393,25 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
-	bool fallback_is_fatal =3D false;
+	bool fallback, fallback_is_fatal;
 	struct sock *new_msk =3D NULL;
-	bool fallback =3D false;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

-	/* we need later a valid 'mp_capable' value even when options are not
-	 * parsed
+	/* After child creation we must look for 'mp_capable' even when options
+	 * are not parsed
 	 */
 	mp_opt.mp_capable =3D 0;
-	if (tcp_rsk(req)->is_mptcp =3D=3D 0)
+
+	/* hopefully temporary handling for MP_JOIN+syncookie */
+	subflow_req =3D mptcp_subflow_rsk(req);
+	fallback_is_fatal =3D subflow_req->mp_join;
+	fallback =3D !tcp_rsk(req)->is_mptcp;
+	if (fallback)
 		goto create_child;
 =

 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
-	subflow_req =3D mptcp_subflow_rsk(req);
 	if (subflow_req->mp_capable) {
 		if (TCP_SKB_CB(skb)->seq !=3D subflow_req->ssn_offset + 1) {
 			/* here we can receive and accept an in-window,
@@ -429,12 +432,11 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		if (!new_msk)
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
-		fallback_is_fatal =3D true;
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_join ||
 		    !subflow_hmac_valid(req, &mp_opt)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-			return NULL;
+			fallback =3D true;
 		}
 	}
 =

-- =

2.21.3

--===============0921458521864673186==--
