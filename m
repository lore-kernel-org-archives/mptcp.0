Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998A25D8F7
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920447; cv=none; b=AXrJVLiNCW3g1WNF49FpOiNJUyN+dIAbHkm0PeGH2YCEF2kk/iLmaPTtd0N8pmatjapa4wBhhiMZipxtcvf+V+6VXlrBJOTugcmSlBHLGAH8ZYNRo+ymkDsvLQb8BRN9E58JO+8dDsCVftoZo/n6lotAR95uk9DL55b8nR3Y6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920447; c=relaxed/simple;
	bh=+lodPecUPznUaR9XCKDjq5BANsI4lcWQdcnmYqdu18o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KF0A4xXJggimsY+UkqiKYfTrz2NPH8dcIbGye+VlQFwgMnpy10R1S0CBu3CHBt9WlfzIe8LYxPFWSXxejh+meKlhkHzavf8gRwfGMOg1XtVKIL7EUJQ7t89qhILRgZZxWt17bWZ4G0+RIIFceD+59jsiSv9nJXxNfT2btH6w1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HncK7e6z; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HncK7e6z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742920443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2fQ9iWdqmh9pHSIafPrnWzEZfCrEzOKoLOzP7XOYa5g=;
	b=HncK7e6z310mn7AVLN9vLIeoerX2191LNp9DDTwWJOCPxyEQFaQyJi1ibJUs4tepghDp5L
	FVjQcUQkSnTkRARY/tv8SYyNmIDZyv4l+9xZn7H/XgGWyXwOYSXyqErAlc/vlSYkM4baSs
	Jt0GRsyl8JcfDrY3XYeo24CfQTeyYxs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH v2] mptcp: pm: Return local variable instead of freed pointer
Date: Tue, 25 Mar 2025 17:32:52 +0100
Message-ID: <20250325163251.135510-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
removed an unnecessary if-check, which resulted in returning a freed
pointer.

This still works due to the implicit boolean conversion when returning
the freed pointer from mptcp_remove_anno_list_by_saddr(), but it can be
confusing and potentially error-prone. To improve clarity, add a local
variable to explicitly return a boolean value instead. 

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Remove the if-check again as suggested by Matthieu Baerts
- Rephrase the commit message
- Link to v1: https://lore.kernel.org/r/20250325110639.49399-2-thorsten.blum@linux.dev/
---
 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 18b19dbccbba..f4e32187e2c3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,10 +151,12 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
+	bool ret;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	ret = entry;
 	kfree(entry);
-	return entry;
+	return ret;
 }
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
