Content-Type: multipart/mixed; boundary="===============3256059669121527867=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 09/11] tcp: handle want_cookie clause via reqsk_put
Date: Tue, 14 Jul 2020 20:25:12 +0200
Message-ID: <20200714182514.25250-10-fw@strlen.de>
In-Reply-To: 20200714182514.25250-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5006

--===============3256059669121527867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will allow the syn_recv_sock callback to keep the request
socket around even when syncookies are used.

This will be needed to make MPTCP JOIN requests work in cookie mode.

When a JOIN request is received, we cannot use cookies because
we need to remember the peers nonce value for HMAC validation.

Next patch will handle the cookie+join case by allowing the
rsk to stay around provided:
 1. We can find a valid mptcp socket for the 32bit token provided
    by the join and
 2. the found mptcp socket doesn't exceed the maximum number of
    subflows.

To handle 2) the request socket will not only be accounted with the
listener but also with the mptcp (parent) socket.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/ipv4/tcp_input.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5ae612902806..f45ca689bfa7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6690,6 +6690,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif =3D inet_request_bound_dev_if(sk, skb);
 =

+	refcount_set(&req->rsk_refcnt, 1);
 	af_ops->init_req(req, sk, skb);
 =

 	if (security_inet_conn_request(sk, skb, req))
@@ -6760,10 +6761,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_op=
s,
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
 						   TCP_SYNACK_COOKIE);
-		if (want_cookie) {
-			reqsk_free(req);
-			return 0;
-		}
 	}
 	reqsk_put(req);
 	return 0;
@@ -6771,7 +6768,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 drop_and_release:
 	dst_release(dst);
 drop_and_free:
-	__reqsk_free(req);
+	reqsk_put(req);
 drop:
 	tcp_listendrop(sk);
 	return 0;
-- =

2.26.2

--===============3256059669121527867==--
