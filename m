Content-Type: multipart/mixed; boundary="===============2007880960382647565=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 20/24] net/ipv6: switch do_ipv6_setsockopt to sockptr_t
Date: Mon, 20 Jul 2020 14:47:33 +0200
Message-ID: <20200720124737.118617-21-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5120

--===============2007880960382647565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv6/ipv6_sockglue.c | 66 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 90442c8366dff2..dcd000a5a9b124 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -136,15 +136,15 @@ static bool setsockopt_needs_rtnl(int optname)
 	return false;
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

 		if (optlen < sizeof(gr32))
 			return -EINVAL;
-		if (copy_from_user(&gr32, optval, sizeof(gr32)))
+		if (copy_from_sockptr(&gr32, optval, sizeof(gr32)))
 			return -EFAULT;
 		greqs->gsr_interface =3D gr32.gsr_interface;
 		greqs->gsr_group =3D gr32.gsr_group;
@@ -152,7 +152,7 @@ static int copy_group_source_from_user(struct group_sou=
rce_req *greqs,
 	} else {
 		if (optlen < sizeof(*greqs))
 			return -EINVAL;
-		if (copy_from_user(greqs, optval, sizeof(*greqs)))
+		if (copy_from_sockptr(greqs, optval, sizeof(*greqs)))
 			return -EFAULT;
 	}
 =

