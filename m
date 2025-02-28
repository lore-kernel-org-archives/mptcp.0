Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCA14A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749508; cv=none; b=CzXJD9eMhjCkKBjM720sHpD46aFzj95dIRlm0uX8i5+9mFaoyOMU6jisco+IaPpwPlWrYK+tldRmIGO7t/7/kvrMhfWXFE9QpTtdA1TyRUQiN4L44ylg20McSnY1P3t3WGYVkjZBKgRIGq9fgtEfFkRzmkpWoq4LVMynnqdXmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749508; c=relaxed/simple;
	bh=Qks4HpbCgZw1OMzEuFgKW2nSklsXlmPVyAuGYfkRgpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXHhsMKggGLBNbaG0ePU8m/SKXKot7DkoXfOmNmz3nUcBLDrxKuEht3aPyJHFUxCHlV/mfpCIPuD7Zb4A0DxgyWXIEEz+9HPOuFWnf/M5lQFVyzdwXaec7dnmXonG+UNydk+Jl7vMab6KdAOUOU3SuwmXkOcQjkAUQl8YRhxBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jsdo4sij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jsdo4sij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A6BC4CEE2;
	Fri, 28 Feb 2025 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749507;
	bh=Qks4HpbCgZw1OMzEuFgKW2nSklsXlmPVyAuGYfkRgpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jsdo4sij9p62nsMumxhYhFplyOmD5qN9jsF7zBLlWErpMmUeIWrfZ8ReT17bmwcvt
	 Xc2z9QPNh1r9xEGdaj0SI8N8GUD2+EmyJJ9sjN95C4tnSyNwtoaT6Ht+9tqSXkDFsL
	 IJ4wt9UnI5u4vgDR2AKN61FXabVNHRIaKQv3h/eKeZdUztbinOaoXtqGo7K0q4y1EM
	 oWN/odt9nBvbOKJ+HEpPdff/3QBcqQ1a1GZr/zIiInpohfUJDYzqTa0ll7+2OuJLC5
	 y2czbJkOYVk+i3kBhbjZQF2jBz6B2T84TPI8ukxc1qIxMAOlzwCSw0QQFCQE3bVQE4
	 sPiBKIzIHbnrw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:26 +0100
Subject: [PATCH mptcp-next v2 06/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_is_init_remote_addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-6-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Qks4HpbCgZw1OMzEuFgKW2nSklsXlmPVyAuGYfkRgpc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq622+26T9nSIPVyv2puhJLBDRZGB6CI87fN
 hvTOl2t7rSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 cwUuEADu0CGRKUx36v6TTNjyB5+3GyFYKBhSx9jVj8SVPgD0DzND9MfiWdEm/LmF4T3l75erdx0
 gdusIixiuO7ncyXjjSDjukKZhyKM5MhxYGEKY6D7SFKVzgZNAPe592x5W6361xO9vPlTG/p+Awx
 nbtpUGsUjOrZ6BUzuiZXe+wGErXpHCVRpXaPI6ilgNyujSc7mZwb8M3XrN0igFK2QjVOGYYT9NF
 0GAYy6pomCdINV8tPUkBw8pcbC31PnOdahNCkNhjUgkptTG1Qz9uZZG6oeumQFZivT2++99cmUe
 4tBusV7vFh5s8rmxQ0TnY2v7NTU4QjAvjqB/zH5rpotv2Zc4YN5DaxhVIm/RmamPdvIqnKniyM2
 qOtYxnH7Fvq14PpPHdp1YzYaiV2c78mR3QyR8C5sKGBIQuWEevgTZnIC6n+W/ll966Dr4E5VStx
 4Iph2g29Gwh/aHZgzlx6+32ijWLjKkufHMUNlTP6hJu+GKrVMk0jITiyPazsRRN/IGE5A+AWWFS
 Zd3nK6x4YMEo5/O5vg+CgiXHQLhwSFcQBxB9bfSCiIE9Z96xpuNHWH1W1fJtAiiJiVWa4zw6esv
 JWCjW1ZAXhxARsxeWpRjrkBMTvZ7OXalW8slMTy8tqTobOIb2BNWSQBjphqVMURfS/5v/MSIEuB
 PEckvr3n70DRBHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_is_init_remote_addr' is not
specific to this PM: it is called from pm.c for both the in-kernel and
userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 2 +-
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 14c7ff5c606c4ad4b12ff5cbe96c1f2426fbd9c9..ab443b9f9c5f28e34791fa75ce42ee013ed70d78 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -231,7 +231,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
 	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 43667ad4c4aeb6eb018d18849ff14b600a21816f..029a74162b0bce0d3f34f0aeb854ef1b99c020dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -772,8 +772,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote)
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote)
 {
 	struct mptcp_addr_info mpc_remote;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 984de2bb8d8715caa73db3b124f30ef68ff2284e..5e9708e4416da6dd4dfa2269436a4943bdb1c903 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1011,8 +1011,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote);
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);

-- 
2.47.1

