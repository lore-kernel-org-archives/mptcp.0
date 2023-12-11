Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00F20B2D
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9xviA0n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UHn1ldZilvpkFxyJLkqRg5LKxqCWOCrhtk6IbXRmQPw=;
	b=k9xviA0nX6WS0rAbCCVv3bt/nkUeeGzcZpU99lf+H6OXSVSCS21aOcEyAwyUO4kTVjJxCK
	eEEbA07pbpev4vIn81W0xM0nLaT7h/w6prJAahSPrfcQCNY96lSu6pYs5L1ATyvXVzTURb
	CcQTlsP5gVVuLVf7Ai9OldWTOf+eKZk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next] mailmap: add entries for Geliang Tang
Date: Mon, 11 Dec 2023 16:22:15 +0800
Message-Id: <887df28eb56432c25ae6cc64da4817667562a020.1702282928.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Map Geliang's old mail addresses to his @linux.dev one.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 43031441b2d9..4ea59eb7aa07 100644
--- a/.mailmap
+++ b/.mailmap
@@ -190,6 +190,10 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
+Geliang Tang <geliang.tang@linux.dev> <geliang.tang@suse.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@xiaomi.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@gmail.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@163.com>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
-- 
2.35.3

