Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457445BFB
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424982; cv=none; b=MtJzivVOafxwxRtHCfvj61qweyXwEynAl7ufqubKwQ2tbHHPoOQCoHjRmf5GGF4bbc8jxZqyOEyLIS5Ogr3n484Iy9eNPZtH2AbCsw6xkJJ1krj7yrnHZzI/LUlsqXBh6I5b3s7yL0fxrM1FJh1OELaBoYDyiib1h7rN6xsOujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424982; c=relaxed/simple;
	bh=RArSk1MaaMQE6RStJlMmMFaMYVYDlkHtZ/Xi/67mM3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xei5dX9co+LveyMq1WroqneYXMKR1IoutT0Q9+f/UtPfBdbRp/DBE8put70ncfUTrlHeESsyPjgzpOxlnd74ZpnuYQZQALXm6n8Dhv2W0hRNkLj6XaTuM0Lt161KYwzL66FaMiXW4zgSEWpLXDo4RD3uQNvGSqmsvM3hlzQc/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsxZWMFq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsxZWMFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707424979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2LuycBoDHZtsKufyTqMIKCNfjKKqgGophSzKH5Ey3c=;
	b=OsxZWMFql9xTGqfR0iR55oha9GoY/4YkGAaSBxlHSRO4xBCd1mVmyMET1G0d7P6jYvgKuM
	Nj/1G2XDOlkSj7EOD7cJEZxU3R6AkNgeNllar8txuDVEFQTbfBFHo5Gi+1lsvVFdgmBKQs
	or5gDEBCd/tLK2nBx5eEYj4Oc4BPMhI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-VZa3NCWRPimgahF6H8kc0w-1; Thu,
 08 Feb 2024 15:42:58 -0500
X-MC-Unique: VZa3NCWRPimgahF6H8kc0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D95463C0C484
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6864BC08EF7
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 4/4] mptcp: fix duplicate subflow creation
Date: Thu,  8 Feb 2024 21:42:48 +0100
Message-ID: <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
In-Reply-To: <cover.1707418323.git.pabeni@redhat.com>
References: <cover.1707418323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
v1 -> v2:
 - forbit -> forbid

Note that there is no problem for the opposite event sequence.
---
 net/mptcp/pm_netlink.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a88cbe266a90..b87d802da028 100644
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
+		/* Forbid creation of new subflows matching existing
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
+				/* forbid creating multiple address towards
+				 * this id
+				 */
+				__set_bit(addrs[i].id, unavail_id);
 				msk->pm.subflows++;
 				i++;
 			}
-- 
2.43.0

