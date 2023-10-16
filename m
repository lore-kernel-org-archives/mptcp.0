Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6C27EFB
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+IWKwp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697463820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgOFhuezaA3luEvym+AcVt4JaVtufAN+xse4n419UAE=;
	b=L+IWKwp4UVel1mI+iJ5sB65+7VKvkiH7XdTB941tQbHWL2dVjF2rRN3FtvoFvL7HiduB8M
	w266RQQqlTMGJ+DPDmo7q1jfyJFdht2iYvg445YpyYbLtIvbKmj5LuBP1MZ8E+VXbkidHb
	J/TpGaiI479IwdXqqLwMFHucp3Dtt+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-RjrlGYPtPHess2nfSgzIuQ-1; Mon, 16 Oct 2023 09:43:29 -0400
X-MC-Unique: RjrlGYPtPHess2nfSgzIuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 020338ECF66
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:29 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FFC5492BFA
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:28 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/5] Squash-to: "net: mptcp: convert netlink from small_ops to ops"
Date: Mon, 16 Oct 2023 15:43:07 +0200
Message-ID: <00f6df700d4a314dd67048ff584fe81a345ab283.1697463031.git.dcaratti@redhat.com>
In-Reply-To: <cover.1697463031.git.dcaratti@redhat.com>
References: <cover.1697463031.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 32976cf7c82b..fd4e843505e5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -53,7 +53,7 @@ const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1
 	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
 	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
 	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
-	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = NLA_POLICY_EXACT_LEN(16),
 	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
 	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
 	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
-- 
2.41.0

