Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522273672AA
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813276; cv=none; b=jxLyJ2hdTRW/GRunWH7dZfzidsJaGlxhUm4luzohghZL21mNXj22UJ5mJXAHnWzxAkMYkP+hkbhrdTkc7B0Y5Rl+OlTMd0OO2JG5WmzVn5RF2qN0FbMUUgvhCwvLrNw3orbZo5HpBm47vLIgvJRxzn+JM8tBOFfCxCxLM3mv0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813276; c=relaxed/simple;
	bh=4XsE5mZiz2vfS5Efqeo2BObZEhhij7C95rRHr1lCql8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGNas6XvvepQV0iwRgca+bXelRhYEnSC33iOiRo48Yjp0Y7HnNQC9ebcDbnfKdtuM+OpBZtJ3uqzPpqJMOfKqUMBjhTyCWUQF05gPXRieZpWl4NAx8XN/qNpu9BkIgxWIclJzIVaNlRspJUuS6K0jjdPx+sW78iaF5V/K0I46lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+eXzfhS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+eXzfhS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782813272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sdLsN1VECbIeqH8FWe9qkDwPpKMdzSgddenzoesKBXY=;
	b=Z+eXzfhSndkdhbSCkG45KRArV3Ciq2sN0c9e3G6FfltPplMqpT7KkZ1faIPJKIwjyGd6zU
	axsxCL097G1RG9Wf/hbuLqLhdbDuCxp+JeiMvcRBIXkwHQ3AapkeIMlKfnxj25ySboDTHY
	EfmRuPcHpndDDx9RVVvcF0iOfkzbzfo=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: fix extra_subflows leak on failed passive join
Date: Tue, 30 Jun 2026 17:54:32 +0800
Message-Id: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
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

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
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

