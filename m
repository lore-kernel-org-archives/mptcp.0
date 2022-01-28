Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63212C9D
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330274; x=1674866274;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lfoNaX7qxWIwWosdC3BWMWtNm5HisrhICQ+ri51+zxY=;
  b=bUwq+oIb8lg9773iAvf2E0UeOs7CHupb0KzsYFT1McQPyscUs+EtFizg
   DQ+MyqCfMqBQl4nAI2jcviPLzWsK7qQohGjSR2/ZherORXRo9hKcfnIRO
   6QtmvT1J1xtw2eYQImMfn2t+8KfgVdS+Bl8aUOqfiHw9eJc8KhxfEqgME
   Mzu5FZP7rCWc9ZwRHW/d+q3n7wVk81dAuyDVSfRC87aZN6Z2sgMBrwlnm
   T8pM+jvekVIuF3Sd6dtcbG0If3xbKCk5RgqvFUuxcYPOv8Mvc2qIgsplR
   ZnhUXLYhJJ/2zHyXfzd4cxB6SgGmSc4563WqPnvUz+Qmq0BSniL3WoH8t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310318782"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="310318782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:37:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="521466535"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:37:53 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3] mptcp: netlink: process IPv6 addrs in creating listening sockets
Date: Thu, 27 Jan 2022 19:37:46 -0500
Message-Id: <20220128003746.2732527-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates mptcp_pm_nl_create_listen_socket() to create
listening sockets bound to IPv6 addresses (where IPv6 is supported).

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5eac5bde5b49..93800f32fcb6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -925,6 +925,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
+	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct mptcp_sock *msk;
 	struct socket *ssock;
@@ -949,8 +950,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	}
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
-	err = kernel_bind(ssock, (struct sockaddr *)&addr,
-			  sizeof(struct sockaddr_in));
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (entry->addr.family == AF_INET6)
+		addrlen = sizeof(struct sockaddr_in6);
+#endif
+	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
 	if (err) {
 		pr_warn("kernel_bind error, err=%d", err);
 		goto out;

base-commit: 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8
-- 
2.31.1

