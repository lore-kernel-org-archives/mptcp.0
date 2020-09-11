Content-Type: multipart/mixed; boundary="===============2460562555388422763=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Fri, 11 Sep 2020 15:38:28 +0200
Message-ID: <c92e068760b45b13cae7f29107acabf8512c5f3f.1599830705.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5804

--===============2460562555388422763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a syn-cookies request socket don't pass MPTCP-level
validation done in syn_recv_sock(), we need to release
it immediatelly, or it will be leaked.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in us=
e")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/ipv4/syncookies.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
I don't really know what I'm doing here ;) =

But apparently it fixes the leak in my tests

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index c375c126f436..5c8390876cf8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -209,15 +209,15 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
 	child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req);
 	if (child) {
-		refcount_set(&req->rsk_refcnt, 1);
-		tcp_sk(child)->tsoffset =3D tsoff;
-		sock_rps_save_rxhash(child, skb);
-
 		if (rsk_drop_req(req)) {
-			refcount_set(&req->rsk_refcnt, 2);
+			reqsk_free(req);
 			return child;
 		}
 =

+		refcount_set(&req->rsk_refcnt, 1);
+		tcp_sk(child)->tsoffset =3D tsoff;
+		sock_rps_save_rxhash(child, skb);
+
 		if (inet_csk_reqsk_queue_add(sk, req, child))
 			return child;
 =

-- =

2.26.2

--===============2460562555388422763==--
