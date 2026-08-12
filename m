Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AF30F803
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513633; cv=none; b=uIZVO1frqy8TeGDZA7Hk7ILFClsdlHoYMaaR1b9nK5bEQCVMI/rVtWfjTD/3kEtFh+Ifqj5ZPkLScEhkS+iV+0GcS4AyDr/WyJUNHCtP9cmPk3ZDcqJiy8T00YZc0fqBRic1AIt7qNPYIDWhe9HFqEqYi0J6y8Q7ufADmMQO4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513633; c=relaxed/simple;
	bh=m/ZTkU9LPHJHMkq6fsZ8ateyUWxxMQ4RfFgnEK9P1tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htn7tbquIr7kv+zmu9Sv8QgnRVRScEDnV9EZMLdBZo/OErJMYq6vRhn/DKrvJX8Jfw9IjtSo5BG0IOlKWbXuU2cQlP39jN2U6ZVwE1bWpQH/Y8IWxEvRfg0bTBfMiLK+kIsZmr05s7rIfOkAnt1CPxT+675+5mSLcyFe5QzCupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4wBnLYA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4wBnLYA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y58GHDMA2z2UYVXWijYf8YT+cpfKwlW9sOC0RXa2MH0=;
	b=X4wBnLYAJBnRO8QEXkHcgmDb8oy5+7TT8+ALbskV5RjpaPczSGsa9Kt3Fxu5fAgZ3MY2Q1
	EhD/cPulHTZ1rioqSBjvbAxukSBwmUspkGKCLedRrbJPpe5At+JawkO7rm+ntrnIGIYd/s
	EmkgIUZuxqgM5j5Z2nQu+QfF55FUsqw=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH export v3 4/4] mptcp: fallback to TCP on MP_FAIL with a single subflow
Date: Wed, 12 Aug 2026 13:46:53 +0800
Message-Id: <20260812054653.43799-5-chenguang.zhao@linux.dev>
In-Reply-To: <20260812054653.43799-1-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
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

Fall back immediately via mptcp_try_fallback() after accepting MP_FAIL
on a single contiguous subflow, as required by RFC8684 §3.7.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/pm.c       | 9 ++++++---
 net/mptcp/protocol.c | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8c263084db7b..cb85caf1df43 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -876,7 +876,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	/* After accepting the fail, we can't create any other subflows */
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
@@ -891,8 +890,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		mptcp_subflow_reset(sk);
 		return;
 	}
-
-	msk->allow_subflows = false;
 	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
@@ -901,6 +898,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
 		tcp_send_ack(sk);
+
+		/* RFC8684 §3.7: fallback with a single subflow */
+		if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+			mptcp_subflow_reset(sk);
+		}
 	} else {
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f879b1061f2d..519e8d9c3164 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1418,7 +1418,9 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
+	if (__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
+	} else if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 		mptcp_subflow_reset(ssk);
 		return;
-- 
2.25.1

