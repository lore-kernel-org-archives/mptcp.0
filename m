Content-Type: multipart/mixed; boundary="===============8607670840031283689=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 10/22] netfilter/ebtables: clean up compat {get,
 set}sockopt handling
Date: Fri, 17 Jul 2020 08:23:19 +0200
Message-ID: <20200717062331.691152-11-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5059

--===============8607670840031283689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Merge the native and compat {get,set}sockopt handlers using
in_compat_syscall().  Note that this required moving a fair
amout of code around to be done sanely.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/bridge/netfilter/ebtables.c | 214 +++++++++++++++-----------------
 1 file changed, 98 insertions(+), 116 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtable=
s.c
index c83ffe9121639c..fe13108af1f542 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1451,86 +1451,6 @@ static int copy_everything_to_user(struct ebt_table =
*t, void __user *user,
 	   ebt_entry_to_user, entries, tmp.entries);
 }
 =

-static int do_ebt_set_ctl(struct sock *sk,
-	int cmd, void __user *user, unsigned int len)
-{
-	int ret;
-	struct net *net =3D sock_net(sk);
-
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case EBT_SO_SET_ENTRIES:
-		ret =3D do_replace(net, user, len);
-		break;
-	case EBT_SO_SET_COUNTERS:
-		ret =3D update_counters(net, user, len);
-		break;
-	default:
-		ret =3D -EINVAL;
-	}
-	return ret;
-}
-
-static int do_ebt_get_ctl(struct sock *sk, int cmd, void __user *user, int=
 *len)
