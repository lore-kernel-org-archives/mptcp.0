Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F245041B
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138477; cv=none; b=CtRVxgoACc0KAx9g2W7GbbBHm0zFb91bVo4Ako8nM/0lVpuRz0SPF9cqpyGo48/7IefZZrdbACtu7AnVPvmVFdFqXVIFZAOhQwEDkyNhzB8TpprEATOaV+50CtiTBuNqkDEDt+uMUKP4x7jzm3VAUMKf582KeiXygHtK4mRXnPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138477; c=relaxed/simple;
	bh=8S3HqF8lDcnm4y0EwSOZh5Kvt8asehGiiZ0ptMeaMh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxJdO1uTf0iWeE+UCIImivdMpAhNBMe0jqtpfRLgNLWGKqoXRfGNQp76igM7TbRJPUbNw5NzI3qE7pTA9W4qvBNCGjxHLCYDf4cDh3kDItCPTs90hZJBQsqr5eW47H5wzRJyO1FVwQ20beQ4hC6zJjke/RQWVCTTqnN4gchdg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9c/NIuX; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9c/NIuX"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=8S3HqF8lDcnm4y0EwSOZh5Kvt8asehGiiZ0ptMeaMh8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787138473; v=1; x=1787743273;
 b=g9c/NIuXJnEpAGzKPvBgmpOeRD5ukWkyNoUAkEF9UoJ+FKIO+1Biy1t0Q3SXDYlwIZdf6LoQ
 ZbKV3huJSPYfu6UayddMt+EReOWfnt3NVwCCCW/zqcwE6viw4cyB2SNo+A3Ch/Hj89lhdYWV2RK
 wGTMl52ObSpSxE9OkR59PmUk=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 9422cd53a58792be;
	Wed, 19 Aug 2026 11:21:13 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v5 2/3] mptcp: fallback immediately on MP_FAIL reception
Date: Wed, 19 Aug 2026 19:21:11 +0800
Message-Id: <20260819112112.1985121-3-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Call mptcp_try_fallback() right after the MP_FAIL response
ACK, and simplify mptcp_update_infinite_map() accordingly.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/pm.c       | 5 +++++
 net/mptcp/protocol.c | 8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7c6f80a183..69701ac7e436 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -895,6 +895,11 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
 	}
+
+	if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+		mptcp_subflow_reset(sk);
+	}
 }
 
 static int mptcp_add_addr_len(int family, bool echo, bool port)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f879b1061f2d..abe45a31ca5f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,13 +1417,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
-
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
-		mptcp_subflow_reset(ssk);
-		return;
-	}
-
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 }
 
-- 
2.25.1

