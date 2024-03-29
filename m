Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403F36119
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703230; cv=none; b=nKJxUppo2ctRjWzV41uamsv8Vj8nii7dPuC8DtQJrbdfipnz8PS59UclCxkKls+hXV21af6cOYyA5VPOsk38a3xAFokW66dGod+mwErg6XHWYY4I24PiFZqO0bpUF271K3lGBhkG0I7UwG5GWgG8d9TsvlKmJiec+eZu60fr+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703230; c=relaxed/simple;
	bh=hkoDZOuPqtAY3Wsi6VBhf7SUD+iXtlQ4gTo7nvgCfDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eENfA3dmHWhzpFdX57C0AluLBZtvsOK7TjqETpUp91qGRiqd5ZPBQQQVDHfKip9XO7vTq586KX8tqtBWCH7d200PqPYlLxGN9XscMs/S7vjXGMwkpoEpUaN/y+i6XYjPx/xKCW+9ruMhD7hTxnlceSf/PVFfJT0QXmRod4IXofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytzk5x+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytzk5x+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA89BC433C7;
	Fri, 29 Mar 2024 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703229;
	bh=hkoDZOuPqtAY3Wsi6VBhf7SUD+iXtlQ4gTo7nvgCfDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ytzk5x+ofXzH2xcfSsT1hNHNB8+tv12KyvU3o5z7NixiuonJfSDhaREIAUGNHDuC6
	 vS0fTs8IYt18TAB1cFZ7bKlX+bv+DRYi7HUUJpVDsOjMWAh2w7Qvc/9ZkSKubV89nJ
	 z3U8LuzZAsfgOYthCQfycYIY9t7rC9FBJ8CjSS99c0epx5eqEuxprt+BhD89XMy5X5
	 SI52s/TNLl/OLW8NuNSp5vDqP2J4Jlv5/1QnTVLdRHaWBU/32afqjk4aqNzh7SpXvL
	 acDFrRTZB2b/DpR5rt7qr9GBHk/M6O8qAteuHWHO8wqC8CBBT9P4jKJF4e3lis1QyI
	 EBpYEVdFx1qVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] mptcp: add last time fields in mptcp_sock
Date: Fri, 29 Mar 2024 17:06:59 +0800
Message-Id: <83a26dc8e1049d8c4d047fecd9ba5f91c5e77af2.1711702915.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711702915.git.tanggeliang@kylinos.cn>
References: <cover.1711702915.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 7 +++++++
 net/mptcp/protocol.h | 3 +++
 3 files changed, 11 insertions(+)

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
-- 
2.40.1

