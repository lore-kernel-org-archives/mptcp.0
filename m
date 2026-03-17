Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660F35AC0F
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738819; cv=none; b=GAPcj36Ygfgt3tlnAtpHCxWXxucArxSWLX/8HGNE6Ktvj8HawDvLDut1swcbUyNT1bPjBrwWLuhEf+hKybw/5gU8zYJLFPR+tYYmlZYWTiBnRfq2T05FY6Zlel9TzLoqSS29Skfp6j1og3wzi6EkJhcIQBVeLOyEgsGI9bDGbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738819; c=relaxed/simple;
	bh=IpOEgkWeR/fGuGvjz34os5dYQma6F4rBZsAwJ7DQ8No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuZfJKXGBksotrU1Wa6/E4vROOO1YfVbumA5ZK+6cUquBkJDN3dKcDl5+ejBosTZoV0Z0bU0Qzdr4SDl7GtKiUUKufX9Ji6o2pUXu7yT4wba7QCMaGIOdSG2u4xeHJi1Mjs28di1NKf+FNEsGo8ASi0MgHMucb8cadG0DTUvbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By1k3TgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By1k3TgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137DC19425;
	Tue, 17 Mar 2026 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738819;
	bh=IpOEgkWeR/fGuGvjz34os5dYQma6F4rBZsAwJ7DQ8No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=By1k3TgFAZ0sts23EGD9OVSWv0DNBwObhEOB1e0AAOvcZZikfTrNfJaDmad/uu8B0
	 DVzKIMWczEwvjU9+5X+CgjRQq5IJr20Dkm1P1mPsNMkS6JWdVb27uweKcvgSHPY4Nv
	 vdoFLdSzl37ADPCqJ+BxC2LQ8JukHbNJoBADY9s39o1CYAO6xxbkaFkhbndtYbMwMa
	 wX+BcZPeSH5H79XIwTP+nKlQRLtPiUusUsWXfSwQ5F9SEank7QTaYrKxlCRtCtx6UH
	 JbzqQyqXK1Sw/ZwQqd2Rmpq42c2UxAmvvdHQCDmhc++XA44gDMtDZzNMdbaD9Tr8EV
	 d0S0l2keNQvKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v10 03/14] tls: add MPTCP SKB offset check in strp queue walk
Date: Tue, 17 Mar 2026 17:12:39 +0800
Message-ID: <bc5b2ce6f9071dfa9483ba7df05c453e92b0a836.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
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
index ef1a8659ee18..b6798d09c922 100644
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
2.53.0

