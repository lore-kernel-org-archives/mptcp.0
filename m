Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DA6D14
	for <mptcp@lists.linux.dev>; Wed,  7 Apr 2021 00:16:13 +0000 (UTC)
IronPort-SDR: FN2w0H2C4TYWxnv2HLMNOEV8nrKAoTPZ0V5cgbSPm3NBdJJkILg4hdGOrXpOMPbOUf3KoMw7w9
 YLSciCoOG9ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192723063"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192723063"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:11 -0700
IronPort-SDR: FtkyBnW36PmpT21Eo/hOYN1FvgFz2tWNMf5U6IlbFNVMHOGJ1fdj0Ki/vBLrk5MftAXqefQa24
 qYUDD+Lt4LuA==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="458105201"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.115.52])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/8] mptcp: drop MPTCP_ADDR_IPVERSION_4/6
Date: Tue,  6 Apr 2021 17:16:01 -0700
Message-Id: <20210407001604.85071-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407001604.85071-1-mathew.j.martineau@linux.intel.com>
References: <20210407001604.85071-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

Since the type of the address family in struct mptcp_options_received
became sa_family_t, we should set AF_INET/AF_INET6 to it, instead of
using MPTCP_ADDR_IPVERSION_4/6.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 14 +++++++-------
 net/mptcp/protocol.h |  2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8d28f2e0de82..3bdb92a3b480 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -220,22 +220,22 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (!mp_opt->echo) {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT)
-				mp_opt->addr.family = MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family = AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6 ||
 				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_PORT)
-				mp_opt->addr.family = MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family = AF_INET6;
 #endif
 			else
 				break;
 		} else {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
-				mp_opt->addr.family = MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family = AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
 				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
-				mp_opt->addr.family = MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family = AF_INET6;
 #endif
 			else
 				break;
@@ -243,7 +243,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->add_addr = 1;
 		mp_opt->addr.id = *ptr++;
-		if (mp_opt->addr.family == MPTCP_ADDR_IPVERSION_4) {
+		if (mp_opt->addr.family == AF_INET) {
 			memcpy((u8 *)&mp_opt->addr.addr.s_addr, (u8 *)ptr, 4);
 			ptr += 4;
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT ||
@@ -268,7 +268,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 		}
 		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
-			 (mp_opt->addr.family == MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
 
@@ -991,7 +991,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	if (mp_opt->echo)
 		return true;
 
-	if (mp_opt->addr.family == MPTCP_ADDR_IPVERSION_4)
+	if (mp_opt->addr.family == AF_INET)
 		hmac = add_addr_generate_hmac(msk->remote_key,
 					      msk->local_key,
 					      mp_opt->addr.id, &mp_opt->addr.addr,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ca3013facbba..d8de1e961ab0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -90,8 +90,6 @@
 
 /* MPTCP ADD_ADDR flags */
 #define MPTCP_ADDR_ECHO		BIT(0)
-#define MPTCP_ADDR_IPVERSION_4	4
-#define MPTCP_ADDR_IPVERSION_6	6
 
 /* MPTCP MP_PRIO flags */
 #define MPTCP_PRIO_BKUP		BIT(0)
-- 
2.31.1

