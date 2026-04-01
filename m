Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602812FCC0E
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033710; cv=none; b=gJp2CNcEbdgCSLM9qq46h2pbXwovjMl4xOBjuFQydBWBEWVum8T5Y6a2urnq2YpMnAzA1dKYwVJMiNUbtTehWcTGqVplFDH+d+Wy66dObXACPQUoLHeJMucpoLWwZ+qLfxezT4LJRMhdB2b8jck4s+h3TrYyy5GhmDRVi7r2q3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033710; c=relaxed/simple;
	bh=tDA86iW/Z2v/bPHGhTLCRYLH586Q5mh+K/pQQX4ICWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPzTiT0rbAmkXWq3XVu/s+zsMtF2lb8x7s9SakZMFxJIHxvM2GZiK0+sNP7r7r6zj9eobxbPQcCDquZ+KKN2upPMFALIyMbqBriJA4ZzVr2UyeQgtkOFFerJMEIpScwwuB/6PxJmpoTaJB7xYZ7Vu8hpf61eDtCt3inqdehsH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZsFf35Bo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZsFf35Bo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775033707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+Q4K+MR0uTQ0JcO38uG/YcpUQbBSm1E6cg9PUxF8LI=;
	b=ZsFf35Bot0yKkFfjyG9Z/m4Ik23GEtoGs5WNoZvAwdNUspMxa5u8vQZknbMoWZw1MhAoP5
	2SYgYSKQ274LjvJEjereHUV7cs9AOoFI3NQhnxDRNcggfZu/Y311P/3hU3SkRcoRmBoRmv
	dmQI9dMLOlvkAxMWqSIHmrU7pvjOc1Y=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in mptcp_data_ready
Date: Wed,  1 Apr 2026 16:54:17 +0800
Message-ID: <8ed0aeb49f13410b25200d884c89ef3201d2c23b.1775033340.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775033340.git.yangang@kylinos.cn>
References: <cover.1775033340.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch defers mptcp_check_data_fin from __mptcp_move_skbs to avoid
deadlock.

When processing backlogged data in softirq context, __mptcp_move_skbs
directly calls mptcp_check_data_fin, which can lead to a deadlock if
the msk socket is in TCP_FIN_WAIT2 state. In that case,
mptcp_check_data_fin calls mptcp_shutdown_subflows, which attempts to
lock the subflow socket with lock_sock_fast() - a sleeping function
that cannot be called in atomic context (softirq).

The correct pattern is already used in move_skbs_to_msk: if a data fin
is pending, schedule the work to be processed later in process context
rather than handling it directly.

Reported-by: Geliang Tang <geliang@kernel.org>
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Notes:

Hi Matt,Paolo:

Here is the response of AI review for this patch:

- Typo problem in subject line:
    Already fixed in v5.

- Remove else branch:
    It demonstrates a TOCTOU race, though the race window is extremely
    narrow. The else branch is useless even without the race. So I
    removed it in v5. WDYT?

Thanks,
Gang

Changelog:
v5:
  - Fix typo in title.
  - Remove the else branch.

---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 326b5d4d79e7..88e19fa61b84 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2247,8 +2247,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (moved)
-		mptcp_check_data_fin((struct sock *)msk);
+	if (moved && mptcp_pending_data_fin(sk, NULL))
+		mptcp_schedule_work(sk);
+
 	return moved;
 }
 
-- 
2.43.0

