Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFD25BF08
	for <mptcp@lists.linux.dev>; Thu, 26 Jun 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927325; cv=none; b=HdBM7wSjyy4dAonJ3wxgx+Ek2dHCeZYrL2IQBXpAYlYt7dTa0dBTy4vKEHMZ2dtxmBTcQHSV4coNqzjlAKFKPwHkoneeLG/kUHsC/eJt9E5CwZNlW0yxW4HiWd1OAGdm41Q2ABCleRGPqpFELwRn+vz3n/fylOPlFiRr7YeofSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927325; c=relaxed/simple;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2XcpRaTMJSWpE4N35+JpoxZvsho4Cv8HhkSSPxN8QtHiwXwx5cwTfl8bT1bJdQxEmgtj8lKCldB9vpEHcXoSwHjVnEyYMv1pMzhckT0GUZo51OIk0ReE0X/d6ztx+d8pUv/JS7uINhpaX+O4/au3ZTi69GVthyOm3d9PF4+/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhxT6E6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhxT6E6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368F9C4CEEE;
	Thu, 26 Jun 2025 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927324;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhxT6E6Xqbrj/JzxGyu7KSud5bpSyI6i+BkaifWY+kIoltNYPXm0yCqU33uvk8WfG
	 cUh0GDkIZPN7gFHFQVEpOMBgBth/jEEAVHLf4M03RF2s1CJPewJhJ6SrSHXavWbghw
	 jPjwKz7Vm8nA68RGMguBlV0ZC38w3+HshsPysJ4mnlCwgvKRfv5pXcTgfWuhpsZs91
	 Aqrme9MQ9/Fitbys+vuLHxIocKhOch2o8hbEWN25djyRPGZHrDdXtq0FJy+5Hy3kjD
	 HMSyg+83pE0OjT14/My5017S9gUKBKbAacCpLYpWdi76oNrnEmKF+GSgLTBWKSBZ2c
	 NP2fPE7jgeudA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/4] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Thu, 26 Jun 2025 16:41:50 +0800
Message-ID: <3433ba514e79e7e888dfdd786db13fb150ecfd22.1750926916.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1750926916.git.geliang@kernel.org>
References: <cover.1750926916.git.geliang@kernel.org>
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
index 1de42dc4e8ea..2f747ab730e5 100644
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
2.48.1

