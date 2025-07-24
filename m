Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB915148830
	for <mptcp@lists.linux.dev>; Thu, 24 Jul 2025 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337150; cv=none; b=E9FCMcILpEpYBPToXSiVa9o51pZ/l7EBctzRPSpEeBeOgFn3khzCzmyB7XHjokLouBheZ351/tSldHfN2gWPTLyL3WT/Y2r7WZsyaJ5OY5c9KG5LBrhOaFbB7eGPpzx+gmxMjaLp4Vz/4MVk+5hc+ijoWkVuidjSF0+egcmYzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337150; c=relaxed/simple;
	bh=5ASNa7L/KkuSuSsq19il/cd8dKCQAUC3vWRJxhnpfhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0DWXY0QDBXC/zy7dvm8n8crMTOcJANsNnT4Xif/bds61XqeSo6/Slwf6r43NcOQOdkw1gVw6ygPrrCxm+hppu9AKMDytYCyaQ4Qg9Ksg5dhLwXz4CVRAKdOrEDwr4MFhiZ1nS5RPVagGvFjebsV220zBKOvSk/c223wPOZsg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNV2ZjyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNV2ZjyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC1DC4CEED;
	Thu, 24 Jul 2025 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753337150;
	bh=5ASNa7L/KkuSuSsq19il/cd8dKCQAUC3vWRJxhnpfhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gNV2ZjyMDbRV+dQO/djj97y+p7199wa4va9RgjO9vH7h1nFcH2slNdmep9Q/CatEP
	 bK4hafvWZXVWcEAqQfaa3ijDjeoz/9qY1GI7HfXjY5EpMA2Jos6bjlKkfeECKWltTs
	 DHPCjWu4pxk6KeBmAK/jJdGH2lnZ1+E11N44GFX5evFGIBBdYrtGDk/VSpo4Npa28C
	 69JRu93Rmx6qzC2U/l39igBUTgRX+9cq2vdMX0e0dCGCL90H4RAHGbENPEfoD6b1hB
	 6Iz1rNkP9e9sCzfXmxEVx/6OFsUoakUQ0t6Jxw1zL9zi6MhDiYebnxmZXB9RBYbF67
	 a9Xs9reiTdZ2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag
Date: Thu, 24 Jul 2025 14:05:37 +0800
Message-ID: <9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_carve_data_frag() already receives struct page_frag via its 'pfrag'
parameter, making the separate 'orig_offset' parameter redundant since it
merely duplicates pfrag->offset.

Simplify the function signature by removing this unnecessary parameter
and directly accessing the offset from struct pfrag internally.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b510e04724f..ca7b9ed9657a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1039,9 +1039,9 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
+	int orig_offset = pfrag->offset;
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
@@ -1800,7 +1800,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.48.1

