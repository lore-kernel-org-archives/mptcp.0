Content-Type: multipart/mixed; boundary="===============5419847829732161117=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 03/11] tcp: syncookies: use single reqsk_free
 location
Date: Tue, 14 Jul 2020 20:25:06 +0200
Message-ID: <20200714182514.25250-4-fw@strlen.de>
In-Reply-To: 20200714182514.25250-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5000

--===============5419847829732161117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add a common error label and use it.
Followup patch would need to add a 3rd 'if (err) { free(x); goto out;}
pattern, this will allow use of 'if (err) goto free'.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/ipv4/syncookies.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 9a4f6b16c9bc..ee17f55401ef 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -363,10 +363,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct s=
k_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(sock_net(sk), skb));
 =

-	if (security_inet_conn_request(sk, skb, req)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
 =

 	req->num_retrans =3D 0;
 =

@@ -383,10 +381,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct s=
k_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi(&fl4));
 	rt =3D ip_route_output_key(sock_net(sk), &fl4);
-	if (IS_ERR(rt)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (IS_ERR(rt))
+		goto out_free;
 =

 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->dst, RTAX_W=
INDOW);
@@ -405,5 +401,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct s=
k_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
-out:	return ret;
+	return ret;
+
+out_free:
+	reqsk_free(req);
+out:
+	return ret;
 }
-- =

2.26.2

--===============5419847829732161117==--
