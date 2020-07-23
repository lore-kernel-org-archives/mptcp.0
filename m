Content-Type: multipart/mixed; boundary="===============4114606434550311107=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 7/8] subflow: use rsk_ops->send_reset()
Date: Thu, 23 Jul 2020 13:02:35 +0200
Message-ID: <a3d4154c2b5aede36cc6014edcffc086249b7381.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5237

--===============4114606434550311107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_send_active_reset() is more prone to transient errors
(memory allocation or xmit queue full): in stress conditions
the kernel may drop the egress packet, and the client will be
stuck.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3ef445f59556..ada04df6f99f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -524,9 +524,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============4114606434550311107==--
