Content-Type: multipart/mixed; boundary="===============7657288401051499006=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: allow dumping subflow context to userspace
Date: Fri, 27 Sep 2019 22:51:54 +0200
Message-ID: <8791464ca2ddf0cf2e2ea555ede7f098e427085c.1569617413.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1941

--===============7657288401051499006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add ulp-specific diagnostic functions, so that subflow information can be
dumped to userspace programs like 'ss'.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---

Notes:
    changes since RFC:
     - dump all subflow-related infos except keys

 include/uapi/linux/inet_diag.h |  1 +
 include/uapi/linux/mptcp.h     | 34 ++++++++++++
 net/mptcp/Makefile             |  2 +-
 net/mptcp/diag.c               | 95 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h           |  3 ++
 net/mptcp/subflow.c            |  2 +
 6 files changed, 136 insertions(+), 1 deletion(-)
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
index 000000000000..2856b89cc36e
--- /dev/null
+++ b/include/uapi/linux/mptcp.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_MPTCP_H
+#define _UAPI_MPTCP_H
+
+#include <linux/types.h>
+
+#define SUBFLOW_FLAGS_MCAP_REM		BIT(0)
+#define SUBFLOW_FLAGS_MCAP_LOC		BIT(1)
+#define SUBFLOW_FLAGS_JOIN_REM		BIT(2)
+#define SUBFLOW_FLAGS_JOIN_LOC		BIT(3)
+#define SUBFLOW_FLAGS_BKUP_REM		BIT(4)
+#define SUBFLOW_FLAGS_BKUP_LOC		BIT(5)
+#define SUBFLOW_FLAGS_4THACK		BIT(6)
+#define SUBFLOW_FLAGS_CONNECTED		BIT(7)
+#define SUBFLOW_FLAGS_MAPVALID		BIT(8)
+
+enum {
+	MPTCP_SUBFLOW_UNSPEC,
+	MPTCP_SUBFLOW_TOKEN_REM,
+	MPTCP_SUBFLOW_TOKEN_LOC,
+	MPTCP_SUBFLOW_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_MAP_SEQ,
+	MPTCP_SUBFLOW_MAP_SFSEQ,
+	MPTCP_SUBFLOW_SSN_OFFSET,
+	MPTCP_SUBFLOW_MAP_DATALEN,
+	MPTCP_SUBFLOW_FLAGS,
+	MPTCP_SUBFLOW_ID_REM,
+	MPTCP_SUBFLOW_ID_LOC,
+	MPTCP_SUBFLOW_PAD,
+	__MPTCP_SUBFLOW_MAX
+};
+
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
index 000000000000..a42c96619faa
--- /dev/null
+++ b/net/mptcp/diag.c
@@ -0,0 +1,95 @@
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
+	struct subflow_context *sf;
+	struct nlattr *start;
+	u32 flags =3D 0;
+	int err;
+
+	start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
+	if (!start)
+		return -EMSGSIZE;
+
+	rcu_read_lock();
+	sf =3D rcu_dereference(inet_csk(sk)->icsk_ulp_data);
+	if (!sf) {
+		err =3D 0;
+		goto nla_failure;
+	}
+
+	if (sf->mp_capable)
+		flags |=3D SUBFLOW_FLAGS_MCAP_REM;
+	if (sf->request_mptcp)
+		flags |=3D SUBFLOW_FLAGS_MCAP_LOC;
+	if (sf->mp_join)
+		flags |=3D SUBFLOW_FLAGS_JOIN_REM;
+	if (sf->request_join)
+		flags |=3D SUBFLOW_FLAGS_JOIN_LOC;
+	if (sf->backup)
+		flags |=3D SUBFLOW_FLAGS_BKUP_REM;
+	if (sf->request_bkup)
+		flags |=3D SUBFLOW_FLAGS_BKUP_LOC;
+	if (sf->fourth_ack)
+		flags |=3D SUBFLOW_FLAGS_4THACK;
+	if (sf->conn_finished)
+		flags |=3D SUBFLOW_FLAGS_CONNECTED;
+	if (sf->map_valid)
+		flags |=3D SUBFLOW_FLAGS_MAPVALID;
+
+	if (nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_REM, sf->remote_token) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_LOC, sf->token) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_RELWRITE_SEQ, sf->rel_write_seq) ||
+	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_MAP_SEQ, sf->map_seq,
+			      MPTCP_SUBFLOW_PAD) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_MAP_SFSEQ, sf->map_subflow_seq) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_SSN_OFFSET, sf->ssn_offset) ||
+	    nla_put_u16(skb, MPTCP_SUBFLOW_MAP_DATALEN, sf->map_data_len) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_FLAGS, flags) ||
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ID_REM, sf->remote_id) ||
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ID_LOC, sf->local_id)) {
+		err =3D -EMSGSIZE;
+		goto nla_failure;
+	}
+
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
+	size +=3D nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_TOKEN_REM */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_TOKEN_LOC */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_RELWRITE_SEQ */
+		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_MAP_SEQ */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_MAP_SFSEQ */
+		nla_total_size(2) +	/* MPTCP_SUBFLOW_SSN_OFFSET */
+		nla_total_size(2) +	/* MPTCP_SUBFLOW_MAP_DATALEN */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_FLAGS */
+		nla_total_size(1) +	/* MPTCP_SUBFLOW_ID_REM */
+		nla_total_size(1) +	/* MPTCP_SUBFLOW_ID_LOC */
+		0;
+	return size;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f3f293c82058..f38639cc35b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,4 +314,7 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 #define after64(seq2, seq1)	before64(seq1, seq2)
 =

+size_t subflow_get_info_size(const struct sock *sk);
+int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 80d297ce11d2..9c860fcc4232 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -495,6 +495,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly=
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

2.21.0


--===============7657288401051499006==--
