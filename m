Content-Type: multipart/mixed; boundary="===============3521287858230558126=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 4/5] genetlink: add CAP_NET_ADMIN test
 for multicast bind
Date: Wed, 20 Jan 2021 16:43:36 +0100
Message-ID: <20210120154337.27997-5-fw@strlen.de>
In-Reply-To: 20210120154337.27997-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7458

--===============3521287858230558126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

genetlink sets NL_CFG_F_NONROOT_RECV for its netlink socket so anyone can
subscribe to multicast messages.

rtnetlink doesn't allow this unconditionally,  rtnetlink_bind() restricts
bind requests to CAP_NET_ADMIN for a few groups.

This allows to set GENL_UNS_ADMIN_PERM flag on genl mcast groups to
mandate CAP_NET_ADMIN.

This will be used by the upcoming mptcp netlink event facility which
exposes the token (mptcp connection identifier) to userspace.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/genetlink.h |  1 +
 net/netlink/genetlink.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e55ec1597ce7..7cb3fa8310ed 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -14,6 +14,7 @@
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
+	u8			flags;
 };
 =

 struct genl_ops;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index c992424e4d63..2d6fdf40df66 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1360,11 +1360,43 @@ static struct genl_family genl_ctrl __ro_after_init=
 =3D {
 	.netnsok =3D true,
 };
 =

+static int genl_bind(struct net *net, int group)
+{
+	const struct genl_family *family;
+	unsigned int id;
+	int ret =3D 0;
+
+	genl_lock_all();
+
+	idr_for_each_entry(&genl_fam_idr, family, id) {
+		const struct genl_multicast_group *grp;
+		int i;
+
+		if (family->n_mcgrps =3D=3D 0)
+			continue;
+
+		i =3D group - family->mcgrp_offset;
+		if (i < 0 || i >=3D family->n_mcgrps)
+			continue;
+
+		grp =3D &family->mcgrps[i];
+		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+			ret =3D -EPERM;
+
+		break;
+	}
+
+	genl_unlock_all();
+	return ret;
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg =3D {
 		.input		=3D genl_rcv,
 		.flags		=3D NL_CFG_F_NONROOT_RECV,
+		.bind		=3D genl_bind,
 	};
 =

 	/* we'll bump the group number right afterwards */
-- =

2.26.2

--===============3521287858230558126==--
