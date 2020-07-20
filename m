Content-Type: multipart/mixed; boundary="===============2805161236900952546=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 19/24] net/ipv6: factor out a ipv6_set_opt_hdr helper
Date: Mon, 20 Jul 2020 14:47:32 +0200
Message-ID: <20200720124737.118617-20-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5119

--===============2805161236900952546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factour out a helper to set the IPv6 option headers from
do_ipv6_setsockopt.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv6/ipv6_sockglue.c | 150 +++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 3897fb55372d38..90442c8366dff2 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -315,6 +315,80 @@ static int compat_ipv6_mcast_join_leave(struct sock *s=
k, int optname,
 	return ipv6_sock_mc_drop(sk, gr32.gr_interface, &psin6->sin6_addr);
 }
 =

+static int ipv6_set_opt_hdr(struct sock *sk, int optname, void __user *opt=
val,
+		int optlen)
+{
+	struct ipv6_pinfo *np =3D inet6_sk(sk);
+	struct ipv6_opt_hdr *new =3D NULL;
+	struct net *net =3D sock_net(sk);
+	struct ipv6_txoptions *opt;
+	int err;
+
+	/* hop-by-hop / destination options are privileged option */
+	if (optname !=3D IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
+		return -EPERM;
+
+	/* remove any sticky options header with a zero option
+	 * length, per RFC3542.
+	 */
+	if (optlen > 0) {
+		if (!optval)
+			return -EINVAL;
+		if (optlen < sizeof(struct ipv6_opt_hdr) ||
+		    optlen & 0x7 ||
+		    optlen > 8 * 255)
+			return -EINVAL;
+
+		new =3D memdup_user(optval, optlen);
+		if (IS_ERR(new))
+			return PTR_ERR(new);
+		if (unlikely(ipv6_optlen(new) > optlen)) {
+			kfree(new);
+			return -EINVAL;
+		}
+	}
+
+	opt =3D rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
+	opt =3D ipv6_renew_options(sk, opt, optname, new);
+	kfree(new);
+	if (IS_ERR(opt))
+		return PTR_ERR(opt);
+
+	/* routing header option needs extra check */
+	err =3D -EINVAL;
+	if (optname =3D=3D IPV6_RTHDR && opt && opt->srcrt) {
+		struct ipv6_rt_hdr *rthdr =3D opt->srcrt;
+		switch (rthdr->type) {
+#if IS_ENABLED(CONFIG_IPV6_MIP6)
+		case IPV6_SRCRT_TYPE_2:
+			if (rthdr->hdrlen !=3D 2 || rthdr->segments_left !=3D 1)
+				goto sticky_done;
+			break;
+#endif
+		case IPV6_SRCRT_TYPE_4:
+		{
+			struct ipv6_sr_hdr *srh =3D
+				(struct ipv6_sr_hdr *)opt->srcrt;
+
+			if (!seg6_validate_srh(srh, optlen, false))
+				goto sticky_done;
+			break;
+		}
+		default:
+			goto sticky_done;
+		}
+	}
+
+	err =3D 0;
+	opt =3D ipv6_update_options(sk, opt);
+sticky_done:
+	if (opt) {
+		atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
+		txopt_put(opt);
+	}
+	return err;
+}
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -580,82 +654,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int lev=
el, int optname,
 	case IPV6_RTHDRDSTOPTS:
 	case IPV6_RTHDR:
 	case IPV6_DSTOPTS:
-	{
-		struct ipv6_txoptions *opt;
-		struct ipv6_opt_hdr *new =3D NULL;
-
-		/* hop-by-hop / destination options are privileged option */
-		retv =3D -EPERM;
-		if (optname !=3D IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
-			break;
-
-		/* remove any sticky options header with a zero option
-		 * length, per RFC3542.
-		 */
-		if (optlen =3D=3D 0)
-			optval =3D NULL;
-		else if (!optval)
-			goto e_inval;
-		else if (optlen < sizeof(struct ipv6_opt_hdr) ||
-			 optlen & 0x7 || optlen > 8 * 255)
-			goto e_inval;
-		else {
-			new =3D memdup_user(optval, optlen);
-			if (IS_ERR(new)) {
-				retv =3D PTR_ERR(new);
-				break;
-			}
-			if (unlikely(ipv6_optlen(new) > optlen)) {
-				kfree(new);
-				goto e_inval;
-			}
-		}
-
-		opt =3D rcu_dereference_protected(np->opt,
-						lockdep_sock_is_held(sk));
-		opt =3D ipv6_renew_options(sk, opt, optname, new);
-		kfree(new);
-		if (IS_ERR(opt)) {
-			retv =3D PTR_ERR(opt);
-			break;
-		}
-
-		/* routing header option needs extra check */
-		retv =3D -EINVAL;
-		if (optname =3D=3D IPV6_RTHDR && opt && opt->srcrt) {
-			struct ipv6_rt_hdr *rthdr =3D opt->srcrt;
-			switch (rthdr->type) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-			case IPV6_SRCRT_TYPE_2:
-				if (rthdr->hdrlen !=3D 2 ||
-				    rthdr->segments_left !=3D 1)
-					goto sticky_done;
-
-				break;
-#endif
-			case IPV6_SRCRT_TYPE_4:
-			{
-				struct ipv6_sr_hdr *srh =3D (struct ipv6_sr_hdr *)
-							  opt->srcrt;
-
-				if (!seg6_validate_srh(srh, optlen, false))
-					goto sticky_done;
-				break;
-			}
-			default:
-				goto sticky_done;
-			}
-		}
-
-		retv =3D 0;
-		opt =3D ipv6_update_options(sk, opt);
-sticky_done:
-		if (opt) {
-			atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
-			txopt_put(opt);
-		}
+		retv =3D ipv6_set_opt_hdr(sk, optname, optval, optlen);
 		break;
-	}
 =

 	case IPV6_PKTINFO:
 	{
-- =

2.27.0

--===============2805161236900952546==--
