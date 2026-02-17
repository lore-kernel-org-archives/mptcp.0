Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54682AE77;
	Tue, 17 Feb 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332379; cv=none; b=eFlBIyVa8UNWGpwUh7EYtOUF5blYyb1t+StxKYE5FpE6Xb05Z0VfCwZ8971sypyoO/tc1AtdthZH/1qaCkzOy9vKEw2B3zSL/WiMbxUJm9lVcvUj6L0cvOK+xtgxl2i/+h+ad2g4Q7/xb03MMYTbF1jWamrUOQCWSn02+tM+l+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332379; c=relaxed/simple;
	bh=NEaRtjkl+nXBn5AyFio24oYqcoe9bH4CP+wbf/Xq9pA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Xdrr+FklIyn8wjXqPDZkn16gYE08bUaf7M+8PD4bbHEqBAbpV+JPR34wfg5S50R1JoHY6QVh0FTS3xyqR7K7aYNQU+eNrtO65vRcucPGhnT5VUgGF9nTaTOwVmCtkQcEaSlxlndeVxnF9+oSEP24nNNo4rG4sznp2hWTs8eoYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSbde75J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSbde75J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF709C4CEF7;
	Tue, 17 Feb 2026 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332379;
	bh=NEaRtjkl+nXBn5AyFio24oYqcoe9bH4CP+wbf/Xq9pA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=XSbde75JhDCxqmlTMXmdC6MzdN6V3WgrjA8VYKpzJm/WS0Ot4dIZ+c5yNqgkAcvXi
	 8eaIJl4kX6WDWlGaP+wBa76Mjcjx0qTAZWwtzEbxKtDJrSODsn3FUGwoMtNLxFoXlT
	 empVqIarJlxKNF6vE4hVXx6etdmj8dBsZsdjxbe8=
Subject: Patch "mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()" has been added to the 5.15-stable tree
To: edumazet@google.com,eulgyukim@snu.ac.kr,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:45:30 +0100
In-Reply-To: <20260212174146.1841030-2-matttbe@kernel.org>
Message-ID: <2026021730-pentagram-stable-9e4c@gregkh>
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

    mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-race-in-mptcp_pm_nl_flush_addrs_doit.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-215984-greg=kroah.com@vger.kernel.org Thu Feb 12 18:42:13 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 12 Feb 2026 18:41:47 +0100
Subject: mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, Eulgyu Kim <eulgyukim@snu.ac.kr>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260212174146.1841030-2-matttbe@kernel.org>

From: Eric Dumazet <edumazet@google.com>

commit e2a9eeb69f7d4ca4cf4c70463af77664fdb6ab1d upstream.

syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
and/or mptcp_pm_nl_is_backup()

Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
which is not RCU ready.

list_splice_init_rcu() can not be called here while holding pernet->lock
spinlock.

Many thanks to Eulgyu Kim for providing a repro and testing our patches.

Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/611
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts because the code has been moved from pm_netlink.c to
  pm_kernel.c later on in commit 8617e85e04bd ("mptcp: pm: split
  in-kernel PM specific code"). The same modifications can be applied
  in pm_netlink.c with one exception, because 'pernet->local_addr_list'
  has been renamed to 'pernet->endp_list' in commit 35e71e43a56d
  ("mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'"). The
  previous name is then still being used in this version.
  Also, another conflict is caused by commit 7bcf4d8022f9 ("mptcp: pm:
  rename helpers linked to 'flush'") which is not in this version:
  mptcp_nl_remove_addrs_list() has been renamed to
  mptcp_nl_flush_addrs_list(). The previous name has then been kept. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1656,16 +1656,26 @@ static void __reset_counters(struct pm_n
 static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	free_list = pernet->local_addr_list;
+	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+
+	if (free_list.next == &pernet->local_addr_list)
+		return 0;
+
 	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->local_addr_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-fix-race-in-mptcp_pm_nl_flush_addrs_doit.patch
queue-5.15/selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
