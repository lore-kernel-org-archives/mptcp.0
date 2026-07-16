Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE4357CEB
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188292; cv=none; b=LbErlfDackwmXB1ggV9kbMKO3A9plnfINAkcQ7ny3EnanwhqXB9IgVOD4ZmF41j0CWN3ivOn+JnqvP6A702ZiTnpaGlqpo7W3bupBEuiRiBhRqynazi3/2Hr2gAHlaZHguPig/qssrFadkcG2KRb1XL27WyVft7lGXxPMRwDh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188292; c=relaxed/simple;
	bh=yy/4/NGgVfbFhP3r00OaG89OolxyJLVTIEBTNQDZpsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwKjjnDmilijL1LX/WWjfPVTLPO4T+yaLoP/aqYBc7/O6d6tFprXnos38faU418jjqgmiX2UOWQ9afOUEmgll+Wfu+hT1Hs5z57Rb79h2sBbCXhq93vrFt/FDBZgNZvH1btYm3QnZeIsfF4ViV4eOTc41lL4V2V8RgUw5aGybQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgBV4//M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgBV4//M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830F31F000E9;
	Thu, 16 Jul 2026 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188291;
	bh=Jep9UZlxM4FIDz9E1VeMkNUfTC1ZyZqyVsPSt4aOL5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgBV4//MgacfPjL8Bx0Sn6dnfSSP0attcD/A5ltsSyUlnlKeJRwL3Pk3QhrL4GoYO
	 gn4P0wle2RsTP3HHhWUwy9I1RmRGZGhb5XTtvg9DKOL4w+LO0a8OEJYkj/olgmb7dU
	 H0jyMujsBREbbcTcFiJGHHrEUxd4srbFd3G63BfrLTiMs6rzwIazml2pYwwopPoakj
	 eJOufXIaObYYG4ITuW7kgpJf/v1uPOLVmz37Lv11Ay4GvcFCvqBsWtkTNMMekcOMrv
	 vo1Zc94PZfXWaoi3BrYIvYZXxKF8fjoTHgZt6vFkElG+ev/aR1q0rGiXTTnJ5bV+bl
	 AFFC0OjvJAwGQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 04/10] mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
Date: Thu, 16 Jul 2026 15:50:43 +0800
Message-ID: <fde91a05b425374188400a291bd91058a5017217.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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
index 3acd61ae6160..7ad3a4a09e3b 100644
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

