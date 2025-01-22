Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB99212D6F
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554156; cv=none; b=i7aYU4pfO+ty8Ao2anW0UqsqQdoKKRtrJRYCY7U5f762Sw1s3lZ09g5uBowONyXBpp31bTnZGDJfCEDgGz8qImv2k9/aV8mORD7VNPUUSLEr06JAxFxBpQdmpywH0RXQ139unHHwSiobz1bI15Aq0Gd/Yl5xcVQ/x+EHLzPFGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554156; c=relaxed/simple;
	bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASBCuiwPME1hGoXx7bnjV67A7sOw7eD7wqZ9wo+Sp14V4EMeINAJckn3RlGbdTY033v0XQd5YFIdG2CZzbRN2sBOknXvGxnP4sYcm2lAwCC8Z6eIigSqgE2Xa1e/xSIjft2gDn3UD7UhR+FRKf7o9z29ZMWWZ8kLyt4u/bhfpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGxNVaIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGxNVaIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA362C4CED3;
	Wed, 22 Jan 2025 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737554155;
	bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGxNVaILEhTvFbEv7WQM7CSDPwAfvZ4xR6kD0yBO0/MNL5SYCGb01cNgJyPaQLQX3
	 YL5RBGK9HiX/fgbBdGIfwnZDUEPyIPdygJfsn3woLJn7FNs32B/MZ0uGthfzN750km
	 NSBGw8WYnEpkKuUSKRVcGkbNk46ImaUNeuWVTq/qhvnVq2ezy6RhILt1zE4yHXG5sK
	 nRgnJlJVJeuoNGPap2i/RddPnAVsN90PjxPyKTKB42ZzN5jV5/93THzDYw/9ZRlbRF
	 oExodvcH1zXW7cGvaN0NsaS0Yxbx7cpGs1p5qdLXaPnFofsvHFySlwpF2B+UkEKVBN
	 YRWSHKVD35y+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jan 2025 13:31:44 +0100
Subject: [PATCH mptcp-next v3 1/2] mptcp: pm: remove unused ret value to
 set flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-mptcp-issue-540-v3-1-4aeed3022f23@kernel.org>
References: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
In-Reply-To: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkPjo4S6lKGRCRa6nAwELV0Zv6AMbGH7OI4j70
 ZlO4ah/mwqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5D46AAKCRD2t4JPQmmg
 c4R1D/490PSxwDwiToOF+tm8ad6oALJysR1PIqPXuuIWPXIt22S+bLU4Ei9iGWHJhgzRwdv3dKt
 cZayqjW19rWzYF10DAoNOjVK4Di92XSwfdYaIbWG2kBvxXEyy5uRfLyolqIcdhBZbAeswEqYKWw
 9xHt9wpp6g9rM4K//0BG7yBP5vT3NnX+SxonHs0ezPvzZLmnspc0D8rt+832VraorUnwwfT9E0z
 1txgrEBEk1k7M3M7IiznM42GhVoc80MwuQg5wCNieHyBPIdOCRJahYpW1cgN3LSF/tJ2xFuZEfb
 Xx9T1vbBM0AZWcaNPZXSUeFmEZ53nmPdUZ4GgyeVX+MCJtqzouULZm3pX94VF5PgU/+TgaNxisE
 ULxYmLbr3ESq5qg/Ssr8q06YjOnNsM0mScpiz/w4mUbFnH6u6R90rzfZHBmOcEpywaA0X29CIuW
 yqZiK+hOQxk+/a7atyBOky10WvHJQrTQqJhHYGqwQsoOM/kmjEKoDr0lwo7IzTXcOoRU6wSA9Nw
 E8qsCycH/EHkPsmkvpttHzPkMQAiRp/EvpUiMG6F0lTqvcw1ln+xQYx9rnEVxslMMxBJz6bF3cq
 B93uWa5s420N5IWDbspBaRLRDeg+PAyDNWmebjAXD/33tg4c0Zw79n1QRpHggrTCrOdvhV8Qf3u
 JGpaT/D20qN4ssA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The returned value is not used, it can then be dropped.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 99705a9c2238c6be96e320e8cd1d12bfa0e0e7f0..ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1922,13 +1922,11 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static int mptcp_nl_set_flags(struct net *net,
-			      struct mptcp_addr_info *addr,
-			      u8 bkup, u8 changed)
+static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
+			       u8 bkup, u8 changed)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
-	int ret = -EINVAL;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
@@ -1938,7 +1936,7 @@ static int mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
+			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
@@ -1948,7 +1946,7 @@ static int mptcp_nl_set_flags(struct net *net,
 		cond_resched();
 	}
 
-	return ret;
+	return;
 }
 
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,

-- 
2.47.1

