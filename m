Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26017BECB;
	Fri, 27 Sep 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425524; cv=none; b=pXBlUkgSEtPqKzBIoOk7AUfuQoIWiLs0oDKBkawzLKawq+h2XzHHOjVzbVtocZ2OAuKZTIuAm1cDvUzdOa92oiOJTKs721QnlyHgK9ZTdDbriYQN8++VmDHzo/KnAuJgWG3s1ootpFgJ6mZ+9gCejmUcMlFXr/Vw16+HII21Byk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425524; c=relaxed/simple;
	bh=ufHa8zVzI9QNCozJAUsduPlsy1wf2Jsw4927uYdyIuo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=eLTMS7zL3G/XV+BBRzKaSg/ITQ4bPmzLCcc6lUbT9f6OpMCJb723T6xbAUkx8ye9Ib+YREV1WrytUvoZnFsGHk8x3eQygh0sQhQZ5Ddd44sBXfB1fenZNlinwCwN5tafTlH/kKC44IbdFjqZrmgwXjDQrBRZvAz7QErYiyMDr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nkBpSEGx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkBpSEGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E9C4CEC4;
	Fri, 27 Sep 2024 08:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727425524;
	bh=ufHa8zVzI9QNCozJAUsduPlsy1wf2Jsw4927uYdyIuo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nkBpSEGxXrWdT00wgPkpmW+iHnsLo6L7UALVEEqx1CDpDf+jfWGqNWrFw7ZuyNEvK
	 z52Lunjsbs2D02gudz9gEc7TQd8OROUqUt7dLjgI/w7jlg6833LV3lcXthkx58ZxzH
	 FBbNumNR4FDsCy/86km0NTj7tNOmVgvYZToPWx8Y=
Subject: Patch "mptcp: pm: Fix uaf in __timer_delete_sync" has been added to the 5.10-stable tree
To: eadavis@qq.com,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Sep 2024 10:25:13 +0200
In-Reply-To: <20240917072607.799536-8-matttbe@kernel.org>
Message-ID: <2024092713-massive-friday-655f@gregkh>
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

    mptcp: pm: Fix uaf in __timer_delete_sync

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-fix-uaf-in-__timer_delete_sync.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-76550-greg=kroah.com@vger.kernel.org Tue Sep 17 09:26:39 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 17 Sep 2024 09:26:11 +0200
Subject: mptcp: pm: Fix uaf in __timer_delete_sync
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com, Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240917072607.799536-8-matttbe@kernel.org>

From: Edward Adam Davis <eadavis@qq.com>

There are two paths to access mptcp_pm_del_add_timer, result in a race
condition:

     CPU1				CPU2
     ====                               ====
     net_rx_action
     napi_poll                          netlink_sendmsg
     __napi_poll                        netlink_unicast
     process_backlog                    netlink_unicast_kernel
     __netif_receive_skb                genl_rcv
     __netif_receive_skb_one_core       netlink_rcv_skb
     NF_HOOK                            genl_rcv_msg
     ip_local_deliver_finish            genl_family_rcv_msg
     ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
     tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
     tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
     tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
     tcp_data_queue                     remove_anno_list_by_saddr
     mptcp_incoming_options             mptcp_pm_del_add_timer
     mptcp_pm_del_add_timer             kfree(entry)

In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
zone protected by "pm.lock", the entry will be released, which leads to the
occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).

Keeping a reference to add_timer inside the lock, and calling
sk_stop_timer_sync() with this reference, instead of "entry->add_timer".

Move list_del(&entry->list) to mptcp_pm_del_add_timer and inside the pm lock,
do not directly access any members of the entry outside the pm lock, which
can avoid similar "entry->x" uaf.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b4cd80b0338945a94972ac3ed54f8338d2da2076)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -253,15 +253,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -766,7 +772,6 @@ static bool remove_anno_list_by_saddr(st
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-pm-fix-uaf-in-__timer_delete_sync.patch
queue-5.10/mptcp-validate-id-when-stopping-the-add_addr-retransmit-timer.patch
queue-5.10/mptcp-export-lookup_anno_list_by_saddr.patch
