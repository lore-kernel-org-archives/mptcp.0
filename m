Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A25CB0
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665440308; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kn0f4d8etNJDGbFQ464clUsqmCTnlKm/R1PKQUSvs2HezwrXswbrS8rYVwksk+JLnZbs6Pu+Jdf2sqxFQ4oks5gOpI52cjfrGiJrjrXEpYVPgcSiFtTeyt0FoiYhgCDdK5BD0pFf1bARo+UGooNIV3X3JDW0cyz/xowoTbVkvxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665440308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Xv76KnkqTZVuO5RScDnsFJ5wzxmYYgBVV1S/QyukRwM=; 
	b=XUKGkKTmEg8NnpAKVGrV59uIRTUAnG/h6xhv/39xiQve+wJpkAHL2ZEjdhk8B+rELxrOT58+CJFovqPJi9D3a6KTullae4mBoYei71KbeMGtTO9ax1n3ogJ1SWy8TmpVtiZnrUxjnG6f/ybp64joKN0L+/tMF3sWvPtFjFtaDLo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665440308;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Xv76KnkqTZVuO5RScDnsFJ5wzxmYYgBVV1S/QyukRwM=;
	b=DvXfbwSe2BB+v92uG+4QaCMm+6qD2ZGeLmmM5uve1FjUlIpFVfgOwCuzntuvd+FC
	6uMX2Amq2+h/fiPpABuH6+QEB0fGjL9iuLC5IpDVIAAsz6slgrALc1+Vp4V/oLvwtx1
	ksjzc+pq+qS6Y/wv9rzM+fOTKVFE9uGJkzjv3qT8=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665440306886890.3400640647226; Tue, 11 Oct 2022 00:18:26 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221010221809.1792-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v14 2/5] mptcp: implement delayed seq generation for passive fastopen
Date: Mon, 10 Oct 2022 22:18:06 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010221809.1792-1-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

With fastopen in place the first subflow socket is created
before the MPC handshake completes, and we need to properly initialize
the sequence numbers at MPC ACK reception.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/Makefile   |  2 +-
 net/mptcp/fastopen.c | 19 +++++++++++++++++++
 net/mptcp/options.c  |  5 +++++
 net/mptcp/protocol.h |  6 ++++++
 4 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/fastopen.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 8a7f68efa35f..c42ad8609876 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
+=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
new file mode 100644
index 000000000000..d6fb45e6be4f
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+ */
+
+#include "protocol.h"
+
+void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
+=09=09=09=09   struct mptcp_options_received mp_opt)
+{
+=09u64 ack_seq;
+
+=09WRITE_ONCE(msk->can_ack, true);
+=09WRITE_ONCE(msk->remote_key, mp_opt.sndr_key);
+=09mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+=09ack_seq++;
+=09WRITE_ONCE(msk->ack_seq, ack_seq);
+=09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.sndr_ke=
y);
+=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..0b6c4535750c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1208,6 +1208,11 @@ bool mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 =09=09=09mpext->dsn64 =3D 1;
 =09=09=09mpext->mpc_map =3D 1;
 =09=09=09mpext->data_fin =3D 0;
+
+=09=09=09if (msk->is_mptfo) {
+=09=09=09=09mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
+=09=09=09=09mpext->data_seq =3D READ_ONCE(msk->ack_seq);
+=09=09=09}
 =09=09} else {
 =09=09=09mpext->data_seq =3D mp_opt.data_seq;
 =09=09=09mpext->subflow_seq =3D mp_opt.subflow_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f866b1afda..41276788626b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -282,6 +282,7 @@ struct mptcp_sock {
 =09bool=09=09use_64bit_ack; /* Set when we received a 64-bit DSN */
 =09bool=09=09csum_enabled;
 =09bool=09=09allow_infinite_fallback;
+=09bool=09=09is_mptfo;
 =09u8=09=09mpc_endpoint_id;
 =09u8=09=09recvmsg_inq:1,
 =09=09=09cork:1,
@@ -840,6 +841,11 @@ void mptcp_event_addr_announced(const struct sock *ssk=
, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
=20
+// Fast Open Mechanism functions begin
+void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
+=09=09=09=09   struct mptcp_options_received mp_opt);
+// Fast Open Mechanism functions end
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 =09return READ_ONCE(msk->pm.addr_signal) &
--=20
2.34.1


