Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A35334692
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113447; cv=none; b=SpZerCpfflNKJG7YysBpEUJ1E870GzGZfdYEcHre9O10iWGgL4Zimmy0uFiDuv757349V52Hj8smwzXE62pHTaE4XiiiSfyT/htjtxD5RNseDa350PChE5hgxlSsiuziL//u0n6yVuYs27ysMUCodqwuT3Xeg5nbi6GzspY5d94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113447; c=relaxed/simple;
	bh=VO2lWM9yY6PIOaTJ4sd3MLKK0esuT4PcPjMrYkyKJfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arttRasrkMQGdlVZPi2Fkm1hoqaNTjsnGpM50ZqCjM2z5xKSkVmGucEsusyUYswmmLPWh5LRBfwLZj2AxmM7a2qW5DvtzL3ElsSz5YsVPsqgfj8GG62Yz9haZ6kEKJW6Ue/iveBCI9IpgAbgTK9qDs7xEhPhh9nhfBzVCyJBG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGmkgLlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGmkgLlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F751F00A3A;
	Wed, 15 Jul 2026 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113446;
	bh=hBTp4gJcdKx312WpXFgr4fskzyl+43n/D4lcsgFrgyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGmkgLlm6pJ7awVOXC7c9tG8Ol1RI5J6HQml7EI+2eDYIbZEltW6Td+qhP9H7DNC5
	 VaafwqWEYuxRiOaDysEaNietvHQBhiSTOK04RPOBTTrKUsLDKoq+oQYmi624DM4O70
	 fG3jHPPrO4+8zQJTz7H7vwQtMmEhEkiPu0egfbS68W3DHah3BQWa01F8kzZ/NPTR56
	 H1DXX+DypyUUSlgv4IjKxeNqTPfMofj5p6ogKbuEZZIiIKOfu3lusgUznYOZOqKhKY
	 59+Z1MICHQ+kynI+qvxhsCCbsdr6iKkJyoENt4zw9lm0fOZ8rCVhpVxQ6Gf7IxFrjp
	 7l0mjusRx1WVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/8] mptcp: remove redundant orig_offset in carve_data_frag
Date: Wed, 15 Jul 2026 19:03:48 +0800
Message-ID: <0241a104ea5183010ac867dffb7fe8366fab6da7.1784113088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca0c02f3bfd3..6a9daa187dad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1234,12 +1234,13 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
-	int offset = ALIGN(orig_offset, sizeof(u64));
+	int orig_offset = pfrag->offset;
 	struct mptcp_data_frag *dfrag;
+	int offset;
 
+	offset = ALIGN(orig_offset, sizeof(u64));
 	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
 	dfrag->data_len = 0;
 	dfrag->data_seq = msk->write_seq;
@@ -2031,7 +2032,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.53.0

