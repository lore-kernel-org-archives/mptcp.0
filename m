Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15421B191
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199024; cv=none; b=gOEfnjAm/aIdrOtZH6QnMSJkYOYyEUJ1AGtk47CEnRoBb/qPmTHzyw3myoIohrVFjkSvUGS15L7SWWFbSce1s+QyTVLMSdo1W9FUXsNFoKAq6rw+BVqWa+dR+CrfnCXThee2qCQeGrvX+FYXja1AVWIT1D2/dA4fbOZYtwnkaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199024; c=relaxed/simple;
	bh=vBg86gohczo2OpiIL+s4yD+6iUuOJ2MgWvmfndK07Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8tDAvdb4jtg+nmPQS9szSCWDmfONbQXi4ijZzI21fN8Ee8jz5arbphQBBUTiWYRmmSRgyTr0HuCsky/wLE6+54DHuIwUfRSftKBfg5Qq/UTeraTbNIp0ax5BdZu81/tJoJLmR5w1ZEAz1V3tgyO0QSIHRnvPjEs7t02iuct52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgj48RtC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgj48RtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36893C4CEFB;
	Thu, 23 Oct 2025 05:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199021;
	bh=vBg86gohczo2OpiIL+s4yD+6iUuOJ2MgWvmfndK07Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wgj48RtCDFWKN4/DY/hN7uS8WZdi2D5+Kll8l5/ysPd2rsMUR7FWnH9izqkwnqozq
	 TVcXpI6dbqyC2Kazx6XU7gb2c6hyPu2Z+7bZQljESvEWjK8t6DsMj5xMnxfdgct5B1
	 OejSwFZROGS1BDxMahX+xJYbHp3KrBmjggRCgM8DtUZxpyORIELNcK5QwippuP+P0t
	 BiEsHoNDjCo/4ZvjFkCsIQtalck+mWBvFQQNoO4PTuVDq5lVbxpeZ08c36qCF5OAb/
	 pwf92AppwB2fPkpg4+ilL7KgnT7UYuukKtk+XGsZZRRGL8+VjRhPZ4aWQGRGwYgYtz
	 fJUFS8g9acYBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 1/8] mptcp: add eat_recv_skb helper
Date: Thu, 23 Oct 2025 13:56:44 +0800
Message-ID: <ea2b2b9aa1746d9e8dd2da6ad1fac62e90323c99.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ee4d88e22888..813d438bbea8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1992,6 +1992,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
+static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	/* avoid the indirect call, we know the destructor is sock_rfree */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, skb->truesize);
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	skb_attempt_defer_free(skb);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
@@ -2046,13 +2057,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				break;
 			}
 
-			/* avoid the indirect call, we know the destructor is sock_rfree */
-			skb->destructor = NULL;
-			skb->sk = NULL;
-			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
-			sk_mem_uncharge(sk, skb->truesize);
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			skb_attempt_defer_free(skb);
+			mptcp_eat_recv_skb(sk, skb);
 		}
 
 		if (copied >= len)
-- 
2.43.0

