Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D81869
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656669941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7OC7siZlgh2V8GE/bIeQ5XSN0QjjB/wMmgjUbAS9Z0=;
	b=CgrNQSELwIHzfypl+osoUvbA+Z1X26H4FiZU5vIBAG7/UePKdJgzKHsE+kX8CMwq3vkyoL
	RjtFx6wXmwrJymCGYx9xqh2PUfqGBjGxuwlqMF3qyM3Y6u8k8Q8Ue4bsK4sKRCywTPXaTa
	hmm8iKYa+DLGsCP5kQPhCKgaNbCF2mM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-HIsuwN5GOyuRO_5QSPO_jg-1; Fri, 01 Jul 2022 06:05:40 -0400
X-MC-Unique: HIsuwN5GOyuRO_5QSPO_jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43821C06EDD
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53F9C400DFD0
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/6] mptcp: fix local endpoint acconting.
Date: Fri,  1 Jul 2022 12:05:21 +0200
Message-Id: <f0f5893c05f19d5076a9d03c84b65495f488fbf2.1656669391.git.pabeni@redhat.com>
In-Reply-To: <cover.1656669391.git.pabeni@redhat.com>
References: <cover.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In mptcp_pm_nl_rm_addr_or_subflow() we always mark as availble
the id corresponding to the just removed address.

The used bitmap actually tracks only the local IDs: we must
restrict the operation when a (local) subflow is removed.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0a295acf99b8..f1909006a859 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,7 +800,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			removed = true;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
+		if (rm_type == MPTCP_MIB_RMSUBFLOW)
+			__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
-- 
2.35.3

