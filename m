Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676017E
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670546679; x=1702082679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msV/M1wz+UVrq7h8FdkC4OUJp8FGohM+zY3ESmWi5ts=;
  b=ecYZeCq/wuw4IfH2HprBgR9qVgP+3Hdv8odIezJDGG1PnqQJJLuoTVB6
   T5tv6RfN7Fi3ZIZ1x6iL3dV2+paeU0h/Zg58qh1q5P2mYLxrIJDO6tINL
   8L7yayB+68PCVFEkBdE5RFFLtHx4xNRvGYBN4/SwSVSrvYLpgn7z9J7P1
   sjGqqcSnOSaJAOJXlrXJoZGQux8STLxQf6U9q1W+ntcmeW4IM0nkED3IW
   1fUB98v7iB8Kmjl39LN63yfEnVAZ3qACdSTQdMdXleIdaF1EaMsxuOVGr
   g9jACYzk7Y0l+XsFPp45LrqZLmjKc8Cfvwdl774KUMc3/uVYLXbDrKIY0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="317367582"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="317367582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="736027002"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="736027002"
Received: from mchombea-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.102.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/2] mptcp: use nlmsg_free instead of kfree_skb
Date: Thu,  8 Dec 2022 16:44:30 -0800
Message-Id: <20221209004431.143701-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209004431.143701-1-mathew.j.martineau@linux.intel.com>
References: <20221209004431.143701-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Use nlmsg_free() instead of kfree_skb() in pm_netlink.c.

The SKB's have been created by nlmsg_new(). The proper cleaning way
should then be done with nlmsg_free().

For the moment, nlmsg_free() is simply calling kfree_skb() so we don't
change the behaviour here.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eef69d0e44ec..08c65f3e70a3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2094,7 +2094,7 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event_addr_announced(const struct sock *ssk,
@@ -2151,7 +2151,7 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event_pm_listener(const struct sock *ssk,
@@ -2203,7 +2203,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
@@ -2261,7 +2261,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 static const struct genl_small_ops mptcp_pm_ops[] = {
-- 
2.38.1

