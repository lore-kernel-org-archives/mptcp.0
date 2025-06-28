Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A214A08
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093880; cv=none; b=ZO+MA+3UoKo2S1pEdawlRKica86/KLwsLDr6H2XSbnfTPoZuYsw0H9o7mdMz/geLy8FInezbWQsibkWry0AJhmDaXrchsJ7K5G9VD8PNuh7HyOK1cF5Cr5KaJr1niVSBttV5PRMaYlH2tcBtzG/p/uxvFvI4DbQBoaYWSQvKL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093880; c=relaxed/simple;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq16+zu1Cxd17Cvk1egmrPnWmpFMvEZH4gtyB6C6B8rYK1VX1S6SAP+MkC+ks1fNsWGYBwZbNhJ7QKep8Bx+1j6sGa8HxoluOTw7ZO1ERK70dp6LQfP7CLkaZT3UvHXYUDjbMvBd8/NOel8R9s8mU1lesyuUQg78RTfnQ6E6QuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3xhDDq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3xhDDq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D0CC4CEF1;
	Sat, 28 Jun 2025 06:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093880;
	bh=epwapybJb3CgkKtp/aeYa0kMv1PgIz/cC1O6ujlwZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3xhDDq2oS+fhMeKaaPlrJ6TlKm2kPG8UneLGY2nKKzpeubjNbbp06SEYZ++YaevZ
	 JFwBsgIUfKQUWhNgR8S0BIwXAmtlpjvgz8v4qgSQWS/DWyB///RZ6M2OAovImJkZQ6
	 4hsUUCOjqLHsz48R2nmMNpK9iHHYzPERUbmF7asZXmeqOoktkugdAIdel3htKuS8T6
	 GnyWrGz1oXqSTIH007TLvNxxcyeyowGXDnONu7+m3lmVTIML1//CQD558g3sOkswGr
	 Y74JHpF6xwOyGZTXa6Ji1VehTjftUTJWkTngBsBFcxlCh9eDdL73Wgcap/S9mnZF0n
	 WEWV771NqWRcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 1/5] mptcp: use sk_eat_skb in recvmsg_mskq
Date: Sat, 28 Jun 2025 14:57:09 +0800
Message-ID: <4a309ea09d8398ea08588aafba020b676f57616e.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751093346.git.tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
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

