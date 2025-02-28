Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03714A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749502; cv=none; b=oepC1jpqLmWo8ka9Zw/epxeucN5V6ltnItvNCofIJC4Efjyt3cO4K9HWXsbWy9muQVS4ITwzD/yF8/9scQHeS1KztqEhzhE8etKXCWBkeHEIW5aGGJDuIegIk5C88tVb3kzpd9vjeKXXb8gIIZkBR3jIwUuoiS3ZbcC+M4mibsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749502; c=relaxed/simple;
	bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvYScPeEiw6RYdWarGLXM1NoeXMYlhMaZeuzAQ28tjYJY2b89CtFRxLdNVaoCHvSUAupJoX7C2firwYgex8NFW0EpWYATbm35cjIHiKifJ06qwbqe7/Oz4oEEEQTCIgpbJWo/h8tGTGz2TkLIhds8CCNVPfxlnfEJ2G7t8Jmmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxRrE3xx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxRrE3xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25408C4CEE2;
	Fri, 28 Feb 2025 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749501;
	bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hxRrE3xxlKNFwyGTvg27EO9775JOE2d/C3VdScbHjhBRen9KH7Wdu730qOPt2Yvss
	 pMBGjHrtuP9Jd6zcL/sg8etEpQoW6AvU63OP060/1X7Xkyu9xF1uMyRhCzBKFwQh0n
	 JAXF7LP6p5BhNGgDwD7MNc8VO9JrZey6FSz+OaSwuuTCwUuBfrR/0kGzWJRFq8g3LB
	 SMBVMO2xAeY4PCwYQpxsaAOy4AkkoemMb2kUWnjfKaBWEgnELP8UrQbArv/eHe5Q9+
	 SKEQ8oBykYbJ95n3+wa8lYgabMYMAFRRgWTy2V6QqordLL0JrRoN7HV4ihjV1jVKvC
	 Up3T3eJYG+diw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:21 +0100
Subject: [PATCH mptcp-next v2 01/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_addr_send_ack
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-1-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5uVTrueQzHRGf7trse0DF7d8Ea6tlbcppB
 qXndda3ZpGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 cxoyEADmBp8XsLaSsdhS0xj8fzfg6eRyXtSvyLXfJ9EQExZnt364OBlJjKa0gv1b7pyZ0DBpn6g
 RklD3gtrsW+bTfSlwsb9FQ3HPcVegvxCyCKbplSfvE6sbm3GIYAYKvSk3hJXRhAKPN5XhKm9s7T
 AEuhu54tzdCx7zzeKJze8SCzFda7P4/3veRGlH+IGE0VkiD2KSyXQJ4g2Th0V+LzK7j/D5IaPxY
 Wjf1ex1iUcmUjL3Pgx0U6vy+MIpSZCT8LTE6EarPkSNsQC4gbQ0SYAIg2YQd6AzjSeKyuR2vrQF
 5thTV4uXZu0YZ+MIot9eTdJBKAnh57aKclK5P59DQlcuEZ+QeS/bvs59vS65wxN7RYZGBtEOc8r
 gFlXQjWYxiwD+z9Se6zAFjHFOxQo9LkZmgE6s+Nhqt6WNKnCVrI6OlgeS7SZGCCnWUM5YINKo4k
 avvTCGr1ZyXFlgu7MJNSk4XiDYJY6S2WHCxxVYkOrw8YCTsYLhqvMLknMeRoGAxa6+8LW2zEreh
 u8pj0975ZtAEXlOy1V/lLK4tq27tS9ocxHFlEB2NOUCF9uQ1W19iqyK0SogqOfa+L/W8kK6nvBO
 Tcr/E+I2xoLVzAGc77gemGTDZ4KWk8Z6jS+WD9mPQht0r9yM85VaIwQoNmlSjrjnaAZIdttZOnK
 wMsU0RtPsgDVbUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_addr_send_ack()' is not specific
to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f6030ce04efdf20b512b3445fb909b4dec386b1a..ece706e8ed22bfd10249f6e655a0d790dcee34c1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -57,7 +57,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 23c28e37ab8f1befb391894e465635ee523d54ed..a70a688eae845c562c03caa0f3e20169c5f5be11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -606,7 +606,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			local.addr.id = 0;
 
 		mptcp_pm_announce_addr(msk, &local.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 
 		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			signal_and_subflow = true;
@@ -740,7 +740,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		return;
@@ -781,7 +781,7 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *alt = NULL;
 
@@ -942,7 +942,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be6de9d1b74f60088b508bb5f57d52..fbb29a9eb19125ea29f557e97123488689bfb3ce 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -235,7 +235,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef1d43406f9bd87f2ea0c7d31f4ef9ea4d9ea9c6..b8800fd208429df43869c40e5f67f110d9584332 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,7 +1013,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *remote);
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);

-- 
2.47.1

