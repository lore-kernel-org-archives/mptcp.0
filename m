Content-Type: multipart/mixed; boundary="===============8647924190590335823=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 17/22] net/ipv4: remove compat_ip_{get,set}sockopt
Date: Fri, 17 Jul 2020 08:23:26 +0200
Message-ID: <20200717062331.691152-18-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5067

--===============8647924190590335823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the few cases that need special treatment in-line using
in_compat_syscall().

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 include/net/ip.h       |   4 -
 net/dccp/ipv4.c        |   4 -
 net/ipv4/ip_sockglue.c | 214 ++++++++++++-----------------------------
 net/ipv4/raw.c         |  22 -----
 net/ipv4/tcp_ipv4.c    |   4 -
 net/ipv4/udp.c         |  24 -----
 net/ipv4/udp_impl.h    |   6 --
 net/ipv4/udplite.c     |   4 -
 net/l2tp/l2tp_ip.c     |   4 -
 net/sctp/protocol.c    |   4 -
 10 files changed, 61 insertions(+), 229 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 862c9545833a95..3d34acc95ca825 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -727,10 +727,6 @@ int ip_setsockopt(struct sock *sk, int level, int optn=
ame, char __user *optval,
 		  unsigned int optlen);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *op=
tval,
 		  int __user *optlen);
-int compat_ip_setsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, unsigned int optlen);
-int compat_ip_getsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, int __user *optlen);
 int ip_ra_control(struct sock *sk, unsigned char on,
 		  void (*destructor)(struct sock *));
 =

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 316cc5ac0da72b..b91373eb1c7974 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -913,10 +913,6 @@ static const struct inet_connection_sock_af_ops dccp_i=
pv4_af_ops =3D {
 	.getsockopt	   =3D ip_getsockopt,
 	.addr2sockaddr	   =3D inet_csk_addr2sockaddr,
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_ip_setsockopt,
-	.compat_getsockopt =3D compat_ip_getsockopt,
-#endif
 };
 =

 static int dccp_v4_init_sock(struct sock *sk)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 73bb88fbe54661..86b3b9a7cea30d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -679,20 +679,48 @@ static int set_mcast_msfilter(struct sock *sk, int if=
index,
 	return -EADDRNOTAVAIL;
 }
 =

