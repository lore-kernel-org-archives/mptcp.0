Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7A228C9D
	for <mptcp@lists.linux.dev>; Sat, 13 Dec 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765608001; cv=none; b=K5p7cVMkoD5f5WdpU1jKQBwlARprJp22yzJvSuXZDpNqfir1F50okqAtN6XYkh//MnQ39BQ6xoJF9PD5feAK7aEs9a3r2N1HluBsesqomumwSLoafToKa5Hyc//oITMIxG58bYljWFwAjcc9r7IV3wTGo6GSlSlE6ni4Tc+VKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765608001; c=relaxed/simple;
	bh=8GzJj/JlQvJbLU8iEbNNEvqpXqOFZvGX5gDrw/RSTSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7pVm+11pyIoyFf5E/QjKaNOzt6AbZxAQZVa+/xXajtLCvR3BoO26wL0fyztfCLtLsUJizs4nICkgSTjYcFt46mDv0aqvHyet603FPaeMV2JfrHYav4EiInZLMGkSlRHX4Q96Ka67fNL7PHmtalNyFsgb1E8JkJyYf6dmRgIy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a51Nfebi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a51Nfebi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A1C116B1;
	Sat, 13 Dec 2025 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765608001;
	bh=8GzJj/JlQvJbLU8iEbNNEvqpXqOFZvGX5gDrw/RSTSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a51NfebiufGAdjI24ywkQzj47Msl1nVB/4OybXY+mqesP+SpM2LdqB8spLvysv5YW
	 S/aK3/C+LCv76L2rQswp+s6KpOBkzZljhR7TfyOoO7dsOQs8eeo6DeYRMGu84e5LcU
	 TcHOCfRlPqHpNHn1vSZpklSsU6wVMhRgd0t2YMOVWQksqG9CIH7zckfJKWSZs0gWvS
	 tZhOrQfiQMRPoZXIag2FkQtnvO1IEG4A+E8IBe42Q8ABSPsqlNXA3tawOWuk6VvxCx
	 15pj1Fm77RHiUI0EFt1eSFvYllPbxfdwjGJzRw5De2VGH/x7OUn+ruNjZJPKJTPQhd
	 bNQzwbp/tBQfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] tls: use recv_should_stop helper
Date: Sat, 13 Dec 2025 14:39:50 +0800
Message-ID: <51351ea6098c066588dece8f33592073eb5f4e5b.1765607485.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765607485.git.tanggeliang@kylinos.cn>
References: <cover.1765607485.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added tcp_recv_should_stop() helper in tls_rx_rec_wait() to
check whether to stop receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_sw.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..26517c317ee7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1377,14 +1377,12 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				break;
 		}
 
-		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			return 0;
-
-		if (sock_flag(sk, SOCK_DONE))
-			return 0;
-
-		if (!timeo)
-			return -EAGAIN;
+		ret = tcp_recv_should_stop(sk, timeo);
+		if (ret < 0) {
+			if (ret == -ENETDOWN || ret == -ESHUTDOWN)
+				ret = 0;
+			return ret;
+		}
 
 		released = true;
 		add_wait_queue(sk_sleep(sk), &wait);
@@ -1395,10 +1393,6 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				    &wait);
 		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		remove_wait_queue(sk_sleep(sk), &wait);
-
-		/* Handle signals */
-		if (signal_pending(current))
-			return sock_intr_errno(timeo);
 	}
 
 	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
-- 
2.51.0

