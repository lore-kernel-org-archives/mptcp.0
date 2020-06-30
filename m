Content-Type: multipart/mixed; boundary="===============6692836922421338611=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/5] subflow: use rsk_ops->send_reset()
Date: Tue, 30 Jun 2020 13:12:06 +0200
Message-ID: <de09aa5dfd3e84397738df12cbd24d1bd70f89ef.1593515429.git.pabeni@redhat.com>
In-Reply-To: cover.1593515429.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4866

--===============6692836922421338611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_send_active_reset() is more prone to transient errors
(memory allocation or xmit queue full): in stress conditions
the kernel may drop the egress packet, and the client will be
stuck.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 862997d5d9f3..f3517d4f70f6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -502,9 +502,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 dispose_child:
 	subflow_drop_ctx(child);
 	tcp_rsk(req)->drop_req =3D true;
-	tcp_send_active_reset(child, GFP_ATOMIC);
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
+	req->rsk_ops->send_reset(sk, skb);
 =

 	/* The last child reference will be released by the caller */
 	return child;
-- =

2.26.2

--===============6692836922421338611==--
