Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC41AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622672; cv=none; b=LKZDXzLGk6WP009K4rTMOXaxRT1zyhcvr6eWJH/SKSdFAC0HX91246AkanYTmqLjnfnziRKKoJfW/PNPRvUVAo6VG/W8X/kGIuG7lKiMn9Y9wQKGTcBFIozplRdqTi51Lc89UyzcoOch+XkKNPHoIejChAlcjlDYXDrWi2Ae1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622672; c=relaxed/simple;
	bh=jzCnTdKEaBj2I6Ig7Wb5w18r5QTMqq2lxNKRica19fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvHI6C34EgYLzYwsH19m/Q9GBh9supAX9qVW7aAoFrk2vgMdKbsi0zxC25LhGfzD3RTFuiTA9eXOHqBaa2ko43+B/YMnEOpnx0KUVGhz0KHiyWlyIPVHGFlFFXmcNBn3mFC+WU+l9vxoNE0AIWSHXA1L1coskW2mS/0R5zLgHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDeNR6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDeNR6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196CFC4AF09;
	Fri,  2 Aug 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622671;
	bh=jzCnTdKEaBj2I6Ig7Wb5w18r5QTMqq2lxNKRica19fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dYDeNR6zlfGcodJfrg7AqGRq82Xtg8Zc+kuxSbzM3uQRLSFTkUL5XPcpiTTgRnkF0
	 YvseCEmPOyEWyf76E3E6JrpVZwMKCcRq5qZLxfSStChV0HdPuh8YhY/BnyNvlQLXfi
	 a8epL4NGSEg1ZnlSNVIfGtnkIXHlhtSFM04rLBaOJ7D/dT+ZjUy0oM5BCpD6yXYmo+
	 PVJF0PvmARimMO8MlbnYDegFF3CW0GkwUAZU/dz/zYodGETCFSaOWVvLCXjymMV7YZ
	 C2X1hY/iPb/DDBaaN41WLPF6gUrGmVY+GJURPIuo9kxGmi8Wad9KlakGYYM1eYw6ax
	 aDUvE/gPvBC7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:39 +0200
Subject: [PATCH mptcp-net v6 02/11] Squash to "mptcp: pm: fullmesh: select
 the right ID later"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-2-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jzCnTdKEaBj2I6Ig7Wb5w18r5QTMqq2lxNKRica19fo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLKEwdkKDyvXNgL512S/SCDLP5ME7QgMsRoD
 59zSk8/Q3mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iygAKCRD2t4JPQmmg
 c58PD/9f6Ae1z0oK0hijlOe45OUiHRLPRedUg6SMOqQP46/gNbSRf68NywsX3TFJUDTvNUme6EC
 IUUhNwN/+JiwucQSHY7oAHneAmnJKbXihfqNerUjstJCxHuXcolIqQuk2q3VktJPA7KeVs0TMj3
 JonHBnkBb6/8Ym/FXM6NMFV5CHEGynB28FQmJ9ga15xy4Lm3lahMKEjC4sCT6ZC4nuhaAzkqk3D
 BfqstoDjJg4GaXcW7IhMeJqbbbHWISky3iV4uJNKjv9gO+wIQXQZdED/NN/FAb1Cz1JH2sCkq3V
 O6i7/fH579EGPM55NBX7g+MVZSnHcKgOswtu6knZZrZrlHJgXejqb9P9s/ZcXc7glJCZI9WzAMo
 25tMPjUcBNk+TINrgCTM4yHdjHBdStPBh5qenWP9bl1cJThlGB8mjYlnm4O8hpuM+DAAqoRpfJh
 wDTliP0H5Yx4FgTtHkfj+FeILV7Gbw/elpaaxxUm0QCeoOReVHaqeqazkXOelILdcflKJ1Yrxuy
 9x3mIBwcALIuIMhNiCb3kX8B6/GnWc77MqZ+78NzI8EV9Wjj5qOwHZoIjuMLKl+sWRsnWS1ZnUg
 L8IpTF20QOcXui0PS3boc74OJ58DZYuhZAKxHUJV9SQkcQavboK0N0nIC2fvAmM3n24qD1XnhXd
 HgiDKKulyxtZ8WA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

We don't need to depend on msk->first to get the source address of the
initial subflow: it can be retrieved from the msk itself.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e552b4f1a21..605cfd7bc004 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -661,8 +661,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	if (msk->first)
-		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -678,8 +677,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			locals[i].ifindex = entry->ifindex;
 
 			/* Special case for ID0: set the correct ID */
-			if (msk->first &&
-			    mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
 				locals[i].addr.id = 0;
 
 			msk->pm.subflows++;

-- 
2.45.2

