Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75B4746A5
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520961; cv=none; b=Hw0jK8I5aHDcvaTRGQIhcUxcTz7jjxj2A7yXjGqBBq9+DZmP1kVAv/jIeoKOoYNpKMWYelyF55RfWpqZArAbU0G/jLVQkII5sZ1CfvvDK2dlNuEZJuIGILysW1tyV3d99uuChJKel6zG8XTJw0+eM3e5neMLR2A4SckcWYa66Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520961; c=relaxed/simple;
	bh=YkrtJPTEybNDjrvaJOtlmEmrpDyklinGMzu7uIysU+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nyoc/p3dZw3r6JZhKW/EexPh3+ySEZ/gfqdGJp6c0Mo6RFIlwOXEKSOzC3hZY7dCLBN2O0wnL435WIapIRrzu38hJPagK4X+89LneH9OR65PODGPy71506P0gfz1j8B2K5JTZCdDqhfu/hC3ELMd+qEf3pXUK8eyejIownekfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/labkfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/labkfo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91ACBC2BCF5;
	Fri,  4 Sep 2026 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788520960;
	bh=YkrtJPTEybNDjrvaJOtlmEmrpDyklinGMzu7uIysU+s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=k/labkfoCSnJ0ks365N7u3ZFhGME8mQGzCaHgoPTmV2U9SojO3ZUu3/PZD+58Fpot
	 zmZ+d9VT7gQkJnsWJFQI7aCOab1O+2StYEHCJBme4bkOsgwmA05h035DxU3pU8eLHy
	 MPq3GFdDxGj+Mqb8NZStx32xBu26rngbG/cOvtcMk6FARGUnmG9EvFyyUKivQEZEID
	 rZTItbvysckBEY7J8uocHFIyx5dOGNaq60Vwpboyf3IPjMshqFcEQAt3yLHGolxBCq
	 4rNjnvq8TQ+Ih4ZJRTxd9GqY/cK+JNGKtjOCNBNpo365N0ek1a/ZwwpbWMMTNofrIG
	 T4AWlBqZV4pqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B230C624DE;
	Fri,  4 Sep 2026 11:22:40 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 04 Sep 2026 19:22:39 +0800
Subject: [PATCH mptcp-next v2] mptcp: shrink struct mptcp_options_received
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OzQ6CMBCEX4Xs2TVtA0g9+R6GA5RFqrFttpVgC
 O8uP3ePk5lvZmaIxJYiXLMZmEYbrXerUKcMzNC4B6HtVg1KqFJokeM7JBMwDmzdC31IyBOOCru
 KhCl1IZXOYYUDU2+nvfgOB+NoSlAfXvy0TzJpa97Sg43J83d/Mcqd+T8oUaLqqkvT6kIUfX8L7
 JN35zdBvSzLD4sFlvnXAAAA
X-Change-ID: 20260904-mptcp-shrink-opt-rx-v2-d8e0c6951294
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788520959; l=4282;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=aVqcS8WPDUb76u1ehRT8vA/YOKHuGD81HPnkyRznza4=;
 b=6iyA+Dpf0azJbDWux0MDyVHRP098n18qkacGvi2qcpnZI0QPBF4LYxlfomzn5YUMO6BrJlt0P
 b7SKOuHE/1KA/7thjJMnXTEqdrwwXp1ZxqVkqRx0GTu6H01W559C+/T
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
an anonymous union: MP_CAPABLE keys, MP_JOIN, ADD_ADDR, MP_FAIL and
MP_FASTCLOSE. Keep DSS and rm_list outside the union: they can be
combined with other suboptions. Split the former shared rcvr_key into
rcvr_key (MP_CAPABLE) and fc_recv_key (MP_FASTCLOSE). Move join_id into
the MP_JOIN group, and overlap token, thmac and hmac inside that group.

Further shrinking would require changing the parser so currently
coexisting fields (DSS mapping vs ACK, rm_list, status flags) can
overlap. That adds complexity for little gain, since the outer union is
already dominated by the MP_JOIN / ADD_ADDR members.

This reduces the structure size from 136 to 72 bytes on x86_64.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v2:
- Group fields by suboption and move join_id into the MP_JOIN group
- Split rcvr_key into rcvr_key (MP_CAPABLE) and fc_recv_key (MP_FASTCLOSE)
- Overlap MP_JOIN token, thmac and hmac
- Drop the dependency on the invalid-option series
- Link to v1: https://patch.msgid.link/20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me
---
 net/mptcp/options.c  |  6 +++---
 net/mptcp/protocol.h | 44 +++++++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f87707110c75..943b2b37eaae 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -374,10 +374,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			break;
 
 		ptr += 2;
-		mp_opt->rcvr_key = get_unaligned_be64(ptr);
+		mp_opt->fc_recv_key = get_unaligned_be64(ptr);
 		ptr += 8;
 		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
-		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
+		pr_debug("MP_FASTCLOSE: fc_recv_key=%llu\n", mp_opt->fc_recv_key);
 		break;
 
 	case MPTCPOPT_RST:
@@ -1259,7 +1259,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
+		    READ_ONCE(msk->local_key) == mp_opt.fc_recv_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b3121c8c766b..11adb2d67bb6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -145,13 +145,13 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 #define after64(seq2, seq1)	before64(seq1, seq2)
 
 struct mptcp_options_received {
-	u64	sndr_key;
-	u64	rcvr_key;
-	u64	data_ack;
-	u64	data_seq;
-	u32	subflow_seq;
-	u16	data_len;
-	__sum16	csum;
+	struct { /* DSS, also used by MP_CAPABLE with data */
+		u64	data_ack;
+		u64	data_seq;
+		u32	subflow_seq;
+		u16	data_len;
+		__sum16	csum;
+	};
 	struct_group(status,
 		u16 suboptions;
 		u16 use_map:1,
@@ -167,15 +167,29 @@ struct mptcp_options_received {
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
+		struct {
+			u64 sndr_key;
+			u64 rcvr_key;
+		};
+		struct {
+			u32 nonce;
+			u8 join_id;
+			union {
+				u32 token;
+				u64 thmac;
+				u8 hmac[MPTCPOPT_HMAC_LEN];
+			};
+		};
+		struct {
+			struct mptcp_addr_info addr;
+			u64 ahmac;
+		};
+		u64 fail_seq;
+		u64 fc_recv_key;
+	};
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)

---
base-commit: d5a4e55ccfb893614646d0f0e5c440daa92b7467
change-id: 20260904-mptcp-shrink-opt-rx-v2-d8e0c6951294

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


