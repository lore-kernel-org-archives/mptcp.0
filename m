Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738E2E3379
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920344; cv=none; b=JsOSuLka8wf0RJOnrIE3+akKw5plPQB+h/THXckEdfu3m45sr8OxuEcxdbCGoKohTgCD9hL2DKmaipNgLSMoE2/fIT+i7LlaeYrcw5/SucGtrdXpc1I+/MRf7L5En7tOfHQezJ3Xeq3AHt7bk/OyeO1zi76Zea9QUXaeiTb1vl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920344; c=relaxed/simple;
	bh=85ks/A7c17bk/2xpUFa3qFMxjTEYDfN/Hch6nzPeGjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSHaktKg/xN6T4lk+2XZgcV0N4H2uOcTEACw/NeEXs5u3o/5jpdx+8LCljpqHe6AQkgxa6UzKHNx+5LawqpizfmNBBLtsiFf5tyy7Q4Ra7f2Ns+nyPa1e6IOlj2B3FgAxB0LIvUI4bQlwxOoOyQi6D7RWJdksEy1V2o8RkwF2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dORLeh9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dORLeh9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AF4C4CEE9;
	Fri, 14 Mar 2025 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920344;
	bh=85ks/A7c17bk/2xpUFa3qFMxjTEYDfN/Hch6nzPeGjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dORLeh9w5L4o1gJE+qwY5mAJDUvSQAtYM7Oj4zANWfg/au7LkjBrEh4QSId7ROq7t
	 Kh0wCa7OZAdPiTRIzpI7HEtm1jBzIz1qTpU8ilwwfro07M7oGUfLp08zlNNEFecP6G
	 Hs35CLtQsSVrOZ1aZKa9Pwo5WJIoR8jU/XkR89lWEJbxe7T0QMyoRcn8f6rKS5X1px
	 TupMW4MuTh+y+A5Gdf8xT35BeYgs2EP1jrGEEzrO90QgkNmkw1UhddiX6vVKs1OFB4
	 8QVXotk53AKteB23wjVmR/dajfFJPly5VtznIFshLhbd+vrL6tH0YAoan41NvIXepJ
	 x79mZ9RMXs3pQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/10] mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
Date: Fri, 14 Mar 2025 10:45:22 +0800
Message-ID: <7a5ea952636052357b4f10902253a654cf4e29ff.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
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
2.45.2

