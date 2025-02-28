Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B114A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749506; cv=none; b=QSIhvMPQkooldgrR3B6UdSx5Pr24+LAmZHQ/Z/E7slsEfYs0RlG/6iy6iISFquWn4qDZ2YLApMyH1O29nm8yUVCHBw5f1VlG9/D9NHl85VT8+IosoDHN5zFvoD5EIJxjR6WK2QwPbujudaPe0zgtn1HRsgGcdbbFG+QV0NO86+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749506; c=relaxed/simple;
	bh=cn99PhAxx6zvH4ErfJY2NWC6tfvIrJBNaevTPD5cw7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAzNoIUhxWSzUi2YpSokhRYUbvck+yFI69LxmNgsjMo2x5gBrapz4wGL3Q1bCgg4iirHNvsxtH7JxExTHxS73CFk/3JamfJ2yXVTETQCHW3oWIu0cfJLRAllrYe9+4YBbLLaQuKVwj8aOxW8xzNZRHWRyP6CBdIILwacU4pB1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prsUbY4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prsUbY4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3123C4CEE2;
	Fri, 28 Feb 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749506;
	bh=cn99PhAxx6zvH4ErfJY2NWC6tfvIrJBNaevTPD5cw7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=prsUbY4r3g1lAciVRCxbzwDMWwSnDPeJVYWZna46YzfLaUqRKptzI1LmLW+HXwlHB
	 x5yuRnELyBgKu0qnlSUIj3cT2/Zkk+wLE6RS6yT0KLaOC8AAoaYIz6DClxjICfgAzx
	 gwht+KMmCkb7wfLNOsbvZbIErZHHGmWZPENnaUlr8oZhDorl7C+A17+gMyouoXdXzm
	 3HZrDACle1LuF9miT/Iql5Vti3GpdzbbqnlE/DipeW8umpqlSnaRJYptKEL+YwBTmd
	 VKfpq5Cv3QKhEQ97m0fMI0CPLqBJd0NfeBKSwVC6O1mqlo5IEFOlWz2Li3dhfiB829
	 Zr1DJBFJZQbjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:25 +0100
Subject: [PATCH mptcp-next v2 05/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_subflow_chk_stale()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-5-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cn99PhAxx6zvH4ErfJY2NWC6tfvIrJBNaevTPD5cw7U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5coCcMsbjU/IqLDDNT91Cq3e657Pj7O4sL
 RVbgcVYbPyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 cyDpEACBmy0acppXKF6TV4JXMwKin80/RsHrWCjgkR3lw9VSb8uDluUU66z4yIpCFpQ1zeQ6zor
 zgX3MTW3GLu+b6/K8ZGpOL2rC06vy8vPrDzb0aX60zKowyD5WeZUW5vi5MeAd8Ep2EWAjRSRNLs
 ciQAwP8iK1NzMmH6S0RZx0qO6IPNGRbPQGnSCtqhgNkQl90XfWDGOicIYrpRpDS6pIZo0g9ejFq
 2TFFks3/DM/T+ElPYP0JtULykt7TpKiIQMEVT6oRSfZ1tPbFhGvkyZZE1a/zpz5uVxkIrJwc91c
 QjQ6UOuJYpDaRpuEBC9u/6aj3YCe4xXJdvdTh6noKlIlzMJs9t8vjniMdyRcUf8el/V1RwILg+x
 zkACf4m44b45xGjjxd6wI9SsxIOuab6yxCgGF8Rh5eRFfVq4tjzUSc+Z5LyXiyFqP7P+H4wSw/S
 COiPxtcfwjj01gXZxLFVMb+227+4uOp8X2hY52YhRO9Qni+hqx1yk5cg9C8lPDEFY31Hfi90CLG
 IAQYrRizsdF1vRCtaUlGIrUvO6y50QgkabkKgx5/IE9jgM9vBFp0U6WxwMIum9TnqTaxUoX5kYP
 Dxm6y2+WbNhWRrliJYvWMT/94wD/Pq7xpDhxrfrt87qNv+MKr33+Y3cFR7HqkNzr4Cz0lzUB8yB
 miW8WvUIX1mnp0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_subflow_chk_stale' is not specific
to this PM: it is called from pm.c for both the in-kernel and userspace
PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 2 +-
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ece706e8ed22bfd10249f6e655a0d790dcee34c1..14c7ff5c606c4ad4b12ff5cbe96c1f2426fbd9c9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -567,7 +567,7 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
 		if (subflow->stale_count < U8_MAX)
 			subflow->stale_count++;
-		mptcp_pm_nl_subflow_chk_stale(msk, ssk);
+		mptcp_pm_subflows_chk_stale(msk, ssk);
 	} else {
 		subflow->stale_count = 0;
 		mptcp_subflow_set_active(subflow);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09ef3aa025e7094392badfcc24a964c0a530ca5d..43667ad4c4aeb6eb018d18849ff14b600a21816f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1203,7 +1203,7 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index be4d02b9510df06c2795ece6b999bee1c08aa981..984de2bb8d8715caa73db3b124f30ef68ff2284e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -997,7 +997,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);

-- 
2.47.1

