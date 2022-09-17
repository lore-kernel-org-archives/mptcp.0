Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A05C80
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453758; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hmr70rOdxz8elnGTizpPK8nfnxAjrmuR3AOw9hxdH+4Xw0qAVvVKdqtq0Dri0twVXKZDbYtkucIX/eMEZkV7bq9J5bs00kYDsWnUlc3iZj6J71Gr0tiVwRfZAPjlwotyWcrsPvmyoUA1ArvnHWoj1dBoi0VvEjydbwxNXuFHvV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453758; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=GsQyvmSGizvFF+1HgibWVVbslT+CcV6JOXOiNAGM9iQ=; 
	b=JfG+mD8uPSBQrIZ7/3eZMDm9YLHU/0TDziEjonCo7EPxhtdey36jIs6hcv5ursvEBdZ4zihY+hiANRJ9RvYRkW1b29ATqvQIztDkE4/Dh0Z+2Vd4VGJS2HJRdDd0yxKu6JKJf88JCzMSRy+vfbl2k2b65IQgU9WWvZNfRYvuO2c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453758;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=GsQyvmSGizvFF+1HgibWVVbslT+CcV6JOXOiNAGM9iQ=;
	b=JACzBwXcXL00YNPfowS6yNdHs24Mkw9OXb+7E5EwO9Hne6jnq7DVeCjwLjCGfYks
	kzyZMz5oMRfZgFSjMizFcrjmwmL73RXfKsr8repLStiUrj2/GCGuhbj2OCw/3l1c2gy
	xohFqAsEJOyGO9JxkBBKu6MZAs6ODfUwgUHwPWoA=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166345375767072.63750628351613; Sun, 18 Sep 2022 00:29:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 01/11] Add separate fastopen.c file.
Date: Sun, 18 Sep 2022 00:28:43 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220917222853.2406-1-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add separate *.c file. Function prototypes are coming to protocol.h
(Suggestion of @palbeni (JUN 17))

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/Makefile   | 2 +-
 net/mptcp/fastopen.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
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
index 000000000000..0c9ef6f5d528
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+ */
+
+#include "protocol.h"
--=20
2.25.1


