Content-Type: multipart/mixed; boundary="===============1916698080840988538=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 18/26] net/ipv6: split up ipv6_flowlabel_opt
Date: Thu, 23 Jul 2020 08:09:00 +0200
Message-ID: <20200723060908.50081-19-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5218

--===============1916698080840988538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split ipv6_flowlabel_opt into a subfunction for each action and a small
wrapper.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/ipv6/ip6_flowlabel.c | 311 +++++++++++++++++++++------------------
 1 file changed, 167 insertions(+), 144 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index ce4fbba4acce7e..27ee6de9beffc4 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -533,187 +533,210 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct =
in6_flowlabel_req *freq,
 	return -ENOENT;
 }
 =

-int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
+#define socklist_dereference(__sflp) \
+	rcu_dereference_protected(__sflp, lockdep_is_held(&ip6_sk_fl_lock))
+
+static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *f=
req)
 {
-	int uninitialized_var(err);
-	struct net *net =3D sock_net(sk);
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
-	struct in6_flowlabel_req freq;
-	struct ipv6_fl_socklist *sfl1 =3D NULL;
-	struct ipv6_fl_socklist *sfl;
 	struct ipv6_fl_socklist __rcu **sflp;
-	struct ip6_flowlabel *fl, *fl1 =3D NULL;
-
+	struct ipv6_fl_socklist *sfl;
 =

-	if (optlen < sizeof(freq))
-		return -EINVAL;
+	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
+		if (sk->sk_protocol !=3D IPPROTO_TCP)
+			return -ENOPROTOOPT;
+		if (!np->repflow)
+			return -ESRCH;
+		np->flow_label =3D 0;
+		np->repflow =3D 0;
+		return 0;
+	}
 =

-	if (copy_from_user(&freq, optval, sizeof(freq)))
-		return -EFAULT;
+	spin_lock_bh(&ip6_sk_fl_lock);
+	for (sflp =3D &np->ipv6_fl_list;
+	     (sfl =3D socklist_dereference(*sflp)) !=3D NULL;
+	     sflp =3D &sfl->next) {
+		if (sfl->fl->label =3D=3D freq->flr_label)
+			goto found;
+	}
+	spin_unlock_bh(&ip6_sk_fl_lock);
+	return -ESRCH;
+found:
+	if (freq->flr_label =3D=3D (np->flow_label & IPV6_FLOWLABEL_MASK))
+		np->flow_label &=3D ~IPV6_FLOWLABEL_MASK;
+	*sflp =3D sfl->next;
+	spin_unlock_bh(&ip6_sk_fl_lock);
+	fl_release(sfl->fl);
+	kfree_rcu(sfl, rcu);
+	return 0;
+}
+		=

