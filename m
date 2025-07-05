Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AE1A3142
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714270; cv=none; b=Cy+TBCN/5BEoV568JVf6FASROExjkbNv0IEL9U0iTgwO5gh1YArDnEgDKk6kuoPfZMegXQM4ss0nrY4Ry9cwI8ZplnL1+kAUfYNuWlGBdRVGOS6j9CulgtagEG6lMDAX8OY8mvCKJsnFGY75Nvxq86F+IuqqiVvynS/B7lNev+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714270; c=relaxed/simple;
	bh=WY9Ic8bt/AuSNg8fPez0SnXlt2PD17skEModuyxe3+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCm3IUkPWua4a1zihrkouyUakkj35wV1+rBxPy/XbfcZALMz0eEgnSJ9Z+bPb29AuloX/neu3XUWwErmj2yUlG0g9MkYjFTAyuwAQHIN2W11sbQp+a/NowoDLXjnDXAw1bqGOGCkZeJLixTjR2xur9oWMJ6tIX5KFFJLSdgYv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJJ+/aFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJJ+/aFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65CBC4CEED;
	Sat,  5 Jul 2025 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714269;
	bh=WY9Ic8bt/AuSNg8fPez0SnXlt2PD17skEModuyxe3+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJJ+/aFfh+oOjtjs4EjfuebZLhvakfa0Yh5LJQTt9NNbIkF5L65IDpFSgJbchYeYq
	 XL7o8uoGglMkr+Pppmc7HBEmXkejSC2oIzEFw5jJq13GPbvs5BfljczbEg48osQLF+
	 IUPQuNA4kwO0rtMRuJrMmcf/2u2c94iAJk5FY6PlpTlLfQp8Tl5mDC1di+S0C4UZBx
	 roGo+MZwlkBYAtu9GzF4fimaryJ7HomlWuHfokJEunIkKi+OLT/A1xXsDP5izLqrYS
	 hOG1t67jBo51yWcXffkejIztnQgniITr6lpWLMqSq4jIW6wC0fbmFDiCPAv2cyqOvD
	 eoXj8X0ISSfAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/4] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Sat,  5 Jul 2025 19:17:39 +0800
Message-ID: <d11ceba9d676028afeca308ad644e9b5b88e2699.1751714072.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751714072.git.tanggeliang@kylinos.cn>
References: <cover.1751714072.git.tanggeliang@kylinos.cn>
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

Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c93b36373b1..d1e5f72a9d6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1891,8 +1891,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
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

