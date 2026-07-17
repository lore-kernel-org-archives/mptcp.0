Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DB303C8A
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263830; cv=none; b=auc1nWv4ttWVlOGzVkcao9AzpVZvQqgvqqAMjUoBwagqFJ3rUFgo4dT/bpAiX1zJZqwKRa09DDWSJ6byOaTFE0XzJr4+6exqFR1BdxG/SXqT2Kqdz0i6ZQUEtTESKwkMoZZP0PK6e+TwVxmpxTW8KgPse57MnnLmHQyr1DiL5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263830; c=relaxed/simple;
	bh=cs9ZDRNpHUGOZhVgZLHEw9C7VMUcJdt8rlQlk1KLNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBECkiQW/lD1zoz1UpkuTnxa5vXsO/lREk6Gb0iNOvjK6gfEqFakswtMNF1LMAzwzGTRA76PkpO76GRq/NHa6ik5DAxh80SQ7rSTlaor0qDSIz3Xzqvy5hobvEgWWF0TSnYM7fs60SPsEwOm/ZmlocFHD8LCvieJrDyvl/FQq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSomSi46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSomSi46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04881F00A3A;
	Fri, 17 Jul 2026 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263829;
	bh=ElSZlA4Rb1X0Hy0iYkwooMfxGtyLfN6d3LNYXmaf+tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSomSi46hLD7+4OsOiPp/TJAVpLiAdbii6g5tCyQPsYLCerlmQxeS+9cp71xpdVaj
	 +vw+XdBZV0K42DCaY9Fj1/55sqsn+eXD9pYppCTMgGcnqp/KRrL7vYLfeXS26cMur8
	 kevbcrPfA4JEVYlhYLPNw35ipYXeze0o3tl7DrUnLg4ZQYVK+3wtq8ASohW1dOTDh1
	 2ABv1M8u9bvfQKp9d6dH6j1s8aedm4eB6/Y6h+L/lzy70aTX++ppoEXVInspjs1vQL
	 rC7iuZToohhpaTiGJU9YHVIglRXPF2i3o1XEuCTk9aOchRu1TotFYS34hNQUhOd+tP
	 bLTHkL6Y6lBlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/9] mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
Date: Fri, 17 Jul 2026 12:50:12 +0800
Message-ID: <54e907886c661227cf62641ad46bc470344b3613.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
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

