Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7A2853FF
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905802; cv=none; b=sGRQHrnLTXeBSJo4Dfvdj+2LqIh2rFCIqgo4rsQGSBQETnR6Z4oJLx7+NIg8bxE7yammOtDRUOCp8x+oKC+6bwalQC9jX7bbHTqykan0v7tlzJ3mmg9e4RqpAFj8u79TDWZ9EVWQfkrxOWEJyQWB5crEtUSAp7HSUaeiN1GVP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905802; c=relaxed/simple;
	bh=L1q3r6EMn8Ogho9rDR3IHeldc4308SoVsIShnd+VMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbtJe7stuIYUVJ9/NqlpYsm49pOOdc9xHXtKcC03pbB7I27cyhBNcrKKdPs3zoZnY7Si7jJLRCSJieVlCSvdzj9i58auvPjG1FrTBSVYugzAmLZj22cNF95N2/MjldUICz3YLPAu05hZHtOo/4p3beO+2CUHTqAcVvJYMugScks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRj0CYH3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRj0CYH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287C4C4CEED;
	Thu, 22 May 2025 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747905800;
	bh=L1q3r6EMn8Ogho9rDR3IHeldc4308SoVsIShnd+VMwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRj0CYH3Cly7K+NUITvT7W1dI/729aLGO1YBYi+cjHj8dUe5RDCYnWUZVYG4dmczy
	 9nIIn3EDNDur7eX+3ogLTWhnmFkm8g8z/vKmLSJKP52Gq8ZtPNmfeUcndwiFeJcr9e
	 N/9Vl5WR2OtYYm1KbC5ZiYTSgjS7oSEQ6qKPSgz3TBaul/T/FawTcX5iRsqX+Zuvi5
	 u1spmh0YUUIiJ1m9EdAoxbVYsGjh7f3z/4Q44qzWfngeM4Pofw9hMs/ON2WsCZIOyP
	 ED2lcfdAI5GZ2SEF3rWI7H0iO+1VkNAXr6d/3Vqvg4JDqwRNXuckFx9spqOymFOSGW
	 1piuosdeKtGmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: hare@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Thu, 22 May 2025 17:21:32 +0800
Message-ID: <8cd87b3b0b0345caf64883b0bd4d3379a50b2bd7.1747904572.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747904572.git.tanggeliang@kylinos.cn>
References: <cover.1747904572.git.tanggeliang@kylinos.cn>
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
index 2c2618a56b64..a9094cd8bcd0 100644
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

