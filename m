Content-Type: multipart/mixed; boundary="===============1763335549933757449=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/8] subflow: explicitly check for plain tcp
 rsk
Date: Thu, 23 Jul 2020 13:02:34 +0200
Message-ID: <3d0b2caefba40597d5678a4a94ac961a2db6db31.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5238

--===============1763335549933757449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When syncookie are in use, the TCP stack may feed into
subflow_syn_recv_sock() plain TCP request sockets. We can't
access mptcp_subflow_request_sock-specific fields on such
sockets. Explicitly check the rsk ops to do safe accesses.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7f3ef1840df5..3ef445f59556 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -415,7 +415,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 =

 	/* hopefully temporary handling for MP_JOIN+syncookie */
 	subflow_req =3D mptcp_subflow_rsk(req);
-	fallback_is_fatal =3D subflow_req->mp_join;
+	fallback_is_fatal =3D tcp_rsk(req)->is_mptcp && subflow_req->mp_join;
 	fallback =3D !tcp_rsk(req)->is_mptcp;
 	if (fallback)
 		goto create_child;
-- =

2.26.2

--===============1763335549933757449==--
