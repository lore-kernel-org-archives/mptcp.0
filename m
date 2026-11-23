Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422001;
	b=XCJyt/ScI06jTkJKY/gEeYRmVA3kUn0DHS6tpbXs4HDsdu04EaxmUjQCeFKD9eHs0bhW
	 Kb9p6yctiDUnEFVA3R8tx/ZLnIZnUPLVW1XIP8DT2fBFn6bHxKWSFgYlpPqSfw4Owtmdl
	 OOmFio8c5YLKKnonkKhFUlJMpsBUGmILUdtwJ2jA74lJd1rm7SO1vhZCkIbK6q2ydfZ+W
	 qnzB/vW5vHLZ5igEAzAkYGu/VARJQd8oZd/ZKgGPjGjRqZuS8Qdqb3MUYqmOvfZtJBm8d
	 Uj/LT25BLuj32ely9OcSYYn2W41yV7/NxACr0d4ZaqKR2X69+McQD23PG3q/HYqHiRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422001;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sbMD8GKa2FJ3ih07fnwYuq3Kn/VXGZNlJdzl5DfceKs=;
	b=CRn1GyXWzPQZd/h9h+c44sqzi3trL6p5Ijj7yuR3SiMgBkUReAC96e37wr/+PkNzlgC8
	 gg0I1n84+FBKDc5joJ0CjoyHjW/9Lt+Duce9BHG6EOI5nuAwf1ad5KWDgVVFyskP2ZWtB
	 iBshgf0nuGushNeN0g3DdcS0BBgqrzPL/UI4oVtteDT8lSFOQNQzeFYvWe7VK0OIwimXK
	 WZ+6FCTOwM5p3XrmoxU55pNBNnZaNDxLW2+1PPVOP49Js+WnfqbLfLm5hOpiiAwCvXdGE
	 rRb2IKA5pDSuTmo1eXKmxqMUBNOjNYv2R5LF7hxSzn+cGLjWZ245H4LkTZ5al9CNxnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iit9Whh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A48606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iit9Whh+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA681F000D3
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422000;
	bh=sbMD8GKa2FJ3ih07fnwYuq3Kn/VXGZNlJdzl5DfceKs=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Iit9Whh+Xs58aTRgG4nQOJT2K3R9/ZzOBNW4QNclOdHPPr/Y+MSkHBElG5MjHoz2i
	 56+WCvy1tBL6jofbDS2Oo1vuRZiQu8J6yiF65BHDKwkHsLQRjPfLu05LQ7N7iFRjuw
	 wNg0L1NEukKmvThFeukJSLVH8kJQvKDjjHxTus9nBdhojvSDu508FEaeGe0eQSaHXS
	 SiRM7ncB2qVVxwO1QV/TB+JZZLrA+waZGuNJ4N62U9zKRSnfu5h6Tn3b8nCSr1YaM/
	 QIqz5jqcIt+MbyyWwcbbBHsv1hLb5RWHaGB3tXYn5avBAK1U4abDGpfqlM89CkWtUK
	 jWMmZsAp6Fu5w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 3/7] mptcp: remove redundant orig_offset in carve_data_frag
Date: Mon, 23 Nov 2026 16:19:46 +0800
Message-ID: <85aa8ebd8ee170cf2290d75b8e8c1ffc1f02f6a7.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
index 2102adaad4a9..84848cb0a5e9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1302,9 +1302,9 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
+	int orig_offset = pfrag->offset;
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
@@ -2103,7 +2103,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.55.0

