Content-Type: multipart/mixed; boundary="===============0933469692552083567=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 23/24] net/tcp: switch do_tcp_setsockopt to sockptr_t
Date: Mon, 20 Jul 2020 14:47:36 +0200
Message-ID: <20200720124737.118617-24-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5123

--===============0933469692552083567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv4/tcp.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 49bf15c27deac7..71cbc61c335f71 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2764,7 +2764,7 @@ static inline bool tcp_can_repair_sock(const struct s=
ock *sk)
 		(sk->sk_state !=3D TCP_LISTEN);
 }
 =

-static int tcp_repair_set_window(struct tcp_sock *tp, char __user *optbuf,=
 int len)
+static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, in=
t len)
 {
 	struct tcp_repair_window opt;
 =

@@ -2774,7 +2774,7 @@ static int tcp_repair_set_window(struct tcp_sock *tp,=
 char __user *optbuf, int l
 	if (len !=3D sizeof(opt))
 		return -EINVAL;
 =

-	if (copy_from_user(&opt, optbuf, sizeof(opt)))
+	if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
 		return -EFAULT;
 =

 	if (opt.max_window < opt.snd_wnd)
@@ -2796,17 +2796,17 @@ static int tcp_repair_set_window(struct tcp_sock *t=
p, char __user *optbuf, int l
 	return 0;
 }
 =

-static int tcp_repair_options_est(struct sock *sk,
-		struct tcp_repair_opt __user *optbuf, unsigned int len)
+static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
+		unsigned int len)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_repair_opt opt;
 =

 	while (len >=3D sizeof(opt)) {
-		if (copy_from_user(&opt, optbuf, sizeof(opt)))
+		if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
 			return -EFAULT;
 =

-		optbuf++;
+		sockptr_advance(optbuf, sizeof(opt));
 		len -=3D sizeof(opt);
 =

 		switch (opt.opt_code) {
@@ -3020,8 +3020,8 @@ EXPORT_SYMBOL(tcp_sock_set_keepcnt);
 /*
  *	Socket option code for TCP.
  */
-static int do_tcp_setsockopt(struct sock *sk, int level,
-		int optname, char __user *optval, unsigned int optlen)
+static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
+		sockptr_t optval, unsigned int optlen)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -3037,7 +3037,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 		if (optlen < 1)
 			return -EINVAL;
 =

-		val =3D strncpy_from_user(name, optval,
+		val =3D strncpy_from_sockptr(name, optval,
 					min_t(long, TCP_CA_NAME_MAX-1, optlen));
 		if (val < 0)
 			return -EFAULT;
@@ -3056,7 +3056,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 		if (optlen < 1)
 			return -EINVAL;
 =

-		val =3D strncpy_from_user(name, optval,
+		val =3D strncpy_from_sockptr(name, optval,
 					min_t(long, TCP_ULP_NAME_MAX - 1,
 					      optlen));
 		if (val < 0)
@@ -3079,7 +3079,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 		    optlen !=3D TCP_FASTOPEN_KEY_BUF_LENGTH)
 			return -EINVAL;
 =

-		if (copy_from_user(key, optval, optlen))
+		if (copy_from_sockptr(key, optval, optlen))
 			return -EFAULT;
 =

 		if (optlen =3D=3D TCP_FASTOPEN_KEY_BUF_LENGTH)
@@ -3095,7 +3095,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 =

-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
 =

 	lock_sock(sk);
@@ -3174,9 +3174,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 		if (!tp->repair)
 			err =3D -EINVAL;
 		else if (sk->sk_state =3D=3D TCP_ESTABLISHED)
-			err =3D tcp_repair_options_est(sk,
-					(struct tcp_repair_opt __user *)optval,
-					optlen);
+			err =3D tcp_repair_options_est(sk, optval, optlen);
 		else
 			err =3D -EPERM;
 		break;
@@ -3249,8 +3247,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
-		err =3D tp->af_specific->md5_parse(sk, optname,
-						 USER_SOCKPTR(optval), optlen);
+		err =3D tp->af_specific->md5_parse(sk, optname, optval, optlen);
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
@@ -3334,7 +3331,8 @@ int tcp_setsockopt(struct sock *sk, int level, int op=
tname, char __user *optval,
 	if (level !=3D SOL_TCP)
 		return icsk->icsk_af_ops->setsockopt(sk, level, optname,
 						     optval, optlen);
-	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
+	return do_tcp_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
+				 optlen);
 }
 EXPORT_SYMBOL(tcp_setsockopt);
 =

-- =

2.27.0

--===============0933469692552083567==--
