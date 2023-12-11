Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740F20B30
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvfIBtT1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyhpxc190g6uelh8gO5iylLF3XYCCRfKsTUoL6cq4Rg=;
	b=vvfIBtT124zbzXngv+BvseuU3vVUhWqGAR5IcEU0oBPhAcitPYS0i7/DAFtdK1eyDo0IaF
	HdwgQFl902qd3W/QCrjVLDMNaiwn0SBv8epzHdwWdHnZ/Kj/ejKUN8WQGxm+ja4dTvJLpf
	i2qcTBnqQ3LXdeJ3jWQPCIfBqOC/+d4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 1/5] mptcp: add mib counter dec helper
Date: Mon, 11 Dec 2023 16:19:13 +0800
Message-Id: <6fffefdb98080339b9818ce25463cf8ef197e19b.1702282650.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282650.git.geliang.tang@linux.dev>
References: <cover.1702282650.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to MPTCP_INC_STATS() helper, this patch adds a new helper named
MPTCP_DEC_STATS() to decrement a MIB counter.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/mib.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..9b7c366675ec 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -95,4 +95,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
-- 
2.35.3

