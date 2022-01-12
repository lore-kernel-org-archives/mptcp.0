Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02762CA1
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025772; x=1673561772;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+uWiNDauEPfD6qygBmc4NIRCchONURGA14EtKbvKIjs=;
  b=MRmXkN3SUYQxGClCghlFrEcIUKliAanAmjYEIIhyJwza5XXnkgDJA2h3
   Vcm2uBUTaCdQJTJr6pZyGuMunE4RzOj7TjiZrodMTOXJzUUse70C4maI0
   CQwbf1DkVhjitjTAfSdNBmp7ekhBnCdyVEHtJF5I6HnZGdd5E1Osxm4nf
   DmiZJmy2rlmtq9f6A2L2cvFvCEeolMGPwkysd/iZkwEor7lHTGe/sDv/Y
   mI5ERfuvdGiVcQ1j/RSzLJ+awfomPnaQIv4LP9aL/A8fH1GdIwMdAZ5Vq
   fcfhTfaUaW2arm6TR8rxaqAVJvZlkVn4C/9OSqPXpn0tsx158Jkj7YaXT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213935"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213935"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907348"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 07/21] mptcp: netlink: process IPv6 addrs in creating listening sockets
Date: Wed, 12 Jan 2022 17:15:09 -0500
Message-Id: <20220112221523.1829397-8-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
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
index 4c1895dbc2a5..779ec9d375f0 100644
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

