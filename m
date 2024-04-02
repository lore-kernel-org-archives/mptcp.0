Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B358113
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050123; cv=none; b=kEVRVhnZK5clltWTw2/LNSXZk0Q0gXusynPiIYwGi8bNtyRBHxdZRqf1CxrWaNmcWwnGF46TdbHj1E4jisKHA7bcqu3V1Iqnsd1SRC3ndFnCEbyp3HEJjOEAim8SVP98nr9fxWn++EbVuk5OgjtDRV528QVI4lkQpjiZ9VnEpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050123; c=relaxed/simple;
	bh=s32tFXYWLu6yZYOT+V8IYJyyk4WHV/3WuBZO0Ua/5fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0m0aOhHHw0/GVrx+s71BJ5L6KS9fzZWKioYk2elJ8fyjhKOCl5AMzJo/zltHz181dDg3w3xNlMZAXLgyQd08DDdR1v6My6PZH+Q7DyoUaeEhR8lNoVQtKQt1tf9qiVTXbhktoH8oZYSIMyQSZoVJBXSJFpkVV9Jv1gDFB/HGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFOTBiuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFOTBiuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563AC433C7;
	Tue,  2 Apr 2024 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712050123;
	bh=s32tFXYWLu6yZYOT+V8IYJyyk4WHV/3WuBZO0Ua/5fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFOTBiuOApeDPyyIxqqg1AGMe8OgbWzpOlnX2Yn8v73b5JEdxzbdv7QCzhwXgCMY2
	 q/pgWMdfeuazNXw5ON70cmh4fkuPmcBK+PjqNVFoFrZQKObeW+agA1ou2Stb69pF75
	 oQbrZajZeXDtwBPkO2M5tKAmfDYrVuHiYt0Rp35hnyf/+FvlxftxNSTHFMk/c+dC+/
	 4EP4HM3mdSM79nHeg04H2DwqFAD+H2dYxQSz7xUVgf2yxb+WH9BfY3iDgIqRaM3alt
	 9b0xKoQLFvLDlVj44VbOz8mklEqoRwBNpTjKoFFmMgaPtJ8hiaxTduyuq0eZZFnraN
	 0vf0hXP0eTRZg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/2] mptcp: add last time fields in mptcp_info
Date: Tue,  2 Apr 2024 17:28:35 +0800
Message-Id: <8f7f0bc03d89c920ff8e60818d3280bc93fc16a3.1712049966.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712049966.git.tanggeliang@kylinos.cn>
References: <cover.1712049966.git.tanggeliang@kylinos.cn>
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
__mptcp_move_skbs_from_subflow(), and ack is received in ack_update_msk().

Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
exposed with TCP, this patch exposes the last time "an action happened" for
MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
deltas between now and the newly added last time fields in mptcp_sock.

Also add three reserved bytes in struct mptcp_info.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/uapi/linux/mptcp.h | 4 ++++
 net/mptcp/options.c        | 1 +
 net/mptcp/protocol.c       | 7 +++++++
 net/mptcp/protocol.h       | 3 +++
 net/mptcp/sockopt.c        | 4 ++++
 5 files changed, 19 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 74cfe496891e..67d015df8893 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,10 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
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
index 556b3b95c537..43318aa5f991 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -706,6 +706,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	} while (more_data_avail);
 
+	if (moved > 0)
+		msk->last_data_recv = tcp_jiffies32;
 	*bytes += moved;
 	return done;
 }
@@ -1556,6 +1558,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	err = copied;
 
 out:
+	if (err > 0)
+		msk->last_data_sent = tcp_jiffies32;
 	return err;
 }
 
@@ -2793,6 +2797,9 @@ static void __mptcp_init_sock(struct sock *sk)
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
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 73fdf423de44..2ec2fdf9f4af 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -896,6 +896,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
+	u32 now = tcp_jiffies32;
 	u32 flags = 0;
 	bool slow;
 
@@ -930,6 +931,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_snd_una = msk->snd_una;
 	info->mptcpi_rcv_nxt = msk->ack_seq;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
+	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
@@ -942,6 +944,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
+	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
-- 
2.40.1

