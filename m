Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165733E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 21:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701268; x=1683237268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1oOaevUEUkpa5jtiPU0dj9G8Vpovcb/v0acu1kMD198=;
  b=bs9NZyAnz54Qp+rNeXxX4Rk5rWnK0WdMNMxa2FW17kYTcgILR7ekdoBK
   8rmJ/z3vJdKMyXTc7AWh2c6MY3/Q9Ucfsd+ptes5blMl2SPiAzgONXom4
   QFKzCFvabNeVS06RSie5//3PZkKvVPNK/gEvHhgkpTYgMTZfHEj2hEeN3
   80vh/KVkdgyQX81Sks6rcKX37znAkkEnFsReFOyA6d7vjW6nd8oqUAbuQ
   9gwd4C/lTeXSf4GcRYZD6ePJOhNZBy6M5man/3PbvbPrc2C10LGBGgga5
   zmD9ZW50gDbQODzguI8U1welsfpdQqap8o017+iLCyhnYHJMT8HBaAHt4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268064537"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268064537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621000382"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.251.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:20 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/5] mptcp: never shrink offered window
Date: Wed,  4 May 2022 14:54:07 -0700
Message-Id: <20220504215408.349318-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
References: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

As per RFC, the offered MPTCP-level window should never shrink.
While we currently track the right edge, we don't enforce the
above constraint on the wire.
Additionally, concurrent xmit on different subflows can end-up in
erroneous right edge update.
Address the above explicitly updating the announced window and
protecting the update with an additional atomic operation (sic)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 52 ++++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c |  8 +++----
 net/mptcp/protocol.h |  2 +-
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2570911735ab..3e3156cfe813 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1224,20 +1224,58 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
+	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
+	u32 new_win;
+	u64 win;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq = READ_ONCE(msk->ack_seq);
+	rcv_wnd_new = ack_seq + tp->rcv_wnd;
+
+	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
+	if (after64(rcv_wnd_new, rcv_wnd_old)) {
+		u64 rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		for (;;) {
+			rcv_wnd = atomic64_cmpxchg(&msk->rcv_wnd_sent, rcv_wnd_old, rcv_wnd_new);
+
+			if (rcv_wnd == rcv_wnd_old)
+				break;
+			if (before64(rcv_wnd_new, rcv_wnd))
+				goto raise_win;
+			rcv_wnd_old = rcv_wnd;
+		}
+		return;
+	}
+
+	if (rcv_wnd_new != rcv_wnd_old) {
+raise_win:
+		win = rcv_wnd_old - ack_seq;
+		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		new_win = tp->rcv_wnd;
+
+		/* Make sure we do not exceed the maximum possible
+		 * scaled window.
+		 */
+		if (unlikely(th->syn))
+			new_win = min(new_win, 65535U) << tp->rx_opt.rcv_wscale;
+		if (!tp->rx_opt.rcv_wscale &&
+		    sock_net(ssk)->ipv4.sysctl_tcp_workaround_signed_windows)
+			new_win = min(new_win, MAX_TCP_WINDOW);
+		else
+			new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
+
+		/* RFC1323 scaling applied */
+		new_win >>= tp->rx_opt.rcv_wscale;
+		th->window = htons(new_win);
+	}
 }
 
 u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
@@ -1554,7 +1592,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 	}
 
 	if (tp)
-		mptcp_set_rwin(tp);
+		mptcp_set_rwin(tp, th);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6710960b74f3..7339448ecbee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -216,7 +216,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
-	max_seq = READ_ONCE(msk->rcv_wnd_sent);
+	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
 	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
@@ -225,7 +225,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_drop(sk, skb);
 		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
 			 (unsigned long long)end_seq - (unsigned long)max_seq,
-			 (unsigned long long)msk->rcv_wnd_sent);
+			 (unsigned long long)atomic64_read(&msk->rcv_wnd_sent));
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
@@ -3004,7 +3004,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		WRITE_ONCE(msk->ack_seq, ack_seq);
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 	}
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
@@ -3297,9 +3297,9 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
-	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f542aeaa5b09..4672901d0dfe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,7 +257,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		snd_nxt;
 	u64		ack_seq;
-	u64		rcv_wnd_sent;
+	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
-- 
2.36.0

