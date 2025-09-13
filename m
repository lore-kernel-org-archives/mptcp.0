Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6923596D
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723946; cv=none; b=jIHBqMLbhISMDR+dQlWIPBYq56uRsEzexRRZ3tSlNGM1l86Gh5VhTOxgGehk88+9FfCHQ/7J2AlnzlG9B9ntvjlIM+patQQ/Z734SZ3yo1Bf/xx0ROQMSgN5hyOAqX7dTx9VSYBO9sKNJeCejLPw3QTdZmW5l36S0645Ac5kDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723946; c=relaxed/simple;
	bh=5PDdeBCimXHhAnlpCuGubUpW6ZRXHtmPtuFROXo6DVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsoZwgaD0r66J/VhXFlC5+5L5CcmbjgpYjstDH2kmqctMsrhhTg8M4CB+bDdvm9+rRRXK88B/zyc6PTEWVosh/slMNTnuNPdydcpVubnXNoYf/rGVMbOeeOm0kaEUpr5EyjfUOcIxpo11YEZSde7Q2OFtOdlx8Sf5olawLgF9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLkXYhXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLkXYhXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493E3C4CEF5;
	Sat, 13 Sep 2025 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723946;
	bh=5PDdeBCimXHhAnlpCuGubUpW6ZRXHtmPtuFROXo6DVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLkXYhXZvxwaERMSNstWnulfhm31zaac/eGYHLiej0XSFpTl8cVceRgzBHgt6uyZq
	 6kh1+XauPdb2VRV3Vdhs115Bp7Em62bQuPh6FNoMd9aLXDKVwXbMHiUSuvFCasEtQB
	 oEuluyFvJWc3XsUJBo9siJhP87VUzwLUeksDGMQY3oYgCyHsKF/7KXuuYxwUTbX8dR
	 aHMIywTobAucj9+2ghG5NSOMLXD5Sl9k1uiJuHDUhHuPCKCdq3gVflcVe2qMVn/D5H
	 AQsbtUdJlX5PPpjqoGFR1GEI5tlKmM9nqYTk3TXO0yIfwsOPBXfV3J1BhRYxPAtLPd
	 Y3ZFnQcAq0Wgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 1/8] mptcp: add eat_recv_skb helper
Date: Sat, 13 Sep 2025 08:37:20 +0800
Message-ID: <869ac3b23148e394640fa55870c6e39c4e177da3.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
into a new helper mptcp_eat_recv_skb().

Use sk_eat_skb() in this helper instead of open-coding it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7933291e991c..882b68a02fb9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1901,6 +1901,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
+static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	/* avoid the indirect call, we know the destructor is sock_wfree */
+	skb->destructor = NULL;
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, skb->truesize);
+	sk_eat_skb(sk, skb);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1943,12 +1952,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
-			skb->destructor = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			mptcp_eat_recv_skb(sk, skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.48.1

