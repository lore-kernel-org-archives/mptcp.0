Content-Type: multipart/mixed; boundary="===============3105435218318552052=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] net: mptcp: fix memory leak in case slab
 allocation fails
Date: Mon, 13 May 2019 18:55:13 +0200
Message-ID: <c30f4ffaed7419c634a1eb733339f0e2fa36a936.1557766409.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1153

--===============3105435218318552052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

slab_name is allocated, but not freed, when slab allocation fails: ensure
it is freed in the error path of kmem_cache_create(...). While at it, fix
reverse christmas tree in subflow_ops-init() local variable declarations.

Fixes: aedec94346fb ("mptcp: Create SUBFLOW socket for incoming connections=
")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e72492bfb5a7..032424c61ba9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -269,8 +269,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly=
 =3D {
 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 {
 	subflow_ops->obj_size =3D sizeof(struct subflow_request_sock);
-	subflow_ops->slab =3D NULL;
 	subflow_ops->slab_name =3D NULL;
+	subflow_ops->slab =3D NULL;
 =

 	subflow_ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_subflow");
 	if (!subflow_ops->slab_name)
@@ -283,6 +283,7 @@ static int subflow_ops_init(struct request_sock_ops *su=
bflow_ops)
 					      NULL);
 =

 	if (!subflow_ops->slab) {
+		kfree(subflow_ops->slab_name);
 		return -ENOMEM;
 	}
 =

-- =

2.20.1


--===============3105435218318552052==--
