Content-Type: multipart/mixed; boundary="===============8037149786705425826=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/5] subflow: do not create child subflow for
 fallback MP_JOIN
Date: Tue, 30 Jun 2020 13:12:08 +0200
Message-ID: <63292184bb1aed7c8f64d66fe39ef6089266f873.1593515429.git.pabeni@redhat.com>
In-Reply-To: cover.1593515429.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4867

--===============8037149786705425826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On MP_JOIN fallback, the child socket was used just to send-out
the due reset packet. As we don't use the child sock anymore
for such role, when can avoid creating the fallback MP_JOIN
sock entirely.

This saves a busy server from quite a bit of useless work, if
clients are storming with MP_JOIN reqs above the server limits

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: to avoid changing the hook into tcp_check_req(), I had
to introduce a quite ugly const cast in subflow_syn_recv_sock().
I *think* it should be safe, but I'm 110% sure about unintended
implications - alike cc optimizing the calling code assuming sk
never changes, and generated code being bugged due to the above
cast.

I think should be safe, as the struct sock is not accessed
by tcp_check_req() when the relevant conditions held after
syn_recv_sock(), still something require additional eyeballs.
---
 net/mptcp/subflow.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3077e07375b5..9f4f3e29587d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -405,8 +405,11 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 	subflow_req =3D mptcp_subflow_rsk(req);
 	fallback_is_fatal =3D tcp_rsk(req)->is_mptcp && subflow_req->mp_join;
 	fallback =3D !tcp_rsk(req)->is_mptcp;
-	if (fallback)
+	if (fallback) {
+		if (fallback_is_fatal)
+			goto dispose_req;
 		goto create_child;
+	}
 =

 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	if (subflow_req->mp_capable) {
@@ -434,7 +437,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		    !mptcp_can_accept_new_subflow(subflow_req->msk) ||
 		    !subflow_hmac_valid(req, &mp_opt)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-			fallback =3D true;
+			goto dispose_req;
 		}
 	}
 =

@@ -506,15 +509,25 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 		      !mptcp_subflow_ctx(child)->conn));
 	return child;
 =

+dispose_req:
+	/* The last req reference will be released by the caller */
+	child =3D NULL;
+	*own_req =3D false;
+	reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
+	inet_csk_reqsk_queue_drop((struct sock *)sk, req);
+	goto reset;
+
 dispose_child:
+	/* The last child reference will be released by the caller */
 	subflow_drop_ctx(child);
 	tcp_rsk(req)->drop_req =3D true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb);
 =

-	/* The last child reference will be released by the caller */
+reset:
+	req->rsk_ops->send_reset(sk, skb);
 	return child;
+
 }
 =

 static struct inet_connection_sock_af_ops subflow_specific;
-- =

2.26.2

--===============8037149786705425826==--
