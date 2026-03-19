Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0F370D51
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914943; cv=none; b=vALwpDEPjBSyTm1Oi0wakmfXm1tUdcFlHQP/IpHyRIme7HmK8fLghxN8W/3GlLKzOyIRtfxFqKHr/Y7fvnrwUavjnD3brCPZ0B9FtzpwDAqm8lxpZfy9Xe7bRbpfoOY+FgEK4l/0j87S6ezmAzV3jS4XLVh4Q9UN3tGFojGPRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914943; c=relaxed/simple;
	bh=IpOEgkWeR/fGuGvjz34os5dYQma6F4rBZsAwJ7DQ8No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKRQZmZX9J38WfaTVTT7ZxIzXwHyUHCgFYMOKGsLWNwqYJnq0AGQofhQ5DX92U7DtWLNLocRQP3K4x+B2g6rDKAVeRx6/ELhlJUWuQGnzB8H4A5bgJsN5btpmlp0NECBbq2R5d1wPG4dRZ3k7SKROrceeoWON3w+N0bSPHZ5BRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuFVWxyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuFVWxyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12573C2BC87;
	Thu, 19 Mar 2026 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914943;
	bh=IpOEgkWeR/fGuGvjz34os5dYQma6F4rBZsAwJ7DQ8No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuFVWxyl0asl5H5BDfYQDtbJn0waXdlveE3aI+61UOn0rCg+bmmelpTSTYrpOHAHY
	 7UAtzQsMYUK0Y+PFVcCgVYm59jBaYqN6jrI52Ll+qpz+HtfsrOlNN00+Hm7Tj8mQhl
	 Cp5i19FoUuU6szftKp2C1JMVOkUoFnA70iT/+A1KfJ97pu0bB0Cm6ZQE7OMgxMN1FQ
	 hGb64nZNJ+OxYyxveNapcfMOlPxH670WvAdrhAhbr/raQmGOermwUUdaIWcgO3JS52
	 vmAZwF1HB9LjTCiNWZNC7IxCW+NNTV6kDLRKh7s54K28QQILXPA0+si1mNI3VYWBWU
	 S/k3/IjJdBKXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v11 03/15] tls: add MPTCP SKB offset check in strp queue walk
Date: Thu, 19 Mar 2026 18:08:36 +0800
Message-ID: <21b57225396ef0c31b31a19fac02a5b455703a63.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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

