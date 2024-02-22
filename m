Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD617BC2
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589046; cv=none; b=Zm0RI9zGuyGfelf8qZnq/onxAdbJ8lY+uJDf+dn3VWwCpsFkvKVSWLGbF5cI4Ea6sR7KFWMuLeso75b9s5sAvX2Duy3eU9iBhG66BWMnS5AC/fmx3xUUJL5z7LdgbHgFqlS6p9RoteQ56Ct3rnnreGCQGA/+W2zgS34ju0RaO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589046; c=relaxed/simple;
	bh=V+LVlg96JbbxV9/NAT+eYZJ9otqIxXDrJP/t59ex8bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ns4XoQ8li/0E0J0H2AXBAXrskS1B31uwsbgUJx/HdInehQyYsTf8teiRa0Huu9hLWQmAxODBGHppGi5FHaN7I7ZFrIDak6tqZfduFpxoCaYmm2pJwRr0i8dx8cEvigh2pOddtSrlUqZN24UL+AXcf1fZ6NkJUvUZVWooltGc2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUV8CQbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUV8CQbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16661C433F1;
	Thu, 22 Feb 2024 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589045;
	bh=V+LVlg96JbbxV9/NAT+eYZJ9otqIxXDrJP/t59ex8bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUV8CQbkfFxDwmIRqKQieZZHmI1kYxrk56JaALC/meyovTvm4lkImnUz7EZlFeQpP
	 rlksJXPuWu01cZnTV6UwFiyBfha+5ovsAgSrSyspnKDVLUDwnsW2TtlA9FXMdixi28
	 Cw1qC1T4HgTEpsmeVHJXToRldE8jxDk1kTaVk+8dS5QROnQcpM1lwVtEONbzAN1pfD
	 I6p+hGX0Uze9sDSKvy+hSE5ak4Voh+f8kz4xcR+JEIxP147c1GOaCnzSt+DTJ5KX4K
	 8bnv2LsrSp44BJGC1XlODg4yYlQarjFc75AnCr8t7pYtOW67aBZ1ucKhiEHh0vl6vO
	 UHFXb7IBmjzRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] mptcp: drop duplicate header inclusions
Date: Thu, 22 Feb 2024 16:03:53 +0800
Message-Id: <a09170a01f6d32ae966347796aa7b60150e9799c.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708588977.git.tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The headers net/tcp.h, net/genetlink.h and uapi/linux/mptcp.h are included
in protocol.h already, no need to include them again directly. This patch
removes these duplicate header inclusions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/diag.c       | 1 -
 net/mptcp/mptcp_diag.c | 1 -
 net/mptcp/pm.c         | 1 -
 net/mptcp/pm_netlink.c | 3 ---
 net/mptcp/protocol.c   | 1 -
 net/mptcp/subflow.c    | 2 --
 6 files changed, 9 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa..aefe26e5ae72 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -10,7 +10,6 @@
 #include <linux/net.h>
 #include <linux/inet_diag.h>
 #include <net/netlink.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
 static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index bd8ff5950c8d..0566dd793810 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -10,7 +10,6 @@
 #include <linux/net.h>
 #include <linux/inet_diag.h>
 #include <net/netlink.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b4bdd92a5648..28e5d514bf20 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -6,7 +6,6 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/kernel.h>
-#include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 16f8bd47f4b8..a900df9f173d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -8,12 +8,9 @@
 
 #include <linux/inet.h>
 #include <linux/kernel.h>
-#include <net/tcp.h>
 #include <net/inet_common.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
-#include <net/genetlink.h>
-#include <uapi/linux/mptcp.h>
 
 #include "protocol.h"
 #include "mib.h"
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50dcba41b6ef..b2c4eecf86c4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -15,7 +15,6 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6403c56f2902..1626dd20c68f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -15,13 +15,11 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/ip6_route.h>
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 #include "mib.h"
 
-- 
2.40.1

