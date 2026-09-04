Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7D322C73
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491325; cv=none; b=QXGKP05CI6NjwCD1BmrZ/xEP7aIked9BHdSSPMsi627gUIk7mTUuTy8rSl5KwUTljWpsVDl49AGbSTlwKvvCRcvg2CIyF3L5DVJz97vK0PR4O3l2b1Eup1GK5aRLFqekyV6BQPkBx+LONJvUWSns9J72x/7I1qzoGfBm/OWNQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491325; c=relaxed/simple;
	bh=7U4ZcwMlzM2sVawrEAFbCDnzOHVjXiWRN6e3aIWCVT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=guGz+whjblmW46GNxDMZz/86OhTfPmxN9mlHN8DnZ5i005ZO7BPHPb8qcSycfFksWnH4NkNP5Gw/IAtLNZ/2tBE5FWQZZqDxvg5/8B4eRqxRpGe1KGYCMV/xLARc0TpjQGinPVcJ55Fer/7QiaUaKqbvrrrCsnWoFPyRPaYC31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr7WFGo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr7WFGo8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81DC9C2BCF4;
	Fri,  4 Sep 2026 03:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788491324;
	bh=7U4ZcwMlzM2sVawrEAFbCDnzOHVjXiWRN6e3aIWCVT8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qr7WFGo8DYdVaWWr7KfjcoMujls1KztmZYP/zmK2D/oxPFPEiPZlykE2puccDeGrh
	 M7SEWVCd0GNFdyBxv/664kCZwD9DpnFdP2eh6h4+hUlOhMfUq6mkfKgigwNXfAYDbr
	 kADnp7uhSvZX7Bk5pjQek7izMJF69sYWZslqUEXbPwlOlVz0lPOH1zqVvzZemyvxte
	 ZenWgqzQkMkuGMUW9SmJyId7nuzWMGC+WjJTD0lcKO5tPjkvYWsrJjgO8Wj1A3w5dg
	 x2awTZWEbvJUwlVPBdy0MppqaB1SYEAfNiJjYVlCEjHWCanMjsMyoVixsvtFh4nc9/
	 d1lE3N6OMVeHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D11EC624D6;
	Fri,  4 Sep 2026 03:08:44 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 04 Sep 2026 11:08:33 +0800
Subject: [PATCH mptcp-next] mptcp: shrink struct mptcp_options_received
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OQW7DIBBFr2KxLhXYTGKiqOo9qixgGCc0AbtAL
 EtR7l7iePn15/15D5Ypecrs0DxYotlnP8Ya5EfD8GLimbh3NbNWtDuhheJhKjjxfEk+Xvk4FZ4
 WTkMPvRxkC25glZwSDX5ZV3/YG4i0FHZ6d/lufwnLa3a7TvR3r6/LhliTieMYgi9VRTjYO+wAU
 GsSe2mk7gkEKgDRWSStlHOAr6lAOZvV+dAcN+VuUw7ech9nc1utZ8kF75UB6BCgtbvvK6VIt88
 xnb/Y6fn8B9vGUFYaAQAA
X-Change-ID: 20260904-mptcp-shrink-opt-rx-ef8581f125df
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788491322; l=2103;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=1B+1XumgR9LhmxTgiEsBwIPrCKh6bLV+MlAgeHF3ilY=;
 b=6maB2qmgVUN5tItUCYFpsStaBgnYO//ht5tuTdzUjbvIVH/T8fHdLScBmfaEBDy4FYCYgIjgC
 21XCdaUiOhCCZqKjdOL7fx3klf9xM5CNdeLDLbI8ral11A0a3fQdmKc
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

struct mptcp_options_received is allocated on the stack while parsing
incoming MPTCP options.

The sender key, MP_JOIN fields, ADD_ADDR fields and MP_FAIL sequence
number are mutually exclusive, as enforced by mptcp_parse_option().
Place them in an anonymous union while keeping the existing field
access unchanged.

This reduces the structure size from 136 to 88 bytes on x86_64.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 739f9006c1e1..6646c428dbdf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -142,7 +142,6 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 #define after64(seq2, seq1)	before64(seq1, seq2)
 
 struct mptcp_options_received {
-	u64	sndr_key;
 	u64	rcvr_key;
 	u64	data_ack;
 	u64	data_seq;
@@ -166,14 +165,22 @@ struct mptcp_options_received {
 		    __unused:1;
 	);
 	u8	join_id;
-	u32	token;
-	u32	nonce;
-	u64	thmac;
-	u8	hmac[MPTCPOPT_HMAC_LEN];
-	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
-	u64	ahmac;
-	u64	fail_seq;
+	/* Options below are mutually exclusive, see mptcp_parse_option() */
+	union {
+		u64 sndr_key;
+		struct {
+			u32 token;
+			u32 nonce;
+			u64 thmac;
+			u8 hmac[MPTCPOPT_HMAC_LEN];
+		};
+		struct {
+			struct mptcp_addr_info addr;
+			u64 ahmac;
+		};
+		u64 fail_seq;
+	};
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)

---
base-commit: 10d57dc355c99e071a198e50c45503bce944dd5c
change-id: 20260904-mptcp-shrink-opt-rx-ef8581f125df
prerequisite-message-id: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
prerequisite-patch-id: 7f8decba16ce568283eaa86b23cd93b183aaa675
prerequisite-patch-id: c8fedc4ff2b5997f716dac0c30ec7620ecf11fc0
prerequisite-patch-id: 5abea779f2b0af347cd88d6b65bfc3b9eefff405

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


