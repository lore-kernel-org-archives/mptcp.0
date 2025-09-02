Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26198C2D1
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780511; cv=none; b=q+uUesZhJot+8h5Czx9fhsSYNFDX9F31jtt2fcbDT0etAErn7ld/7OJlMUUq7HOazkHPDhRxpos+si/jcX8bXsIY5PCesJvTZIOIL5Hb2OEREOWXhz5OYMgUh8eGmYnHK8UfrKPPYXUHq+fHV68MBaW6w5nUn89fWupBc4bKJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780511; c=relaxed/simple;
	bh=IEMEG5vNolCn6n0KvAjIuxW02rVpbAEkNBU19uB0Keg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr9iTz2FkNqf5h+pEGakDxXa3kdhWNKC8q1WmpfgwooS5sPMtbQcs60+1Fj/eGfTXjMoIwGS9sKfNCNTM0C/hHADhrAmKxFvetjus93YMxbMRUWWYYY/7sdF95wZA3oqd8JY5pDfjZqOcmjh2FEYbs0Wunx3p14RfEc68J19NfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjzF0azc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjzF0azc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8CAC4CEF1;
	Tue,  2 Sep 2025 02:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780510;
	bh=IEMEG5vNolCn6n0KvAjIuxW02rVpbAEkNBU19uB0Keg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjzF0azctH2At97zXdIR9twGiPDvBJSWxM4bgnnAA5g7A/BgQ3jc1G8i88zcw33Pf
	 cFYYT7MdTVF3ZgWRlyLdjC1sgdT1JSGC/uMagD0sdbZuzjtQpkmUC/o7FXHeBMTLqq
	 PzVoFCuiLwBzWBCW98fWKwTLfcUrsxbJRGGQ4hGjdtAmV2+nesngX9xVoxx9RW9zO7
	 DQ+Yav5eYJgDeHBSoH/cRAwOQkB5/Aui/RL+YX4RtWiticBAUWtUalZwD53+G+8UeM
	 d2G36CWQVFQl8u3alKHXsGOk5lzRTxDxhHJ/N+VYljL9ru0FfdxJWOixrN5MXV/cZv
	 n7Nk6MVGn2mAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 1/9] mptcp: add eat_recv_skb helper
Date: Tue,  2 Sep 2025 10:34:52 +0800
Message-ID: <8e91efd0a1a38a7892f7fbe5b075e3749af377e1.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
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
index 1ebba0ef4321..df82584a6f7a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1888,6 +1888,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
@@ -1930,12 +1939,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
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

