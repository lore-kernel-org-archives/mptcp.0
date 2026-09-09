Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A603264C1
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921671; cv=none; b=Smuzrj/+q+OzKuF+cfsVToCMwKfqYTeeSgphwCziEm1FG6mZ6aFS95h1N8erMrdufnqc+ts6Pqmv57/5uSDM7g3dG1578GQASidcR7t721pmt09GKLIHfEzC9GcWZ1RKpfwEvDkLJ2oiRGxKa7K/Ybb49QThd3IX7895/Poxa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921671; c=relaxed/simple;
	bh=CwVjh/j7kdd8yMs/I3EsgxutV8GXbjlDGaBB2WZiNBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6dd1bnm6FYZ8am0uJkNfucT1aAguVftTxT2nfKv/o6I6hwc0+bIUWP3YzBMtAFw8nXpjQM0iiu86DMk1NEi4vK2Tl/bbLnhSvPsp07Rl1HE8INQQkRWS5IzUQpgkNXoVkcuaapl8pyvTFLwkPp0U84LKvKrL16K1MMQoo6kzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny40t4Zh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny40t4Zh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F64C2BCFC;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788921670;
	bh=CwVjh/j7kdd8yMs/I3EsgxutV8GXbjlDGaBB2WZiNBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ny40t4ZhIpLxOZVPEpzHTGp1reyfH4tmMeqXxsw76MOnDKY8AdrmMGWel+ynU66Od
	 d+SSzaIOhrF77chbpR/R4ZRqpdyPYgx2KO1bH3pcLVnPCuUJ6C4Vcb783s7L7pF56g
	 iMIpOXMut0oCmwTJrPTOosSHtf1uUXaZqqfQhyK6D3IOO4OiONrE06BoSRpNEZwmlw
	 2O9UzpKvRP4OlpdS9msy9IwVsmqMayKRJSStQgTHySjgUk4Yd5JwmYfxRuBpy9oB9e
	 7xF8kJOGWMMvpGfq1OMe70hjMlPTehRndc1wQJkdCVkNTg8ctYX7kLjZxQ5DdVKe/2
	 r+J9sz/MSMxrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B30C79FB5;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Wed, 09 Sep 2026 10:40:48 +0800
Subject: [PATCH mptcp-next v3 1/2] mptcp: split FASTCLOSE key from rcvr_key
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mptcp-shrink-opt-rx-v2-v3-1-92bb3009a665@proton.me>
References: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
In-Reply-To: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788921669; l=1863;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=WgO2+QmzY+V2+nRfgV9IITy5E0MZHT50sASW65x//nA=;
 b=t4B3slwt+WfonG2ETHDAAIRxtRgS9VSCQp08CJbdUiAdIxq9XLYetnF0epjkLnrhDWjlBe1SI
 3W+XzB4T1E1AjrfUW2mpPMLA6gYdodrS0+EqHoOnfE2cl6KXlLnowHb
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

MP_CAPABLE and MP_FASTCLOSE both stored their key in rcvr_key. Give
FASTCLOSE a dedicated fc_recv_key overlapped with rcvr_key in a union.

This helps shrink struct mptcp_options_received.

Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/options.c  | 6 +++---
 net/mptcp/protocol.h | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index b3121c8c766b..04e1180012b9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -146,7 +146,10 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 
 struct mptcp_options_received {
 	u64	sndr_key;
-	u64	rcvr_key;
+	union {
+		u64	rcvr_key;
+		u64	fc_recv_key;
+	};
 	u64	data_ack;
 	u64	data_seq;
 	u32	subflow_seq;

-- 
2.55.0


