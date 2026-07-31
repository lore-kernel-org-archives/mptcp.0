Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145393B42D7
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489817; cv=none; b=XwCIrmY9AzXzMvl2EzEfSTuqdP7mJqtelG+e9kMQebr+5cq9izQmPonHYs5UZvn74Hkugr9oS5e7sMAZ72S2HsrJ1/M+7GUsHRJmd+5OFsnC4b8gsYmmTQX3ZMQddJWm4EB7Y1Psq9efAO7j/oCoDZhFY8qhVXy5PuanrHs7I1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489817; c=relaxed/simple;
	bh=SD9ftGsriRKjCH4nll+mB7k03vsk9PNZIEUEu2xI75U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiNMlj+jOvkkAgd+JGaYksg9G922FZ44XJQJS+CTw0wQtGLk4wMv7G27DOx0v3qom4AUqy/ivKNjeI/U+qi83GW/LX7ZrLOc6nw0FIu92roIcosiw/vV5XhOE754xd97xhE1JhYgS9OG2juWknm1P4+4BqjvQgibz5EgF+cY6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuJ3Npe8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuJ3Npe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F64C1F00A3D;
	Fri, 31 Jul 2026 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785489815;
	bh=kI3sA6GmkzofSC/IxvlglLm5ZtlRGfpC1D/tF6IzOS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KuJ3Npe8KRam/OC3/FcbhyFnBxFAXG6vR7e6vzdYR5NLUoRnRJXfGSuqY4FdZd3EC
	 RB2Je7HJCK7VnSQ+bRQwi4iAMZnoTAvPonNBC57gL+JaFHhiYmAwVJYvvZOX/DBXtC
	 ZoGlU3dbTo3KAf7Qz9jXncEUwOZI1Da4Rru4zJpWjHKdTwznW7hOceT8jk1b1R9XEH
	 xV3Lz5fXv+bngCih8irG0fpGokFatDVfs2vk/YqUz+asj3eWxAxuhkrG0ZA/hcqKrY
	 ElXw+4FbKqo9zvP9SiRixcnlRE9TGFsgX98Mq2wU4RUiIPkJjtt0WgVl8n4YWWD3Sg
	 RqaoBt4JS0Cxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 11:23:16 +0200
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: explicitly drop over
 memory limits"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-ooo-pruning-v1-1-a5f5115e1e24@kernel.org>
References: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SD9ftGsriRKjCH4nll+mB7k03vsk9PNZIEUEu2xI75U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyMqeuPSAY6X/0xleWc/cXec5LLQjWOjxDTLpHYmOLc
 7K1ea1nRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQ+tzP8r/wU3P9lgeraLpbG
 ZUc2fD4mcMxjR8DpYP063xk7j/ukzGBkOJjbccWF7WDwJAFG5X3dz2/f9TOV+tg+7TNn790UabF
 8LgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Address comments from Clashiko [1]:

- mib: typo: "constrains" -> "constraints".

- mptcp_over_limit: precise it is not only 0-win, but retrans, dup or
  old acks.

- mptcp_over_limit: bump LINUX_MIB_TCPRCVQDROP, as previously discussed
  in [2].

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54%40kernel.org?part=3 [1]
Link: https://lore.kernel.org/b5244dd4-205d-4abd-8ea5-fd879a97038f@redhat.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.h     | 2 +-
 net/mptcp/options.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 18f35f7e0a2d..25f360724c57 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -89,7 +89,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
-	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d6b009319839..23503984a084 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1193,7 +1193,7 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
 		return false;
 
-	/* Avoid silently dropping pure acks, fin or zero win probes. */
+	/* Avoid silently dropping pure acks, fin or already-acked segments. */
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
 	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
 	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
@@ -1202,6 +1202,10 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 	/* Dropped due to memory constraints, schedule an ack. */
 	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
 	inet_csk_schedule_ack(ssk);
+
+	/* In fallback mode: skb is dropped before the TCP recv queue. */
+	MPTCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+
 	return true;
 }
 

-- 
2.53.0

