Content-Type: multipart/mixed; boundary="===============2661154846762663926=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Thu, 23 Jul 2020 08:08:54 +0200
Message-ID: <20200723060908.50081-13-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5212

--===============2661154846762663926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 include/linux/netfilter.h       |  6 ++++--
 net/bridge/netfilter/ebtables.c | 37 +++++++++++++++------------------
 net/decnet/af_decnet.c          |  3 ++-
 net/ipv4/ip_sockglue.c          |  3 ++-
 net/ipv4/netfilter/arp_tables.c | 28 ++++++++++++-------------
 net/ipv4/netfilter/ip_tables.c  | 24 ++++++++++-----------
 net/ipv6/ipv6_sockglue.c        |  3 ++-
 net/ipv6/netfilter/ip6_tables.c | 24 ++++++++++-----------
 net/netfilter/ipvs/ip_vs_ctl.c  |  4 ++--
 net/netfilter/nf_sockopt.c      |  2 +-
 10 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 711b4d4486f042..0101747de54936 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -13,6 +13,7 @@
 #include <linux/static_key.h>
 #include <linux/netfilter_defs.h>
 #include <linux/netdevice.h>
+#include <linux/sockptr.h>
 #include <net/net_namespace.h>
 =

 static inline int NF_DROP_GETERR(int verdict)
@@ -163,7 +164,8 @@ struct nf_sockopt_ops {
 	/* Non-inclusive ranges: use 0/0/NULL to never get called. */
 	int set_optmin;
 	int set_optmax;
-	int (*set)(struct sock *sk, int optval, void __user *user, unsigned int l=
en);
+	int (*set)(struct sock *sk, int optval, sockptr_t arg,
+		   unsigned int len);
 	int get_optmin;
 	int get_optmax;
 	int (*get)(struct sock *sk, int optval, void __user *user, int *len);
@@ -338,7 +340,7 @@ NF_HOOK_LIST(uint8_t pf, unsigned int hook, struct net =
*net, struct sock *sk,
 }
 =

 /* Call setsockopt() */
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int optval, char __user *o=
pt,
+int nf_setsockopt(struct sock *sk, u_int8_t pf, int optval, sockptr_t opt,
 		  unsigned int len);
 int nf_getsockopt(struct sock *sk, u_int8_t pf, int optval, char __user *o=
pt,
 		  int *len);
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtable=
s.c
index 12f8929667bf43..d35173e803d3fe 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1063,14 +1063,13 @@ static int do_replace_finish(struct net *net, struc=
t ebt_replace *repl,
 }
 =

 /* replace the table */
-static int do_replace(struct net *net, const void __user *user,
-		      unsigned int len)
+static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret, countersize;
 	struct ebt_table_info *newinfo;
 	struct ebt_replace tmp;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	if (len !=3D sizeof(tmp) + tmp.entries_size)
@@ -1286,12 +1285,11 @@ static int do_update_counters(struct net *net, cons=
t char *name,
 	return ret;
 }
 =

-static int update_counters(struct net *net, const void __user *user,
-			    unsigned int len)
+static int update_counters(struct net *net, sockptr_t arg, unsigned int le=
n)
 {
 	struct ebt_replace hlp;
 =

-	if (copy_from_user(&hlp, user, sizeof(hlp)))
+	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 =

 	if (len !=3D sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
@@ -2079,7 +2077,7 @@ static int compat_copy_entries(unsigned char *data, u=
nsigned int size_user,
 =

 =

 static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
-					    void __user *user, unsigned int len)
+					     sockptr_t arg, unsigned int len)
 {
 	struct compat_ebt_replace tmp;
 	int i;
@@ -2087,7 +2085,7 @@ static int compat_copy_ebt_replace_from_user(struct e=
bt_replace *repl,
 	if (len < sizeof(tmp))
 		return -EINVAL;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)))
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)))
 		return -EFAULT;
 =

 	if (len !=3D sizeof(tmp) + tmp.entries_size)
@@ -2114,8 +2112,7 @@ static int compat_copy_ebt_replace_from_user(struct e=
bt_replace *repl,
 	return 0;
 }
 =

