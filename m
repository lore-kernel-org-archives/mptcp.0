Content-Type: multipart/mixed; boundary="===============1878657227551472721=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 15/24] net/ipv4: switch do_ip_setsockopt to sockptr_t
Date: Mon, 20 Jul 2020 14:47:28 +0200
Message-ID: <20200720124737.118617-16-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5115

--===============1878657227551472721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv4/ip_sockglue.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b12f39b52008a3..f7f1507b89fe24 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -683,15 +683,15 @@ static int set_mcast_msfilter(struct sock *sk, int if=
index,
 	return -EADDRNOTAVAIL;
 }
 =

-static int copy_group_source_from_user(struct group_source_req *greqs,
-		void __user *optval, int optlen)
+static int copy_group_source_from_sockptr(struct group_source_req *greqs,
+		sockptr_t optval, int optlen)
 {
 	if (in_compat_syscall()) {
 		struct compat_group_source_req gr32;
 =

 		if (optlen !=3D sizeof(gr32))
 			return -EINVAL;
-		if (copy_from_user(&gr32, optval, sizeof(gr32)))
+		if (copy_from_sockptr(&gr32, optval, sizeof(gr32)))
 			return -EFAULT;
 		greqs->gsr_interface =3D gr32.gsr_interface;
 		greqs->gsr_group =3D gr32.gsr_group;
@@ -699,7 +699,7 @@ static int copy_group_source_from_user(struct group_sou=
rce_req *greqs,
 	} else {
 		if (optlen !=3D sizeof(*greqs))
 			return -EINVAL;
-		if (copy_from_user(greqs, optval, sizeof(*greqs)))
+		if (copy_from_sockptr(greqs, optval, sizeof(*greqs)))
 			return -EFAULT;
 	}
 =

@@ -707,14 +707,14 @@ static int copy_group_source_from_user(struct group_s=
ource_req *greqs,
 }
 =

 static int do_mcast_group_source(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct group_source_req greqs;
 	struct ip_mreq_source mreqs;
 	struct sockaddr_in *psin;
 	int omode, add, err;
 =

-	err =3D copy_group_source_from_user(&greqs, optval, optlen);
+	err =3D copy_group_source_from_sockptr(&greqs, optval, optlen);
 	if (err)
 		return err;
 =

@@ -754,8 +754,7 @@ static int do_mcast_group_source(struct sock *sk, int o=
ptname,
 	return ip_mc_source(add, omode, sk, &mreqs, greqs.gsr_interface);
 }
 =

-static int ip_set_mcast_msfilter(struct sock *sk, void __user *optval,
-		int optlen)
+static int ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval, int op=
tlen)
 {
 	struct group_filter *gsf =3D NULL;
 	int err;
@@ -765,7 +764,7 @@ static int ip_set_mcast_msfilter(struct sock *sk, void =
__user *optval,
 	if (optlen > sysctl_optmem_max)
 		return -ENOBUFS;
 =

-	gsf =3D memdup_user(optval, optlen);
+	gsf =3D memdup_sockptr(optval, optlen);
 	if (IS_ERR(gsf))
 		return PTR_ERR(gsf);
 =

@@ -786,7 +785,7 @@ static int ip_set_mcast_msfilter(struct sock *sk, void =
__user *optval,
 	return err;
 }
 =

-static int compat_ip_set_mcast_msfilter(struct sock *sk, void __user *optv=
al,
+static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		int optlen)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist);
@@ -806,7 +805,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk=
, void __user *optval,
 	gf32 =3D p + 4; /* we want ->gf_group and ->gf_slist aligned */
 =

 	err =3D -EFAULT;
-	if (copy_from_user(gf32, optval, optlen))
+	if (copy_from_sockptr(gf32, optval, optlen))
 		goto out_free_gsf;
 =

 	/* numsrc >=3D (4G-140)/128 overflow in 32 bits */
@@ -831,7 +830,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk=
, void __user *optval,
 }
 =

 static int ip_mcast_join_leave(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct ip_mreqn mreq =3D { };
 	struct sockaddr_in *psin;
@@ -839,7 +838,7 @@ static int ip_mcast_join_leave(struct sock *sk, int opt=
name,
 =

 	if (optlen < sizeof(struct group_req))
 		return -EINVAL;
-	if (copy_from_user(&greq, optval, sizeof(greq)))
+	if (copy_from_sockptr(&greq, optval, sizeof(greq)))
 		return -EFAULT;
 =

 	psin =3D (struct sockaddr_in *)&greq.gr_group;
@@ -853,7 +852,7 @@ static int ip_mcast_join_leave(struct sock *sk, int opt=
name,
 }
 =

 static int compat_ip_mcast_join_leave(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct compat_group_req greq;
 	struct ip_mreqn mreq =3D { };
@@ -861,7 +860,7 @@ static int compat_ip_mcast_join_leave(struct sock *sk, =
int optname,
 =

 	if (optlen < sizeof(struct compat_group_req))
 		return -EINVAL;
-	if (copy_from_user(&greq, optval, sizeof(greq)))
+	if (copy_from_sockptr(&greq, optval, sizeof(greq)))
 		return -EFAULT;
 =

 	psin =3D (struct sockaddr_in *)&greq.gr_group;
@@ -875,8 +874,8 @@ static int compat_ip_mcast_join_leave(struct sock *sk, =
int optname,
 	return ip_mc_leave_group(sk, &mreq);
 }
 =

-static int do_ip_setsockopt(struct sock *sk, int level,
-			    int optname, char __user *optval, unsigned int optlen)
+static int do_ip_setsockopt(struct sock *sk, int level, int optname,
+		sockptr_t optval, unsigned int optlen)
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	struct net *net =3D sock_net(sk);
@@ -910,12 +909,12 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l,
 	case IP_RECVFRAGSIZE:
 	case IP_RECVERR_RFC4884:
 		if (optlen >=3D sizeof(int)) {
-			if (get_user(val, (int __user *) optval))
+			if (copy_from_sockptr(&val, optval, sizeof(val)))
 				return -EFAULT;
 		} else if (optlen >=3D sizeof(char)) {
 			unsigned char ucval;
 =

-			if (get_user(ucval, (unsigned char __user *) optval))
+			if (copy_from_sockptr(&ucval, optval, sizeof(ucval)))
 				return -EFAULT;
 			val =3D (int) ucval;
 		}
@@ -926,8 +925,7 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 	if (optname =3D=3D IP_ROUTER_ALERT)
 		return ip_ra_control(sk, val ? 1 : 0, NULL);
 	if (ip_mroute_opt(optname))
-		return ip_mroute_setsockopt(sk, optname, USER_SOCKPTR(optval),
-					    optlen);
+		return ip_mroute_setsockopt(sk, optname, optval, optlen);
 =

 	err =3D 0;
 	if (needs_rtnl)
@@ -941,8 +939,7 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 =

 		if (optlen > 40)
 			goto e_inval;
-		err =3D ip_options_get(sock_net(sk), &opt, USER_SOCKPTR(optval),
-					      optlen);
+		err =3D ip_options_get(sock_net(sk), &opt, optval, optlen);
 		if (err)
 			break;
 		old =3D rcu_dereference_protected(inet->inet_opt,
@@ -1140,17 +1137,17 @@ static int do_ip_setsockopt(struct sock *sk, int le=
vel,
 =

 		err =3D -EFAULT;
 		if (optlen >=3D sizeof(struct ip_mreqn)) {
-			if (copy_from_user(&mreq, optval, sizeof(mreq)))
+			if (copy_from_sockptr(&mreq, optval, sizeof(mreq)))
 				break;
 		} else {
 			memset(&mreq, 0, sizeof(mreq));
 			if (optlen >=3D sizeof(struct ip_mreq)) {
-				if (copy_from_user(&mreq, optval,
-						   sizeof(struct ip_mreq)))
+				if (copy_from_sockptr(&mreq, optval,
+						      sizeof(struct ip_mreq)))
 					break;
 			} else if (optlen >=3D sizeof(struct in_addr)) {
-				if (copy_from_user(&mreq.imr_address, optval,
-						   sizeof(struct in_addr)))
+				if (copy_from_sockptr(&mreq.imr_address, optval,
+						      sizeof(struct in_addr)))
 					break;
 			}
 		}
@@ -1202,11 +1199,12 @@ static int do_ip_setsockopt(struct sock *sk, int le=
vel,
 			goto e_inval;
 		err =3D -EFAULT;
 		if (optlen >=3D sizeof(struct ip_mreqn)) {
-			if (copy_from_user(&mreq, optval, sizeof(mreq)))
+			if (copy_from_sockptr(&mreq, optval, sizeof(mreq)))
 				break;
 		} else {
 			memset(&mreq, 0, sizeof(mreq));
-			if (copy_from_user(&mreq, optval, sizeof(struct ip_mreq)))
+			if (copy_from_sockptr(&mreq, optval,
+					      sizeof(struct ip_mreq)))
 				break;
 		}
 =

@@ -1226,7 +1224,7 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l,
 			err =3D -ENOBUFS;
 			break;
 		}
-		msf =3D memdup_user(optval, optlen);
+		msf =3D memdup_sockptr(optval, optlen);
 		if (IS_ERR(msf)) {
 			err =3D PTR_ERR(msf);
 			break;
@@ -1257,7 +1255,7 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l,
 =

 		if (optlen !=3D sizeof(struct ip_mreq_source))
 			goto e_inval;
-		if (copy_from_user(&mreqs, optval, sizeof(mreqs))) {
+		if (copy_from_sockptr(&mreqs, optval, sizeof(mreqs))) {
 			err =3D -EFAULT;
 			break;
 		}
@@ -1324,8 +1322,7 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l,
 		err =3D -EPERM;
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 			break;
-		err =3D xfrm_user_policy(sk, optname, USER_SOCKPTR(optval),
-				       optlen);
+		err =3D xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 =

 	case IP_TRANSPARENT:
@@ -1412,7 +1409,8 @@ int ip_setsockopt(struct sock *sk, int level,
 	if (level !=3D SOL_IP)
 		return -ENOPROTOOPT;
 =

-	err =3D do_ip_setsockopt(sk, level, optname, optval, optlen);
+	err =3D do_ip_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
+			       optlen);
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >=3D BPFILTER_IPT_SO_SET_REPLACE &&
 	    optname < BPFILTER_IPT_SET_MAX)
-- =

2.27.0

--===============1878657227551472721==--
