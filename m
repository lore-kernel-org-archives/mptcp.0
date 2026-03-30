Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB94A35
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848805; cv=none; b=vEU9GP/lxmPjnX1Rkj0QEg6TRcPsqPcy/j2WAGvMVgKNiFYNawljEbfP4xAeS+xz1EfET/CT4lLtCKq4FUAJmGzepi7EEKgMf2jTip6KC8hcPDh39WhRdT27Y1U0V462Bi+wRV2npBbMXmWzAiZ6MjUSEfyrjYBZd1HoiWtVVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848805; c=relaxed/simple;
	bh=kecz2SUxO9om/eqlzjoUQxhbqIDskQNGgWFJb019gPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAPh3pDP1xWb9jjH3l5aN6mE0yBsqxbCELc+13ZTCQ0xD4ErlI+/mUg+Vn0kaL0D1BrekvSeNQsia8CHzd2re2U2KNn67LlFxu4epmDClLEgPES9C4DcVkHCiSAWOhaU1AyWbaIhqfIlqm84IRQX5GyGuGk/kOUzFz38j+5kQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCWdQYPg; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCWdQYPg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Crnlbt7mlNXR4YhfmcOS1RkyeMDKqyZxVD9PcEnHY=;
	b=oCWdQYPgPYB6yYE36dFU2tX0+igbm/Sykj2iv/Z75aiX3pDhntTaFOPfQkV5YT0vM3LGr8
	xQ1MK40eY2ywcx6nierBq3+gUhs2MI/KXVyVIyKFG73kL11bovug02VjdhXkkOIeCfwecg
	JMFbqUBhLpKcWdNRN97TKRa5bCK97tA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v4 4/5] mptcp: fix the dead_loack in mptcp_data_ready
Date: Mon, 30 Mar 2026 13:32:59 +0800
Message-ID: <20260330053300.15717-5-gang.yan@linux.dev>
In-Reply-To: <20260330053300.15717-1-gang.yan@linux.dev>
References: <20260330053300.15717-1-gang.yan@linux.dev>
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
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 16c5dcab8982..872022f4796b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2247,8 +2247,12 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (moved)
-		mptcp_check_data_fin((struct sock *)msk);
+	if (moved) {
+		if (mptcp_pending_data_fin(sk, NULL))
+			mptcp_schedule_work(sk);
+		else
+			mptcp_check_data_fin(sk);
+	}
 	return moved;
 }
 
-- 
2.43.0

