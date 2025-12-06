Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257E26B741
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024469; cv=none; b=lPFJJru1pyMuKHmFwu3vu70mTQLZyY+8L+nfLvXTIhZcSM7TcWvoC3+CpQnalj4jMOykM93h/7H7Rn1FSu2+wCqunew5yG8zOiy7cMXgOt6rL+XnWeI6Qt1skvgDQo3leUIfokdCr+4Z1w8Ig54//Kfs2ICMAG1v0hV0mj5jzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024469; c=relaxed/simple;
	bh=hWQMcm1DLMilY3LUwPUQhOMOnXd2TSSzffgFrV/XJ/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny7EQ4u6MlOEvcQacsZ4hlHnxmk8UVmLaggJqj+zDsrt9uzN819ygxSOxTTUjtsY1b+Om7v2KnxXo16M4WIaIjHZSLY3is294f/M8c6m6n8ZbLUTIHwGmv32cgWTKqydKFBullt4aY6O4N9c4872K1zVEQdg/RvVa1bw1YeaxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei1UxPUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei1UxPUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA584C4CEF5;
	Sat,  6 Dec 2025 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024469;
	bh=hWQMcm1DLMilY3LUwPUQhOMOnXd2TSSzffgFrV/XJ/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ei1UxPUd+TtXTOx1SIFlQF+YnYlDEBDB/1baAhQUY5i6G7knMN43TIfFuLmc8DnU0
	 MKfxmUOS4sqXlSj/ian1qJr+NYuEJ4PCHv8/YzkOu8kS3XwKp6tzWrHWTG1GSQNQcd
	 HrJWaENCh4A6YMUt+CLn77rSm9H3YBnufYprm0RIBsog+5watJIhjbvSuq8MoJ7EjO
	 Djf6al+aMCX0DFLCd8k0rCFHqfddc215+wXFvA7Su/LmY10wrmT2StWd56DzGxWtFk
	 Ho/RPx632+pbDXL3KFvWm2fOaV6ac4jD+b7A02PMHZ/8VAmGMQKoQHv9BAjgxQ8z/X
	 xa1BYwzr1z6sQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 1/6] mptcp: add eat_recv_skb helper
Date: Sat,  6 Dec 2025 20:33:51 +0800
Message-ID: <96278b640414dc8edcdce440c411cc1521b10930.1765023923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
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
index 23c4db484861..9d67c751b7a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2017,6 +2017,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
@@ -2071,13 +2082,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
2.51.0