+static int ipv6_flowlabel_renew(struct sock *sk, struct in6_flowlabel_req =
*freq)
+{
+	struct ipv6_pinfo *np =3D inet6_sk(sk);
+	struct net *net =3D sock_net(sk);
+	struct ipv6_fl_socklist *sfl;
+	int err;
 =

-	switch (freq.flr_action) {
-	case IPV6_FL_A_PUT:
-		if (freq.flr_flags & IPV6_FL_F_REFLECT) {
-			if (sk->sk_protocol !=3D IPPROTO_TCP)
-				return -ENOPROTOOPT;
-			if (!np->repflow)
-				return -ESRCH;
-			np->flow_label =3D 0;
-			np->repflow =3D 0;
-			return 0;
-		}
-		spin_lock_bh(&ip6_sk_fl_lock);
-		for (sflp =3D &np->ipv6_fl_list;
-		     (sfl =3D rcu_dereference_protected(*sflp,
-						      lockdep_is_held(&ip6_sk_fl_lock))) !=3D NULL;
-		     sflp =3D &sfl->next) {
-			if (sfl->fl->label =3D=3D freq.flr_label) {
-				if (freq.flr_label =3D=3D (np->flow_label&IPV6_FLOWLABEL_MASK))
-					np->flow_label &=3D ~IPV6_FLOWLABEL_MASK;
-				*sflp =3D sfl->next;
-				spin_unlock_bh(&ip6_sk_fl_lock);
-				fl_release(sfl->fl);
-				kfree_rcu(sfl, rcu);
-				return 0;
-			}
+	rcu_read_lock_bh();
+	for_each_sk_fl_rcu(np, sfl) {
+		if (sfl->fl->label =3D=3D freq->flr_label) {
+			err =3D fl6_renew(sfl->fl, freq->flr_linger,
+					freq->flr_expires);
+			rcu_read_unlock_bh();
+			return err;
 		}
-		spin_unlock_bh(&ip6_sk_fl_lock);
-		return -ESRCH;
+	}
+	rcu_read_unlock_bh();
 =

-	case IPV6_FL_A_RENEW:
-		rcu_read_lock_bh();
-		for_each_sk_fl_rcu(np, sfl) {
-			if (sfl->fl->label =3D=3D freq.flr_label) {
-				err =3D fl6_renew(sfl->fl, freq.flr_linger, freq.flr_expires);
-				rcu_read_unlock_bh();
-				return err;
-			}
-		}
-		rcu_read_unlock_bh();
+	if (freq->flr_share =3D=3D IPV6_FL_S_NONE &&
+	    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		struct ip6_flowlabel *fl =3D fl_lookup(net, freq->flr_label);
 =

-		if (freq.flr_share =3D=3D IPV6_FL_S_NONE &&
-		    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
-			fl =3D fl_lookup(net, freq.flr_label);
-			if (fl) {
-				err =3D fl6_renew(fl, freq.flr_linger, freq.flr_expires);
-				fl_release(fl);
-				return err;
-			}
+		if (fl) {
+			err =3D fl6_renew(fl, freq->flr_linger,
+					freq->flr_expires);
+			fl_release(fl);
+			return err;
 		}
-		return -ESRCH;
-
-	case IPV6_FL_A_GET:
-		if (freq.flr_flags & IPV6_FL_F_REFLECT) {
-			struct net *net =3D sock_net(sk);
-			if (net->ipv6.sysctl.flowlabel_consistency) {
-				net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consi=
stency sysctl is enable\n");
-				return -EPERM;
-			}
+	}
+	return -ESRCH;
+}
 =

-			if (sk->sk_protocol !=3D IPPROTO_TCP)
-				return -ENOPROTOOPT;
+static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *f=
req,
+		void __user *optval, int optlen)
+{
+	struct ipv6_fl_socklist *sfl, *sfl1 =3D NULL;
+	struct ip6_flowlabel *fl, *fl1 =3D NULL;
+	struct ipv6_pinfo *np =3D inet6_sk(sk);
+	struct net *net =3D sock_net(sk);
+	int uninitialized_var(err);
 =

-			np->repflow =3D 1;
-			return 0;
+	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
+		if (net->ipv6.sysctl.flowlabel_consistency) {
+			net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consis=
tency sysctl is enable\n");
+			return -EPERM;
 		}
 =

-		if (freq.flr_label & ~IPV6_FLOWLABEL_MASK)
-			return -EINVAL;
+		if (sk->sk_protocol !=3D IPPROTO_TCP)
+			return -ENOPROTOOPT;
+		np->repflow =3D 1;
+		return 0;
+	}
 =

-		if (net->ipv6.sysctl.flowlabel_state_ranges &&
-		    (freq.flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
-			return -ERANGE;
+	if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
+		return -EINVAL;
+	if (net->ipv6.sysctl.flowlabel_state_ranges &&
+	    (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
+		return -ERANGE;
 =

-		fl =3D fl_create(net, sk, &freq, optval, optlen, &err);
-		if (!fl)
-			return err;
-		sfl1 =3D kmalloc(sizeof(*sfl1), GFP_KERNEL);
+	fl =3D fl_create(net, sk, freq, optval, optlen, &err);
+	if (!fl)
+		return err;
 =

-		if (freq.flr_label) {
-			err =3D -EEXIST;
-			rcu_read_lock_bh();
-			for_each_sk_fl_rcu(np, sfl) {
-				if (sfl->fl->label =3D=3D freq.flr_label) {
-					if (freq.flr_flags&IPV6_FL_F_EXCL) {
-						rcu_read_unlock_bh();
-						goto done;
-					}
-					fl1 =3D sfl->fl;
-					if (!atomic_inc_not_zero(&fl1->users))
-						fl1 =3D NULL;
-					break;
+	sfl1 =3D kmalloc(sizeof(*sfl1), GFP_KERNEL);
+
+	if (freq->flr_label) {
+		err =3D -EEXIST;
+		rcu_read_lock_bh();
+		for_each_sk_fl_rcu(np, sfl) {
+			if (sfl->fl->label =3D=3D freq->flr_label) {
+				if (freq->flr_flags & IPV6_FL_F_EXCL) {
+					rcu_read_unlock_bh();
+					goto done;
 				}
+				fl1 =3D sfl->fl;
+				if (!atomic_inc_not_zero(&fl1->users))
+					fl1 =3D NULL;
+				break;
 			}
-			rcu_read_unlock_bh();
+		}
+		rcu_read_unlock_bh();
 =

-			if (!fl1)
-				fl1 =3D fl_lookup(net, freq.flr_label);
-			if (fl1) {
+		if (!fl1)
+			fl1 =3D fl_lookup(net, freq->flr_label);
+		if (fl1) {
 recheck:
-				err =3D -EEXIST;
-				if (freq.flr_flags&IPV6_FL_F_EXCL)
-					goto release;
-				err =3D -EPERM;
-				if (fl1->share =3D=3D IPV6_FL_S_EXCL ||
-				    fl1->share !=3D fl->share ||
-				    ((fl1->share =3D=3D IPV6_FL_S_PROCESS) &&
-				     (fl1->owner.pid !=3D fl->owner.pid)) ||
-				    ((fl1->share =3D=3D IPV6_FL_S_USER) &&
-				     !uid_eq(fl1->owner.uid, fl->owner.uid)))
-					goto release;
-
-				err =3D -ENOMEM;
-				if (!sfl1)
-					goto release;
-				if (fl->linger > fl1->linger)
-					fl1->linger =3D fl->linger;
-				if ((long)(fl->expires - fl1->expires) > 0)
-					fl1->expires =3D fl->expires;
-				fl_link(np, sfl1, fl1);
-				fl_free(fl);
-				return 0;
+			err =3D -EEXIST;
+			if (freq->flr_flags&IPV6_FL_F_EXCL)
+				goto release;
+			err =3D -EPERM;
+			if (fl1->share =3D=3D IPV6_FL_S_EXCL ||
+			    fl1->share !=3D fl->share ||
+			    ((fl1->share =3D=3D IPV6_FL_S_PROCESS) &&
+			     (fl1->owner.pid !=3D fl->owner.pid)) ||
+			    ((fl1->share =3D=3D IPV6_FL_S_USER) &&
+			     !uid_eq(fl1->owner.uid, fl->owner.uid)))
+				goto release;
+
+			err =3D -ENOMEM;
+			if (!sfl1)
+				goto release;
+			if (fl->linger > fl1->linger)
+				fl1->linger =3D fl->linger;
+			if ((long)(fl->expires - fl1->expires) > 0)
+				fl1->expires =3D fl->expires;
+			fl_link(np, sfl1, fl1);
+			fl_free(fl);
+			return 0;
 =

 release:
-				fl_release(fl1);
-				goto done;
-			}
-		}
-		err =3D -ENOENT;
-		if (!(freq.flr_flags&IPV6_FL_F_CREATE))
+			fl_release(fl1);
 			goto done;
+		}
+	}
+	err =3D -ENOENT;
+	if (!(freq->flr_flags & IPV6_FL_F_CREATE))
+		goto done;
 =

-		err =3D -ENOMEM;
-		if (!sfl1)
-			goto done;
+	err =3D -ENOMEM;
+	if (!sfl1)
+		goto done;
 =

-		err =3D mem_check(sk);
-		if (err !=3D 0)
-			goto done;
+	err =3D mem_check(sk);
+	if (err !=3D 0)
+		goto done;
 =

-		fl1 =3D fl_intern(net, fl, freq.flr_label);
-		if (fl1)
-			goto recheck;
+	fl1 =3D fl_intern(net, fl, freq->flr_label);
+	if (fl1)
+		goto recheck;
 =

-		if (!freq.flr_label) {
-			if (copy_to_user(&((struct in6_flowlabel_req __user *) optval)->flr_lab=
el,
-					 &fl->label, sizeof(fl->label))) {
-				/* Intentionally ignore fault. */
-			}
+	if (!freq->flr_label) {
+		if (copy_to_user(&((struct in6_flowlabel_req __user *) optval)->flr_labe=
l,
+				 &fl->label, sizeof(fl->label))) {
+			/* Intentionally ignore fault. */
 		}
-
-		fl_link(np, sfl1, fl);
-		return 0;
-
-	default:
-		return -EINVAL;
 	}
 =

+	fl_link(np, sfl1, fl);
+	return 0;
 done:
 	fl_free(fl);
 	kfree(sfl1);
 	return err;
 }
 =

+int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
+{
+	struct in6_flowlabel_req freq;
+
+	if (optlen < sizeof(freq))
+		return -EINVAL;
+	if (copy_from_user(&freq, optval, sizeof(freq)))
+		return -EFAULT;
+
+	switch (freq.flr_action) {
+	case IPV6_FL_A_PUT:
+		return ipv6_flowlabel_put(sk, &freq);
+	case IPV6_FL_A_RENEW:
+		return ipv6_flowlabel_renew(sk, &freq);
+	case IPV6_FL_A_GET:
+		return ipv6_flowlabel_get(sk, &freq, optval, optlen);
+	default:
+		return -EINVAL;
+	}
+}
+
 #ifdef CONFIG_PROC_FS
 =

 struct ip6fl_iter_state {
-- =

2.27.0

--===============1916698080840988538==--
