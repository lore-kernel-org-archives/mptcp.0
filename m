Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A6389469;
	Fri, 30 Jan 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801090; cv=none; b=DX26MbKgQ0VYlHGEKikt8QoCTWEbkqs/E3JTRC8sk0FUfwUV1EZaeH78dWYi4zN6ZoU9S8gaI7PulLJNmXZ+Lj5kaie68d8sxTicz9kjSZnffye/tK86qgjEPjUFmidwhR8rNfP4OQGR4+Rosg14gzABz5OsbYHqFaEIwj3erQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801090; c=relaxed/simple;
	bh=5pXsZ1+bdcl0+5ekJkKvICgBbW8Fn1J1qfigEm+sIpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqZn5sqw1YFCb24+szhzx/Peo2EKqoMctGqzPfUEwUYiJ359KqDzjAdHKLhyRl6q1HcLQXD+kJd9dptWsB6kA5ksO1gbeWW3AH35bf+cjJAoBLbx1EAPqTc7HHCHbgc/cH9/9/+VNOZBY6+C1/sl9uAAEeM6FIcCLSKj63ca6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7nWJ4Jb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7nWJ4Jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5279C4CEF7;
	Fri, 30 Jan 2026 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801090;
	bh=5pXsZ1+bdcl0+5ekJkKvICgBbW8Fn1J1qfigEm+sIpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K7nWJ4JbohukozJ+0CKHBm43kGvZvJkYx05RwXOery2ajtyTKVDfUWbFZ+9MoC/lO
	 Ir0nO1ikNv8we9AOEpIV/ypjpwCwEi9Ei5OKXNwSLG04vA3lyy0oLF5EBNIISedicS
	 XsEj2EwEG258NhkdTNvcn9k4dxTzBsI8LqtMBjeH9Xt93LblnsTEbsO8w8OsPwp8Po
	 bgtFORjMtcA9Lm79WhGJDqoXQ3WQlstGbwIcri4pv5RPAd0eXNfd+B5iwn9cbPbsWP
	 1xbXgObzSnQhxmEhdvLrvtPxqPnN6T5Rp6RplmDnMz5nJJpKVnBjrCWJFn38B2ngFy
	 B3cwony5I/ltA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 20:24:26 +0100
Subject: [PATCH net-next v2 3/6] tcp: export tcp_splice_state
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-net-next-mptcp-splice-v2-3-31332ba70d7f@kernel.org>
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=E5O3UWqgt4CvgYo2yhYrE/jWhi6yLAzzOug/sQ4PZ3w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWUv2fbU4Nk/L4ue1V2pfay+cL3gSsdHhRvaBtW8fb
 znVLXghq6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAii+sZGVYc8Pnd5Nnzf7uA
 u4W8Ek+unfcZJR+WhV7HpmiviL6mZ8rIsHzzu9eMO9YEn2zhV1zc80v2x/WQIzqcWkWr6/SCo24
 +ZwYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h
so that they can be used by MPTCP in the next patch.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h | 11 +++++++++++
 net/ipv4/tcp.c    | 13 ++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f1cf9e6730c8..cecec1a92d5e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -347,6 +347,15 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
+/*
+ * TCP splice context
+ */
+struct tcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
 void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
@@ -378,6 +387,8 @@ void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
 void tcp_twsk_purge(struct list_head *net_exit_list);
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e4009158b908..6e94c5859f4b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -318,15 +318,6 @@ EXPORT_SYMBOL(tcp_have_smc);
 struct percpu_counter tcp_sockets_allocated ____cacheline_aligned_in_smp;
 EXPORT_IPV6_MOD(tcp_sockets_allocated);
 
-/*
- * TCP splice context
- */
-struct tcp_splice_state {
-	struct pipe_inode_info *pipe;
-	size_t len;
-	unsigned int flags;
-};
-
 /*
  * Pressure flag: try to collapse.
  * Technical note: it is used by multiple contexts non atomically.
@@ -791,8 +782,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 	__tcp_push_pending_frames(sk, mss_now, nonagle);
 }
 
-static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
-				unsigned int offset, size_t len)
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len)
 {
 	struct tcp_splice_state *tss = rd_desc->arg.data;
 	int ret;

-- 
2.51.0

