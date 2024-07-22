Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7F17108C
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676956; cv=none; b=S+U+O4672HLMKgy3QAaE9NMqO/x20JlS1jwJ7BicgDqZh2VHXrrAszjz772rPvAGevbBsozE8rIcFYiHPVrvRp9VUJx/6UH0kbK6dPHSEyvcDLy/jSV7tG7egrvCQK2r4ysA2eLW8gyLN9fIx73EO23LOHdnN0+5kE708ZYJz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676956; c=relaxed/simple;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vd/OnmevastJnutzGAHGaOR7XrhkgevRyuOLZcLdrRJ2/DroF/IO3+/3JV5UJjYFr23RFlGUbqFb54kyLCKwHhyLn91OBrFRNGNekzYTUI/B//wIi98S2/09LRLWxpty5T5Th7gO/6sQLsHw8ZS96AzW3w8iwUaSmtU3YpT4Gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doyp7EFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doyp7EFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E222C4AF0F;
	Mon, 22 Jul 2024 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676955;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=doyp7EFa5rMkWXi71vTDHqsc0iLvW9g8TX7UEp/h4V3dBUnrwagk1r8utxvwm/CtC
	 j9xltuuPG1BP8iID0f92fq5NefuSgZDKPg/wkfxSjwgg9E/MQs+yMb1zsr641rjyXI
	 hV27VtZ+BNBoJRLRqnUgg8WdJqF9c2PGE+qX1qqHeELQZfVrb6FHUGjlE11YWeHEbA
	 xcG35fKHaDE/qR1sRKzQk7DoYIbktbZ+lHfAvUEgQ4GBKe4s9MyIL/trvZJAkZDU0h
	 ds3mz9uS8eJ3caUHQVgcL2S4PcNn7siC21A2oNbsT3+IyG5dMNlo3vUMa4abzbIRkG
	 DuiHQNmpiDFAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:41 +0200
Subject: [PATCH mptcp-net v4 03/23] mptcp: pm: reduce indentation blocks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-3-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWbVwJTTxNfvAO4pJQEW06RervHaWzzIWvD
 OG4MEoEl0OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c1VxD/99S9t7IQ4/YLHGJmYLpYod63LJTko5o1ZPCuLcdZftqbsxHNi6gfBel8jkN7n4WtvA3Yf
 ODyXJGo1GqBHP+khzsmT5mnm1B+d2lE3OiEOFYRZ/fYCZuSsAIPBt8Xnrg2pg+5RMC+F0Yh2YSJ
 fBJfWKN2jun6lwtg2on4atcnkU0cjOLjcmcYJlLWJnY7Tv1vlnsdkgmmPL8PMJ1jPA0CY1h/cRU
 x+vpMPGn1CKoGHUEEBEcsGkLoo2msZZdiaJD25K0mkmucW5qRsZGlGjKSs7rfbL+JEeC4w6suuB
 IvCqU0N6rKtGQ4rSUEgr2OlYBT0QA2iUYPoTQ3D5NCYBJylUG/RO90QwlPIa67WImwhntTwdIIg
 Bcw4V1VD3ULQhd+AGTs5HZsRfE56EOD0JuRCfBQ2iEMRh6FgARXICGRJAymHIIYPIqfbkuFeAMZ
 CvE2DkkuXB0r8rdt7TrmhXe061bJKfYhAc2vbbdHJI8TzalA0GjA826b1lc0SxWpIjUMsAbCDEd
 qo5A9bxPFvG0T6oEMnxdJwc4zmbV1VbrM7pwF4IKjiPp+TdSUTlryEZHSr5BqxIdLS+YUT6jhar
 tquh4Ld8wzdmQgTGEAHQQcnhaaMSLtL6/z46L8vQfitM6AX3xAZte6SjzT1iViw2ph/l1DoachX
 Z4qiJtx533/GM9g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c44b0ae51cdf..adc0183b8d3f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -568,16 +568,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {

-- 
2.45.2

