Content-Type: multipart/mixed; boundary="===============4651133761039346399=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/4] mptcp: add MPTCP socket diag interface
Date: Thu, 09 Jul 2020 15:12:41 +0200
Message-ID: <7f9e6a085163dcb0669b9dd8aace1c62373279db.1594292774.git.pabeni@redhat.com>
In-Reply-To: cover.1594292774.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4958

--===============4651133761039346399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

exposes basic inet socket attribute, plus some MPTCP socket
fields comprising PM status and MPTCP-level sequence numbers.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h |  17 ++++
 net/mptcp/Kconfig          |   4 +
 net/mptcp/Makefile         |   2 +
 net/mptcp/mptcp_diag.c     | 169 +++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 net/mptcp/mptcp_diag.c

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 5f2c77082d9e..9762660df741 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -86,4 +86,21 @@ enum {
 	__MPTCP_PM_CMD_AFTER_LAST
 };
 =

+#define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
+#define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
+
+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u32	mptcpi_flags;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+};
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index af84fce70bb0..698bc3525160 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -13,6 +13,10 @@ config MPTCP
 =

 if MPTCP
 =

+config INET_MPTCP_DIAG
+	depends on INET_DIAG
+	def_tristate INET_DIAG
+
 config MPTCP_IPV6
 	bool "MPTCP: IPv6 support for Multipath TCP"
 	select IPV6
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index c53f9b845523..2360cbd27d59 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -4,6 +4,8 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
 	   mib.o pm_netlink.o
 =

+obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
+
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TESTS) +=3D mptcp_crypto_test.o mptcp_token_test.o
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
new file mode 100644
index 000000000000..5f390a97f556
--- /dev/null
+++ b/net/mptcp/mptcp_diag.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/* MPTCP socket monitoring support
+ *
+ * Copyright (c) 2020 Red Hat
+ *
+ * Author: Paolo Abeni <pabeni(a)redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/net.h>
+#include <linux/inet_diag.h>
+#include <net/netlink.h>
+#include <uapi/linux/mptcp.h>
+#include "protocol.h"
+
+static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
+			struct netlink_callback *cb,
+			const struct inet_diag_req_v2 *req,
+			struct nlattr *bc, bool net_admin)
+{
+	if (!inet_diag_bc_sk(bc, sk))
+		return 0;
+
+	return inet_sk_diag_fill(sk, inet_csk(sk), skb, cb, req, NLM_F_MULTI,
+				 net_admin);
+}
+
+static int mptcp_diag_dump_one(struct netlink_callback *cb,
+			       const struct inet_diag_req_v2 *req)
+{
+	struct sk_buff *in_skb =3D cb->skb;
+	struct mptcp_sock *msk =3D NULL;
+	struct sk_buff *rep;
+	int err =3D -ENOENT;
+	struct net *net;
+	struct sock *sk;
+
+	net =3D sock_net(in_skb->sk);
+	msk =3D mptcp_token_get_sock(req->id.idiag_cookie[0]);
+	if (!msk)
+		goto out_nosk;
+
+	err =3D -ENOMEM;
+	sk =3D (struct sock *)msk;
+	rep =3D nlmsg_new(nla_total_size(sizeof(struct inet_diag_msg)) +
+			inet_diag_msg_attrs_size() +
+			nla_total_size(sizeof(struct mptcp_info)) +
+			nla_total_size(sizeof(struct inet_diag_meminfo)) + 64,
+			GFP_KERNEL);
+	if (!rep)
+		goto out;
+
+	err =3D inet_sk_diag_fill(sk, inet_csk(sk), rep, cb, req, 0,
+				netlink_net_capable(in_skb, CAP_NET_ADMIN));
+	if (err < 0) {
+		WARN_ON(err =3D=3D -EMSGSIZE);
+		kfree_skb(rep);
+		goto out;
+	}
+	err =3D netlink_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).portid,
+			      MSG_DONTWAIT);
+	if (err > 0)
+		err =3D 0;
+out:
+	sock_put(sk);
+
+out_nosk:
+	return err;
+}
+
+static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *=
cb,
+			    const struct inet_diag_req_v2 *r)
+{
+	bool net_admin =3D netlink_net_capable(cb->skb, CAP_NET_ADMIN);
+	struct net *net =3D sock_net(skb->sk);
+	struct inet_diag_dump_data *cb_data;
+	struct mptcp_sock *msk;
+	struct nlattr *bc;
+
+	cb_data =3D cb->data;
+	bc =3D cb_data->inet_diag_nla_bc;
+
+	while ((msk =3D mptcp_token_iter_next(net, &cb->args[0], &cb->args[1])) !=
=3D
+	       NULL) {
+		struct inet_sock *inet =3D (struct inet_sock *)msk;
+		struct sock *sk =3D (struct sock *)msk;
+		int ret =3D 0;
+
+		if (!(r->idiag_states & (1 << sk->sk_state)))
+			goto next;
+		if (r->sdiag_family !=3D AF_UNSPEC &&
+		    sk->sk_family !=3D r->sdiag_family)
+			goto next;
+		if (r->id.idiag_sport !=3D inet->inet_sport &&
+		    r->id.idiag_sport)
+			goto next;
+		if (r->id.idiag_dport !=3D inet->inet_dport &&
+		    r->id.idiag_dport)
+			goto next;
+
+		ret =3D sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+next:
+		sock_put(sk);
+		if (ret < 0) {
+			/* will retry on the same position */
+			cb->args[1]--;
+			break;
+		}
+		cond_resched();
+	}
+}
+
+static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
+				void *_info)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_info *info =3D _info;
+	u32 flags =3D 0;
+	bool slow;
+	u8 val;
+
+	r->idiag_rqueue =3D sk_rmem_alloc_get(sk);
+	r->idiag_wqueue =3D sk_wmem_alloc_get(sk);
+	if (!info)
+		return;
+
+	slow =3D lock_sock_fast(sk);
+	info->mptcpi_subflows =3D READ_ONCE(msk->pm.subflows);
+	info->mptcpi_add_addr_signal =3D READ_ONCE(msk->pm.add_addr_signaled);
+	info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
+	info->mptcpi_subflows_max =3D READ_ONCE(msk->pm.subflows_max);
+	val =3D READ_ONCE(msk->pm.add_addr_signal_max);
+	info->mptcpi_add_addr_signal_max =3D val;
+	val =3D READ_ONCE(msk->pm.add_addr_accept_max);
+	info->mptcpi_add_addr_accepted_max =3D val;
+	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+		flags |=3D MPTCP_INFO_FLAG_FALLBACK;
+	if (READ_ONCE(msk->can_ack))
+		flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
+	info->mptcpi_flags =3D flags;
+	info->mptcpi_token =3D READ_ONCE(msk->token);
+	info->mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
+	info->mptcpi_snd_una =3D atomic64_read(&msk->snd_una);
+	info->mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
+	unlock_sock_fast(sk, slow);
+}
+
+static const struct inet_diag_handler mptcp_diag_handler =3D {
+	.dump		 =3D mptcp_diag_dump,
+	.dump_one	 =3D mptcp_diag_dump_one,
+	.idiag_get_info  =3D mptcp_diag_get_info,
+	.idiag_type	 =3D IPPROTO_MPTCP,
+	.idiag_info_size =3D sizeof(struct mptcp_info),
+};
+
+static int __init mptcp_diag_init(void)
+{
+	return inet_diag_register(&mptcp_diag_handler);
+}
+
+static void __exit mptcp_diag_exit(void)
+{
+	inet_diag_unregister(&mptcp_diag_handler);
+}
+
+module_init(mptcp_diag_init);
+module_exit(mptcp_diag_exit);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-262 /* AF_=
INET - IPPROTO_MPTCP */);
-- =

2.26.2

--===============4651133761039346399==--
