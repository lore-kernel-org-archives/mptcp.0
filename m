Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88358F4F
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558332; cv=none; b=sqN02SckkXjcLKLTEX5kovzuV1NLm0SoWu1FnCZZs5E205Pm/9m3qW7qgJ4epw2ZX2+11Qi1X4Qo84u3l3846DRYbzXRlT7+cyj54NxOMP+z7jcaGyh2qRMYRku6jyVgWvIEV+z0EeEtDw/1Jjppf9cP7Od70L/bCXCsLh+WO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558332; c=relaxed/simple;
	bh=Ikwz+OjNnryV8x48fw54k45/9ukZa+8huwLsHZAJRKg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=GAzzz87+3LQyFySA3jm7+S4RUI3KdCddTXfeDzxtzS4e83PtATT5Y4FpwAjMkXI9UpGacsFtdu6dleDJiNnAJaLf5oYFr9FsCMvxT09gefxqcgwO2rRBApWiEr42JPnREV8iLsX0Yp8Z2iYoFBSxpc8Q7U6w3hXNhmjPzqiETU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCLb0Rma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCLb0Rma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937C4C433F1;
	Thu, 18 Jan 2024 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558331;
	bh=Ikwz+OjNnryV8x48fw54k45/9ukZa+8huwLsHZAJRKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCLb0Rma8emmppCzvfyMPsPldfYz49vgv2bAkFK2kTLTsowZWorhicdZ47QOeVyRe
	 tbDCzAp8KTTN/990afLwmJVg8XDUjt9iL78i4+SjiAW0A/NDOsDulirHjHJ8x8HPf0
	 wPx+TL8O4y9/k3sWA56rJk/sFyq9m0sQj5JWfY5+IP6k7TbFY4W4Fm9WFMxif1CnWC
	 ICTCl7MBwKF1gsWEzckgT4IBXpv1PBivHQ8lvRsNRKiNCD4HvWeaUNDpWaXpY36BsJ
	 e+J+pFUoxJpqvg9ffftCS8OMv4OjsNKbASEGvvSuzql9jVQQ+VUNXHYoUoPFWKIkmI
	 hYrcAZn6ykcAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 02/23] mptcp: add needs_id for userspace appending addr
Date: Thu, 18 Jan 2024 14:11:42 +0800
Message-Id: <eb36016f963d58a1531b7e90e9ee9f753f48da9a.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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

In mptcp_userspace_pm_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(),
pass mptcp_pm_has_addr_attr_id() to needs_it.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4f3901d5b8ef..8ca6e28a121e 100644
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
@@ -198,7 +199,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val,
+						       !mptcp_pm_has_addr_attr_id(addr, info));
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -378,7 +380,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
+						       !mptcp_pm_has_addr_attr_id(laddr, info));
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.40.1

