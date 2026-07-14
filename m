Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF1360EE8
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993282; cv=none; b=KCPIKTfW4hibQMYjo5+rpI+UI7n2Thm9aJZJNuXsnTQQMQgBD6c6m9LSWxLXxYi+JYKmezfcGz/udOx71ukPWFJMuA1/+KZi6AAXAh3KT/O6dCnkLJgUtr0nBe4jXLvnSjT+ChY592gxQn0wtpTp1KAJ4ccMmpZO2733oeXcH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993282; c=relaxed/simple;
	bh=kBi0yLOv/oI2k5sq55OaIAlOFS1OXgl4ObwpZc8E4uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMlCc56QoyBlavS6SuNyWr17TM3BX2kNFcDEtGm7S8Qf6mgDy/UQ7+il4O4LUeHpsvFtDx8K96SjzKltJ02IamLGT+52Yrnsq9D2giHT82rM/fVaHdR4R4U4r14qBjO/dgGMldSZO/S1/+Nx2tIBJshg6i+G00EhYn5musyHgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwC9/uw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwC9/uw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FAA1F000E9;
	Tue, 14 Jul 2026 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993281;
	bh=YupAB59tw+FVXwy+ZOzTZAeHm3llU1gWIUKkYa6d06c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwC9/uw6TadkaZRNiXJ3/wYN+yPu5VxkMIyU4DBb6rOtVJeSmOHke0A+W4I7f/yha
	 9PybQhtsA62ZsxnFLCJ8lew596zCjVB8+5yRpmw8f3hjnkH8i1OZjse5MJOzmCmIl3
	 tgEBGjHbNwZv/dw9dcUHC/p6gmNaqcCKk3/k3GIjoOK/Lrgk5ZnfY7K9jETsDf9Dp4
	 iWM4hdhx7uU7ULdGK7Y5eD7+P0PvWXvv3h38kNgVToqTIj8dz2+pMANLDhOIXTGU8u
	 /pL0vMcXHRFYgPRXOvX6J8A082ZUs8M6B3+m9JvvVaT1JkNQpuBFxce3RCpSVQhNRh
	 4MZ4jX+TU4JXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/7] mptcp: remove redundant orig_offset in carve_data_frag
Date: Tue, 14 Jul 2026 09:40:57 +0800
Message-ID: <457631a70151d3ee143f806dbe45e15ca9c0db16.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
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
index 1cab07b1b9b1..111da68d5875 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1234,9 +1234,9 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
+	int orig_offset = pfrag->offset;
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
@@ -2031,7 +2031,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.53.0

