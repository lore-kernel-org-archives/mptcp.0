Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FF1C689C
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590064; cv=none; b=uCzTyRy0KtnAswRTyGAdEHc4oXeM2P3zeX1BQJZLcWL45wO0fWoqcA1WNLNqxHVLSG5pqe+aWAyydKkhX2OSEDS/G6kRq1I6kPCpwdvhnG9fouah+R9G3axvQZqNRjXNLhyh6iAe2mRb+7a+ZZxsitIzKYfpWMQnbweET8C5JDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590064; c=relaxed/simple;
	bh=EwWh+3DWzVpZ1QIErg4XyvyEUw0wj3Ube0RJh8z7BfQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIYSiTXfcqB7cLW6ldbWQVe7Qfcf85hWasF4MvRe3gLDBsTD5Z2pxAlLQksv+9AeG+Mas69ZuPC2TawsWYC3rGSKRoI1cYf8r8hI0+yRPNhjWTNUSZkS56y0+VLEDQLd7WDukpGcqDWEwD4KQEINw914FOaIlQnxRXnBnDrRXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPmaZ/42; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPmaZ/42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719590061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Squ10khlfFWTEyFced8/TycyLB7EKlaYUBlZqUxfSQo=;
	b=RPmaZ/421WOlmz4He/k8b6LejpwjPwlfDeSDnlt4kbbxPW++f/ycjkiPK6j0LoC3wQBE/z
	ZpnXWXbqcnUiv+5CHm1syOBnlWUkUjlKaMtNIPPm03MiY4jzzo3qi4zGbi+XAI+GPYOybX
	8jthvMYvMoFxNpyjYiZdPQMfq2Yu8Kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-_-fbwmuxNfqnkTLdtuXjTQ-1; Fri,
 28 Jun 2024 11:54:20 -0400
X-MC-Unique: _-fbwmuxNfqnkTLdtuXjTQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5672F1956089
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C91D1955D89
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/3] mptcp: fix announced address accounting
Date: Fri, 28 Jun 2024 17:54:06 +0200
Message-ID: <4a8ac95282ec2b551a64134f24b2e2fd7d82973c.1719589916.git.pabeni@redhat.com>
In-Reply-To: <cover.1719589916.git.pabeni@redhat.com>
References: <cover.1719589916.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time one of such address is removed.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
slightly unrelated: is unclear to me why mptcp_pm_remove_addrs() does
things slightly differently from mptcp_pm_remove_addrs_and_subflows(),
with the latter IMHO doing the right thing (TM)
---
 net/mptcp/pm_netlink.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..624f9ea66aea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1534,16 +1535,25 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
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
@@ -1556,17 +1566,18 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    slist.nr < MPTCP_RM_IDS_MAX)
+		if (slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.45.1

