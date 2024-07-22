Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EE171094
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676957; cv=none; b=LAQJYwGmiS2TFP2OQkm6NhP6E8+k9a/81eZo3wytYWSQkXPe3qMtb+Rinz7k6WUZJyPE2V9kIAzeBvqRqRtRaEhu4k4cYcA0uvOwzdpczAKzDjwYYycKr2Dr/2NksZN6qhy85kb/CDt46Kq5Ac0/+p2ugFFF9L6qd1gDAMVptQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676957; c=relaxed/simple;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVyVvwRyAg4aoROE0AcMTPOPcFXacVKLnLCwWhnmmgJiGF7LJvcTIzIR7qlfrCpmeMQ73wyR5jnkxRVrI2XUgej8j+opmmPOAa4EQdn6OXrA/SjbDxiRNlnMIpKISthVfsRMA3JIbsAVnQLaEqp6mIHzkToyKzw5IVSsWkRuN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNbuWlrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNbuWlrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6347EC116B1;
	Mon, 22 Jul 2024 19:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676957;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YNbuWlrRyo5Uyj9zNOwW0WVA/tikXUDh0XK62vlKwECB/7tgc12+XM+k6jmn7fBAG
	 q5ypFd+NDOpma2HcpLX/cLAyX/2eASKQmKG23jbyJXfJHAoo0iRgYkKWG7dYoPUZDa
	 zw7IwTLNunoOF5LfHefrE+ac5var+XrJCb3Ku2Vdz8rIY0bz1pQStvZgYqDKfSoszf
	 9JvcNErQJc7Y8QvqgnsASw4rfvfsnWYOBs/HE7LuyacfCMyFPaTJaR4DAaUMWa34mx
	 ScsHNFnc95t1tWgNAGDP8wB5jAjjzhpbgBZUHDsLUdimlOi0k3qEtdCWLUG2b5PGNj
	 3xCDCaXP9JOtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:42 +0200
Subject: [PATCH mptcp-net v4 04/23] mptcp: pm: don't try to create sf if
 alloc failed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-4-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWI3HG3wH+y11jUYGHOtc5Yz8etTEoOCc8e
 PbvIVZ/8lWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c5FtD/9OmAgWtE/iViYQv9Nmq4CPf5Co7mWq2WOvOma7vnkqJmsnhmi6WNSbYMhDQh5+/Ngd+xo
 wGE1tDuxywbUHYmYIefZ9r14f8qAwWy7tbH9fknLP6/GJT/ODtOz5HrJBSvR4Ywb6WBix/Cw2Co
 cGp66CymUZeRmfF4Qp80mmWo9SQJCOQKDSfnJBgsy7AsI22LiqO4aa1VUIUpQNun1I77OolxiWJ
 OTHsMAJ9ECptlfknET7nfKyXLifPFMTGVkelcQaMQw4EnsAH1Hv0skY6kEMl5vgpEPpS6Zq/dG/
 NQepZmH1Yy5hkh/lHQkmKqkkxqOK+gwcSbT9oUdaZmHGYvJyRNNhfBfTc8bjiIHhBhMFxksKd/W
 fCMzjYW/x2pE5Cwhpx/FYD2CL9gtdC2k3jF0D4X5LXGYuw1bCNO2DN/jZKAYJUmJ4we/31GARpy
 JhTiai4TgIm9SbmbAlbqrrOb8CpG/kz/RC8g8RDgCybFAGK0bQ0u4cqvyfRnPLcQFSZCeSjyJa/
 VWhtVXe2bc3fB1Cp2FtMWkbjJP8kx59ppZpv3I3eZOhuMyFDeaZsyVjrwQaljf4eh5mUsnA72aI
 6Vc01rF5cTZ40V/NtxK1Eew5BxAmomiVsVlEyJBpux287h7y7xW98B38jysNvLrp2l6e55JGzsH
 gHHr836XUME854w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index adc0183b8d3f..0ca6b358ab51 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -348,7 +348,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -556,8 +556,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -568,11 +566,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;

-- 
2.45.2

