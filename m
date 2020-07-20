Content-Type: multipart/mixed; boundary="===============5538553753698637589=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/24] net: switch sock_set_timeout to sockptr_t
Date: Mon, 20 Jul 2020 14:47:20 +0200
Message-ID: <20200720124737.118617-8-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5107

--===============5538553753698637589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 include/net/sock.h   |  3 ++-
 net/core/sock.c      | 26 ++++++++++++--------------
 net/mptcp/protocol.c |  6 ++++--
 net/socket.c         |  3 ++-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 62e18fc8ac9f96..bfb2fe2fc36876 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -59,6 +59,7 @@
 #include <linux/filter.h>
 #include <linux/rculist_nulls.h>
 #include <linux/poll.h>
+#include <linux/sockptr.h>
 =

 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -1669,7 +1670,7 @@ void sock_pfree(struct sk_buff *skb);
 #endif
 =

 int sock_setsockopt(struct socket *sock, int level, int op,
-		    char __user *optval, unsigned int optlen);
+		    sockptr_t optval, unsigned int optlen);
 =

 int sock_getsockopt(struct socket *sock, int level, int op,
 		    char __user *optval, int __user *optlen);
diff --git a/net/core/sock.c b/net/core/sock.c
index d45bb1c2c36abf..9cf8318bc51de4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -825,7 +825,7 @@ EXPORT_SYMBOL(sock_set_rcvbuf);
  */
 =

 int sock_setsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, unsigned int optlen)
+		    sockptr_t optval, unsigned int optlen)
 {
 	struct sock_txtime sk_txtime;
 	struct sock *sk =3D sock->sk;
@@ -839,12 +839,12 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 	 */
 =

 	if (optname =3D=3D SO_BINDTODEVICE)
-		return sock_setbindtodevice(sk, USER_SOCKPTR(optval), optlen);
+		return sock_setbindtodevice(sk, optval, optlen);
 =

 	if (optlen < sizeof(int))
 		return -EINVAL;
 =

-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
 =

 	valbool =3D val ? 1 : 0;
@@ -957,7 +957,7 @@ int sock_setsockopt(struct socket *sock, int level, int=
 optname,
 			ret =3D -EINVAL;	/* 1003.1g */
 			break;
 		}
-		if (copy_from_user(&ling, optval, sizeof(ling))) {
+		if (copy_from_sockptr(&ling, optval, sizeof(ling))) {
 			ret =3D -EFAULT;
 			break;
 		}
@@ -1051,21 +1051,20 @@ int sock_setsockopt(struct socket *sock, int level,=
 int optname,
 =

 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
-		ret =3D sock_set_timeout(&sk->sk_rcvtimeo, USER_SOCKPTR(optval),
+		ret =3D sock_set_timeout(&sk->sk_rcvtimeo, optval,
 				       optlen, optname =3D=3D SO_RCVTIMEO_OLD);
 		break;
 =

 	case SO_SNDTIMEO_OLD:
 	case SO_SNDTIMEO_NEW:
-		ret =3D sock_set_timeout(&sk->sk_sndtimeo, USER_SOCKPTR(optval),
+		ret =3D sock_set_timeout(&sk->sk_sndtimeo, optval,
 				       optlen, optname =3D=3D SO_SNDTIMEO_OLD);
 		break;
 =

 	case SO_ATTACH_FILTER: {
 		struct sock_fprog fprog;
 =

-		ret =3D copy_bpf_fprog_from_user(&fprog, USER_SOCKPTR(optval),
-					       optlen);
+		ret =3D copy_bpf_fprog_from_user(&fprog, optval, optlen);
 		if (!ret)
 			ret =3D sk_attach_filter(&fprog, sk);
 		break;
@@ -1076,7 +1075,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 			u32 ufd;
 =

 			ret =3D -EFAULT;
-			if (copy_from_user(&ufd, optval, sizeof(ufd)))
+			if (copy_from_sockptr(&ufd, optval, sizeof(ufd)))
 				break;
 =

 			ret =3D sk_attach_bpf(ufd, sk);
@@ -1086,8 +1085,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 	case SO_ATTACH_REUSEPORT_CBPF: {
 		struct sock_fprog fprog;
 =

-		ret =3D copy_bpf_fprog_from_user(&fprog, USER_SOCKPTR(optval),
-					       optlen);
+		ret =3D copy_bpf_fprog_from_user(&fprog, optval, optlen);
 		if (!ret)
 			ret =3D sk_reuseport_attach_filter(&fprog, sk);
 		break;
@@ -1098,7 +1096,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 			u32 ufd;
 =

 			ret =3D -EFAULT;
-			if (copy_from_user(&ufd, optval, sizeof(ufd)))
+			if (copy_from_sockptr(&ufd, optval, sizeof(ufd)))
 				break;
 =

 			ret =3D sk_reuseport_attach_bpf(ufd, sk);
@@ -1178,7 +1176,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 =

 		if (sizeof(ulval) !=3D sizeof(val) &&
 		    optlen >=3D sizeof(ulval) &&
-		    get_user(ulval, (unsigned long __user *)optval)) {
+		    copy_from_sockptr(&ulval, optval, sizeof(ulval))) {
 			ret =3D -EFAULT;
 			break;
 		}
@@ -1221,7 +1219,7 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 		if (optlen !=3D sizeof(struct sock_txtime)) {
 			ret =3D -EINVAL;
 			break;
-		} else if (copy_from_user(&sk_txtime, optval,
+		} else if (copy_from_sockptr(&sk_txtime, optval,
 			   sizeof(struct sock_txtime))) {
 			ret =3D -EFAULT;
 			break;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f0b0b503c2628d..27b6f250b87dfd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1643,7 +1643,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_s=
ock *msk, int optname,
 			return -EINVAL;
 		}
 =

-		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
+		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname,
+				      USER_SOCKPTR(optval), optlen);
 		if (ret =3D=3D 0) {
 			if (optname =3D=3D SO_REUSEPORT)
 				sk->sk_reuseport =3D ssock->sk->sk_reuseport;
@@ -1654,7 +1655,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_s=
ock *msk, int optname,
 		return ret;
 	}
 =

-	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen=
);
+	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
+			       USER_SOCKPTR(optval), optlen);
 }
 =

 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
diff --git a/net/socket.c b/net/socket.c
index 93846568c2fb7a..c97f83d879ae75 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2130,7 +2130,8 @@ int __sys_setsockopt(int fd, int level, int optname, =
char __user *optval,
 	}
 =

 	if (level =3D=3D SOL_SOCKET && !sock_use_custom_sol_socket(sock))
-		err =3D sock_setsockopt(sock, level, optname, optval, optlen);
+		err =3D sock_setsockopt(sock, level, optname,
+				      USER_SOCKPTR(optval), optlen);
 	else if (unlikely(!sock->ops->setsockopt))
 		err =3D -EOPNOTSUPP;
 	else
-- =

2.27.0

--===============5538553753698637589==--
