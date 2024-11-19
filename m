Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308E1C2454;
	Tue, 19 Nov 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021387; cv=none; b=BmaflWs83LLWnMK418iK5XA9iRevGAxtbbk4SfnTVw5BHLX6tlMw3RnnOEYfQUcQSjbrAGkwLtlPdj0fhMBJyurpEZn/gY/8LrtZCpXn71WPm85DbM8Q7Xo7YIfKBZU+Ykhu17FtXSDlHQVvUOtE0/BttExeF4Y1QsU6OEp95xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021387; c=relaxed/simple;
	bh=84J9oWZ1jO/jeM8NXkQq00KrpH49A7W8fNrkqymXFRg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=KX4LfDhWX+dtJ2HYxDPtQO4fP3H+YZpZFa7fNAqLMWq5lza5cVklg6Al1h5WVe02ph09EktYHcrbnoqpjb2BJSIW5MOd0qucZTA5cT+UjDr8OHP3Vxns/POR3cgfXpIsG1HOsYEQ1MwCYzeCaK5Aa+U6BLJZ1oF0HYX6Fb/DDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvNYT99t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvNYT99t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA32C4CED0;
	Tue, 19 Nov 2024 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021387;
	bh=84J9oWZ1jO/jeM8NXkQq00KrpH49A7W8fNrkqymXFRg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=rvNYT99t7+MveoiT6JAoErPHzZVtWLqYnHW6VeQNy9YaDgP/vzKvD+S8k6ZM3EuUQ
	 MjUeRvvvJ4uj3WVRWARFwMgh8RVvMORpuU4czERJ4kXdEIKOa3aiPIQl0cIwsf4S8j
	 WJRk3K2OlnMqfpdfxzUsLY/VSvADiQ9Y1VROgzoQ=
Subject: Patch "mptcp: drop lookup_by_id in lookup_addr" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:02:34 +0100
In-Reply-To: <20241118182718.3011097-13-matttbe@kernel.org>
Message-ID: <2024111934-gonad-recast-264e@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-drop-lookup_by_id-in-lookup_addr.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93826-greg=kroah.com@vger.kernel.org Mon Nov 18 19:27:58 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 Nov 2024 19:27:23 +0100
Subject: mptcp: drop lookup_by_id in lookup_addr
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241118182718.3011097-13-matttbe@kernel.org>

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
@@ -521,15 +521,12 @@ __lookup_addr_by_id(struct pm_nl_pernet
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
@@ -560,7 +557,7 @@ static void mptcp_pm_create_subflow_or_s
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -2064,7 +2061,8 @@ int mptcp_pm_nl_set_flags(struct net *ne
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.6/mptcp-error-out-earlier-on-disconnect.patch
queue-6.6/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.6/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_spac.patch
queue-6.6/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.6/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.6/mptcp-define-more-local-variables-sk.patch
queue-6.6/mptcp-update-local-address-flags-when-setting-it.patch
