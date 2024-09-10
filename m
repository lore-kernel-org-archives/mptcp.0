Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A117BB01
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962367; cv=none; b=VGOTLWl18c9sz4xUpNJNM7h6UGuf5tW0SrYodxSexxN47Xb8RsPx8VQEScqW6BpDwerPoggnGieq/2jIv1haJ8b/aVBTPHeGZhvzmjlLMogchv7piC4q+IkMjCAEwIL8DKHkzBMnQruggNaYueZepfZu3uHJoYd3GVPjqT401MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962367; c=relaxed/simple;
	bh=9+c9pvgoddnrMvDhdI6Wh8Iz8hbCY/65n/sGOMz/UlA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R5rKWebfrcYoEeGXOnfDDvWdUS22vuzLV4r7xuufYLV7e4MhQH5WWj2cz3GFIzO51CxwqSkAbFkPDzhCojjxThQcjI8nh737SZuBsbuBmgmF1rPfl8F4NrAUD65BS2wfmihVVLt+3+IeTs/oOi4+D031h4fn9DpY1V7ytLZ4D6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mE/7RZL9; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mE/7RZL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725962359; bh=SH5quYrxe+ydY/dZue9zWjjQGockMw3uC6pR6yuHmC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mE/7RZL9SSyX+8LX5Gqgy1zsEyt48XMCxJ3FGFxF++AGNlS8p64khpKcEFLcCncnf
	 ufiBb+XnA1MZma3g7G40D4w5kZbjN2TaDmUxweJn00j/uyfBTOQDKjbA+ovmtbAX0l
	 oREQyB1/JR9eCfbz+aSVcOoBp/foDagt9fzmIEos=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id EB82C6BA; Tue, 10 Sep 2024 17:58:56 +0800
X-QQ-mid: xmsmtpt1725962336tey4kg212
Message-ID: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
X-QQ-XMAILINFO: MoTnVqEimZYUDPMNuaEEYD1qKiYGKR18HtjHTCrT9DFB6E6aYK2PWPueA8De56
	 P5jrFDiiQQqQQFd8Cxr6HKaKZyl1Z3fyvyHD8pwgAKbXJ5ZwF3mH+GCFFnEIChpjNneSaKRu9NQc
	 7WbFeayXT4kaQevoB9LajPHWxkAEmzaEB1lw75XEhiArRrbQ3NnBAknTMNGR0lM3L0B50LxBObm/
	 ifIzj7bXQOc/1hX7NmCPpN8kc/e2xGyCIW8yH4ZWiVMLUbAPuXM8krf9Ypk3rQTkOYCa2Q/RfNIq
	 DwdGOX8aJjYXF9SRecYLKQDVo9D7b3jPEW+/vfnp+No4kxo3dIJGoRs+BcmBY3v3J0Wo1e5FNuaq
	 VF5lCBuNTD42I3GxXBRGKSuAQ9fgElF4zk3iueDv9arxK58cA5r/+9kXj69lniegPw3sFei75C9T
	 UwIKWhgf0RV+74swfUUrqG5BuolVXntmBhJA1UPDZPQQAJAiSWGy1lkK1Y9CVAzb/46c04ssDRkl
	 Cx4RSH3buQK00B7Osb/+FHXZ2FVJS36fiMZctefRod+kuH7uRts9Zo2meXRckT+9pzpomlAkXb2Q
	 YdLgTG/QkHnEr0L3Qj57u9d3ZuP9KY/rP9Wf/Aq7wLHjr8Zt1DLgoHvuwrRv0mhGvWQmuAoJNonr
	 iv1O7m9aDFa6ojTOiT9rrDHFPgfS9rb2DH5YGOcuSl1fBzRTJBxYmEtry+y9t+rnJWsLtlzMihfL
	 jDJvNlwY+xSu0gIWNfHENwKgIdsD2T319KGuN6NUGhyT/ki1rFYxqwVyWBRkx80LiIIxyHuDcOvL
	 SY8U+rYd0muh0wYg4boHX9FlvIbpbPS2WSxFPvenM00N1paEXhy9QgV0U6g7zxO9uQPOQD6XH22/
	 kGs6tOUZIEL3QSqaOZRUUsgujLGxoUIUHF5DoupAX5SJ5X/zPDP/c1A4djpNioqZgt/Zno8fYQCn
	 cf4F4kklhD/LcmnhKrUyB/NVRyfpz+tMgUsNKx4keYV2G2C1sK4TSGH1TKFHY4u3BgF4p+ss50DN
	 vHi7LKz1YKozdRep8GjLl33xUFZZkCaNI4eJKo7VBHzhc5wKyv6CXnOsJ1qUQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net V4] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Tue, 10 Sep 2024 17:58:56 +0800
X-OQ-MSGID: <20240910095855.2618606-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
References: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/mptcp/pm_netlink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..f195b577c367 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -331,15 +331,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -1430,7 +1436,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}
-- 
2.43.0


