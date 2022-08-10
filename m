Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734A17CE
	for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660117397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnpW51o9vZB2n42cpIUEn3WnJ9XdWtbQ6q61mDUC/uo=;
	b=TMHr59Pz5FZfsDPqEPRX0Gv2mvdTWKgIWRseyJxphtRoAdVLn0Fq9wXuiTQZPpkBiDTbHc
	UAS23guj+JIxEG+bFyy/fXQxD5PtmUSimwaX8k26bXrnupG10P/y9/LNtYXlRLOVVSXbVz
	21rLRUrwpiuddmQQpcAr+T68X8yKQzM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-Wbjp_Ui0MVKWqAc1AYk0Ig-1; Wed, 10 Aug 2022 03:43:16 -0400
X-MC-Unique: Wbjp_Ui0MVKWqAc1AYk0Ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55ED31C0755A;
	Wed, 10 Aug 2022 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.40])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF51F1121314;
	Wed, 10 Aug 2022 07:43:14 +0000 (UTC)
From: Thomas Haller <thaller@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Thomas Haller <thaller@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 2/2] mptcp: account memory allocation in mptcp_nl_cmd_add_addr() to user
Date: Wed, 10 Aug 2022 09:42:51 +0200
Message-Id: <20220810074251.31887-2-thaller@redhat.com>
In-Reply-To: <20220810074251.31887-1-thaller@redhat.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
 <20220810074251.31887-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Now that non-root users can configure MPTCP endpoints, account
the memory allocation to the user.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c145cdc7bdc..79469178a2a8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1327,7 +1327,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
-- 
2.37.1

