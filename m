Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5462312803
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116082; cv=none; b=Ci42QTJp5WGLeWxwDJEANvJ+geA0fBCuSbXK8wtzOH7oyYQcrlKD/FcYTPNqlxN+QGTTQNICBq/YGiNJ2B2oOfDXWzpBxCOR+pdMBjRHeFdkEaI0kxoLGecrPPqzD0hKIArvR0pVq9ILZL2zfeaGMH38jDhFNbvh76MZMy/+6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116082; c=relaxed/simple;
	bh=a9BA3RROZ+6Yrz+vdVhG7rEBjuXHlU7FP7q/LlVozCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG34djEveOy8JU6KUKoAzntE4S4qvAoT4VARSJsVLmn8s0Yp1NY6A62x9FOiocSIf2qQTT+5hFv83+wCA4Zqb2SluMFD3s4e9ek9boPUJ5NGUAe7MHzPJP86+wTcyT/EEDRmqrhAv1YnDfZZ44qOKmUTIyszXbT4e9k6hAWAk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLL6sLLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLL6sLLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E1C19423;
	Thu,  2 Apr 2026 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116082;
	bh=a9BA3RROZ+6Yrz+vdVhG7rEBjuXHlU7FP7q/LlVozCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLL6sLLdkBppuk0bhgToHc9ZPRfX0dZJ0EOBVZSlXQAjJMRwoeaKP4JFRyjIwBFlX
	 QDIQAa1dTWmfdqNe03cql1Ck9zas56zhtOsHHX0qPsejHFrX7wwR032IWG80oIoiZG
	 cFuNm7gHjTijlt1vVEJxg57/rpzt8oJtSvcxY5sEqwXjmlghC42UaNxo8UegtHBv3J
	 C2Nfxic5nli2UdDwCQJxL83yPuyiR+KX1dWhbkyYzWrbqoBNywAh/ZpxnVxLLeHNN7
	 f56N2OKfM8KApJjx8objSak1FlcCwH9eWGu0wxZxMmZkDzI+sgUiQMeaBvlcMbC6n0
	 GgVMrHFqM+w2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v12 03/15] tls: add skb offset check for mptcp
Date: Thu,  2 Apr 2026 15:47:38 +0800
Message-ID: <066da609f001a94f70ef30cfeec7e968514b9d71.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In MPTCP, subflow SKBs can have non-zero offsets due to out-of-order
handling or partial delivery. When walking the TLS strp queue for
sequence and decryption checks, validate each SKB's offset except the
first using get_skb_off() to ensure queue consistency. This is specific
to MPTCP, as TCP does not require offset checks.

If any invalid offset is found, return false to trigger resynchronization.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/tls/tls_strp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 71f44bf9ed59..feef440d49fd 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -454,6 +454,9 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
+		if (ctx->ops->get_skb_off &&
+		    ctx->ops->get_skb_off(skb))
+			return false;
 		if (ctx->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
-- 
2.51.0

