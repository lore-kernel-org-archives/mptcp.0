Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E991FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594117; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cVfTp4a39Zx0k9wQuEXxxuoxb2oc8hx84DeX4yCpI+Vf6ZBbnnQEpxlrEVMF8w4vmgYx3JpnrNXDdM9sv3my7v9L8KjiAEzcaO+RkeBS/i5R5DzBknuPYaLQu5jF2CmqBV8AFOGWYKpE+5eypBGiM3ItJ4Q35v5BQnL7+ANYV2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594117; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=VqYP35xY/OK3vntT8aRgm9rT97ft5Aj3fACZNODN0lw=; 
	b=FuBAAN7a9Dbgs9WD1YBfTsNFsrvSZakq4NXY9uBSk/Z4Cjxny73tH+ENtw6372lNtG/2OoeZObXgtYP9hs9ZaZlSUrf364ObRcwjmteitKcA60ntwdNVpEixZFmrBR3/824egu3ACox0OKEpdiDXQpz9EfOq0vlRAv5kcsP7qzI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594117;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=VqYP35xY/OK3vntT8aRgm9rT97ft5Aj3fACZNODN0lw=;
	b=gbDrJautx83aWqcjXTvzs3BxPbAoBiP4C/htekWN3zE9yVsY2SZXiZRwASRUD9i5
	GXyRP4LCBkHLDsDo6d1J0zZ7eiXlMhoEmuJCZ5gjnOufTcaCOumITPLhImMaPEVrCt7
	bAXDa0dRatw7i7MwdJyf41Ngi92ipL96CODpLhNM=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594115870263.49021903953735; Sat, 1 Oct 2022 05:15:15 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 1/7] mptcp: add __mptcp_pre_connect() helper
Date: Sat,  1 Oct 2022 03:14:56 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221001031502.29152-1-dmytro@shytyi.net>
References: <20221001031502.29152-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Set the fastopen_req inside the __mptcp_pre_connect() helper
and call it in the mptcp_sendmsg(). Used together with the
next patch.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/Makefile   |  2 +-
 net/mptcp/fastopen.c | 27 +++++++++++++++++++++++++++
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  5 +++++
 4 files changed, 35 insertions(+), 1 deletion(-)
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
index 000000000000..65a6a87c0079
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+ */
+
+#include "protocol.h"
+
+void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
+=09=09=09 struct msghdr *msg, size_t size)
+{
+=09struct tcp_sock *tp;
+=09struct sk_buff *skb;
+=09struct ubuf_info *uarg;
+
+=09lock_sock(ssk);
+
+=09tp =3D tcp_sk(ssk);
+
+=09skb =3D tcp_write_queue_tail(ssk);
+=09uarg =3D msg_zerocopy_realloc(ssk, size, skb_zcopy(skb));
+=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
+=09=09=09=09   ssk->sk_allocation);
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D size;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09release_sock(ssk);
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8feb684408f7..b080237d9d7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1688,6 +1688,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =09=09int copied_syn =3D 0;
=20
 =09=09lock_sock(ssk);
+=09=09if (msg->msg_flags & MSG_FASTOPEN && sk->sk_state =3D=3D TCP_CLOSE)
+=09=09=09__mptcp_pre_connect(msk, ssk, msg, len);
=20
 =09=09ret =3D tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
 =09=09copied +=3D copied_syn;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93c535440a5c..30c03c70fdeb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -838,6 +838,11 @@ void mptcp_event_addr_announced(const struct sock *ssk=
, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
=20
+// Fast Open Mechanism functions begin
+void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
+=09=09=09 struct msghdr *msg, size_t len);
+// Fast Open Mechanism functions end
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 =09return READ_ONCE(msk->pm.addr_signal) &
--=20
2.34.1


