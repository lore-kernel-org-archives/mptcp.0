Content-Type: multipart/mixed; boundary="===============8044177322208994729=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/22] netfilter/arp_tables: clean up compat {get,
 set}sockopt handling
Date: Fri, 17 Jul 2020 08:23:16 +0200
Message-ID: <20200717062331.691152-8-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5056

--===============8044177322208994729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Merge the native and compat {get,set}sockopt handlers using
in_compat_syscall().

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv4/netfilter/arp_tables.c | 85 ++++++++-------------------------
 1 file changed, 21 insertions(+), 64 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_table=
s.c
index b167f4a5b68453..15807fb4a65f3e 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -787,8 +787,7 @@ static int compat_table_info(const struct xt_table_info=
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
@@ -802,7 +801,7 @@ static int get_info(struct net *net, void __user *user,
 =

 	name[XT_TABLE_MAXNAMELEN-1] =3D '\0';
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_lock(NFPROTO_ARP);
 #endif
 	t =3D xt_request_find_table_lock(net, NFPROTO_ARP, name);
@@ -812,7 +811,7 @@ static int get_info(struct net *net, void __user *user,
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
 =

-		if (compat) {
+		if (in_compat_syscall()) {
 			ret =3D compat_table_info(private, &tmp);
 			xt_compat_flush_offsets(NFPROTO_ARP);
 			private =3D &tmp;
@@ -837,7 +836,7 @@ static int get_info(struct net *net, void __user *user,
 	} else
 		ret =3D PTR_ERR(t);
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_unlock(NFPROTO_ARP);
 #endif
 	return ret;
@@ -998,7 +997,7 @@ static int do_replace(struct net *net, const void __use=
r *user,
 }
 =

 static int do_add_counters(struct net *net, const void __user *user,
-			   unsigned int len, int compat)
+			   unsigned int len)
 {
 	unsigned int i;
 	struct xt_counters_info tmp;
@@ -1009,7 +1008,8 @@ static int do_add_counters(struct net *net, const voi=
d __user *user,
 	struct arpt_entry *iter;
 	unsigned int addend;
 =

-	paddc =3D xt_copy_counters_from_user(user, len, &tmp, compat);
+	paddc =3D xt_copy_counters_from_user(user, len, &tmp,
+					   in_compat_syscall());
 	if (IS_ERR(paddc))
 		return PTR_ERR(paddc);
 =

@@ -1294,30 +1294,6 @@ static int compat_do_replace(struct net *net, void _=
_user *user,
 	return ret;
 }
 =

-static int compat_do_arpt_set_ctl(struct sock *sk, int cmd, void __user *u=
ser,
-				  unsigned int len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case ARPT_SO_SET_REPLACE:
-		ret =3D compat_do_replace(sock_net(sk), user, len);
-		break;
-
-	case ARPT_SO_SET_ADD_COUNTERS:
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
 static int compat_copy_entry_to_user(struct arpt_entry *e, void __user **d=
stptr,
 				     compat_uint_t *size,
 				     struct xt_counters *counters,
@@ -1425,29 +1401,6 @@ static int compat_get_entries(struct net *net,
 	xt_compat_unlock(NFPROTO_ARP);
 	return ret;
 }
-
-static int do_arpt_get_ctl(struct sock *, int, void __user *, int *);
-
-static int compat_do_arpt_get_ctl(struct sock *sk, int cmd, void __user *u=
ser,
-				  int *len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case ARPT_SO_GET_INFO:
-		ret =3D get_info(sock_net(sk), user, len, 1);
-		break;
-	case ARPT_SO_GET_ENTRIES:
-		ret =3D compat_get_entries(sock_net(sk), user, len);
-		break;
-	default:
-		ret =3D do_arpt_get_ctl(sk, cmd, user, len);
-	}
-	return ret;
-}
 #endif
 =

 static int do_arpt_set_ctl(struct sock *sk, int cmd, void __user *user, un=
signed int len)
@@ -1459,11 +1412,16 @@ static int do_arpt_set_ctl(struct sock *sk, int cmd=
, void __user *user, unsigned
 =

 	switch (cmd) {
 	case ARPT_SO_SET_REPLACE:
-		ret =3D do_replace(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_do_replace(sock_net(sk), user, len);
+		else
+#endif
+			ret =3D do_replace(sock_net(sk), user, len);
 		break;
 =

 	case ARPT_SO_SET_ADD_COUNTERS:
-		ret =3D do_add_counters(sock_net(sk), user, len, 0);
+		ret =3D do_add_counters(sock_net(sk), user, len);
 		break;
 =

 	default:
@@ -1482,11 +1440,16 @@ static int do_arpt_get_ctl(struct sock *sk, int cmd=
, void __user *user, int *len
 =

 	switch (cmd) {
 	case ARPT_SO_GET_INFO:
-		ret =3D get_info(sock_net(sk), user, len, 0);
+		ret =3D get_info(sock_net(sk), user, len);
 		break;
 =

 	case ARPT_SO_GET_ENTRIES:
-		ret =3D get_entries(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_get_entries(sock_net(sk), user, len);
+		else
+#endif
+			ret =3D get_entries(sock_net(sk), user, len);
 		break;
 =

 	case ARPT_SO_GET_REVISION_TARGET: {
@@ -1610,15 +1573,9 @@ static struct nf_sockopt_ops arpt_sockopts =3D {
 	.set_optmin	=3D ARPT_BASE_CTL,
 	.set_optmax	=3D ARPT_SO_SET_MAX+1,
 	.set		=3D do_arpt_set_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_set	=3D compat_do_arpt_set_ctl,
-#endif
 	.get_optmin	=3D ARPT_BASE_CTL,
 	.get_optmax	=3D ARPT_SO_GET_MAX+1,
 	.get		=3D do_arpt_get_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_get	=3D compat_do_arpt_get_ctl,
-#endif
 	.owner		=3D THIS_MODULE,
 };
 =

-- =

2.27.0

--===============8044177322208994729==--