+static int copy_group_source_from_user(struct group_source_req *greqs,
+		void __user *optval, int optlen)
+{
+	if (in_compat_syscall()) {
+		struct compat_group_source_req gr32;
+
+		if (optlen !=3D sizeof(gr32))
+			return -EINVAL;
+		if (copy_from_user(&gr32, optval, sizeof(gr32)))
+			return -EFAULT;
+		greqs->gsr_interface =3D gr32.gsr_interface;
+		greqs->gsr_group =3D gr32.gsr_group;
+		greqs->gsr_source =3D gr32.gsr_source;
+	} else {
+		if (optlen !=3D sizeof(*greqs))
+			return -EINVAL;
+		if (copy_from_user(greqs, optval, sizeof(*greqs)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int do_mcast_group_source(struct sock *sk, int optname,
-				 struct group_source_req *greqs)
+		void __user *optval, int optlen)
 {
+	struct group_source_req greqs;
 	struct ip_mreq_source mreqs;
 	struct sockaddr_in *psin;
 	int omode, add, err;
 =

-	if (greqs->gsr_group.ss_family !=3D AF_INET ||
-	    greqs->gsr_source.ss_family !=3D AF_INET)
+	err =3D copy_group_source_from_user(&greqs, optval, optlen);
+	if (err)
+		return err;
+
+	if (greqs.gsr_group.ss_family !=3D AF_INET ||
+	    greqs.gsr_source.ss_family !=3D AF_INET)
 		return -EADDRNOTAVAIL;
 =

-	psin =3D (struct sockaddr_in *)&greqs->gsr_group;
+	psin =3D (struct sockaddr_in *)&greqs.gsr_group;
 	mreqs.imr_multiaddr =3D psin->sin_addr.s_addr;
-	psin =3D (struct sockaddr_in *)&greqs->gsr_source;
+	psin =3D (struct sockaddr_in *)&greqs.gsr_source;
 	mreqs.imr_sourceaddr =3D psin->sin_addr.s_addr;
 	mreqs.imr_interface =3D 0; /* use index for mc_source */
 =

@@ -705,21 +733,21 @@ static int do_mcast_group_source(struct sock *sk, int=
 optname,
 	} else if (optname =3D=3D MCAST_JOIN_SOURCE_GROUP) {
 		struct ip_mreqn mreq;
 =

-		psin =3D (struct sockaddr_in *)&greqs->gsr_group;
+		psin =3D (struct sockaddr_in *)&greqs.gsr_group;
 		mreq.imr_multiaddr =3D psin->sin_addr;
 		mreq.imr_address.s_addr =3D 0;
-		mreq.imr_ifindex =3D greqs->gsr_interface;
+		mreq.imr_ifindex =3D greqs.gsr_interface;
 		err =3D ip_mc_join_group_ssm(sk, &mreq, MCAST_INCLUDE);
 		if (err && err !=3D -EADDRINUSE)
 			return err;
-		greqs->gsr_interface =3D mreq.imr_ifindex;
+		greqs.gsr_interface =3D mreq.imr_ifindex;
 		omode =3D MCAST_INCLUDE;
 		add =3D 1;
 	} else /* MCAST_LEAVE_SOURCE_GROUP */ {
 		omode =3D MCAST_INCLUDE;
 		add =3D 0;
 	}
-	return ip_mc_source(add, omode, sk, &mreqs, greqs->gsr_interface);
+	return ip_mc_source(add, omode, sk, &mreqs, greqs.gsr_interface);
 }
 =

 static int ip_set_mcast_msfilter(struct sock *sk, void __user *optval,
@@ -754,7 +782,6 @@ static int ip_set_mcast_msfilter(struct sock *sk, void =
__user *optval,
 	return err;
 }
 =

-#ifdef CONFIG_COMPAT
 static int compat_ip_set_mcast_msfilter(struct sock *sk, void __user *optv=
al,
 		int optlen)
 {
@@ -788,23 +815,16 @@ static int compat_ip_set_mcast_msfilter(struct sock *=
sk, void __user *optval,
 	if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen)
 		goto out_free_gsf;
 =

-	rtnl_lock();
-	lock_sock(sk);
-
 	/* numsrc >=3D (4G-140)/128 overflow in 32 bits */
 	err =3D -ENOBUFS;
 	if (n > sock_net(sk)->ipv4.sysctl_igmp_max_msf)
-		goto out_unlock;
+		goto out_free_gsf;
 	err =3D set_mcast_msfilter(sk, gf32->gf_interface, n, gf32->gf_fmode,
 				 &gf32->gf_group, gf32->gf_slist);
-out_unlock:
-	release_sock(sk);
-	rtnl_unlock();
 out_free_gsf:
 	kfree(p);
 	return err;
 }
-#endif
 =

 static int ip_mcast_join_leave(struct sock *sk, int optname,
 		void __user *optval, int optlen)
@@ -828,14 +848,12 @@ static int ip_mcast_join_leave(struct sock *sk, int o=
ptname,
 	return ip_mc_leave_group(sk, &mreq);
 }
 =

-#ifdef CONFIG_COMPAT
 static int compat_ip_mcast_join_leave(struct sock *sk, int optname,
 		void __user *optval, int optlen)
 {
 	struct compat_group_req greq;
 	struct ip_mreqn mreq =3D { };
 	struct sockaddr_in *psin;
-	int err;
 =

 	if (optlen < sizeof(struct compat_group_req))
 		return -EINVAL;
@@ -848,17 +866,10 @@ static int compat_ip_mcast_join_leave(struct sock *sk=
, int optname,
 	mreq.imr_multiaddr =3D psin->sin_addr;
 	mreq.imr_ifindex =3D greq.gr_interface;
 =

-	rtnl_lock();
-	lock_sock(sk);
 	if (optname =3D=3D MCAST_JOIN_GROUP)
-		err =3D ip_mc_join_group(sk, &mreq);
-	else
-		err =3D ip_mc_leave_group(sk, &mreq);
-	release_sock(sk);
-	rtnl_unlock();
-	return err;
+		return ip_mc_join_group(sk, &mreq);
+	return ip_mc_leave_group(sk, &mreq);
 }
-#endif
 =

 static int do_ip_setsockopt(struct sock *sk, int level,
 			    int optname, char __user *optval, unsigned int optlen)
@@ -1265,26 +1276,23 @@ static int do_ip_setsockopt(struct sock *sk, int le=
vel,
 	}
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
-		err =3D ip_mcast_join_leave(sk, optname, optval, optlen);
+		if (in_compat_syscall())
+			err =3D compat_ip_mcast_join_leave(sk, optname, optval,
+							 optlen);
+		else
+			err =3D ip_mcast_join_leave(sk, optname, optval, optlen);
 		break;
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
 	case MCAST_UNBLOCK_SOURCE:
-	{
-		struct group_source_req greqs;
-
-		if (optlen !=3D sizeof(struct group_source_req))
-			goto e_inval;
-		if (copy_from_user(&greqs, optval, sizeof(greqs))) {
-			err =3D -EFAULT;
-			break;
-		}
-		err =3D do_mcast_group_source(sk, optname, &greqs);
+		err =3D do_mcast_group_source(sk, optname, optval, optlen);
 		break;
-	}
 	case MCAST_MSFILTER:
-		err =3D ip_set_mcast_msfilter(sk, optval, optlen);
+		if (in_compat_syscall())
+			err =3D compat_ip_set_mcast_msfilter(sk, optval, optlen);
+		else
+			err =3D ip_set_mcast_msfilter(sk, optval, optlen);
 		break;
 	case IP_MULTICAST_ALL:
 		if (optlen < 1)
@@ -1410,62 +1418,6 @@ int ip_setsockopt(struct sock *sk, int level,
 }
 EXPORT_SYMBOL(ip_setsockopt);
 =

-#ifdef CONFIG_COMPAT
-int compat_ip_setsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, unsigned int optlen)
-{
-	int err;
-
-	if (level !=3D SOL_IP)
-		return -ENOPROTOOPT;
-
-	switch (optname) {
-	case MCAST_JOIN_GROUP:
-	case MCAST_LEAVE_GROUP:
-		return compat_ip_mcast_join_leave(sk, optname, optval, optlen);
-	case MCAST_JOIN_SOURCE_GROUP:
-	case MCAST_LEAVE_SOURCE_GROUP:
-	case MCAST_BLOCK_SOURCE:
-	case MCAST_UNBLOCK_SOURCE:
-	{
-		struct compat_group_source_req __user *gsr32 =3D (void __user *)optval;
-		struct group_source_req greqs;
-
-		if (optlen !=3D sizeof(struct compat_group_source_req))
-			return -EINVAL;
-
-		if (get_user(greqs.gsr_interface, &gsr32->gsr_interface) ||
-		    copy_from_user(&greqs.gsr_group, &gsr32->gsr_group,
-				sizeof(greqs.gsr_group)) ||
-		    copy_from_user(&greqs.gsr_source, &gsr32->gsr_source,
-				sizeof(greqs.gsr_source)))
-			return -EFAULT;
-
-		rtnl_lock();
-		lock_sock(sk);
-		err =3D do_mcast_group_source(sk, optname, &greqs);
-		release_sock(sk);
-		rtnl_unlock();
-		return err;
-	}
-	case MCAST_MSFILTER:
-		return compat_ip_set_mcast_msfilter(sk, optval, optlen);
-	}
-
-	err =3D do_ip_setsockopt(sk, level, optname, optval, optlen);
-#ifdef CONFIG_NETFILTER
-	/* we need to exclude all possible ENOPROTOOPTs except default case */
-	if (err =3D=3D -ENOPROTOOPT && optname !=3D IP_HDRINCL &&
-			optname !=3D IP_IPSEC_POLICY &&
-			optname !=3D IP_XFRM_POLICY &&
-			!ip_mroute_opt(optname))
-		err =3D nf_setsockopt(sk, PF_INET, optname, optval, optlen);
-#endif
-	return err;
-}
-EXPORT_SYMBOL(compat_ip_setsockopt);
-#endif
-
 /*
  *	Get the options. Note for future reference. The GET of IP options gets
  *	the _received_ ones. The set sets the _sent_ ones.
@@ -1507,22 +1459,18 @@ static int ip_get_mcast_msfilter(struct sock *sk, v=
oid __user *optval,
 	return 0;
 }
 =

-#ifdef CONFIG_COMPAT
 static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optv=
al,
-		int __user *optlen)
+		int __user *optlen, int len)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist);
 	struct compat_group_filter __user *p =3D optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
-	int len, err;
 	int num;
+	int err;
 =

-	if (get_user(len, optlen))
-		return -EFAULT;
 	if (len < size0)
 		return -EINVAL;
-
 	if (copy_from_user(&gf32, p, size0))
 		return -EFAULT;
 =

@@ -1531,11 +1479,7 @@ static int compat_ip_get_mcast_msfilter(struct sock =
*sk, void __user *optval,
 	num =3D gf.gf_numsrc =3D gf32.gf_numsrc;
 	gf.gf_group =3D gf32.gf_group;
 =

-	rtnl_lock();
-	lock_sock(sk);
 	err =3D ip_mc_gsfget(sk, &gf, p->gf_slist);
-	release_sock(sk);
-	rtnl_unlock();
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
@@ -1547,10 +1491,9 @@ static int compat_ip_get_mcast_msfilter(struct sock =
*sk, void __user *optval,
 		return -EFAULT;
 	return 0;
 }
-#endif
 =

 static int do_ip_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen, unsigned int flags)
+			    char __user *optval, int __user *optlen)
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	bool needs_rtnl =3D getsockopt_needs_rtnl(optname);
@@ -1707,7 +1650,11 @@ static int do_ip_getsockopt(struct sock *sk, int lev=
el, int optname,
 		goto out;
 	}
 	case MCAST_MSFILTER:
-		err =3D ip_get_mcast_msfilter(sk, optval, optlen, len);
+		if (in_compat_syscall())
+			err =3D compat_ip_get_mcast_msfilter(sk, optval, optlen,
+							   len);
+		else
+			err =3D ip_get_mcast_msfilter(sk, optval, optlen, len);
 		goto out;
 	case IP_MULTICAST_ALL:
 		val =3D inet->mc_all;
@@ -1724,7 +1671,7 @@ static int do_ip_getsockopt(struct sock *sk, int leve=
l, int optname,
 		msg.msg_control_is_user =3D true;
 		msg.msg_control_user =3D optval;
 		msg.msg_controllen =3D len;
-		msg.msg_flags =3D flags;
+		msg.msg_flags =3D in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
 =

 		if (inet->cmsg_flags & IP_CMSG_PKTINFO) {
 			struct in_pktinfo info;
@@ -1788,45 +1735,7 @@ int ip_getsockopt(struct sock *sk, int level,
 {
 	int err;
 =

-	err =3D do_ip_getsockopt(sk, level, optname, optval, optlen, 0);
-#if IS_ENABLED(CONFIG_BPFILTER_UMH)
-	if (optname >=3D BPFILTER_IPT_SO_GET_INFO &&
-	    optname < BPFILTER_IPT_GET_MAX)
-		err =3D bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
-#endif
-#ifdef CONFIG_NETFILTER
-	/* we need to exclude all possible ENOPROTOOPTs except default case */
-	if (err =3D=3D -ENOPROTOOPT && optname !=3D IP_PKTOPTIONS &&
-			!ip_mroute_opt(optname)) {
-		int len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
-
-		err =3D nf_getsockopt(sk, PF_INET, optname, optval, &len);
-		if (err >=3D 0)
-			err =3D put_user(len, optlen);
-		return err;
-	}
-#endif
-	return err;
-}
-EXPORT_SYMBOL(ip_getsockopt);
-
-#ifdef CONFIG_COMPAT
-int compat_ip_getsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, int __user *optlen)
-{
-	int err;
-
-	if (optname =3D=3D MCAST_MSFILTER) {
-		if (level !=3D SOL_IP)
-			return -EOPNOTSUPP;
-		return compat_ip_get_mcast_msfilter(sk, optval, optlen);
-	}
-
-	err =3D do_ip_getsockopt(sk, level, optname, optval, optlen,
-		MSG_CMSG_COMPAT);
+	err =3D do_ip_getsockopt(sk, level, optname, optval, optlen);
 =

 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >=3D BPFILTER_IPT_SO_GET_INFO &&
@@ -1850,5 +1759,4 @@ int compat_ip_getsockopt(struct sock *sk, int level, =
int optname,
 #endif
 	return err;
 }
-EXPORT_SYMBOL(compat_ip_getsockopt);
-#endif
+EXPORT_SYMBOL(ip_getsockopt);
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 47665919048f9d..2a57d633b31e00 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -857,16 +857,6 @@ static int raw_setsockopt(struct sock *sk, int level, =
int optname,
 	return do_raw_setsockopt(sk, level, optname, optval, optlen);
 }
 =

-#ifdef CONFIG_COMPAT
-static int compat_raw_setsockopt(struct sock *sk, int level, int optname,
-				 char __user *optval, unsigned int optlen)
-{
-	if (level !=3D SOL_RAW)
-		return compat_ip_setsockopt(sk, level, optname, optval, optlen);
-	return do_raw_setsockopt(sk, level, optname, optval, optlen);
-}
-#endif
-
 static int do_raw_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
@@ -887,16 +877,6 @@ static int raw_getsockopt(struct sock *sk, int level, =
int optname,
 	return do_raw_getsockopt(sk, level, optname, optval, optlen);
 }
 =

-#ifdef CONFIG_COMPAT
-static int compat_raw_getsockopt(struct sock *sk, int level, int optname,
-				 char __user *optval, int __user *optlen)
-{
-	if (level !=3D SOL_RAW)
-		return compat_ip_getsockopt(sk, level, optname, optval, optlen);
-	return do_raw_getsockopt(sk, level, optname, optval, optlen);
-}
-#endif
-
 static int raw_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -980,8 +960,6 @@ struct proto raw_prot =3D {
 	.usersize	   =3D sizeof_field(struct raw_sock, filter),
 	.h.raw_hash	   =3D &raw_v4_hashinfo,
 #ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_raw_setsockopt,
-	.compat_getsockopt =3D compat_raw_getsockopt,
 	.compat_ioctl	   =3D compat_raw_ioctl,
 #endif
 	.diag_destroy	   =3D raw_abort,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 116c11a0aaed62..e5b7ef9a288769 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2134,10 +2134,6 @@ const struct inet_connection_sock_af_ops ipv4_specif=
ic =3D {
 	.getsockopt	   =3D ip_getsockopt,
 	.addr2sockaddr	   =3D inet_csk_addr2sockaddr,
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_ip_setsockopt,
-	.compat_getsockopt =3D compat_ip_getsockopt,
-#endif
 	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
 };
 EXPORT_SYMBOL(ipv4_specific);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 073d346f515c44..d4be4471c424e3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2656,17 +2656,6 @@ int udp_setsockopt(struct sock *sk, int level, int o=
ptname,
 	return ip_setsockopt(sk, level, optname, optval, optlen);
 }
 =

-#ifdef CONFIG_COMPAT
-int compat_udp_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
-{
-	if (level =3D=3D SOL_UDP  ||  level =3D=3D SOL_UDPLITE)
-		return udp_lib_setsockopt(sk, level, optname, optval, optlen,
-					  udp_push_pending_frames);
-	return compat_ip_setsockopt(sk, level, optname, optval, optlen);
-}
-#endif
-
 int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		       char __user *optval, int __user *optlen)
 {
@@ -2732,15 +2721,6 @@ int udp_getsockopt(struct sock *sk, int level, int o=
ptname,
 	return ip_getsockopt(sk, level, optname, optval, optlen);
 }
 =

-#ifdef CONFIG_COMPAT
-int compat_udp_getsockopt(struct sock *sk, int level, int optname,
-				 char __user *optval, int __user *optlen)
-{
-	if (level =3D=3D SOL_UDP  ||  level =3D=3D SOL_UDPLITE)
-		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
-	return compat_ip_getsockopt(sk, level, optname, optval, optlen);
-}
-#endif
 /**
  * 	udp_poll - wait for a UDP event.
  *	@file: - file struct
@@ -2812,10 +2792,6 @@ struct proto udp_prot =3D {
 	.sysctl_rmem_offset	=3D offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		=3D sizeof(struct udp_sock),
 	.h.udp_table		=3D &udp_table,
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt	=3D compat_udp_setsockopt,
-	.compat_getsockopt	=3D compat_udp_getsockopt,
-#endif
 	.diag_destroy		=3D udp_abort,
 };
 EXPORT_SYMBOL(udp_prot);
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index 6b2fa77eeb1c3e..ab313702c87f30 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -17,12 +17,6 @@ int udp_setsockopt(struct sock *sk, int level, int optna=
me,
 int udp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 =

-#ifdef CONFIG_COMPAT
-int compat_udp_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen);
-int compat_udp_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen);
-#endif
 int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblo=
ck,
 		int flags, int *addr_len);
 int udp_sendpage(struct sock *sk, struct page *page, int offset, size_t si=
ze,
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index 5936d66d1ce2f2..bd8773b49e72ed 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -56,10 +56,6 @@ struct proto 	udplite_prot =3D {
 	.sysctl_mem	   =3D sysctl_udp_mem,
 	.obj_size	   =3D sizeof(struct udp_sock),
 	.h.udp_table	   =3D &udplite_table,
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_udp_setsockopt,
-	.compat_getsockopt =3D compat_udp_getsockopt,
-#endif
 };
 EXPORT_SYMBOL(udplite_prot);
 =

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index f8d7412cfb3d37..2a3fd31fb589dc 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -612,10 +612,6 @@ static struct proto l2tp_ip_prot =3D {
 	.hash		   =3D l2tp_ip_hash,
 	.unhash		   =3D l2tp_ip_unhash,
 	.obj_size	   =3D sizeof(struct l2tp_ip_sock),
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_ip_setsockopt,
-	.compat_getsockopt =3D compat_ip_getsockopt,
-#endif
 };
 =

 static const struct proto_ops l2tp_ip_ops =3D {
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 8d25cc464efdf3..7ecaf7d575c097 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1089,10 +1089,6 @@ static struct sctp_af sctp_af_inet =3D {
 	.net_header_len	   =3D sizeof(struct iphdr),
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
 	.ip_options_len	   =3D sctp_v4_ip_options_len,
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt =3D compat_ip_setsockopt,
-	.compat_getsockopt =3D compat_ip_getsockopt,
-#endif
 };
 =

 struct sctp_pf *sctp_get_pf_specific(sa_family_t family)
-- =

2.27.0

--===============8647924190590335823==--
