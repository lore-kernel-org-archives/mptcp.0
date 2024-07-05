Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E81442E3
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211650; cv=none; b=eglwFjvgV/BrLnC6XhGz2/4dm940UEeUKwF9ZyzepFQgBXVirYXR85Ri+DN+9dzfgtL2peUXBatDM76IgN1U2yY4+QDAijqkfpQxFXGqTxYVbun7s71ZWyh3yRHKqs1OkK5mg/m7v2qU/gH/q10WHsuMjvGoZp1xJdq6+qC4oFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211650; c=relaxed/simple;
	bh=YQxBgZTxEbotcEDtCk7DpkX72+qfRupY9k+BPt0bX+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRUmBMx+iFfB2HHV9XV0oERYDFx3Jke5KVK3H8/l7p2tS3WVY3F1I46lmfNLCMDFF4ic80sLskDtYibP+fQ28Bwp5jEd41CRvMjTq+KSLXw6exJ97wVQWQdpZaQhY2sAyunxLe9iBVe8ezdM+e3GVsRw3+lpPpKYG1AqVZpA9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ww3cP5wS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ww3cP5wS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720211647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/mGoG/EyXf12h/xGva93XUt7eZu9i0wOAuxNsZeXCs=;
	b=Ww3cP5wS5WZMcwXSKjZYaihNd+X1rkqy/WlqtZNWYDiPoADT6JhfFtQceXaK9dFLuknS6q
	8cE8vkY/f9FnSlxljQelWiPCvOFYy98xOmhOHIWAIHJ84MvT9koNjGrg2G0TunXhKBqRTd
	4KtPTJ+YPVbMo+ukZlrwx5zvMiDrcxc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-_vgnFW3WOK-dicB__UgohA-1; Fri,
 05 Jul 2024 16:34:05 -0400
X-MC-Unique: _vgnFW3WOK-dicB__UgohA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F10A819560B1
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A20C41955F3B
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/4] mptcp: fix user-space PM announced address accounting
Date: Fri,  5 Jul 2024 22:33:47 +0200
Message-ID: <dfb0abf1107af829d6fb2e7a393633f36eec469c.1720211515.git.pabeni@redhat.com>
In-Reply-To: <cover.1720211515.git.pabeni@redhat.com>
References: <cover.1720211515.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the per-connection announced address counter is never
decreased. When the user-space PM is in use, this just affect
the information exposed via diag/sockopt, but it could still foul
the PM to wrong decision.

Add the missing accounting for the user-space PM's sake.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..b399f2b7a369 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1534,16 +1534,25 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
+	int anno_nr = 0;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
-		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
-			alist.ids[alist.nr++] = entry->addr.id;
+		if (alist.nr >= MPTCP_RM_IDS_MAX)
+			break;
+
+		/* only delete if either announced or matching a subflow */
+		if (remove_anno_list_by_saddr(msk, &entry->addr))
+			anno_nr++;
+		else if (!lookup_subflow_by_saddr(&msk->conn_list,
+						  &entry->addr))
+			continue;
+
+		alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= anno_nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.45.2

