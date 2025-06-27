Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BF14EC73
	for <mptcp@lists.linux.dev>; Fri, 27 Jun 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040087; cv=none; b=OZdlVHglKlO2fFYj/4okn/NcDk6K4zGYzOaYuaP04Rpefn3l9VvUkQtBFO3cV00Wv/4kj6x0iYuMtu9hwH73n5GXvpq5Uj8q228d6VjePwkxvd8aZ8mDA43AGwjk7xCfWLrISeG6DOAQc3mHNa4gegTxtePleXb/SrgeyzSt528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040087; c=relaxed/simple;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9D5JoVv0syFCuxNhzrBNJ0nOoRVK3CM6bPX037x3ezC7kQa/Zp0FPuIR9s1B/gHlrzdDa8GgD+zzwNT1DUSzgCwO9iPw3hKieVO/JPlWyDTUMMntiq4YTkew5B8XUIFqFW+3LLDYC1/2O0wYQhdBt2uAlYNMscx3CoUC0AgTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8utLYfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8utLYfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B168C4CEED;
	Fri, 27 Jun 2025 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751040087;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8utLYflfDn5CofMP0jtQ78kLdv4zDe2mnZa21Ya0yMoMezm6wwr+aYI0xg9OJ0sK
	 xqNJtKyGhLBCyTdyKm1V0KJTX0I00IcvOrkPpnN78pYrS1WBDBKoipjJLbP1mgCqNx
	 5SkQ5oONJ4eJh7y/8IBfQzUFyoVg8yzd70ioBsM0+HE0ZN0NzhYtKpSB2T3p6ZxdGU
	 rNBwtE4sreTl1fIrrIJv1bRw99km/zaqhjkCPX6C1VdvxZCIKMydTlot/iVEtyQ84F
	 HeSHlo3hGJhw9CIvfd8IwPMk5i5QdlvlFiHchHNhyo2SNO+CMXJQflOzcOk7N91Rtd
	 HNN2w7K2ipW/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/4] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Fri, 27 Jun 2025 23:59:40 +0800
Message-ID: <28f02218b3e0dff52714f7ff8fd9a401d8f31fc8.1751039657.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751039657.git.tanggeliang@kylinos.cn>
References: <cover.1751039657.git.tanggeliang@kylinos.cn>
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

