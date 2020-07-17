Content-Type: multipart/mixed; boundary="===============7551627505276779141=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/22] netfilter/ip_tables: clean up compat {get,
 set}sockopt handling
Date: Fri, 17 Jul 2020 08:23:17 +0200
Message-ID: <20200717062331.691152-9-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5057

--===============7551627505276779141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Merge the native and compat {get,set}sockopt handlers using
in_compat_syscall().

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv4/netfilter/ip_tables.c | 86 +++++++++-------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 5bf9fa06aee0be..fbfad38f397949 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -944,8 +944,7 @@ static int compat_table_info(const struct xt_table_info=
 *info,
 }
 #endif
 =

-static int get_info(struct net *net, void __user *user,
-		    const int *len, int compat)
+static int get_info(struct net *net, void __user *user, const int *len)
 {
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
@@ -959,7 +958,7 @@ static int get_info(struct net *net, void __user *user,
 =

 	name[XT_TABLE_MAXNAMELEN-1] =3D '\0';
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_lock(AF_INET);
 #endif
 	t =3D xt_request_find_table_lock(net, AF_INET, name);
@@ -969,7 +968,7 @@ static int get_info(struct net *net, void __user *user,
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
 =

-		if (compat) {
+		if (in_compat_syscall()) {
 			ret =3D compat_table_info(private, &tmp);
 			xt_compat_flush_offsets(AF_INET);
 			private =3D &tmp;
@@ -995,7 +994,7 @@ static int get_info(struct net *net, void __user *user,
 	} else
 		ret =3D PTR_ERR(t);
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_unlock(AF_INET);
 #endif
 	return ret;
@@ -1153,7 +1152,7 @@ do_replace(struct net *net, const void __user *user, =
unsigned int len)
 =

 static int
 do_add_counters(struct net *net, const void __user *user,
-		unsigned int len, int compat)
+		unsigned int len)
 {
 	unsigned int i;
 	struct xt_counters_info tmp;
@@ -1164,7 +1163,8 @@ do_add_counters(struct net *net, const void __user *u=
ser,
 	struct ipt_entry *iter;
 	unsigned int addend;
 =

-	paddc =3D xt_copy_counters_from_user(user, len, &tmp, compat);
+	paddc =3D xt_copy_counters_from_user(user, len, &tmp,
+					   in_compat_syscall());
 	if (IS_ERR(paddc))
 		return PTR_ERR(paddc);
 =

@@ -1534,31 +1534,6 @@ compat_do_replace(struct net *net, void __user *user=
, unsigned int len)
 	return ret;
 }
 =

-static int
-compat_do_ipt_set_ctl(struct sock *sk,	int cmd, void __user *user,
-		      unsigned int len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IPT_SO_SET_REPLACE:
-		ret =3D compat_do_replace(sock_net(sk), user, len);
-		break;
-
-	case IPT_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), user, len, 1);
-		break;
-
-	default:
-		ret =3D -EINVAL;
-	}
-
-	return ret;
-}
-
 struct compat_ipt_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
@@ -1634,29 +1609,6 @@ compat_get_entries(struct net *net, struct compat_ip=
t_get_entries __user *uptr,
 	xt_compat_unlock(AF_INET);
 	return ret;
 }
-
-static int do_ipt_get_ctl(struct sock *, int, void __user *, int *);
-
-static int
-compat_do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *le=
n)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IPT_SO_GET_INFO:
-		ret =3D get_info(sock_net(sk), user, len, 1);
-		break;
-	case IPT_SO_GET_ENTRIES:
-		ret =3D compat_get_entries(sock_net(sk), user, len);
-		break;
-	default:
-		ret =3D do_ipt_get_ctl(sk, cmd, user, len);
-	}
-	return ret;
-}
 #endif
 =

 static int
@@ -1669,11 +1621,16 @@ do_ipt_set_ctl(struct sock *sk, int cmd, void __use=
r *user, unsigned int len)
 =

 	switch (cmd) {
 	case IPT_SO_SET_REPLACE:
-		ret =3D do_replace(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_do_replace(sock_net(sk), user, len);
+		else
+#endif
+			ret =3D do_replace(sock_net(sk), user, len);
 		break;
 =

 	case IPT_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), user, len, 0);
+		ret =3D do_add_counters(sock_net(sk), user, len);
 		break;
 =

 	default:
@@ -1693,11 +1650,16 @@ do_ipt_get_ctl(struct sock *sk, int cmd, void __use=
r *user, int *len)
 =

 	switch (cmd) {
 	case IPT_SO_GET_INFO:
-		ret =3D get_info(sock_net(sk), user, len, 0);
+		ret =3D get_info(sock_net(sk), user, len);
 		break;
 =

 	case IPT_SO_GET_ENTRIES:
-		ret =3D get_entries(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_get_entries(sock_net(sk), user, len);
+		else
+#endif
+			ret =3D get_entries(sock_net(sk), user, len);
 		break;
 =

 	case IPT_SO_GET_REVISION_MATCH:
@@ -1886,15 +1848,9 @@ static struct nf_sockopt_ops ipt_sockopts =3D {
 	.set_optmin	=3D IPT_BASE_CTL,
 	.set_optmax	=3D IPT_SO_SET_MAX+1,
 	.set		=3D do_ipt_set_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_set	=3D compat_do_ipt_set_ctl,
-#endif
 	.get_optmin	=3D IPT_BASE_CTL,
 	.get_optmax	=3D IPT_SO_GET_MAX+1,
 	.get		=3D do_ipt_get_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_get	=3D compat_do_ipt_get_ctl,
-#endif
 	.owner		=3D THIS_MODULE,
 };
 =

-- =

2.27.0

--===============7551627505276779141==--
