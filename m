Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253B271298
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686943; cv=none; b=HKh73fxK7meTe1YMGm6PeLKFyJ1gvqNWil2WSl8ubqTfafxHAydL6yJsylcdL6173Y2J+f3RuPRw2iw+OWzwtsLcrRqf92ZXy4L2pOL8Bs+LbBxtkuZ6IZlonq3ehw+qIv3eNf/rRftbcBN1rKRlnCjI5jlrQ3L6f9rkv/MuIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686943; c=relaxed/simple;
	bh=0wIyCmNgwPX++HVmZPo5uOdO7P19U7OkHLX/gasw7pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWRXrY2PE2Kv2SzRD/Vc6HlZGto2E3+b21SpdJ0PCh7OzP1QkCMzFk/hwpiOIrOq5fk/Sx7emQyVILO7WHy2GZSJMBlZQ43iCkc1Ci44POAIc4KegYIG7983Mdv3Pe+M3EowRXs5Ui9sBep4jIa8bLd0HJ8V9wDrowqlD1SLvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6QEXd/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6QEXd/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6475CC4CEE8;
	Thu, 27 Feb 2025 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686943;
	bh=0wIyCmNgwPX++HVmZPo5uOdO7P19U7OkHLX/gasw7pE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X6QEXd/KIXiKvCFv348QiaK8eP+gQ/mTGvc/vnk8r1uDd1HnZFmH362wXvIiYvZu+
	 92teS/v4X7/cU1ubWI+ZrKLt8a+1R1mFwDaoUNe1FkZE+D8iPXFkrb8Dbgnc8uk40d
	 5CAyMBWUvacdoZKuLwnNbOA6mLtlsFIhXQifpD01Q9OJtI+GH3dZbmktH+9euD0+YC
	 icnqetZinYOkA2IaoYVxsWJ0QQTZA1tkYmbxibmEg+un4crjg6syPJ0bmjb8zoZY4C
	 jUxM/kGCAhFfWsvnkJrO4XiYh87lN9AqKn3p37Qq7n/8cjaexf7CL59KZCvke5ZrKk
	 Hn8HcDpXHdhXQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:51 +0100
Subject: [PATCH mptcp-next 4/7] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_rm_addr_or_subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-4-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0wIyCmNgwPX++HVmZPo5uOdO7P19U7OkHLX/gasw7pE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZY6Qi9wrvIXI1HGPZQBy49xqNeC0Q+KzzUN
 GT7mKi6gvGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 cyiLEADsPid28mWu4EyR7YNhwnaejNXkdaHgH4lHvRZZAfWPrf4ZWKxfAA+25hDa8LawpkSK7lS
 1IHBec9QGy/qscLB/qWoWhmfJhT/ejwKVYUGX58zLuRs/NQz78AD1jFxFIKli1B35F0zLRlVmRf
 EJduJxHHLMMhpBiqtX+Ru0hUCvjUH67gFhKb51nKrBaceZTWBuxWiTIbUR57BAHcsvCT/A6cSak
 bLO9ySZPIax7Mzizt+6jcM7A/p6u8fCvFeYUCDuuRtsZ3yRqgS7SzOd7BfzSUC9eo0/naZ7lUTj
 j3fGkznLyckasSDGDu7Rp1ro+eNvy+2rDkjp/NoQOBemeVd479Wh80Dkay07ugsqw+Txmr12Ep/
 PilJnK6kmY9JwYQ630WCpe8VZo+C1+GUfd2I+ail5HyhbqWOQXsQRdNbFpqFnTTt4tdR/YavrON
 2dI/Xb1rF1wXXDodRnNqMwxuayQ3MCGg01dpWA7yQmCbmqDPeZSIURdh1XE4kK9uHBVbMea1g2F
 NGzKL3baRSpWKeiI+kU1C5LHs6gObqKUA5nRwZSZgULH838tlqfWNHePxJucaAkPR+rvA5xfjb/
 QNr8gP0gZtsOVS3v8efO8s+iWWjwC07zcGka3BBE21r3dpEOLldVknRRzpExRMQpE8D77+mxWlh
 bdFGVD3YwNZtKtA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_rm_addr_or_subflow' and
'mptcp_pm_nl_rm_addr_received' are not specific to this PM: the latter
is called from the PM worker, and used by both the in-kernel and
userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f6f7ea25640b7f0f71fc6cc3217ea278e15a4c13..44362b0f7ee4f131482705439eb96c0374177c1d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,9 +838,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
-					   const struct mptcp_rm_list *rm_list,
-					   enum linux_mptcp_mib_field rm_type)
+static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
+					const struct mptcp_rm_list *rm_list,
+					enum linux_mptcp_mib_field rm_type)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -913,15 +913,15 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	}
 }
 
-static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
 static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 					    const struct mptcp_rm_list *rm_list)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
+	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
 void mptcp_pm_worker(struct mptcp_sock *msk)
@@ -946,7 +946,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_nl_rm_addr_received(msk);
+		mptcp_pm_rm_addr_recv(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);

-- 
2.47.1

