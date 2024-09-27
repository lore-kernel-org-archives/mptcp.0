Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE317BECB;
	Fri, 27 Sep 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425516; cv=none; b=cFxdOvYidhiHVpKL57GfEjTJqpbi7jXwokSD5zOj/wR8XeU8OZutWOr/Kop0ppCXLrGCmRtxRkpG1AhLCEzQv++hJmg7GGLdACMFmv5tyXGJQjn8WEwgtdMl3xSoE/tOZRAthOjo0tuI8fwUen9sVxGMhPyfTDwaf1+7LKze4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425516; c=relaxed/simple;
	bh=t3YAX322zt6i/rdCfbTis/VMxhTfrT2fvCJpki6+AQw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OXzuWjecCCsqPfQu7AN75lvCYLMFAflHTZe88f/lNP4Z9dG1GvGRVBUO6pBWJdnyV7Q6Upxw7+mq5QMDBymBnijRdKVI6uZHg6eDO1d/+KNMkMXYkVllVwG4VtwBHgvdP5RZS2RKEd+q+4wzCJLm0GKK48zOhseiAno6s+sqV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+J34sLG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+J34sLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58DFC4CEC4;
	Fri, 27 Sep 2024 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727425516;
	bh=t3YAX322zt6i/rdCfbTis/VMxhTfrT2fvCJpki6+AQw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=P+J34sLGkrySowYg8DnOxfqt/nN00bmvMfkjNCQBQEnXzLUcArOm56G62PzyPEzEH
	 ubIJYcsywrCVIwnDds7svlxfF9sajgZuRBzNFzYNQp0T3SF2Bb606LdciFf7LxPgiX
	 5GoJtgVe7ssxljkYznBb/OQEtolWTg8+E1VOzPl4=
Subject: Patch "mptcp: export lookup_anno_list_by_saddr" has been added to the 5.10-stable tree
To: davem@davemloft.net,geliangtang@gmail.com,gregkh@linuxfoundation.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Sep 2024 10:25:13 +0200
In-Reply-To: <20240917072607.799536-6-matttbe@kernel.org>
Message-ID: <2024092713-quartered-neatly-8add@gregkh>
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

    mptcp: export lookup_anno_list_by_saddr

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-export-lookup_anno_list_by_saddr.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-76548-greg=kroah.com@vger.kernel.org Tue Sep 17 09:26:33 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 17 Sep 2024 09:26:09 +0200
Subject: mptcp: export lookup_anno_list_by_saddr
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliangtang@gmail.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240917072607.799536-6-matttbe@kernel.org>

From: Geliang Tang <geliangtang@gmail.com>

commit d88c476f4a7dd69a2588470f6c4f8b663efa16c6 upstream.

This patch exported the static function lookup_anno_list_by_saddr, and
renamed it to mptcp_lookup_anno_list_by_saddr.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   10 +++++-----
 net/mptcp/protocol.h   |    3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -194,9 +194,9 @@ static void check_work_pending(struct mp
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 
-static struct mptcp_pm_add_entry *
-lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-			  struct mptcp_addr_info *addr)
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -255,7 +255,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
@@ -272,7 +272,7 @@ static bool mptcp_pm_alloc_anno_list(str
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 
-	if (lookup_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -451,6 +451,9 @@ void mptcp_pm_free_anno_list(struct mptc
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-pm-fix-uaf-in-__timer_delete_sync.patch
queue-5.10/mptcp-validate-id-when-stopping-the-add_addr-retransmit-timer.patch
queue-5.10/mptcp-export-lookup_anno_list_by_saddr.patch
