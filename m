Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0301C3033;
	Tue, 19 Nov 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021387; cv=none; b=ShiWqlCmASzlVYY2nfG03h0lMt4OZjDcKUCn7FKReKRvXIjYEvO6u4ZEQXy5oLf3kyFYjR6K4xg8yL3fum69DV3MA2218RxBXsG+Q1I25hZ/v2VI+mJJSuJgevzkunEO3R8nypjKrVGNRQjeON34+zXhrcqDDhsnXOzlAhRRehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021387; c=relaxed/simple;
	bh=FHc6hZqhW8FYxx2lL/AbZK/plR+DZXjaYPWvuGsRUQY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ggfWWkBzxYvjqirfC51+UjWJIdt9wi6fafaupLrw74RvwG7Pi9DxO9xDox+YjSgUhFkD9/+rQPq0xNAHXz4qXto6Utll+L9ax1DiSxLfPZWyA1rJiKi9qevHXdXiWw9TeaTNYE7HGmHA00vL9MsspducZkn0T23IzkpUhEC6D90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMARXPZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMARXPZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AADAC4CECF;
	Tue, 19 Nov 2024 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021386;
	bh=FHc6hZqhW8FYxx2lL/AbZK/plR+DZXjaYPWvuGsRUQY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=SMARXPZmBQRJkLFkbBvRlhBvmBeJOvUIOGTRWXKMNeJLQNJGesSI+A0I3WuG1HAbq
	 zirOjE2bN/ZAAqa4psxwy3be1jEKfMkNLiUrNHuuGBqh8b1rqg+/0YVeeSI5Xl1ewf
	 4znryizdZVRWQOFlX0CpPnSXAvhi4Lq0mR2un1NM=
Subject: Patch "mptcp: define more local variables sk" has been added to the 6.6-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:02:34 +0100
In-Reply-To: <20241118182718.3011097-9-matttbe@kernel.org>
Message-ID: <2024111934-climate-broadcast-3ef7@gregkh>
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

    mptcp: define more local variables sk

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-define-more-local-variables-sk.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93822-greg=kroah.com@vger.kernel.org Mon Nov 18 19:27:52 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 Nov 2024 19:27:19 +0100
Subject: mptcp: define more local variables sk
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241118182718.3011097-9-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit 14cb0e0bf39bd10429ba14e9e2f905f1144226fc upstream.

'(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
it's worth adding a local variable sk to point it.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-8-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_userspace.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -183,6 +183,7 @@ int mptcp_nl_cmd_announce(struct sk_buff
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -198,6 +199,8 @@ int mptcp_nl_cmd_announce(struct sk_buff
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -221,7 +224,7 @@ int mptcp_nl_cmd_announce(struct sk_buff
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -231,11 +234,11 @@ int mptcp_nl_cmd_announce(struct sk_buff
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	err = 0;
  announce_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -282,6 +285,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -299,6 +303,8 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
@@ -309,7 +315,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -320,7 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -328,15 +334,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		sock_kfree_s(sk, match, sizeof(*match));
 	}
 
 	err = 0;
  remove_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -558,6 +564,7 @@ int mptcp_userspace_pm_set_flags(struct
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -566,6 +573,8 @@ int mptcp_userspace_pm_set_flags(struct
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -573,11 +582,11 @@ int mptcp_userspace_pm_set_flags(struct
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 set_flags_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return ret;
 }


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.6/mptcp-error-out-earlier-on-disconnect.patch
queue-6.6/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.6/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_spac.patch
queue-6.6/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.6/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.6/mptcp-define-more-local-variables-sk.patch
queue-6.6/mptcp-update-local-address-flags-when-setting-it.patch