-{
-	int ret;
-	struct ebt_replace tmp;
-	struct ebt_table *t;
-	struct net *net =3D sock_net(sk);
-
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (copy_from_user(&tmp, user, sizeof(tmp)))
-		return -EFAULT;
-
-	tmp.name[sizeof(tmp.name) - 1] =3D '\0';
-
-	t =3D find_table_lock(net, tmp.name, &ret, &ebt_mutex);
-	if (!t)
-		return ret;
-
-	switch (cmd) {
-	case EBT_SO_GET_INFO:
-	case EBT_SO_GET_INIT_INFO:
-		if (*len !=3D sizeof(struct ebt_replace)) {
-			ret =3D -EINVAL;
-			mutex_unlock(&ebt_mutex);
-			break;
-		}
-		if (cmd =3D=3D EBT_SO_GET_INFO) {
-			tmp.nentries =3D t->private->nentries;
-			tmp.entries_size =3D t->private->entries_size;
-			tmp.valid_hooks =3D t->valid_hooks;
-		} else {
-			tmp.nentries =3D t->table->nentries;
-			tmp.entries_size =3D t->table->entries_size;
-			tmp.valid_hooks =3D t->table->valid_hooks;
-		}
-		mutex_unlock(&ebt_mutex);
-		if (copy_to_user(user, &tmp, *len) !=3D 0) {
-			ret =3D -EFAULT;
-			break;
-		}
-		ret =3D 0;
-		break;
-
-	case EBT_SO_GET_ENTRIES:
-	case EBT_SO_GET_INIT_ENTRIES:
-		ret =3D copy_everything_to_user(t, user, len, cmd);
-		mutex_unlock(&ebt_mutex);
-		break;
-
-	default:
-		mutex_unlock(&ebt_mutex);
-		ret =3D -EINVAL;
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_COMPAT
 /* 32 bit-userspace compatibility definitions. */
 struct compat_ebt_replace {
@@ -2314,28 +2234,6 @@ static int compat_update_counters(struct net *net, v=
oid __user *user,
 					hlp.num_counters, user, len);
 }
 =

-static int compat_do_ebt_set_ctl(struct sock *sk,
-		int cmd, void __user *user, unsigned int len)
-{
-	int ret;
-	struct net *net =3D sock_net(sk);
-
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case EBT_SO_SET_ENTRIES:
-		ret =3D compat_do_replace(net, user, len);
-		break;
-	case EBT_SO_SET_COUNTERS:
-		ret =3D compat_update_counters(net, user, len);
-		break;
-	default:
-		ret =3D -EINVAL;
-	}
-	return ret;
-}
-
 static int compat_do_ebt_get_ctl(struct sock *sk, int cmd,
 		void __user *user, int *len)
 {
@@ -2344,14 +2242,6 @@ static int compat_do_ebt_get_ctl(struct sock *sk, in=
t cmd,
 	struct ebt_table *t;
 	struct net *net =3D sock_net(sk);
 =

-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	/* try real handler in case userland supplied needed padding */
-	if ((cmd =3D=3D EBT_SO_GET_INFO ||
-	     cmd =3D=3D EBT_SO_GET_INIT_INFO) && *len !=3D sizeof(tmp))
-			return do_ebt_get_ctl(sk, cmd, user, len);
-
 	if (copy_from_user(&tmp, user, sizeof(tmp)))
 		return -EFAULT;
 =

@@ -2413,20 +2303,112 @@ static int compat_do_ebt_get_ctl(struct sock *sk, =
int cmd,
 }
 #endif
 =

+static int do_ebt_get_ctl(struct sock *sk, int cmd, void __user *user, int=
 *len)
+{
+	struct net *net =3D sock_net(sk);
+	struct ebt_replace tmp;
+	struct ebt_table *t;
+	int ret;
+
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+#ifdef CONFIG_COMPAT
+	/* try real handler in case userland supplied needed padding */
+	if (in_compat_syscall() &&
+	    ((cmd !=3D EBT_SO_GET_INFO && cmd !=3D EBT_SO_GET_INIT_INFO) ||
+	     *len !=3D sizeof(tmp)))
+		return compat_do_ebt_get_ctl(sk, cmd, user, len);
+#endif
+
+	if (copy_from_user(&tmp, user, sizeof(tmp)))
+		return -EFAULT;
+
+	tmp.name[sizeof(tmp.name) - 1] =3D '\0';
+
+	t =3D find_table_lock(net, tmp.name, &ret, &ebt_mutex);
+	if (!t)
+		return ret;
+
+	switch (cmd) {
+	case EBT_SO_GET_INFO:
+	case EBT_SO_GET_INIT_INFO:
+		if (*len !=3D sizeof(struct ebt_replace)) {
+			ret =3D -EINVAL;
+			mutex_unlock(&ebt_mutex);
+			break;
+		}
+		if (cmd =3D=3D EBT_SO_GET_INFO) {
+			tmp.nentries =3D t->private->nentries;
+			tmp.entries_size =3D t->private->entries_size;
+			tmp.valid_hooks =3D t->valid_hooks;
+		} else {
+			tmp.nentries =3D t->table->nentries;
+			tmp.entries_size =3D t->table->entries_size;
+			tmp.valid_hooks =3D t->table->valid_hooks;
+		}
+		mutex_unlock(&ebt_mutex);
+		if (copy_to_user(user, &tmp, *len) !=3D 0) {
+			ret =3D -EFAULT;
+			break;
+		}
+		ret =3D 0;
+		break;
+
+	case EBT_SO_GET_ENTRIES:
+	case EBT_SO_GET_INIT_ENTRIES:
+		ret =3D copy_everything_to_user(t, user, len, cmd);
+		mutex_unlock(&ebt_mutex);
+		break;
+
+	default:
+		mutex_unlock(&ebt_mutex);
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int do_ebt_set_ctl(struct sock *sk, int cmd, void __user *user,
+		unsigned int len)
+{
+	struct net *net =3D sock_net(sk);
+	int ret;
+
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	switch (cmd) {
+	case EBT_SO_SET_ENTRIES:
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_do_replace(net, user, len);
+		else
+#endif
+			ret =3D do_replace(net, user, len);
+		break;
+	case EBT_SO_SET_COUNTERS:
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret =3D compat_update_counters(net, user, len);
+		else
+#endif
+			ret =3D update_counters(net, user, len);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+	return ret;
+}
+
 static struct nf_sockopt_ops ebt_sockopts =3D {
 	.pf		=3D PF_INET,
 	.set_optmin	=3D EBT_BASE_CTL,
 	.set_optmax	=3D EBT_SO_SET_MAX + 1,
 	.set		=3D do_ebt_set_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_set	=3D compat_do_ebt_set_ctl,
-#endif
 	.get_optmin	=3D EBT_BASE_CTL,
 	.get_optmax	=3D EBT_SO_GET_MAX + 1,
 	.get		=3D do_ebt_get_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_get	=3D compat_do_ebt_get_ctl,
-#endif
 	.owner		=3D THIS_MODULE,
 };
 =

-- =

2.27.0

--===============8607670840031283689==--