-static int compat_do_replace(struct net *net, void __user *user,
-			     unsigned int len)
+static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int =
len)
 {
 	int ret, i, countersize, size64;
 	struct ebt_table_info *newinfo;
@@ -2123,10 +2120,10 @@ static int compat_do_replace(struct net *net, void =
__user *user,
 	struct ebt_entries_buf_state state;
 	void *entries_tmp;
 =

-	ret =3D compat_copy_ebt_replace_from_user(&tmp, user, len);
+	ret =3D compat_copy_ebt_replace_from_user(&tmp, arg, len);
 	if (ret) {
 		/* try real handler in case userland supplied needed padding */
-		if (ret =3D=3D -EINVAL && do_replace(net, user, len) =3D=3D 0)
+		if (ret =3D=3D -EINVAL && do_replace(net, arg, len) =3D=3D 0)
 			ret =3D 0;
 		return ret;
 	}
@@ -2217,17 +2214,17 @@ static int compat_do_replace(struct net *net, void =
__user *user,
 	goto free_entries;
 }
 =

-static int compat_update_counters(struct net *net, void __user *user,
+static int compat_update_counters(struct net *net, sockptr_t arg,
 				  unsigned int len)
 {
 	struct compat_ebt_replace hlp;
 =

-	if (copy_from_user(&hlp, user, sizeof(hlp)))
+	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 =

 	/* try real handler in case userland supplied needed padding */
 	if (len !=3D sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
-		return update_counters(net, user, len);
+		return update_counters(net, arg, len);
 =

 	return do_update_counters(net, hlp.name, compat_ptr(hlp.counters),
 				  hlp.num_counters, len);
@@ -2368,7 +2365,7 @@ static int do_ebt_get_ctl(struct sock *sk, int cmd, v=
oid __user *user, int *len)
 	return ret;
 }
 =

-static int do_ebt_set_ctl(struct sock *sk, int cmd, void __user *user,
+static int do_ebt_set_ctl(struct sock *sk, int cmd, sockptr_t arg,
 		unsigned int len)
 {
 	struct net *net =3D sock_net(sk);
@@ -2381,18 +2378,18 @@ static int do_ebt_set_ctl(struct sock *sk, int cmd,=
 void __user *user,
 	case EBT_SO_SET_ENTRIES:
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret =3D compat_do_replace(net, user, len);
+			ret =3D compat_do_replace(net, arg, len);
 		else
 #endif
-			ret =3D do_replace(net, user, len);
+			ret =3D do_replace(net, arg, len);
 		break;
 	case EBT_SO_SET_COUNTERS:
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret =3D compat_update_counters(net, user, len);
+			ret =3D compat_update_counters(net, arg, len);
 		else
 #endif
-			ret =3D update_counters(net, user, len);
+			ret =3D update_counters(net, arg, len);
 		break;
 	default:
 		ret =3D -EINVAL;
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index 7d7ae2dd69b8ad..7d51ab608fb3f1 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1332,7 +1332,8 @@ static int dn_setsockopt(struct socket *sock, int lev=
el, int optname, char __use
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D DSO_LINKINFO &&
 	    optname !=3D DSO_STREAM && optname !=3D DSO_SEQPACKET)
-		err =3D nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
+		err =3D nf_setsockopt(sk, PF_DECnet, optname,
+				    USER_SOCKPTR(optval), optlen);
 #endif
 =

 	return err;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index da933f99b5d517..42befbf12846c0 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1422,7 +1422,8 @@ int ip_setsockopt(struct sock *sk, int level,
 			optname !=3D IP_IPSEC_POLICY &&
 			optname !=3D IP_XFRM_POLICY &&
 			!ip_mroute_opt(optname))
-		err =3D nf_setsockopt(sk, PF_INET, optname, optval, optlen);
+		err =3D nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(optval),
+				    optlen);
 #endif
 	return err;
 }
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_table=
s.c
index 6d24b686c7f00a..f5b26ef1782001 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+
 /*
  * Packet matching code for ARP packets.
  *
@@ -947,8 +947,7 @@ static int __do_replace(struct net *net, const char *na=
me,
 	return ret;
 }
 =

-static int do_replace(struct net *net, const void __user *user,
-		      unsigned int len)
+static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret;
 	struct arpt_replace tmp;
@@ -956,7 +955,7 @@ static int do_replace(struct net *net, const void __use=
r *user,
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -972,8 +971,8 @@ static int do_replace(struct net *net, const void __use=
r *user,
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
-			   tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1244,8 +1243,7 @@ static int translate_compat_table(struct net *net,
 	return ret;
 }
 =

-static int compat_do_replace(struct net *net, void __user *user,
-			     unsigned int len)
+static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int =
len)
 {
 	int ret;
 	struct compat_arpt_replace tmp;
@@ -1253,7 +1251,7 @@ static int compat_do_replace(struct net *net, void __=
user *user,
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -1269,7 +1267,8 @@ static int compat_do_replace(struct net *net, void __=
user *user,
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp), tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1401,7 +1400,8 @@ static int compat_get_entries(struct net *net,
 }
 #endif
 =

-static int do_arpt_set_ctl(struct sock *sk, int cmd, void __user *user, un=
signed int len)
+static int do_arpt_set_ctl(struct sock *sk, int cmd, sockptr_t arg,
+		unsigned int len)
 {
 	int ret;
 =

@@ -1412,14 +1412,14 @@ static int do_arpt_set_ctl(struct sock *sk, int cmd=
, void __user *user, unsigned
 	case ARPT_SO_SET_REPLACE:
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret =3D compat_do_replace(sock_net(sk), user, len);
+			ret =3D compat_do_replace(sock_net(sk), arg, len);
 		else
 #endif
-			ret =3D do_replace(sock_net(sk), user, len);
+			ret =3D do_replace(sock_net(sk), arg, len);
 		break;
 =

 	case ARPT_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), USER_SOCKPTR(user), len);
+		ret =3D do_add_counters(sock_net(sk), arg, len);
 		break;
 =

 	default:
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 4697d09c98dc3e..f2a9680303d8c0 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1102,7 +1102,7 @@ __do_replace(struct net *net, const char *name, unsig=
ned int valid_hooks,
 }
 =

 static int
-do_replace(struct net *net, const void __user *user, unsigned int len)
+do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret;
 	struct ipt_replace tmp;
@@ -1110,7 +1110,7 @@ do_replace(struct net *net, const void __user *user, =
unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -1126,8 +1126,8 @@ do_replace(struct net *net, const void __user *user, =
unsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
-			   tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1484,7 +1484,7 @@ translate_compat_table(struct net *net,
 }
 =

 static int
-compat_do_replace(struct net *net, void __user *user, unsigned int len)
+compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret;
 	struct compat_ipt_replace tmp;
@@ -1492,7 +1492,7 @@ compat_do_replace(struct net *net, void __user *user,=
 unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -1508,8 +1508,8 @@ compat_do_replace(struct net *net, void __user *user,=
 unsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
-			   tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1610,7 +1610,7 @@ compat_get_entries(struct net *net, struct compat_ipt=
_get_entries __user *uptr,
 #endif
 =

 static int
-do_ipt_set_ctl(struct sock *sk, int cmd, void __user *user, unsigned int l=
en)
+do_ipt_set_ctl(struct sock *sk, int cmd, sockptr_t arg, unsigned int len)
 {
 	int ret;
 =

@@ -1621,14 +1621,14 @@ do_ipt_set_ctl(struct sock *sk, int cmd, void __use=
r *user, unsigned int len)
 	case IPT_SO_SET_REPLACE:
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret =3D compat_do_replace(sock_net(sk), user, len);
+			ret =3D compat_do_replace(sock_net(sk), arg, len);
 		else
 #endif
-			ret =3D do_replace(sock_net(sk), user, len);
+			ret =3D do_replace(sock_net(sk), arg, len);
 		break;
 =

 	case IPT_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), USER_SOCKPTR(user), len);
+		ret =3D do_add_counters(sock_net(sk), arg, len);
 		break;
 =

 	default:
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 56a74707c61741..85892b35cff7b3 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -996,7 +996,8 @@ int ipv6_setsockopt(struct sock *sk, int level, int opt=
name,
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_IPSEC_POLICY &&
 			optname !=3D IPV6_XFRM_POLICY)
-		err =3D nf_setsockopt(sk, PF_INET6, optname, optval, optlen);
+		err =3D nf_setsockopt(sk, PF_INET6, optname, USER_SOCKPTR(optval),
+				    optlen);
 #endif
 	return err;
 }
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_table=
s.c
index a787aba30e2db7..1d52957a413f4a 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1119,7 +1119,7 @@ __do_replace(struct net *net, const char *name, unsig=
ned int valid_hooks,
 }
 =

 static int
-do_replace(struct net *net, const void __user *user, unsigned int len)
+do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret;
 	struct ip6t_replace tmp;
@@ -1127,7 +1127,7 @@ do_replace(struct net *net, const void __user *user, =
unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -1143,8 +1143,8 @@ do_replace(struct net *net, const void __user *user, =
unsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
-			   tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1493,7 +1493,7 @@ translate_compat_table(struct net *net,
 }
 =

 static int
-compat_do_replace(struct net *net, void __user *user, unsigned int len)
+compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 {
 	int ret;
 	struct compat_ip6t_replace tmp;
@@ -1501,7 +1501,7 @@ compat_do_replace(struct net *net, void __user *user,=
 unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 =

-	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
+	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
 		return -EFAULT;
 =

 	/* overflow check */
@@ -1517,8 +1517,8 @@ compat_do_replace(struct net *net, void __user *user,=
 unsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
-			   tmp.size) !=3D 0) {
+	sockptr_advance(arg, sizeof(tmp));
+	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1619,7 +1619,7 @@ compat_get_entries(struct net *net, struct compat_ip6=
t_get_entries __user *uptr,
 #endif
 =

 static int
-do_ip6t_set_ctl(struct sock *sk, int cmd, void __user *user, unsigned int =
len)
+do_ip6t_set_ctl(struct sock *sk, int cmd, sockptr_t arg, unsigned int len)
 {
 	int ret;
 =

@@ -1630,14 +1630,14 @@ do_ip6t_set_ctl(struct sock *sk, int cmd, void __us=
er *user, unsigned int len)
 	case IP6T_SO_SET_REPLACE:
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret =3D compat_do_replace(sock_net(sk), user, len);
+			ret =3D compat_do_replace(sock_net(sk), arg, len);
 		else
 #endif
-			ret =3D do_replace(sock_net(sk), user, len);
+			ret =3D do_replace(sock_net(sk), arg, len);
 		break;
 =

 	case IP6T_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), USER_SOCKPTR(user), len);
+		ret =3D do_add_counters(sock_net(sk), arg, len);
 		break;
 =

 	default:
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 4af83f466dfc2c..bcac316addabe8 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2434,7 +2434,7 @@ static void ip_vs_copy_udest_compat(struct ip_vs_dest=
_user_kern *udest,
 }
 =

 static int
-do_ip_vs_set_ctl(struct sock *sk, int cmd, void __user *user, unsigned int=
 len)
+do_ip_vs_set_ctl(struct sock *sk, int cmd, sockptr_t ptr, unsigned int len)
 {
 	struct net *net =3D sock_net(sk);
 	int ret;
@@ -2458,7 +2458,7 @@ do_ip_vs_set_ctl(struct sock *sk, int cmd, void __use=
r *user, unsigned int len)
 		return -EINVAL;
 	}
 =

-	if (copy_from_user(arg, user, len) !=3D 0)
+	if (copy_from_sockptr(arg, ptr, len) !=3D 0)
 		return -EFAULT;
 =

 	/* Handle daemons since they have another lock */
diff --git a/net/netfilter/nf_sockopt.c b/net/netfilter/nf_sockopt.c
index 90469b1f628a8e..34afcd03b6f60e 100644
--- a/net/netfilter/nf_sockopt.c
+++ b/net/netfilter/nf_sockopt.c
@@ -89,7 +89,7 @@ static struct nf_sockopt_ops *nf_sockopt_find(struct sock=
 *sk, u_int8_t pf,
 	return ops;
 }
 =

-int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
+int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, sockptr_t opt,
 		  unsigned int len)
 {
 	struct nf_sockopt_ops *ops;
-- =

2.27.0

--===============2661154846762663926==--