@@ -160,13 +160,13 @@ static int copy_group_source_from_user(struct group_s=
ource_req *greqs,
 }
 =

 static int do_ipv6_mcast_group_source(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct group_source_req greqs;
 	int omode, add;
 	int ret;
 =

-	ret =3D copy_group_source_from_user(&greqs, optval, optlen);
+	ret =3D copy_group_source_from_sockptr(&greqs, optval, optlen);
 	if (ret)
 		return ret;
 =

@@ -200,7 +200,7 @@ static int do_ipv6_mcast_group_source(struct sock *sk, =
int optname,
 	return ip6_mc_source(add, omode, sk, &greqs);
 }
 =

-static int ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
+static int ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		int optlen)
 {
 	struct group_filter *gsf;
@@ -211,7 +211,7 @@ static int ipv6_set_mcast_msfilter(struct sock *sk, voi=
d __user *optval,
 	if (optlen > sysctl_optmem_max)
 		return -ENOBUFS;
 =

-	gsf =3D memdup_user(optval, optlen);
+	gsf =3D memdup_sockptr(optval, optlen);
 	if (IS_ERR(gsf))
 		return PTR_ERR(gsf);
 =

@@ -231,7 +231,7 @@ static int ipv6_set_mcast_msfilter(struct sock *sk, voi=
d __user *optval,
 	return ret;
 }
 =

-static int compat_ipv6_set_mcast_msfilter(struct sock *sk, void __user *op=
tval,
+static int compat_ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optva=
l,
 		int optlen)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist);
@@ -251,7 +251,7 @@ static int compat_ipv6_set_mcast_msfilter(struct sock *=
sk, void __user *optval,
 =

 	gf32 =3D p + 4; /* we want ->gf_group and ->gf_slist aligned */
 	ret =3D -EFAULT;
-	if (copy_from_user(gf32, optval, optlen))
+	if (copy_from_sockptr(gf32, optval, optlen))
 		goto out_free_p;
 =

 	/* numsrc >=3D (4G-140)/128 overflow in 32 bits */
@@ -276,14 +276,14 @@ static int compat_ipv6_set_mcast_msfilter(struct sock=
 *sk, void __user *optval,
 }
 =

 static int ipv6_mcast_join_leave(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct sockaddr_in6 *psin6;
 	struct group_req greq;
 =

 	if (optlen < sizeof(greq))
 		return -EINVAL;
-	if (copy_from_user(&greq, optval, sizeof(greq)))
+	if (copy_from_sockptr(&greq, optval, sizeof(greq)))
 		return -EFAULT;
 =

 	if (greq.gr_group.ss_family !=3D AF_INET6)
@@ -296,14 +296,14 @@ static int ipv6_mcast_join_leave(struct sock *sk, int=
 optname,
 }
 =

 static int compat_ipv6_mcast_join_leave(struct sock *sk, int optname,
-		void __user *optval, int optlen)
+		sockptr_t optval, int optlen)
 {
 	struct compat_group_req gr32;
 	struct sockaddr_in6 *psin6;
 =

 	if (optlen < sizeof(gr32))
 		return -EINVAL;
-	if (copy_from_user(&gr32, optval, sizeof(gr32)))
+	if (copy_from_sockptr(&gr32, optval, sizeof(gr32)))
 		return -EFAULT;
 =

 	if (gr32.gr_group.ss_family !=3D AF_INET6)
@@ -315,7 +315,7 @@ static int compat_ipv6_mcast_join_leave(struct sock *sk=
, int optname,
 	return ipv6_sock_mc_drop(sk, gr32.gr_interface, &psin6->sin6_addr);
 }
 =

-static int ipv6_set_opt_hdr(struct sock *sk, int optname, void __user *opt=
val,
+static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 		int optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
@@ -332,14 +332,14 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optn=
ame, void __user *optval,
 	 * length, per RFC3542.
 	 */
 	if (optlen > 0) {
-		if (!optval)
+		if (sockptr_is_null(optval))
 			return -EINVAL;
 		if (optlen < sizeof(struct ipv6_opt_hdr) ||
 		    optlen & 0x7 ||
 		    optlen > 8 * 255)
 			return -EINVAL;
 =

-		new =3D memdup_user(optval, optlen);
+		new =3D memdup_sockptr(optval, optlen);
 		if (IS_ERR(new))
 			return PTR_ERR(new);
 		if (unlikely(ipv6_optlen(new) > optlen)) {
@@ -390,7 +390,7 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optnam=
e, void __user *optval,
 }
 =

 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, unsigned int optlen)
+		   sockptr_t optval, unsigned int optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	struct net *net =3D sock_net(sk);
@@ -398,11 +398,11 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
 	int retv =3D -ENOPROTOOPT;
 	bool needs_rtnl =3D setsockopt_needs_rtnl(optname);
 =

-	if (!optval)
+	if (sockptr_is_null(optval))
 		val =3D 0;
 	else {
 		if (optlen >=3D sizeof(int)) {
-			if (get_user(val, (int __user *) optval))
+			if (copy_from_sockptr(&val, optval, sizeof(val)))
 				return -EFAULT;
 		} else
 			val =3D 0;
@@ -411,8 +411,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int leve=
l, int optname,
 	valbool =3D (val !=3D 0);
 =

 	if (ip6_mroute_opt(optname))
-		return ip6_mroute_setsockopt(sk, optname, USER_SOCKPTR(optval),
-					     optlen);
+		return ip6_mroute_setsockopt(sk, optname, optval, optlen);
 =

 	if (needs_rtnl)
 		rtnl_lock();
@@ -663,12 +662,13 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
 =

 		if (optlen =3D=3D 0)
 			goto e_inval;
-		else if (optlen < sizeof(struct in6_pktinfo) || !optval)
+		else if (optlen < sizeof(struct in6_pktinfo) ||
+			 sockptr_is_null(optval))
 			goto e_inval;
 =

-		if (copy_from_user(&pkt, optval, sizeof(struct in6_pktinfo))) {
-				retv =3D -EFAULT;
-				break;
+		if (copy_from_sockptr(&pkt, optval, sizeof(pkt))) {
+			retv =3D -EFAULT;
+			break;
 		}
 		if (!sk_dev_equal_l3scope(sk, pkt.ipi6_ifindex))
 			goto e_inval;
@@ -709,7 +709,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int leve=
l, int optname,
 		refcount_set(&opt->refcnt, 1);
 		opt->tot_len =3D sizeof(*opt) + optlen;
 		retv =3D -EFAULT;
-		if (copy_from_user(opt+1, optval, optlen))
+		if (copy_from_sockptr(opt + 1, optval, optlen))
 			goto done;
 =

 		msg.msg_controllen =3D optlen;
@@ -831,7 +831,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int leve=
l, int optname,
 			break;
 =

 		retv =3D -EFAULT;
-		if (copy_from_user(&mreq, optval, sizeof(struct ipv6_mreq)))
+		if (copy_from_sockptr(&mreq, optval, sizeof(struct ipv6_mreq)))
 			break;
 =

 		if (optname =3D=3D IPV6_ADD_MEMBERSHIP)
@@ -849,7 +849,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int leve=
l, int optname,
 			goto e_inval;
 =

 		retv =3D -EFAULT;
-		if (copy_from_user(&mreq, optval, sizeof(struct ipv6_mreq)))
+		if (copy_from_sockptr(&mreq, optval, sizeof(struct ipv6_mreq)))
 			break;
 =

 		if (optname =3D=3D IPV6_JOIN_ANYCAST)
@@ -929,15 +929,14 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
 		retv =3D 0;
 		break;
 	case IPV6_FLOWLABEL_MGR:
-		retv =3D ipv6_flowlabel_opt(sk, USER_SOCKPTR(optval), optlen);
+		retv =3D ipv6_flowlabel_opt(sk, optval, optlen);
 		break;
 	case IPV6_IPSEC_POLICY:
 	case IPV6_XFRM_POLICY:
 		retv =3D -EPERM;
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			break;
-		retv =3D xfrm_user_policy(sk, optname, USER_SOCKPTR(optval),
-					optlen);
+		retv =3D xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 =

 	case IPV6_ADDR_PREFERENCES:
@@ -992,7 +991,8 @@ int ipv6_setsockopt(struct sock *sk, int level, int opt=
name,
 	if (level !=3D SOL_IPV6)
 		return -ENOPROTOOPT;
 =

-	err =3D do_ipv6_setsockopt(sk, level, optname, optval, optlen);
+	err =3D do_ipv6_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
+				 optlen);
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_IPSEC_POLICY &&
-- =

2.27.0

--===============2007880960382647565==--
