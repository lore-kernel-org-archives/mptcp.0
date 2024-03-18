Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200522EF0
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749018; cv=none; b=AeDF6HMvzGnHeRgl8jtgm2VtacxIkq2rLhqW6i/8EEb1CAPM9ccjcUGrs6pMBgWFWvwdDD2Do8Ms6wuvk/JNkE6d1D+Q0HVkheK28hJz53LFukTQMBpO7tr2+6aLbky6plaYpKkU81Qhtno3LNSFxGq7sDMjD6YXaEEmnGOvQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749018; c=relaxed/simple;
	bh=Gap66gd2HKGg0r8pZDaTpJV5/xdx8b1n1vRLDgNLY1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCaZjlJWKMrRisZxf0xDM8ak6tyST8DTuI7BEiWZgXtpjhpzNhXCOefWAlBZZtoF9fNI0W2Ovq+euMBp3GI8A0Mt9jGWCm3iEAjU3QclxbFZ8woHGU/qQGMjYBUSsDp7VIGt1ezZ5klkT8ces0qThpzVc4Ir4dXQ+EbvfHe5OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N13RXiIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N13RXiIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9271C43390;
	Mon, 18 Mar 2024 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710749018;
	bh=Gap66gd2HKGg0r8pZDaTpJV5/xdx8b1n1vRLDgNLY1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N13RXiIKtmmMWCkaIsvSUeEnFxDDmifpN/T/+0U4SR3YC9dXy/S+T6sK6NLlIPBvr
	 1NblII1C9DYOrbFgXeezC5dLRBQw4/EG6j1FKJ1owEndBBSkDJrUYoEVTQQk/dnMYe
	 tSgtB+fNKSMteJQDFdpkErc/2Bod1X4Uzzzt/9jrChVe2HanxKF0bhdEnuiQagShEA
	 VQg2k/zVyAdVU7tTfRKzsmoyvuESIT4Mm5ZkPsScG+D1LkXNwTc/Ehm2iIlc3fFnGR
	 b9M3T663HX5VhdJD90RG9/uTUZWB8hJSTfN+zBDG8cab97mKNpMPDRohYjeqrOGxp9
	 sH9oYCCAhz9+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: add last time fields in mptcp_sock
Date: Mon, 18 Mar 2024 16:03:29 +0800
Message-Id: <ddf6d9178e3fa8b2646d8b7b9fb5e091ebf07833.1710748923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710748923.git.tanggeliang@kylinos.cn>
References: <cover.1710748923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds "last time" fields last_data_sent, last_data_recv and
last_ack_recv in struct mptcp_sock to record the last time data_sent,
data_recv and ack_recv happened. They all are initialized as
tcp_jiffies32 in __mptcp_init_sock(), but updated as tcp_jiffies32 too
when data is sent in __subflow_push_pending(), data is received in
mptcp_recvmsg(), and ack is received in ack_update_msk().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 5 +++++
 net/mptcp/protocol.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5926955625cf..c0832df3b0a3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1069,6 +1069,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
+	msk->last_ack_recv = tcp_jiffies32;
 	mptcp_data_unlock(sk);
 
 	trace_ack_update_msk(mp_opt->data_ack,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdf9ec67795e..a6b5c6492e9b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1556,6 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	err = copied;
 
 out:
+	msk->last_data_sent = tcp_jiffies32;
 	return err;
 }
 
@@ -2262,6 +2263,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
 		mptcp_rcv_space_adjust(msk, copied);
+	msk->last_data_recv = tcp_jiffies32;
 
 	release_sock(sk);
 	return copied;
@@ -2793,6 +2795,9 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 	msk->subflow_id = 1;
+	msk->last_data_sent = tcp_jiffies32;
+	msk->last_data_recv = tcp_jiffies32;
+	msk->last_ack_recv = tcp_jiffies32;
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5a4538205fd6..3a3fed3642dd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -282,6 +282,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		last_data_sent;
+	u32		last_data_recv;
+	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
 	int		rmem_released;
-- 
2.40.1

