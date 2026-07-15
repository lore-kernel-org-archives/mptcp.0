Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D22931D7
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113446; cv=none; b=oEnLpV64Shqjrw/c3B1SZzuZbvijE5cQyPV7ygDjN9c1dgUElasOdwtipCIcbqtCAahP/sg3z+WznhBijlgNa8KN0goGMqJa78h/p5HemwNdOFulsvkckhX9Yh3bLmd00Wlq9PJpSWA20WQOraI0gkkGABb3Wl8bopEvOfYii1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113446; c=relaxed/simple;
	bh=cs9ZDRNpHUGOZhVgZLHEw9C7VMUcJdt8rlQlk1KLNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGIzrhIJCSXyvTdgC1fN4jeliYIM+zPuqBsQeNxQdrNwJEVK2EGDo1g7i0O5d8337KNpzB7r+3XoGQKegDtmWTG3qZ9cQQpDlFtutVpAx5JgiYoucGSfFXSzmaDgstYsbShjLcjROYZjklRTTS65cIhlC19omS8+qOIaujlt+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCDUJE06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCDUJE06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D071C1F000E9;
	Wed, 15 Jul 2026 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113444;
	bh=ElSZlA4Rb1X0Hy0iYkwooMfxGtyLfN6d3LNYXmaf+tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCDUJE06+cMzau7YyzBvmqK9d/hnSVrgdrvBZ5QjrQ81gjV/TZ4+EBcg9KK3Eod44
	 wQaqnK4LBUFAgwFZEg9/OmmY6FdhokhO2EzYudOJCSlWywkAQ3hWGmyGzqJ3pu19Ua
	 JGYtpUkmQsTP7Os/FSTvq7A4tldoIWKUkOe2880BGsNbays6urvKYrnmGwMMaTrWZk
	 ZcY+wNEhi0UHO5tT085rChANVI7TO8Hp3ogZf8XJANYbF5WqZzRUmesCbRLm4B/Ls6
	 +0WXJ8rF2PA52qCyn5/v1wI7IWVR81tG3YBI4eBzXDg55xld+zeYeUAKKwWG8cBbxr
	 kpwpfE1tvnWSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/8] mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
Date: Wed, 15 Jul 2026 19:03:47 +0800
Message-ID: <05eacad4eb98fd960fde99acda2e339c6f64649e.1784113088.git.tanggeliang@kylinos.cn>
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

mptcp_carve_data_frag() places a struct mptcp_data_frag inside a
page-frag region, using ALIGN(orig_offset, sizeof(long)) to compute
the offset where the struct lives. On 64-bit Linux sizeof(long) is 8
and this works as intended. On 32-bit Linux sizeof(long) is 4, which
only guarantees 4-byte alignment for the struct.

struct mptcp_data_frag contains a u64 data_seq member, which requires
8-byte alignment. 4-byte-aligned 64-bit loads fault on 32-bit
architectures that do not handle unaligned 64-bit accesses in
hardware (armv7, mips, sparc, ...). The in-source comment near
BUILD_BUG_ON that states "ALIGN(1, sizeof(long)) - 1, so 8-1" is
misleading because it implicitly assumes sizeof(long) is always 8.

Switch both the ALIGN() and the matching BUILD_BUG_ON to sizeof(u64)
so the 8-byte alignment is enforced on every architecture, and the
overhead u8 budget still fits the worst-case 7-byte padding plus the
struct size. This is a no-op on 64-bit and a correctness fix on
32-bit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cab07b1b9b1..ca0c02f3bfd3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1237,7 +1237,7 @@ static struct mptcp_data_frag *
 mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 		      int orig_offset)
 {
-	int offset = ALIGN(orig_offset, sizeof(long));
+	int offset = ALIGN(orig_offset, sizeof(u64));
 	struct mptcp_data_frag *dfrag;
 
 	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
@@ -4789,9 +4789,9 @@ void __init mptcp_proto_init(void)
 	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, cb));
 
 	/* struct mptcp_data_frag: 'overhead' corresponds to the alignment
-	 * (ALIGN(1, sizeof(long)) - 1, so 8-1) + the struct's size
+	 * (ALIGN(1, sizeof(u64)) - 1, so 8-1) + the struct's size
 	 */
-	BUILD_BUG_ON(ALIGN(1, sizeof(long)) - 1 + sizeof(struct mptcp_data_frag)
+	BUILD_BUG_ON(ALIGN(1, sizeof(u64)) - 1 + sizeof(struct mptcp_data_frag)
 		     > U8_MAX);
 }
 
-- 
2.53.0

