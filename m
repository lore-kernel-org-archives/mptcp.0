Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9581CC157;
	Tue, 19 Nov 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021994; cv=none; b=CqU8W5mcyqI6VvLACdSfMg9YBl7iRNMyK3l4/hi3n2oMo+t9J26f38wsIiJO6fPV1Rfx7PXTvxEYefaX5g1k3sEHt9uDVkC+tNcWMrfbvKfRjI4BpoxUWP5QbtcoKaYuG3d5vfifLrPC/aavExYfv7SunaHGW7my8qkKVJ/KE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021994; c=relaxed/simple;
	bh=SA4yQwzFLs4ObUmi/qm1f1bTngZXuTq1VBY8b59vAwY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=o9IZ6SQ3lB0lIXBrF0T6sicxsAd8g66AyRH/68NUKye/JLwqEaEtdKmZ3zAdq7ykUt9iNRLGa3+t0G3XpmmOPcVmRzeyTBxxFBSPwY98Ur0+W7knwq2AohXRJnv3OnNhPVrdtY7Gy1zrg08vYLRu3Sf8y1ww8/4KOO1QPKM0vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FuOJ01kJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FuOJ01kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D3DC4CECF;
	Tue, 19 Nov 2024 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021993;
	bh=SA4yQwzFLs4ObUmi/qm1f1bTngZXuTq1VBY8b59vAwY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=FuOJ01kJzEetgraBnL3lCtKhnsId4Ula40n7hwNI1vrg4HD10ehTuStGxFRBVfi0r
	 KW9rTHQFPsEWL94m6FtjeDrzOX/jY65o3Kh6QCYh5uQyvZEKHCKZ/8zaFzTX3PNBj3
	 GrDS8gOi02BwkHhVjz8xoKaZAGbOzK+JjjSfVSn8=
Subject: Patch "mptcp: drop lookup_by_id in lookup_addr" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:12:46 +0100
In-Reply-To: <20241119083547.3234013-15-matttbe@kernel.org>
Message-ID: <2024111946-hurdle-popcorn-87b1@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    mptcp: drop lookup_by_id in lookup_addr

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-drop-lookup_by_id-in-lookup_addr.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93941-greg=kroah.com@vger.kernel.org Tue Nov 19 09:36:48 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Nov 2024 09:35:54 +0100
Subject: mptcp: drop lookup_by_id in lookup_addr
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241119083547.3234013-15-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
  set_flags interfaces") is not in this version, and causes too many
  conflicts when backporting it. The conflict is easy to resolve: addr
  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
  code is the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -525,15 +525,12 @@ __lookup_addr_by_id(struct pm_nl_pernet
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -564,7 +561,7 @@ static void mptcp_pm_create_subflow_or_s
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -2081,7 +2078,8 @@ static int mptcp_nl_cmd_set_flags(struct
 						    token, &addr, &remote, bkup);
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
+			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.1/mptcp-error-out-earlier-on-disconnect.patch
queue-6.1/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.1/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
queue-6.1/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.1/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.1/mptcp-define-more-local-variables-sk.patch
queue-6.1/mptcp-update-local-address-flags-when-setting-it.patch
