Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F653AC34
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759488; cv=none; b=bPmDu4/QRsQHk+Pc11uGeyni1SOrhD5Q+iHRRG/eG4I6lSRAix2VGxJ7PvKQHkcjKjZsp2rvij80UH59YOzVYgVNSDRgcAjKdXe8Sv/iR0Iv5VxRtGBan5+NrN46IDpfiqBpxFgzISrMwlD9ctxdNlMn2J/0M05MAAVV0RRADjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759488; c=relaxed/simple;
	bh=j38uX59mZzne+RTKkfxsSPM8FSRFWxzy3117B8D5coU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPC+YV8oeV4Wn2L8Eu7ywOwLcRYxBsqgss5LaOvtMqUW8mCweUA5GkEECJ7pvZAhb0SJ6UG9FMQ7NPprTnkqYeSMPisvAdnYeMRtj8ZZUu2WcibJjoXI9k+kXUW67NhvuSQ+1WcCHWG+TfrFexYDedn4nm48Zr+7SmWoYWDk25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZS+cGil; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZS+cGil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEEEC433F1;
	Thu,  1 Feb 2024 03:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706759487;
	bh=j38uX59mZzne+RTKkfxsSPM8FSRFWxzy3117B8D5coU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZS+cGilzrtn71kGrq8DOUganyv546n2t8rd5Qx5OMOYcDIPS23/M8o5lZfGqQ6I2
	 XPM88+Sk/cmwUK+moDoyD12wqFTisq/6Ux3ZfNc6H1a++sa0m27ak3Cfd8uzk9ViKs
	 OFr+5g4rrxh/FHyxgy4xWCDZY/X6Af2C7OUs+zPktwKTcVClSEBZvUszecKbqf8Y7m
	 kLaHXaWRWegGb1P0i5tCj7TBl0iwJIyVO8uzjqA49181i2zYLMttqyFhGMQLSbCldI
	 he4u5JmM4scXkbLnMRmbCF53yJI1VSImdZcQuolmth08hi1PVvmmlSWGzFIbMz+V7o
	 IDuDHBzT9V8ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 1/4] mptcp: add needs_id for userspace appending addr
Date: Thu,  1 Feb 2024 11:51:15 +0800
Message-Id: <0d089da27becde2a0ff936dbbe856b2baf9bf710.1706759413.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706759413.git.tanggeliang@kylinos.cn>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An ID 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a new parameter needs_id is added for
mptcp_userspace_pm_append_new_local_addr() to distinguish between
whether userspace PM has set an ID 0 or whether userspace PM has
not set any address.

needs_id is true in mptcp_userspace_pm_get_local_id(), but false in
mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit().

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4f3901d5b8ef..e582b3b2d174 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,7 +26,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -41,7 +42,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -64,7 +65,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -153,7 +154,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -198,7 +199,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -378,7 +379,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.40.1

