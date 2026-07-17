Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B03B530D
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270463; cv=none; b=m/66Pr51oEEmpRUPnkxYEy9qEKUqUxliaJfq/2kc8K8x1vq0Gm65XEs3IRCpbegD2GZ8THbpSlODt4Duh1ehHlmUp83k5JiFu9o3mx+QfEqQWA+uaq9a2RikUUcYy3Sw7njRk3DBlh3eHBh+dua+fxUwBY2BhSzFwK0QXCjYeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270463; c=relaxed/simple;
	bh=9nrfUND6xlBfyT86wA5kIJ6b4XYT2/Hsd1IfWjDMVq0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=k4xFUYtvuYWreQVspA9P2/d9gWpYxBqfWQMFU36NIPlzJfnNXnUifZ54+umxUUxJ3CWtmNON4xXJ4XmMufdxQ5LzSIAb1jr1WH1RO563ZyjTyZv7G/r6LleAgMgJ5dk175Kc5JNocvTnnhPpVhv95ph58nQU9Ikhwv3m9gcMJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hGtZlign; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hGtZlign"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I5
	uOGiGOLHnZkHqS/qXvpPH6D2J1Jm43oX4CeULqxXw=; b=hGtZlignbkZM11qB7G
	F8MlcW4ydm1p68Qg1+C0SmQCh218izzGsv5tFmG9K8Ls7jMTp7yu0chNy5zAEUkV
	0m/uxj3qPN+4DukC7udtRH1rlmjbTzsFNc8tNaCWmdY33PcsR7Fv3d/uzJf0nkqH
	th7TcW2VVkaIkM2gSf8UET9uE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHuABdzllqjiJSIw--.155S2;
	Fri, 17 Jul 2026 14:40:32 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] mptcp: pm: fix data race in add_addr timer callback
Date: Fri, 17 Jul 2026 14:40:28 +0800
Message-Id: <20260717064028.767876-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuABdzllqjiJSIw--.155S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWrGryDArWUtF18Zw18Krg_yoW8KFykpF
	45Wan8Jr18tr4Ivr1xAF4DWryjgFZYyryfGw4Y9390yFs5JFyDJay5GF4rtFW7JFsYvrn2
	yFW0va98Zw4kCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uo5lnUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+gC8AWpZzmCuIQAA3V

From: luoqing <luoqing@kylinos.cn>

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

Use a local 'completed' flag set inside pm.lock only when the timer
callback itself increments retrans_times to ADD_ADDR_RETRANS_MAX. This
ensures that mptcp_pm_subflow_established() is only called when the
retransmission naturally exhausts.

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 net/mptcp/pm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..ed39a1241ffd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,8 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool completed = false;
+	u8 retrans_times;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -399,27 +401,32 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 
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
-		timeout <<= entry->retrans_times;
-	else
+	if (retrans_times < ADD_ADDR_RETRANS_MAX)
+		timeout <<= retrans_times;
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

