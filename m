Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696254;
	b=1mlKl7/3r1oYOkrEFJlB9ad03JAQoNaBKwklDUq3/y5XfMd6B6U8lQjD6DuHJW2SRzfj
	 KRlc4+R7oabLgY/KDg1mHf9O4IUCqIn7nFtRkU1+ll9seVSxF9cb5Cbk/GEMNg4nsHLfI
	 FmKf+2sLbrydSd3BWJQtWAv2XzDwx/5TtV/WqxPwHqpZPSzLMef+cUsMetonrv3Ggka/Z
	 CKrH3tmZ6mKAf2JcUcZeO49JJilgsDxyhFf8xsbDfqJZiKLHcA5hN8GiD1cIN8h+WWmj6
	 9vhMnR9YS1tM7t4MjYueT3MfYXSLq7qCOwNcM7voPq7EfLby7ZknPqX+vi73lRIZZVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yJntaRQbzGVnzWYMHY7FegV5Yjg1bccMilBjtwueFxg=;
	b=rML2mYQv7wPPdkyWW/sjLxI3/xl/VY+bCLX5SHVGaucKQnvfRJyS2exKxCczHWL+C1i8
	 gM64+9SwRpe3AIc/uAIoatXFNgKLB3//uVpDWzB8KlqyfDNVoI0j+zeE2WWPHjlWi7N88
	 bQSmJy5USaYv8TjD2lFrExZlSXyLOuffBQ+rJ5PQktnICzLbJpR1s1E3qVDlkWFFRc8OA
	 rSgZl0g2sbU6PQk1uHmBQKb1hE8Q/04iDYqlSgPPAANADcAS2iAUCmj8I9aSdjcVsC90p
	 uL8fPWEXtjJXaRlvqq1sYKKc+Y/ebqkCusYBldWoVgAPFfS2rVzaArUaZybFJq0nNPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWFQRtF5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21C606A32D
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWFQRtF5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EE1F00A16;
	Tue,  3 Nov 2026 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696254;
	bh=yJntaRQbzGVnzWYMHY7FegV5Yjg1bccMilBjtwueFxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AWFQRtF5GzgaBZOuuBk2meYJHTJi17Pp2w2zngbbF0rOQ+wsgQUM7qdXXUznm+Zha
	 ugNnwT2CCJrGqaVAQ+VI65OyHaKBmCJrOIFkADpZyVzeuNwkJCd03lwHh0L5ZyTZ75
	 0koJEOTsEo/4CDrGf9QNApED3J6Y2ahxg3zDqzwhMfOkZZBkdvk2l7o/uhg5bJ9a1Z
	 pW34BTkTPVqXl2FqW4vmjr6YiRrVu1R8/8j9CVHw6GMrIJb1MSpcObUq2x0EOn/bGC
	 GZQycXrMACwmdI+9T30w7XMxm/VMb6fKY1Vgit7QM/emNSRAV2t8KbGjc0bpxZo74Y
	 6Eick7EGhoMQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v20 3/6] mptcp: fix TFO map_seq sign extension in fastopen
Date: Tue,  3 Nov 2026 16:57:22 +0800
Message-ID: <6cded4388add37e9314abc3199507bec457000f6.1793695518.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
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

In mptcp_fastopen_subflow_synack_set_params(), the TFO skb's map_seq is
set to -skb->len to represent data before the IASN.

Since skb->len is u32, the negation -skb->len is computed in u32
arithmetic, producing a large positive value (e.g., -1420 becomes
4294965876). When assigned to map_seq (u64), this value is zero-extended
rather than sign-extended.

This causes incorrect behavior in sequence number comparisons throughout
the code. Functions like after64() and before64() may misorder TFO skbs,
and the out-of-order queue handling may misclassify TFO data.

Fix by casting to u64 before negation: -(u64)skb->len. This ensures
proper 64-bit two's complement representation and correct semantics for
all sequence number operations.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/fastopen.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e18b31028e7e..79765cf55286 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -45,8 +45,10 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	subflow->ssn_offset += skb->len;
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
-	/* Only the sequence delta is relevant */
-	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
+	/* The TFO segment data sits before the IASN; before receiving
+	 * the remote key, IASN is assumed being 0.
+	 */
+	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-- 
2.55.0

