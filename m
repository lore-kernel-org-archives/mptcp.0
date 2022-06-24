Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD987C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656088706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7OkVUbfttfEym+rk9UuMQIvrm4/ED6RhiPAR/EIjS0=;
	b=Z14Qzomgq6+NuIWKbbBUXpTMtDP6w/m3iSuDlay4gtEgpU4YlYH6WPyieu1xQoPwL2omOg
	oyHXnUOuJKebqQoyFYM6vWfJ/4GBNnZLi/3lPWZK/d9lQez7QjDrFbUkM6WhBG4amtdXqe
	jzfxcoNxAU2xuibmzUw34EQt+WAIIz8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-n3FLh6Y4Mmil_NALgEvKKw-1; Fri, 24 Jun 2022 12:38:16 -0400
X-MC-Unique: n3FLh6Y4Mmil_NALgEvKKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8850C101AA46
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC132026D64
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC 1/4] mptcp: fix local endpoint acconting.
Date: Fri, 24 Jun 2022 18:38:07 +0200
Message-Id: <211c8536d4776abdb86e60a154d5fc6c140a6535.1656088406.git.pabeni@redhat.com>
In-Reply-To: <cover.1656088406.git.pabeni@redhat.com>
References: <cover.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
index e099f2a12504..2b2bb3599781 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -801,7 +801,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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

