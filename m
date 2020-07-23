Content-Type: multipart/mixed; boundary="===============1281468926642495331=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 13/26] bpfilter: switch bpfilter_ip_set_sockopt to
 sockptr_t
Date: Thu, 23 Jul 2020 08:08:55 +0200
Message-ID: <20200723060908.50081-14-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5213

--===============1281468926642495331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is mostly to prepare for cleaning up the callers, as bpfilter by
design can't handle kernel pointers.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 include/linux/bpfilter.h     | 6 +++---
 net/bpfilter/bpfilter_kern.c | 6 +++---
 net/ipv4/bpfilter/sockopt.c  | 8 ++++----
 net/ipv4/ip_sockglue.c       | 3 ++-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 9b114c718a7617..2ae3c8e1d83c43 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -4,9 +4,10 @@
 =

 #include <uapi/linux/bpfilter.h>
 #include <linux/usermode_driver.h>
+#include <linux/sockptr.h>
 =

 struct sock;
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *opt=
val,
+int bpfilter_ip_set_sockopt(struct sock *sk, int optname, sockptr_t optval,
 			    unsigned int optlen);
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *opt=
val,
 			    int __user *optlen);
@@ -16,8 +17,7 @@ struct bpfilter_umh_ops {
 	struct umd_info info;
 	/* since ip_getsockopt() can run in parallel, serialize access to umh */
 	struct mutex lock;
-	int (*sockopt)(struct sock *sk, int optname,
-		       char __user *optval,
+	int (*sockopt)(struct sock *sk, int optname, sockptr_t optval,
 		       unsigned int optlen, bool is_set);
 	int (*start)(void);
 };
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 00540457e5f4d3..f580c3344cb3ac 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -60,17 +60,17 @@ static int bpfilter_send_req(struct mbox_request *req)
 }
 =

 static int bpfilter_process_sockopt(struct sock *sk, int optname,
-				    char __user *optval, unsigned int optlen,
+				    sockptr_t optval, unsigned int optlen,
 				    bool is_set)
 {
 	struct mbox_request req =3D {
 		.is_set		=3D is_set,
 		.pid		=3D current->pid,
 		.cmd		=3D optname,
-		.addr		=3D (uintptr_t)optval,
+		.addr		=3D (uintptr_t)optval.user,
 		.len		=3D optlen,
 	};
-	if (uaccess_kernel()) {
+	if (uaccess_kernel() || sockptr_is_kernel(optval)) {
 		pr_err("kernel access not supported\n");
 		return -EFAULT;
 	}
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 9063c6767d3410..1b34cb9a7708ec 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -21,8 +21,7 @@ void bpfilter_umh_cleanup(struct umd_info *info)
 }
 EXPORT_SYMBOL_GPL(bpfilter_umh_cleanup);
 =

-static int bpfilter_mbox_request(struct sock *sk, int optname,
-				 char __user *optval,
+static int bpfilter_mbox_request(struct sock *sk, int optname, sockptr_t o=
ptval,
 				 unsigned int optlen, bool is_set)
 {
 	int err;
@@ -52,7 +51,7 @@ static int bpfilter_mbox_request(struct sock *sk, int opt=
name,
 	return err;
 }
 =

-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *opt=
val,
+int bpfilter_ip_set_sockopt(struct sock *sk, int optname, sockptr_t optval,
 			    unsigned int optlen)
 {
 	return bpfilter_mbox_request(sk, optname, optval, optlen, true);
@@ -66,7 +65,8 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname,=
 char __user *optval,
 	if (get_user(len, optlen))
 		return -EFAULT;
 =

-	return bpfilter_mbox_request(sk, optname, optval, len, false);
+	return bpfilter_mbox_request(sk, optname, USER_SOCKPTR(optval), len,
+				     false);
 }
 =

 static int __init bpfilter_sockopt_init(void)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 42befbf12846c0..36f746e01741f6 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1414,7 +1414,8 @@ int ip_setsockopt(struct sock *sk, int level,
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >=3D BPFILTER_IPT_SO_SET_REPLACE &&
 	    optname < BPFILTER_IPT_SET_MAX)
-		err =3D bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
+		err =3D bpfilter_ip_set_sockopt(sk, optname, USER_SOCKPTR(optval),
+					      optlen);
 #endif
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
-- =

2.27.0

--===============1281468926642495331==--
