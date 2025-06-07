Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D51F1315
	for <mptcp@lists.linux.dev>; Sat,  7 Jun 2025 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286508; cv=none; b=EfB4L12gidbYjUeO2yrXYSbeDwBskg6oRBdxjhAw/7Tjztta4dApwK6sNCVngo16zL9VGdmfeYhzdf7yyRSjyJvfQEXrPsnoX5ouVPoZVJN9jxxCXx6V0e8Tpp29cLblLQnwRuvk2JV9hCK/B5NJbMH3uRlt5ww/CEctER033dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286508; c=relaxed/simple;
	bh=rlPWFbDGn4rfSud+FUNzK8GGdubOHWA050mN1hGDH4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzti6vlGrVXB456voIfxbSkuNW+1fnHbyNzDaGVMCep+291cNTcurOWIIW9Vsn+1O1CJa3PgHcTAY3sqeef63lBW6B9vykEKCPwrK3+svKCmT8s4a+CHtg7BYbheYt5ua4SVUwfyUyq/Li+uIgusQlgF37noCBL8XtvWMuKdO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9YWWeX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9YWWeX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC33C4CEED;
	Sat,  7 Jun 2025 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749286508;
	bh=rlPWFbDGn4rfSud+FUNzK8GGdubOHWA050mN1hGDH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9YWWeX9XYykvKixxJpFyHlgCl0GxMvCTRHzdsYvISP4i9qUg0p0ts4VqagHoQh8g
	 l2ieUY34W3l2QwFpvKcNCb7Eu5c8Ar1X7xHHOzeJ2zsCFtgdG7/VSxRWuh98RosRE5
	 Xs9yjPNC5GRbMKd1GPBz1qEiQ3fcg7BtJsdlR1Ytt0LpEaOjfIqs4XMD1wjLse4aCB
	 Oza5oeU4nIGyounTQnL16Zl1g305LHyf/IRug5SlEINV5WIA+sMbhnAdBqBTRv3oUh
	 jywvBCkq12h27IkrnPFz1BMxSJMn4jy05S7ZRm70mVUBomj9mkhfN+HxsEYs6eC41z
	 yaooxJ1Mb83KA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/4] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Sat,  7 Jun 2025 08:54:16 +0000
Message-ID: <1da1c1ea356769ec72d0d0b211bb76770bc7e527.1749286212.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749286212.git.tanggeliang@kylinos.cn>
References: <cover.1749286212.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses sk_eat_skb() helper in __mptcp_recvmsg_mskq() instead of
open-coding it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a52c127b60a..7fc940a60b3d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1890,8 +1890,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 			skb->destructor = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			sk_eat_skb(sk, skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.43.0

