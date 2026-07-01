Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52D27A47F
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876023; cv=none; b=kwVnBABaC2KTcWfrVSM2UoFNjKCvQwztU5UtVgZGfzU79UB4kaRue/NvNA5PuXxerdKNqIH8CbK/WpE7HsxHyQFpZ5dUozCSXX+dej01VRdfHo69cITZ8pUECFSNn3nATjQ6QoVMj8y9KmvEdT4/7KMB1yVjGXdTdV+CMcQFBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876023; c=relaxed/simple;
	bh=yZwQaE8wpgnqqnIjx/suY3JiY02LiH5dxYlJ453qHa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG3Yc7NH3ALcLe6yiC7uQk6qex+iMby7IoJix133lHIBufGoXiJBY7JsB+lxAVMPVa33IkuYRnV7Ubn6CO3sWyMqGFIpj3O6RCxE1H7u8i8cqxB/2fehjl8qJWlYeK/tlX5XLwu7Rc5qeBZ92rIrlizVS76pPqK4jNW/9QD8XfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PCsjSOTg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PCsjSOTg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782876020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8LYCTgwMLpIZHVsQ7ghIUs6/E86r2qf6MBESCIUgrA=;
	b=PCsjSOTg9em24j5tTfddUmnK3m7iHywLh9HuIhoHRx/JssohxfsxuIApeyaptsmQIeQ1Jf
	z+vbIcFnanf0Ok6DwpIBTOMsNE0mWiXOMKd8afqW4DKTxe1Gzf6IiMinACLySAPx1G1BAr
	7vsRwJCf4e/ziH3CVFx/PyiVJCQsYbg=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2] mptcp: fix extra_subflows leak on failed passive join
Date: Wed,  1 Jul 2026 11:20:11 +0800
Message-Id: <20260701032011.358940-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp_pm_allow_new_subflow() increments extra_subflows
before __mptcp_finish_join() on the passive MP_JOIN path.
On synchronous join failure the subflow is dropped without
calling mptcp_close_ssk(), so the counter is not rolled back.

Call mptcp_pm_close_subflow() when the join completion fails.

Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 Hi Matthieu,
 Thanks for the review.
 - I spotted this by reading the code. I don't have a reproducer
   yet. I also see we already have a Packetdrill test for
   synchronous connect failure (simult_connect.pkt), but not for
   synchronous join failure. I'll add a similar Packetdrill test
   for that case and send it in a follow-up patch.
 - Add Fixes and Reviewd-by tag.
 - I looked again at the history, and I think the Fixes tag
   should point to 3e5014909b56 ("mptcp: cleanup MPJ subflow list
   handling"), not 10f6d46c943d ("mptcp: fix race between MP_JOIN and close"). 
v1:
 - https://lore.kernel.org/all/20260630095432.1340629-1-chenguang.zhao@linux.dev/

 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cb9515f505aa..b32f0cd262a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3907,6 +3907,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	mptcp_data_unlock(parent);
 
 	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
-- 
2.25.1

