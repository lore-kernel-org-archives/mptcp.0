Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150C1A9F87
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096387; cv=none; b=BZPlTpWuT33gQD2IDJiKjyLq+EBfo5XQ2UT4CO6eDpogTgJvV4m5H8mxTBgUUIDJEIQ7x4i83SsgwSiqf2pX/TpLqEWFttYey1rGUFr7K45gf53+owoaKgCG3ifzw6GmW9hHjSNmI4ODLCSWnXB9Fzz0xhntDmfwJSbAmom6nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096387; c=relaxed/simple;
	bh=wSyANPMvvTEUlyOHy8WN4MigwgykeReb4MW8Jz4jGYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhAoL5Gn6GggZFXR6cEKOjxn09CcMxZHx+mDN9REJsIZqk79hVw4OI1AjwAzVJcxQ4INEaspO80hxXGvTokzvSwExjjbYQqOC7r6gnGgOIO3C5poaklGRV/hKBFzuoCDhktPe/tMLBbXFRyz6UQDfj0vaNrGW7n1i3K1gjNoi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TjUyQXbS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TjUyQXbS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784096383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIBygXDUOUELjVRXL2x111P0YqKWluCyM0rc/9+nJUc=;
	b=TjUyQXbSIyFmASEKtrOfUCk/hIEsj0ctfyB3GRLx1yD/adrMEi5/YyMJCxJOJpzw3EnrsC
	JtU+VKbfviAK0uPQAg5UztXKSrqadYCjemuoEsePlwCiIZ3oqeXTO1HLy9xR7WRwWiYeMK
	1RfC47NUHPuv0hRHKT1lW/jniH/gEJs=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-net v2 3/3] mptcp: add MPFailFallback MIB for MP_FAIL TCP fallback
Date: Wed, 15 Jul 2026 14:18:30 +0800
Message-Id: <20260715061830.1057851-4-chenguang.zhao@linux.dev>
In-Reply-To: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
References: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Track fallbacks triggered by receiving MP_FAIL with a dedicated MIB, and
switch mptcp_pm_mp_fail_received() to mptcp_try_fallback() so the counter
is updated and pending DATA_FIN is handled through the common path.
InfiniteMapTx remains counted when the infinite mapping is transmitted.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/mib.c |  1 +
 net/mptcp/mib.h |  1 +
 net/mptcp/pm.c  | 28 ++++------------------------
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..4dc107ab1aec 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -83,6 +83,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
+	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 };
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..9db8812d8e04 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -86,6 +86,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_MPFAILFALLBACK,	/* Received MP_FAIL, fallback to TCP */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 869876a06493..82d3dbedd603 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -906,33 +906,13 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		tcp_send_ack(sk);
 
 		/* RFC8684 §3.7: after accepting MP_FAIL with a single
-		 * subflow, leave MPTCP mode and never revert. No dedicated
-		 * fallback MIB yet; InfiniteMapTx is counted when the map
-		 * is transmitted. Handle pending DATA_FIN like
-		 * mptcp_try_fallback().
+		 * subflow, leave MPTCP mode and never revert. Use
+		 * mptcp_try_fallback() so pending DATA_FIN is handled.
+		 * InfiniteMapTx is counted when the map is transmitted.
 		 */
-		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
-			spin_unlock_bh(&msk->fallback_lock);
-			return;
-		}
-		if (!msk->allow_infinite_fallback) {
-			spin_unlock_bh(&msk->fallback_lock);
+		if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
 			mptcp_subflow_reset(sk);
-			return;
-		}
-		set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
-		spin_unlock_bh(&msk->fallback_lock);
-
-		if (READ_ONCE(msk->snd_data_fin_enable) &&
-		    !(sk->sk_shutdown & SEND_SHUTDOWN)) {
-			gfp_t saved_allocation = sk->sk_allocation;
-
-			sk->sk_allocation = GFP_ATOMIC;
-			sk->sk_shutdown |= SEND_SHUTDOWN;
-			tcp_shutdown(sk, SEND_SHUTDOWN);
-			sk->sk_allocation = saved_allocation;
 		}
 	} else {
 		pr_debug("MP_FAIL response received\n");
-- 
2.25.1

