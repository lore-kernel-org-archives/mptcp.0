Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0B4682
	for <mptcp@lists.linux.dev>; Sun, 25 Sep 2022 23:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664148371; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZCy/dPfWPNcvefJO4kaRmf14rV1MtiY+QH3Uiqilcka9F60Uqs9YaYXkoB6I8DeXjanI6vulhoYe6LRhLCL9HGk5jzEF5+1usoIjt6qtt3ZHV4/EooudI21dZyu0Gb89bosTF/+rfZae2dE6F8+Eew6Vre3/gyzH5ipjmzqqXDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664148371; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=+gI5I5olr5+iXgM3I5tUNUeHJnYUQ+eC+S96KmqxXIg=; 
	b=EqdgEP3ct8HD9TZT7IViFPmJ9R5NaLpQr2yeX/IrMWPQTFwBIfMik4CFW+4cibt7GGPE2ou31NHx3xglrY3TGs5jM1sSoILkHt+i5yw8Ry1PP+OAlAwQJ32XDmOLe7rJO5qQm74AS4JM+67YLM5iBG2aQg1pYCF3Ih2t991GDvo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664148371;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=+gI5I5olr5+iXgM3I5tUNUeHJnYUQ+eC+S96KmqxXIg=;
	b=ehf/QT7wObQ97AIrg1y15JhamAFI3Qmqyp3DGKV/moCTormcEz9TJ2rDJbxD60e+
	giz6EgQjglC0fQ+pC4aB8vCL4hHZKBZpld2RxN5T50ByZkWepgRfYCPJE0e03BywX+L
	WvRw3SKQ+wRFZyvmrbKswMMNsh4ldYkY7kkLfeUA=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664148368893720.3573427483719; Mon, 26 Sep 2022 01:26:08 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220925232601.25252-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v11 1/4] mptcp: add mptcp_setsockopt_fastopen
Date: Mon, 26 Sep 2022 01:25:58 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925232601.25252-1-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add set MPTFO socket option for MPTCP. This option is needed for
the listen socket to accept MPTFO.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/Makefile   |  2 +-
 net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 +++++
 net/mptcp/sockopt.c  |  3 +++
 4 files changed, 46 insertions(+), 1 deletion(-)
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
index 000000000000..086cbad49979
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+ */
+
+#include "protocol.h"
+
+int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
+=09=09=09=09      unsigned int optlen)
+{
+=09struct sock *sk =3D (struct sock *)msk;
+=09struct net *net =3D sock_net(sk);
+=09struct socket *ssock;
+=09struct sock *ssk;
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09ssock =3D __mptcp_nmpc_socket(msk);
+=09ssk =3D ssock->sk;
+=09net =3D sock_net(ssk);
+=09lock_sock(ssk);
+
+=09if (val >=3D 0 && ((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) =
{
+=09=09tcp_fastopen_init_key_once(net);
+=09=09fastopen_queue_tune(ssk, val);
+=09} else {
+=09=09ret =3D -EINVAL;
+=09}
+
+=09release_sock(ssk);
+
+=09return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93c535440a5c..522647804aed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -838,6 +838,11 @@ void mptcp_event_addr_announced(const struct sock *ssk=
, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
=20
+// Fast Open Mechanism functions begin
+int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
+=09=09=09=09      unsigned int optlen);
+// Fast Open Mechanism functions end
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 =09return READ_ONCE(msk->pm.addr_signal) &
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..f62f0d63b8e6 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_NOTSENT_LOWAT:
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
+=09=09case TCP_FASTOPEN:
 =09=09=09return true;
 =09=09}
=20
@@ -796,6 +797,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+=09case TCP_FASTOPEN:
+=09=09return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
--=20
2.25.1


