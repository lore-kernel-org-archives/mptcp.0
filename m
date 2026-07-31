Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456C419FCB
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493145; cv=none; b=KtzD9pqF+1rUhGCfmuAvjVuGzd+AJwzNOdQtMC0lxERq03yqzm1HF30euyinQDfn2wAboJ1KogdEefNPTlNIQBSY9yEWup2WeE7QjaEzWJylqiDhNzjv4+Yir9XIfSOMXK0hGRxPD6mXs4x4Ruvq35IVlLDtK+XVg1dufrFAyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493145; c=relaxed/simple;
	bh=0HQczlsRk6ulA4HUX8jH281qPMQIphdNwhcxuUcMCTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6yTt6POfMBtSJRCNp0jcoxJZDbrCuT77G6TBOodxin9ktI4cpF0FuFpT0LWozP+oZlLwS/uQx1VUcgH5LXxhgWpZZBVE+NF+yR5yYRg0h+oGBQ88mdXFi8De/sldFj8ST16iGI+I7NhzCdLgxQl2GvWF/TPVZ/WkJyGFA9VoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6eNcEBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6eNcEBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45CC1F00AC4;
	Fri, 31 Jul 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493131;
	bh=Lv4+0o2m5LkSth64dac8eYjlXTC7rag4sWRl9eif6CM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E6eNcEBkPCzRkYKeZi3h29oX3Rxcv5AmZLfEs19POtyGzxOm1VoO75U/Pv4Wh3FH3
	 pJm8ihRFh1OjxX7JnklzIltrluc2GcIFfw6HNNfxrXHnPQYlVCfhPNrp6q55LkK68K
	 lWhgtJnXj35lXBsxdSSV9p5QSLdoiqljPnPHUZkHQzdSM6g2rWzE+t60GnbJbB5PA6
	 pN4kGxmjrLgjGASg0fOV2UsO8iKRwH3Mg4EMFszpra1oEH0v8oMA2E+QaGcOeXAU/f
	 hTXFi246ftx7GUioTGiU6Ia+MEqVV7kS/8L7CvyVQazPUiR5hO/au4AcIsMHuo2P1Y
	 S4n8mvAxFbXEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 12:18:43 +0200
Subject: [PATCH mptcp-next v2 1/2] Squash to "mptcp: explicitly drop over
 memory limits"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-ooo-pruning-v2-1-499a523bbce3@kernel.org>
References: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0HQczlsRk6ulA4HUX8jH281qPMQIphdNwhcxuUcMCTA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyyjrOnJbIk/lksaH21/vABMlL2jrr92yaPfO6jc3KJ
 d9sc96Id5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkLh8jw2apvIPGjzep37z0
 4pa/1CLHBefuhL5+kbZhqbeZge7WeycYGb7Vnin2aW9fE3pXSt1/ucHskwuPaPbpz88o4J9336l
 NkQ8A
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
index d6b009319839..7c0bce3780c5 100644
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
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+
 	return true;
 }
 

-- 
2.53.0

