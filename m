Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971833D0
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711784779; cv=none; b=PzXKmQ+8QLbVanuWsJ3HXzfBkcNrapWafapa1YhkHa6rDYmYeRM2pTaMxffT5A0RiNBo5suzRqv7F3w5loUet2GqWBLzhRxT5XkYscKIXUExlfjc35VtaXny6sQQqcIKCeUxmagwClDut3rlOKEe/vrF6CjfHcYMu0TXWgPq23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711784779; c=relaxed/simple;
	bh=hkoDZOuPqtAY3Wsi6VBhf7SUD+iXtlQ4gTo7nvgCfDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmmpllA226JLzY5oJYrP2E9IT6q8Mv0bXrkPCBy+f9NRiqtPrxviVkCb0w55Rjmka1/RmWBFbx7O0PSwcegXWFg+c6X2OsweK7Ce1EnMqsr9aKxOhqOtOxQlJsSch83nTomMDJ9Dn+fyDlnp4DIjomoETN0STp2TXJf3ODmw47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMC15/gh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMC15/gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F9C43390;
	Sat, 30 Mar 2024 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711784779;
	bh=hkoDZOuPqtAY3Wsi6VBhf7SUD+iXtlQ4gTo7nvgCfDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMC15/gh2rOlwUig5bozCi7pms0bxKC27jZYHFGqDNuMqbP827QJ+qS66D4LBLpg8
	 5/5S5uijQu53KsIS7PlY+AiuduYZVXXb73sZ/Ny6BXPU5jWA8TIwdNGc9s5RJvVIj+
	 eLPs00zmqEzWKvHyVts/TWQHUW4aQWyxYOVpAOrSho2mlBKiewLr68InzpIEhoNznV
	 hG/8M8E8MBq4A/VS6oTUrjlGSU2W2Z/jL0MTA22FlpCZC7WBnm3h9wjGLC5X9o+1rS
	 3i4Qu5CVpwTSd6Bl1ftk2p0puv3es3NX3bkojbzpvFH5jUiCHtsby3nGa2OtgLc2n6
	 yC1pIb3C9AoYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] mptcp: add last time fields in mptcp_sock
Date: Sat, 30 Mar 2024 15:46:08 +0800
Message-Id: <b6035764dc3c248e1f607a61e03e5d781a00c2ad.1711784619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711784619.git.tanggeliang@kylinos.cn>
References: <cover.1711784619.git.tanggeliang@kylinos.cn>
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

