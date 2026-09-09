Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B5322DB7
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921671; cv=none; b=XxpaGIIqGnuPJaWIdOOShJkwPhmb+lWCY9xcje2/PFvk2t4P8gB+paxRVZPUfSNxYJFecVVeDrx/AbNrAdUPK1i5n1QDeAgyp5yqqMCppABdeh6LsB4kAL4/O0XdDJ5oT1IrVhdyrbxs9rmJm11JGGPVRN+n/GoLNaaMbt4MYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921671; c=relaxed/simple;
	bh=Ebz0RNra8oREl1MPq7eloyPf8ZATqk4qCxowxdq7xds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGzfJsH3dE5XPT5HN0Jvoj2fB74XewtvEkFj0Ss881+1nd3Yr8aXBr4s3aTajmrruxpHbxhDq7xhCA12EG8LIJ8JgnddHYwgiEJ73KveKcL8NnpC7zRQ75Zo1IYg2mPYpI7C6fNCe5G+Vvumr8FTp3/cQNfskCS7m6LFaY5sRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni1gt/r8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni1gt/r8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE90BC2BCF5;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788921670;
	bh=Ebz0RNra8oREl1MPq7eloyPf8ZATqk4qCxowxdq7xds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ni1gt/r8/tafnpY1d7lfy5NynU1UywQ715fwNSxeJAOXcDgNc65nHAMwo0FJ0ef1R
	 ZIulBOVBdAVb0L1pu60QgmjuJakMC3sXhKPeUp+1eArA31WEny88Mru7CTYS+ayCVY
	 FaYOSFOJ195AlKKJ5joqLOF53zvRwIplt7Ez77HX7KTf5V3zbh9QUj6ghAR/6z+3/u
	 7SXnE/NMryTPa7ye8gMi82MrMUyj2iVUvLt6CBpW/jAaZH4Rqm1//Nq9136nVv26uB
	 LH/gidgnBpsxWwEeaJk3EqDwScPVMZmoYyjqqfK2KMLcvWBDjCH5qCWKRRpuqhGryR
	 kezCAw0y5Jbdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CCC79FB7;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Wed, 09 Sep 2026 10:40:49 +0800
Subject: [PATCH mptcp-next v3 2/2] mptcp: shrink struct
 mptcp_options_received
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mptcp-shrink-opt-rx-v2-v3-2-92bb3009a665@proton.me>
References: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
In-Reply-To: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788921669; l=2657;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=YpW1YW98fTieQNQguyspktoCp+D2q9Bq/4Xz1WxldUA=;
 b=HNol1HmkDp8gGW2N0KttaORjzWENHxPvnAi8R3DT4y04QijGCQxeWd7+t0KmhwQdRXQ/gne9N
 P/gDDszp6hVDzgwSpP4eKzeGio+0KUc01mmtZ7i7MXljfdw2Cj0TD3E
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

struct mptcp_options_received is allocated on the stack while parsing
incoming MPTCP options. Several suboptions are mutually exclusive, as
enforced by mptcp_parse_option(), so their payloads can overlap.

Group fields by suboption and place the mutually exclusive payloads in
an anonymous union. Keep DSS and rm_list outside the union: they can
be combined with other suboptions. Move join_id into the MP_JOIN
group, and overlap token, thmac and hmac inside that group.

Further shrinking would require changing the parser so currently
coexisting fields (DSS mapping vs ACK, rm_list, status flags) can
overlap. That adds complexity for little gain, since the outer union is
already dominated by the MP_JOIN / ADD_ADDR members.

This reduces the structure size from 136 to 72 bytes on x86_64.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.h | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 04e1180012b9..534d052ec007 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -145,16 +145,13 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 #define after64(seq2, seq1)	before64(seq1, seq2)
 
 struct mptcp_options_received {
-	u64	sndr_key;
-	union {
-		u64	rcvr_key;
-		u64	fc_recv_key;
+	struct { /* DSS, also used by MP_CAPABLE with data */
+		u64	data_ack;
+		u64	data_seq;
+		u32	subflow_seq;
+		u16	data_len;
+		__sum16	csum;
 	};
-	u64	data_ack;
-	u64	data_seq;
-	u32	subflow_seq;
-	u16	data_len;
-	__sum16	csum;
 	struct_group(status,
 		u16 suboptions;
 		u16 use_map:1,
@@ -170,15 +167,29 @@ struct mptcp_options_received {
 		    deny_join_id0:1,
 		    __unused:2;
 	);
-	u8	join_id;
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
+		struct { /* MP_CAPABLE */
+			u64	sndr_key;
+			u64	rcvr_key;
+		};
+		struct { /* MP_JOIN */
+			u32	nonce;
+			u8	join_id;
+			union {
+				u32	token;			/* SYN */
+				u64	thmac;			/* SYN + ACK */
+				u8	hmac[MPTCPOPT_HMAC_LEN];	/* ACK */
+			};
+		};
+		struct { /* ADD_ADDR */
+			struct mptcp_addr_info addr;
+			u64	ahmac;
+		};
+		u64	fail_seq;	/* MP_FAIL */
+		u64	fc_recv_key;	/* MP_FASTCLOSE */
+	};
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)

-- 
2.55.0


