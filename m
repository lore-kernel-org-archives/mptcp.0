Content-Type: multipart/mixed; boundary="===============3852410773313598983=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to userspace
Date: Thu, 12 Sep 2019 18:50:37 +0200
Message-ID: <d9b73a7a7065931e920f0c0df3012209a8448f60.1568307013.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1828

--===============3852410773313598983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add ulp-specific diagnostic functions, so that subflow information can be
dumped to userspace programs like 'ss'.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---

Notes:
    this patch applies on top of "net/mptcp: rcu-ify the subflow context"

 include/uapi/linux/inet_diag.h |  1 +
 include/uapi/linux/mptcp.h     | 23 ++++++++++
 net/mptcp/Makefile             |  2 +-
 net/mptcp/diag.c               | 78 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h           |  3 ++
 net/mptcp/subflow.c            |  2 +
 6 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 net/mptcp/diag.c

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index a1ff345b3f33..13d16b887512 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -163,6 +163,7 @@ enum {
 	INET_ULP_INFO_UNSPEC,
 	INET_ULP_INFO_NAME,
 	INET_ULP_INFO_TLS,
+	INET_ULP_INFO_MPTCP,
 	__INET_ULP_INFO_MAX,
 };
 #define INET_ULP_INFO_MAX (__INET_ULP_INFO_MAX - 1)
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
new file mode 100644
index 000000000000..2e0cdc395dc3
--- /dev/null
+++ b/include/uapi/linux/mptcp.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_MPTCP_H
+#define _UAPI_MPTCP_H
+
+#include <linux/types.h>
+
+#define SUBFLOW_FLAGS_MP_REMOTE		BIT(0)
+#define SUBFLOW_FLAGS_MP_LOCAL		BIT(1)
+#define SUBFLOW_FLAGS_MP_JOIN		BIT(2)
+#define SUBFLOW_FLAGS_DSS_CSUM		BIT(3)
+#define SUBFLOW_FLAGS_BKUP_LOCAL	BIT(4)
+
+enum {
+	MPTCP_SUBFLOW_UNSPEC,
+	MPTCP_SUBFLOW_TOKEN,
+	MPTCP_SUBFLOW_LOCAL_KEY,
+	MPTCP_SUBFLOW_REMOTE_KEY,
+	MPTCP_SUBFLOW_FLAGS,
+	MPTCP_SUBFLOW_PAD,
+	__MPTCP_SUBFLOW_MAX
+};
+#define MPTCP_SUBFLOW_MAX (__MPTCP_SUBFLOW_MAX - 1)
+#endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 289fdf4339c1..6b556e2995ec 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o d=
iag.o
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
new file mode 100644
index 000000000000..789e9684d29a
--- /dev/null
+++ b/net/mptcp/diag.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* MPTCP socket monitoring support
+ *
+ * Copyright (c) 2019 Red Hat
+ *
+ * Author: Davide Caratti <dcaratti(a)redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/net.h>
+#include <linux/inet_diag.h>
+#include <net/netlink.h>
+#include <uapi/linux/mptcp.h>
+#include "protocol.h"
+
+int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+{
+	struct subflow_context *subflow;
+	struct nlattr *start;
+	u32 flags =3D 0;
+	int err;
+
+	start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
+	if (!start)
+		return -EMSGSIZE;
+
+	rcu_read_lock();
+	subflow =3D rcu_dereference(inet_csk(sk)->icsk_ulp_data);
+	if (!subflow) {
+		err =3D 0;
+		goto nla_failure;
+	}
+	if (nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN, subflow->token)) {
+		err =3D -EMSGSIZE;
+		goto nla_failure;
+	}
+	if (subflow->mp_capable)
+		flags |=3D SUBFLOW_FLAGS_MP_REMOTE;
+	if (subflow->request_mptcp)
+		flags |=3D SUBFLOW_FLAGS_MP_LOCAL;
+	if (subflow->mp_join)
+		flags |=3D SUBFLOW_FLAGS_MP_JOIN;
+	if (subflow->request_cksum)
+		flags |=3D SUBFLOW_FLAGS_DSS_CSUM;
+	if (subflow->request_bkup)
+		flags |=3D SUBFLOW_FLAGS_BKUP_LOCAL;
+	if (nla_put_be64(skb, MPTCP_SUBFLOW_LOCAL_KEY,
+			 cpu_to_be64(subflow->local_key),
+			 MPTCP_SUBFLOW_PAD) ||
+	    nla_put_be64(skb, MPTCP_SUBFLOW_REMOTE_KEY,
+			 cpu_to_be64(subflow->remote_key),
+			 MPTCP_SUBFLOW_PAD) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_FLAGS, flags)) {
+		err =3D -EMSGSIZE;
+		goto nla_failure;
+	}
+	rcu_read_unlock();
+	nla_nest_end(skb, start);
+	return 0;
+
+nla_failure:
+	rcu_read_unlock();
+	nla_nest_cancel(skb, start);
+	return err;
+}
+
+size_t subflow_get_info_size(const struct sock *sk)
+{
+	size_t size =3D 0;
+
+	size +=3D nla_total_size(0) +		/* INET_ULP_INFO_MPTCP */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_TOKEN */
+		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_LOCAL_KEY */
+		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_REMOTE_KEY */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_FLAGS */
+		0;
+	return size;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7a210593ca60..53c63e32431c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -273,4 +273,7 @@ static inline struct mptcp_ext *mptcp_get_ext(struct sk=
_buff *skb)
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
 }
 =

+size_t subflow_get_info_size(const struct sock *sk);
+int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3d4a388147bc..7f9fec9e1514 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -498,6 +498,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly=
 =3D {
 	.init		=3D subflow_ulp_init,
 	.release	=3D subflow_ulp_release,
 	.clone		=3D subflow_ulp_clone,
+	.get_info	=3D subflow_get_info,
+	.get_info_size	=3D subflow_get_info_size,
 };
 =

 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
-- =

2.20.1


--===============3852410773313598983==--
