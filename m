Content-Type: multipart/mixed; boundary="===============5637229390587405317=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 13/22] netfilter: split nf_sockopt
Date: Fri, 17 Jul 2020 08:23:22 +0200
Message-ID: <20200717062331.691152-14-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5062

--===============5637229390587405317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split nf_sockopt into a getsockopt and setsockopt side as they share
very little code.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/netfilter/nf_sockopt.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/nf_sockopt.c b/net/netfilter/nf_sockopt.c
index 02870993d335c9..90469b1f628a8e 100644
--- a/net/netfilter/nf_sockopt.c
+++ b/net/netfilter/nf_sockopt.c
@@ -89,36 +89,32 @@ static struct nf_sockopt_ops *nf_sockopt_find(struct so=
ck *sk, u_int8_t pf,
 	return ops;
 }
 =

-/* Call get/setsockopt() */
-static int nf_sockopt(struct sock *sk, u_int8_t pf, int val,
-		      char __user *opt, int *len, int get)
+int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
+		  unsigned int len)
 {
 	struct nf_sockopt_ops *ops;
 	int ret;
 =

-	ops =3D nf_sockopt_find(sk, pf, val, get);
+	ops =3D nf_sockopt_find(sk, pf, val, 0);
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
-
-	if (get)
-		ret =3D ops->get(sk, val, opt, len);
-	else
-		ret =3D ops->set(sk, val, opt, *len);
-
+	ret =3D ops->set(sk, val, opt, len);
 	module_put(ops->owner);
 	return ret;
 }
-
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
-		  unsigned int len)
-{
-	return nf_sockopt(sk, pf, val, opt, &len, 0);
-}
 EXPORT_SYMBOL(nf_setsockopt);
 =

 int nf_getsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
 		  int *len)
 {
-	return nf_sockopt(sk, pf, val, opt, len, 1);
+	struct nf_sockopt_ops *ops;
+	int ret;
+
+	ops =3D nf_sockopt_find(sk, pf, val, 1);
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+	ret =3D ops->get(sk, val, opt, len);
+	module_put(ops->owner);
+	return ret;
 }
 EXPORT_SYMBOL(nf_getsockopt);
-- =

2.27.0

--===============5637229390587405317==--
