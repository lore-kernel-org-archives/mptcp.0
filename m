Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73307E110;
	Thu, 12 Feb 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917917; cv=none; b=NaDwjVLI+psGuL+RdzWrmnLm2P4kYjlAJQ199fUYBV67yxbkCELY0MOxpbv8XEjH9ybj/NBFJ0brB2ZVnuls05dgFfcYtv2PJH+tnF2d7EjcwTvNDSbl6cJ11VdlNN8+x/D5m5LKrPUk9urjOCCak2yfpx0TCv+3oxYOVtpw0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917917; c=relaxed/simple;
	bh=ykgZuO7gieD0L3G2D1age0y4AlvnU72zKeBhb9bo88I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShZyMB1Ct2+3SPBc5Vjs+2eXmPmioLArfRa/0/BM63kDhJmbk05EWnjZhaWsM8OIkXk1usIshNmxIqCj3ITRNAvvP7rVl+6MZa0SuevZWD0IOr9uqdNNz3nhz5RWPzn9dEsfqaNaqGoK78sciZUjEGlMToP7dZRmULeYgDcFxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP32udXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP32udXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2473C4CEF7;
	Thu, 12 Feb 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917916;
	bh=ykgZuO7gieD0L3G2D1age0y4AlvnU72zKeBhb9bo88I=;
	h=From:To:Cc:Subject:Date:From;
	b=QP32udXe9sz8z/3MNmFjLWZOsRgRC+wSYRVTk9mqmrjs1aKkek2d/LXFvxs/5Rcqd
	 Sr2B+3PKXIA/XArsyG72IC6dCVFna6aXqcaM+D8AmcmvCrPUyQmctnRsixxMi99wTx
	 t2DV3xO7L8u6jY1w3miy/wv9JJNBPzYg1g8Gg/zXGRV+y5MYc4U5fNwUzpf+ivEICi
	 Wl3yr8chQMLaIDAmTKDRKcnEcLUbaaM/Qynx2yrZtmdhhYo71G+F1V6eMY5zJznTMK
	 bE2Nf+dcoVaxZXujQFfkppVHdzU9m3M2w9b6TY/7b33JIfbTZDzxyV5MblUNPbDV+R
	 hKTN/MkECJgEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
Date: Thu, 12 Feb 2026 18:37:26 +0100
Message-ID: <20260212173725.1834288-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=matttbe@kernel.org; h=from:subject; bh=BJDmpspCA5oQqlpGL5+/OOHDzb4xxJwCzQ0zlzFS/YM=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL7+K+dPaj+h4X9nnVDm9QD7aNC/5bI8D5QnD2Xcdaqi uMaR21tOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYS58zIsC9u5u4ziRsmvQq9 whqTf+Bq8m+WO5Ic553Pifzeu/SxYSIjQ586v/1EufYN9x1eaFz44/X5n9qUZW+2dd+INb6ZvFi 0gwkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

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
---
 net/mptcp/pm_netlink.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9f25cfd96f98..4b805d7f5769 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1859,16 +1859,26 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
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
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
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
-- 
2.51.0

