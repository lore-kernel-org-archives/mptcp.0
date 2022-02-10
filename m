Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EB2C9E
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456317; x=1675992317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0+MAlrnsf/greE/vEdVzWDF/aTaDZ7Y2QTg6LX8frg=;
  b=K5T4istc9NtHwrMOBxIPEMzDvDPmSEaFvdBK0IPPU75ul9jixKwKokcb
   FaOhWtRUVXdg0Txk9aBmukRDoibG+nYaJHBYN+I8rrIinW+fDNE0zRZu6
   5Ra/PJ+/TOrhWR5iFKBtZfLIGVtlEfNXS+Ozp8JOWHtzsMVUHaIcKoyRl
   hwEW9KRYiJmXafU2aWSkQBFdKQOCwc1Gk8xk7qRuEmcRw1Ni99Sw9hGyw
   3kWZTgNC6EhPLf69Stuja/Uz0XPLi/012rOLyb3jjsgBlDs/8KbsjKbQk
   LWBqpyFjzRSxBpCvLjwAKpeAVSD5d0+YiPWLsyA98ZHLykHjs7oQjK6Nd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249136293"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="249136293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:25:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="526263247"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.22.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:25:15 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/2] mptcp: netlink: process IPv6 addrs in creating listening sockets
Date: Wed,  9 Feb 2022 17:25:08 -0800
Message-Id: <20220210012508.226880-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210012508.226880-1-mathew.j.martineau@linux.intel.com>
References: <20220210012508.226880-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change updates mptcp_pm_nl_create_listen_socket() to create
listening sockets bound to IPv6 addresses (where IPv6 is supported).

Cc: stable@vger.kernel.org
Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Acked-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 782b1d452269..356f596e2032 100644
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
-- 
2.35.1

