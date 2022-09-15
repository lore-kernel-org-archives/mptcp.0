Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1B6713
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286185; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hqYziGTsk7NqAyeZb3bA34DPkU+ZtpjxIX7Ey8MFfVBHQqe4+VKMTdVuB0y5VKSfQIvTMyqYV2tHuiwtacB+jd6kuOu5qcmWQElOMusp5uZFvpSg9VAfyMjifH/b1iUOY3ayti5MYUsnVghTEYqSdgScn9HIxttchGQTcLPw/U0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286185; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=GsQyvmSGizvFF+1HgibWVVbslT+CcV6JOXOiNAGM9iQ=; 
	b=e3EPfMQBxTJzMjXkSZP2P03eIlA0W63o9vZ5s9ChXbHMNpy+kboSP8PNH/6eDnbEzf1tvfzP9HdFhzmocirl5C+WkEWNIcuv9H1QZcejZxSWTLPZ8C/gy7Bsp2vWeuN8a+1ivhYBhNtbkp+P5sKuoHno2ryr/gA2UeA11vQHhm4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286185;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=GsQyvmSGizvFF+1HgibWVVbslT+CcV6JOXOiNAGM9iQ=;
	b=PLr64PygENnUwb8Fs81Sy3bLq19n2HC9jQE2sRVFnkUzemwKL08Zr9gLNfwaeWo3
	o75RMrGF3juoPoWYxB7Ma71/bMRksC3w4GpolSWJPLfWI2GfdK9Q9SZyl8gjqONbH/n
	65Ds2tdmFxGa+KZS/rG6FJ7CcSWtrmjlwWG1PspA=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663286184155722.8943006248229; Fri, 16 Sep 2022 01:56:24 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 1/9] Add separate fastopen.c file.
Date: Fri, 16 Sep 2022 01:55:56 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915235604.26018-1-dmytro@shytyi.net>
References: <20220915235604.26018-1-dmytro@shytyi.net>
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


