Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA333D4
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764965; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=H+UU/3Jy9g/tEH7X6gEUSTHOegiI3eHkv/3FZCLbsv9Vggn4XuAkaETO74xt5izeM1L0trtXOpDxXNX8wXK7GQLxL9+/cmcBaiLCjnvshjY9uEZOH9D6tXHWA6efrKreOAKP1jowf0wXqeIYxG+Ndsi+YUlMglVwPF5tIs28qeg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764965; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=5OyQn/p9PkC8XokMX7sYXXXkgJmhTlm5FtNujHkyZ0s=; 
	b=CpeFqoGQDIc3FsJSznOc6l2tbRC7+OXekfiDVwe/KFI31fcvT0iKhJ45aEZnJAHuxEMZJXaCko5uossOhp/Yyqs7hbZ7SbL2KMhTqY/vXEJnYUOU3OVQOwL0hH3d8TvZpuCIFmwIBBYTUY9anPM2Mv2b1cwwmI9ujuLu56DEstM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764965;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=5OyQn/p9PkC8XokMX7sYXXXkgJmhTlm5FtNujHkyZ0s=;
	b=cJ2RghRwkETAukYIkL66AjyA5dv1twLH7jodXDVu8F6Ox8ZmO+No5d5mEjOSUFoK
	6+ufsmJNOBlyRmI2ig5AmgOweBZxIij8ygoydcsOvoLYH44DdeZOytXCiUYKu1obigu
	KOAoWKJsGGq15WXFTGdhshGHsDYlq6fYzDCNmUzQ=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663764962931359.4916161028393; Wed, 21 Sep 2022 14:56:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 2/6] mptcp: add mptcp_setsockopt_fastopen
Date: Wed, 21 Sep 2022 14:55:54 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
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
 net/mptcp/fastopen.c | 32 ++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 +++++
 net/mptcp/sockopt.c  |  3 +++
 4 files changed, 41 insertions(+), 1 deletion(-)
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
index 000000000000..9ef49a2d2ea2
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,32 @@
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
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09lock_sock(sk);
+
+=09if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
+=09=09tcp_fastopen_init_key_once(net);
+=09=09fastopen_queue_tune(sk, val);
+=09} else {
+=09=09ret =3D -EINVAL;
+=09}
+
+=09release_sock(sk);
+
+=09return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 632161b13950..57596cdfb1f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -839,6 +839,11 @@ void mptcp_event_addr_removed(const struct mptcp_sock =
*msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
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


