Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33618FC9D
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481819; cv=none; b=KGk/Nm8u/TMB0luNvMT/VjB9hjlo8Gptn7jBHjL7r4UMBkudLXdXYFMA23Q7X9sqfvCgqgJX5WmSpDUPhjmXuSIVWIDnwSsx0BTzCmuYbEcVizj2OdUFcPuhbDfUmykRJ5jaTNLNRcqAAjYcVgjyHiSva9SntI2Rtj9Ovv0fTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481819; c=relaxed/simple;
	bh=vHtAa3nM/zZD0isUYfhzEiHNsZPc8HB1lHvljXHsHsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l//hueFhR0neigipF8wuhFhThT4vMnqqFflf1hJzBOUmSkn4kOL1RMugO6wNTRQA163bOfFkRv2azbgDrNSP2iBEDTcGhATSm4oQYdCQK/EquSSRglnkHfP0ZwHL/4EHAW5bYfzSZ8OrjjCDyzPOOtq4R6O/sBtYH5nsIkMwe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAlMHHMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAlMHHMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A73C4CEE8;
	Tue,  1 Apr 2025 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743481818;
	bh=vHtAa3nM/zZD0isUYfhzEiHNsZPc8HB1lHvljXHsHsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAlMHHMwn8dVRChmd17es203QZiS57N8bG72EvRjAugpkQLNGVRMVwpnhdwkDI591
	 9rVViNiFfJwMwU1NBSZ7C66wfoFE6pxjGJldWIG6LPqPbfECikGvoGJtaZmimGlq4r
	 8EJ0x8weripDDBEfbpnY9I10LQYSmKoZQX7IgsxXAns7aQGxINFTge6UfM/DLIvmy7
	 JrqMSJEEnPhxWp1vOsbtGEa8JSKueklW6vuE6nmg86ErQ54ajpmBgHPvZtd6uN33ET
	 XejqwopBrh8C7Fg5VZmAGsHhaHrKwGMsIeZS4R89kxVFcbgTP1JrdpIPPtVZRBj7UJ
	 aWivlGcTHFRHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/4] mptcp: pm: add accept_address helper
Date: Tue,  1 Apr 2025 12:30:08 +0800
Message-ID: <26c904d198ab1a642f947e65a4f9bac40771a1b9.1743481566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743481566.git.tanggeliang@kylinos.cn>
References: <cover.1743481566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the code in mptcp_pm_add_addr_received() to test whether the
address can be accepted into a new helper mptcp_pm_accept_address()
to simplify the code.

For this, mptcp_pm_is_init_remote_addr() needs to be exported in
protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       |  8 +++-----
 net/mptcp/protocol.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d576b03a64e1..f37ddd6111de 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -104,8 +104,8 @@ void mptcp_remote_address(const struct sock_common *skc,
 #endif
 }
 
-static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
-					 const struct mptcp_addr_info *remote)
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote)
 {
 	struct mptcp_addr_info mpc_remote;
 
@@ -598,9 +598,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+	} else if (!mptcp_pm_accept_address(msk, addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 134b46b53014..910d422d64fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1015,6 +1015,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
@@ -1209,6 +1211,14 @@ static inline bool mptcp_pm_accept_subflow(struct mptcp_sock *msk)
 	return ret;
 }
 
+static inline bool mptcp_pm_accept_address(struct mptcp_sock *msk,
+					   const struct mptcp_addr_info *addr)
+{
+	/* id0 should not have a different address */
+	return !((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
+		 (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr)));
+}
+
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
-- 
2.43.0

