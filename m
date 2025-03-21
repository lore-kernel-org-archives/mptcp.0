Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6661846C
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521541; cv=none; b=rGcvbp6A5S3E3NOeP3e6aEiv12aZepJTxQ9T5fQC+xeVVUplVuSYkd/u2PL++AJBZezQF6ZlHPXBqGeCLkBeT/XvlrdkAMmlhPIH5WFpqPC03eR9CJZWbvW7kHvZztNO+DOUAzOlOQDrRs6Dsmlkj6W6fFW/fHb4ody2otAJyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521541; c=relaxed/simple;
	bh=x32P4JxwbIuxroNAM9CIAKb1pewVJqP1b7gNmR79csQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbLRg4aJH/sk2bo6Go3/WS1eLeCna9XJQFr4rMy35b5AAtxmxMqx129GYZUjKipwLjGmhziIe7BJ1m4uKhJFrFybCOKoM8nq9Sf6pnUJL0a4NMIpdEDm8dTB6PGvQDiA9GHhYQsSJaaVk9UBE2blRVOJzVGeaRyT4DT/TlbF4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwpca79d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwpca79d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF47C4CEEA;
	Fri, 21 Mar 2025 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521540;
	bh=x32P4JxwbIuxroNAM9CIAKb1pewVJqP1b7gNmR79csQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jwpca79ddECu2O4zvWbVrVQYkDaWKlo1C8Co9XmcEAUIPGYYEsqSjDmCuvYrb3RWk
	 TLG7upNbG8lOigNhk2yRqppObZ7IDpnHTDN96sVpYAwZC8kERgdUdDuLZ+wP7pCjyq
	 VwWRlB7y462ErcKAfiNJMTcE5+H99zpsUpsKo7n40aSi9NRRRwlFExjKZbsgr8Xth4
	 MrfOb5l3Bst1jLNDPWys4TxKQhL+xuU5nmOHWlYhZdqJOhZ/crdIELML+nBClrpA7Q
	 0g3Lj674pEqZ1HxBoyGxhBIltn3BWOzPHC0y5srV6EQGjxngiGCyVojZB+tRDfYnMi
	 xY4IckQmtiZPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 01/10] mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
Date: Fri, 21 Mar 2025 09:44:55 +0800
Message-ID: <4923b521502f91e89ae6f4f4e4f1d1971ce8f669.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP_MIB_ADDADDRDROP MIB counter is incremented from both the in-kernel PM
and the userspace PM. This can be called only once to reduce redundant
code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7424582ebf..4895318b94cc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -592,6 +592,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret = 0;
 
 	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
@@ -605,7 +606,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			mptcp_pm_announce_addr(msk, addr, true);
 			mptcp_pm_add_addr_send_ack(msk);
 		} else {
-			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+			ret = -EINVAL;
 		}
 	/* id0 should not have a different address */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
@@ -615,9 +616,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote = *addr;
 	} else {
-		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+		ret = -EINVAL;
 	}
 
+	if (ret)
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+
 	spin_unlock_bh(&pm->lock);
 }
 
-- 
2.43.0

