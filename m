Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352F4A13A4
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711603; cv=none; b=YFd2/TVS37FbUOj/R6HP9XvAPQnZHJQY66DXNMjBziHEBRt3m4xBP0hvQTJLIKZtTkYqY7nm4BF3WbE3cqIg/tBklZE+NqEjTAJ6p7GHblEReTne+C4Oq0l5+BXQChq8WhcWprkV9Rgk+of4N8jnuRB1ceBL4gabHibtnajeiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711603; c=relaxed/simple;
	bh=dQu2f3zmRKicV2WqyALWDhZU7INUx+0cGYuOqC/SoM4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NMSUkswvgFM1s+weTIvZggbhvCrpthnsAeRVJRj6ozZImq8Zz11x8ZfueIR46F20bb8wkpMU/VC5tTvXSJzn0WEUnjp3gCIhtDnzrtJkXz/17Y70Zooz63wuPtV5H7hYgYgKAHVt9h2e74dyAyskma9Q6SdTF07OC+54Qcjjf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KmIV+/BE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KmIV+/BE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zf
	nbl/B7Yn+pJIsGRwMfQyxZ1CAePAfNGTTeZda2lnE=; b=KmIV+/BEISgM1sFv9F
	WJIwrwwStXkJoOSLjjB1nOr6ieboNJ1QMhYvFNfU+lbAWYhsKB8oqHu+Ph/MHbp6
	3c8FUidiu/UAzG4RjWvCFk0o378smGboFh7/Mqoacy2P92WS/DmcdvCZSdTERzGK
	ES9J/268bDjVMQwkT1NAlrLWw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHGYmpiWBqiO1NKg--.26490S2;
	Wed, 22 Jul 2026 17:13:16 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3] mptcp: pm: fix data race in add_addr timer callback
Date: Wed, 22 Jul 2026 17:13:11 +0800
Message-Id: <20260722091311.1218738-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHGYmpiWBqiO1NKg--.26490S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWrGryDArWUtF18Zw18Krg_yoW8XF1kpF
	W5W3ZxGF48XrW7Xr48AF4kWrWagFZ5Jry8Gr1Y9wsIyFsYqFyDJayrGr45tFW7GF4vvFna
	yFW0vas8Zw4kCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwYFZUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+QxAhGpgiaysnwAA3t

From: Qing Luo <luoqing@kylinos.cn>

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

Use a local 'completed' flag set inside pm.lock when retrans_times
reaches ADD_ADDR_RETRANS_MAX. This ensures that
mptcp_pm_subflow_established() is only called when the retransmission
naturally exhausts.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/mptcp/pm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..f93fefbb727e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,7 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool completed = false;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -414,12 +415,14 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		timeout <<= entry->retrans_times;
-	else
+	else {
 		timeout = 0;
+		completed = true;
+	}
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (completed)
 		mptcp_pm_subflow_established(msk);
 
 out:
-- 
2.25.1

