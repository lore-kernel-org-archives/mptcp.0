Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887813C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497083; cv=none; b=BzC2nrQnHYc6zKV2+Spo5Y7RroAQJTGo64ROwEVLjsbsnDA1/nSKx/2eGPEjPjljDjRyB3bVAGE/B8d6WNSPhCRhZUncMD0BH/ilsCXdd8q2xhdQX0JQjD9U8Y2WrApnwwU0bpccRgGiGJjEE2rhrq463qc/621l1KHMFV4tVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497083; c=relaxed/simple;
	bh=V+LVlg96JbbxV9/NAT+eYZJ9otqIxXDrJP/t59ex8bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdzLqKiUoeGj6Lwa8UapncB9IoKCFmSdrsYaAgcYLZ699wPVFdQdDFc68Eo8ENmc9iFhxvY/aEoNwX2zbCBmaHVvt69Q6vlv+kTXK9aR4W6dAkKxxKHPzc7bD2IJfO6Z/G0uwWIs/IX+TlaZ+XKmqoOET9V7tNHveh7I2xvjoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuGTE40/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuGTE40/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9119DC43399;
	Wed, 21 Feb 2024 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497083;
	bh=V+LVlg96JbbxV9/NAT+eYZJ9otqIxXDrJP/t59ex8bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuGTE40/dgr+kVEHB8h1c15ybjm00sKysVzxYvPo2ALaHgAEZ7rr0OPSyi9/zi0Sj
	 q1zUVQvm7htXTOIgvoini//pz+69Z5mo1ewef2L1whun5SJ7dazltDu6NeFRRuudBr
	 /7r6rw36QEpUfXfI+1ADdYw+oUwtykoXc61R5l0u8DDLnoat2dPAl6SD1VsuI6lqVB
	 GP8HzNELI+/pM+VIj8V5uZylOhvcFXG3EVpVUz34oKjnd3bmrWYBXpMF6TZYTcY+d8
	 EnvQM7JFIcWKk7RH/ZMsypbV+FYvy0VdwEcLzoibOrM/NP+9vUn9hRf0MHOJeESmKq
	 Nu6XOOxpFtgFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] mptcp: drop duplicate header inclusions
Date: Wed, 21 Feb 2024 14:31:09 +0800
Message-Id: <bf14f8ffc1d5938a03177e5ace30b445bacb6326.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
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

