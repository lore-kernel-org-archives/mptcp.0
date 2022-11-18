Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CAA470
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668797176; x=1700333176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/N7njNkgP481j3Xh1uyhGw0c8vyZaLSJFZeI2cSHso=;
  b=SXJ5heIoxGyVT+Chz6jRM6pYVKoBzhbt0sax1hmE0e3V5JJZmtfNvEW2
   6nqlFiZXCqP+jJsa8gxQi7hK4yKeXKd9uTMuACeDWD3CNOCumKUu3Z9mY
   WtERkCyJW3KysVQHkN4VXv6uwEO2UUdv/wJEKvOSHisbXRaikW1TWVoEf
   7EZ8YgDpMKaZ6gu3utPFencB4/5CASR/QJcmpuAYM+GqyX5KLo9KcI5Si
   3KRQldCb24bAZIsOKE3VwEjD7R1l5icCcC+HmPFdXG71HReRydmHWIWUz
   nLqUUcNeEyBNOpF0xTF0HPRG1bzTO2rwOgW0qmsAgFpLz19kv0WSHniCA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314356550"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314356550"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746102227"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746102227"
Received: from mjenkins-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.47.242])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:13 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/2] mptcp: deduplicate error paths on endpoint creation
Date: Fri, 18 Nov 2022 10:46:07 -0800
Message-Id: <20221118184608.187932-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
References: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When endpoint creation fails, we need to free the newly allocated
entry and eventually destroy the paired mptcp listener socket.

Consolidate such action in a single point let all the errors path
reach it.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..fdf2ee29f762 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1003,16 +1003,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		return err;
 
 	msk = mptcp_sk(entry->lsk->sk);
-	if (!msk) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!msk)
+		return -EINVAL;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!ssock)
+		return -EINVAL;
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1022,20 +1018,16 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
 	if (err) {
 		pr_warn("kernel_bind error, err=%d", err);
-		goto out;
+		return err;
 	}
 
 	err = kernel_listen(ssock, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
-		goto out;
+		return err;
 	}
 
 	return 0;
-
-out:
-	sock_release(entry->lsk);
-	return err;
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
@@ -1327,7 +1319,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
@@ -1338,22 +1330,21 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
 			GENL_SET_ERR_MSG(info, "create listen socket error");
-			kfree(entry);
-			return ret;
+			goto out_free;
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
-		if (entry->lsk)
-			sock_release(entry->lsk);
-		kfree(entry);
-		return ret;
+		goto out_free;
 	}
 
 	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
-
 	return 0;
+
+out_free:
+	__mptcp_pm_release_addr_entry(entry);
+	return ret;
 }
 
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-- 
2.38.1

