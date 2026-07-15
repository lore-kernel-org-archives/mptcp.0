Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D308F23
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095561; cv=none; b=hveV8m2E0rwSRy8ll1/+KqRvPb5JcQHXWUXN5BDwpWHOiR44yigt1S3GS2sQ0Fg7OwnB4SZYn0ZMGFnCXJyw0P/7nUTuyWYMJR+Yu735Clk0v3N9aD4RuHGw5O71nSZF1wnMbLHhYTCTmDo2NkV/OsBiv04dC1/4wJGj1zeQ8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095561; c=relaxed/simple;
	bh=15uX4DlKxDBXMMV0ty2ziRLun/3gN1i+UHxq21jgqN0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pN993VeswxLFk1aOgKxdgVRyZyfXuEHv7vcv/YyJQN8RXwaFgEM+LMf3GdO6627ReWh5q9fbDAkJ7RDft5aklCnbMysFk5yStLOJTJGjtHKO37kG0W/LptxYMk6JOshoPyv7bVlnVRke6dhmjhYFrQ89LiAtNvuldSgRTrM7Pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S2ulA/BK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S2ulA/BK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qH
	RPdsKA8DAbHGTu/KlfZVpM+L2eBVWtBcRqFCUp/qM=; b=S2ulA/BKKVs8GYD451
	IRTaVzII2Il7Mwfk1LMI7fhBROk1VDBoqtf5UhzZ5m2RA5CGHT093KxBNJ2DrgKf
	h7eRoSngKFucupXEzFnWVttDU+cLzY/YZmkwLvFbAIyhZ2xhQTAGfa8fAIrug1uY
	xAu89r+Ib+3rA6o+7YsRJ7eKA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Xyk+I1dqfHMpJQ--.13861S2;
	Wed, 15 Jul 2026 14:05:52 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: mptcp@lists.linux.dev
Subject: [PATCH] mptcp: pm: fix data race in add_addr timer callback
Date: Wed, 15 Jul 2026 14:05:50 +0800
Message-Id: <20260715060550.655299-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Xyk+I1dqfHMpJQ--.13861S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWrGryDArWUtF18Zw18Krg_yoW5JFW5pF
	45Wan5Jr1kJr4Ivr1xAF4DuryjgFZYyryfGw4Y9390yFs5JFyDJay5GF45tFW7JFsYvrn2
	yFW0va98Xw4kCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uo5lnUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3QBJjWpXI0DhngAA34

From: luoqing <luoqing@kylinos.cn>

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

Use a local 'schedule_work' flag set inside pm.lock only when the timer
callback itself increments retrans_times to ADD_ADDR_RETRANS_MAX. This
ensures that mptcp_pm_subflow_established() is only called when the
retransmission naturally exhausts.

Additionally, use READ_ONCE/WRITE_ONCE for retrans_times and timer_done
to prevent compiler optimizations.

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 net/mptcp/pm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..4c039e7843d3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,8 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool completed = false;
+	u8 retrans_times;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -399,27 +401,33 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
+	retrans_times = READ_ONCE(entry->retrans_times);
+
 	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
 	 */
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
+	if (retrans_times < ADD_ADDR_RETRANS_MAX &&
 	    !mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
-		entry->retrans_times++;
+		retrans_times++;
+		WRITE_ONCE(entry->retrans_times, retrans_times);
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	if (retrans_times >= ADD_ADDR_RETRANS_MAX)
+		completed = true;
+
+	if (retrans_times < ADD_ADDR_RETRANS_MAX)
 		timeout <<= entry->retrans_times;
 	else
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (completed)
 		mptcp_pm_subflow_established(msk);
 
 out:
-- 
2.25.1

