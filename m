Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AC2CBF
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693456; x=1671229456;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=G096dBDKezzmhXrBs+6LJLlyoiZne8ro/k4R5bPmM88=;
  b=Win4jj5mRCRZg1WfdbPcet1dykDpjEAqHwTIiz+mhdlngwBqvL2PtLMO
   +fjt/G7GLxD6ktLUjDjtaULdDi+EIE2fDhQmx+aTKvzKtUmPNQshv5qF7
   CoHD8h21T8VJU0sRzij05xXVGrmwDhLtr51As5aiDy79faBwkCt00f3TT
   lEZ1Fb4i4Z7VBay+nPjf3e5hihQtx915i+imZyw/qDbhhWZMxrJggYCnN
   irdDC0QkpmmutuWZifU/2Vhgr597wYY4ZUWfFwN4OmNi1Iy2cRTDnmVwF
   wJW+66xqdAy/GsFoMwrgK7c3ECxTTwaRx4eJ/SNbKvBITe9cnk6Rmpbpm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393162"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461243"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in creating listening sockets
Date: Thu, 16 Dec 2021 17:23:00 -0500
Message-Id: <20211216222314.1244708-8-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates mptcp_pm_nl_create_listen_socket() to create
listening sockets bound to IPv6 addresses (where IPv6 is supported).

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 29f6d01ace2d..7adc8c73ec48 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -986,6 +986,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry,
 					    struct socket **lsk)
 {
+	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct mptcp_sock *msk;
 	struct socket *ssock;
@@ -1010,8 +1011,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
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
-- 
2.31.1

