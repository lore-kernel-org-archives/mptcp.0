Content-Type: multipart/mixed; boundary="===============3603471886955175632=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 8/9] subflow: use rsk_ops->send_reset()
Date: Fri, 10 Jul 2020 19:22:17 +0200
Message-ID: <e7cc83037093593f884bc5ba7e42c82835f510a2.1594401165.git.pabeni@redhat.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4985

--===============3603471886955175632==
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
index 8eaf9eb8a29b..1ea37c776777 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -520,9 +520,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============3603471886955175632==--
