Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F031B14F8;
	Wed, 14 Aug 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657476; cv=none; b=bAQz7d1QuweFtHmgeJY49QgrDt6TMHTl4JYywQrF2G86oNyk2TxGTo/dum6ukIyjBYgIU8mEs6TDwRRklMvQ7BxGcEGnRFnkUvtHLO3X3r22b0EpSNybBOT74C1DQXqahn8zHNxBN2m7DFUlgzEXEWPRgFoM/jJ+hPMbF0+qL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657476; c=relaxed/simple;
	bh=GEZVm/6i4Hh3P7uOyFiLUR3Bo0DrYAZuqL7wI1zdykE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=B0KCxqo86hAAS1yAQgD3tGZMvepOiMltQGrSzIay7z9p7KxbaPudSQfq4Gzm3WSZCzih2H4Fud0X+9XBTOrm0PDQ5fpiVwz2kBrVpr7NBemE8QwKWAtmFmAEk8jJLKhnyGf/3LsowcnAq3v6WNA2d9bfpUYr1bIRiG9KFsAhbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbLoknXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbLoknXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907EAC116B1;
	Wed, 14 Aug 2024 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723657476;
	bh=GEZVm/6i4Hh3P7uOyFiLUR3Bo0DrYAZuqL7wI1zdykE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=sbLoknXYLFR22HARpONXke8q5/5GWY71D+c4yc/oH4sFPwwrEHh191OK0Snbn/MS+
	 KwntnYGmAVZ8QGgD6YYaqwzAwi8cSPA7A1H3HbX5ZKxZGQgdg2bYSkvt7U0QKtbzVd
	 9YZtgTXW+TvkuRjEYTrvWrgGLXWEfOh5kl8AJLNg=
Subject: Patch "mptcp: pass addr to mptcp_pm_alloc_anno_list" has been added to the 6.1-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Aug 2024 19:44:33 +0200
In-Reply-To: <20240813092815.966749-8-matttbe@kernel.org>
Message-ID: <2024081432-buckle-author-61bc@gregkh>
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

    mptcp: pass addr to mptcp_pm_alloc_anno_list

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-67437-greg=kroah.com@vger.kernel.org Tue Aug 13 11:28:38 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 11:28:17 +0200
Subject: mptcp: pass addr to mptcp_pm_alloc_anno_list
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240813092815.966749-8-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit 528cb5f2a1e859522f36f091f29f5c81ec6d4a4c upstream.

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c   |    8 ++++----
 net/mptcp/pm_userspace.c |    2 +-
 net/mptcp/protocol.h     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -352,7 +352,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -360,7 +360,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -377,7 +377,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -580,7 +580,7 @@ static void mptcp_pm_create_subflow_or_s
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -225,7 +225,7 @@ int mptcp_nl_cmd_announce(struct sk_buff
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -812,7 +812,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.1/mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
queue-6.1/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.1/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.1/mptcp-pm-reduce-indentation-blocks.patch
