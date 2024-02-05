Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7072C1B6
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148321; cv=none; b=Tvj7UeAVQNka5JTHg8h+GmuJfnfCeDbSkMBPeGb9eF/v2h8YpcF0YpW5caI9OUYjrTekfsq9g5P8ZnUJjpCXL/z874q+2RZ12oNUFhCgxw5gZYk2HYITbjasY5A3b1F++I3tY8H/NIeCkb/5lHeBdBHAVA/JsVjUoXFOP+gVX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148321; c=relaxed/simple;
	bh=nE7aOXyZh1gpXHJ7XAQl2Gp+YmOseIYvTlKUC1ZCH8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSHVJxS+mVzZs1AxHEL/OWlWJRGinweeK9USkXwTVOPRl9FzxmxjuRjBChBXKAQwGkt+PxL8HiEUC88CD66PDyFhAwNpl176kIa4DRqbN214gH4gkxd+jjlmBKxRhuDHSctK0tslKQp3gLGvQF885E3Hbw8HgTZn7tGHhIbKIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+lhx8t/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+lhx8t/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXQUu/QHs7IQNezPJaehmHTvz7QOWaNQAMcwYRZPVsY=;
	b=F+lhx8t/BOolSdfAc6CfECD9oI1rpD4fduqZUFdtmony6UW7E/2bV/+IfTgyMIJJtOzFue
	v75A+TC+M/Ic96tSO468PjZyHVaKzEFmt44mndDrGpmuv9/Xw3AoKaxRLUgZdLznavXngH
	fSuqS2dLF4QYmfpiHyofreJ09XtBqk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6AnHfQjeNs6UZm5OjmkuMw-1; Mon, 05 Feb 2024 10:51:57 -0500
X-MC-Unique: 6AnHfQjeNs6UZm5OjmkuMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33A5E1013664
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6BA43C2E
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 4/4] mptcp: fix duplicate subflow creation
Date: Mon,  5 Feb 2024 16:51:42 +0100
Message-ID: <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
In-Reply-To: <cover.1707144963.git.pabeni@redhat.com>
References: <cover.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Fullmesh endpoints could end-up unexpectedly generating duplicate
subflows - same local and remote addresses - when multiple incoming
ADD_ADDR are processed before the PM creates the subflow for the local
endpoints.

Address the issue explicitly checking for duplicates at subflow
creation time.

To avoid a quadratic computational complexity, track the unavailable
remote address ids in a temporary bitmap and initialize such bitmap
with the remote ids of all the existing subflows matching the local
address currently processed.

The above allows additionally replacing the existing code checking
for duplicate entry in the current set with a simple bit test
operation.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/435
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that there is no problem for the opposite event sequence.
---
 net/mptcp/pm_netlink.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 066bc855365c..617aad83eb87 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -396,19 +396,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
-static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
-				  const struct mptcp_addr_info *addr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++) {
-		if (addrs[i].id == addr->id)
-			return true;
-	}
-
-	return false;
-}
-
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
@@ -440,6 +427,16 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
+		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+
+		/* Forbit creation of new subflows matching existing
+		 * ones, possibly already created by incoming ADD_ADDR
+		 */
+		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		mptcp_for_each_subflow(msk, subflow)
+			if (READ_ONCE(subflow->local_id) == local->id)
+				__set_bit(subflow->remote_id, unavail_id);
+
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
@@ -447,11 +444,17 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
+			if (test_bit(addrs[i].id, unavail_id))
+				continue;
+
 			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
 				continue;
 
-			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
-			    msk->pm.subflows < subflows_max) {
+			if (msk->pm.subflows < subflows_max) {
+				/* forbit creating multiple address towards
+				 * this id
+				 */
+				__set_bit(addrs[i].id, unavail_id);
 				msk->pm.subflows++;
 				i++;
 			}
-- 
2.43.0

