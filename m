Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD941DA55
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259667; cv=none; b=iBZzOZ+wz/SkApY87KHZ783qU0Q2Es61K4H+HL7LaA77BU0v41fSjElHyQfmdy77iG7Xy66DwvS9p+nbCk1G2vGKH4UGffPOfscRYGzI5480V7nU6+8axoIpDwNgz5+YnJzfQZAWHGLTrcXRhgFbg06T1ryAK2mh3gnyRqIaoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259667; c=relaxed/simple;
	bh=nClUGzk8ppW3iBR85j0udiLCPxVKDOW1OJ6dEY6KB4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzq+iH7uPwSCQvPxA1gh6LcBRC1MQNHWGnmzmmsGaVRMXySiyxtTgxp43dXhC5jQnzq6DGcVnMQPxHiSLsKlKtN+UPNy8mxCcNp9nJwoOMIkcOOff/r1cDutt3Ic/TiQ8FheJD2IISrJqwyaK+31T4VB7AksnMCYi2WKpZQ+D7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sGMKmZIv; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sGMKmZIv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762259662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BSnapW9A+k887L5TnVxu5qBOIEF+OvjGODaJXGLWSo8=;
	b=sGMKmZIvvTua++z8exVEVzCpR/QCfuDO9uDnJkRObJtzxH+0J+GxVl4eGnXgHiockZss7a
	4GuKgyw+jv+wykNIHs86pmR/U/NiVKWfP6owh0wSaBgGAazm3vUpdmr8hE98LBrSV3KN3+
	OIie74iDwQR1/Z0xTUdu4Xx+y/48wJA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-net] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
Date: Tue,  4 Nov 2025 20:34:16 +0800
Message-ID: <20251104123416.395362-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Fix inverted WARN_ON_ONCE condition that prevented normal address
removal counter updates. The current code only executes decrement
logic when the counter is already 0 (abnormal state), while
normal removals (counter > 0) are ignored.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index a3f654ba9dbe..cb3ebb2efd00 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -682,7 +682,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
-	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+	if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		u8 limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 
-- 
2.43.0

