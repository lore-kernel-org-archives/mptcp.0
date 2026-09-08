Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E5559CB6;
	Tue,  8 Sep 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876887; cv=none; b=QqJ2JN5ec2azpBm1/AcUzO9bCzhKEIObyY8vog52I3+DtYYP8JKKaeXFzJQuJxjKHkOMJWK8dmPx0z/KLpZynnaIaFK3UOVqVyCV4COl9G/F7gVp6UocoFmxgBMebY8aVVFIvizNCxVST2zFXycTuTY5jShGLLUbIHnIZguxT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876887; c=relaxed/simple;
	bh=oGg5rpzKcZ0L7xt8P9FjM5bph6IJRj54n6TDVtLgUkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZojM9W7XpMxWnrlfHz77N1uLVnMs2xOrm1QzlgfqN/UhNeK3CPmhQvmd67Tb1t6YymLNrMEa5mMe4abL/Xsn/+xkCcyHInYjMKGD2o9jwRtGWo1bxaR9FKkQnk7gPSLyeKC2D/aTLN/vRTLPRY+k4fnQ97SCl3Vdu5+n2keLJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR32VUuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR32VUuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34931F00A3F;
	Tue,  8 Sep 2026 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876879;
	bh=qtOzBM71tbq3AelkzbXg+5WrvGROzIDwE+oJeoYFn5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QR32VUuPlx5DNPKwzbqMyg7jMhKh+42zwwn2Snm867aGiCaB2BHUCKCIR0FNIzLRu
	 oC3hjohdhy3RKKpyRABO5Z0nyd4Hw8vgNtcSDwemxxPTVoTuuYV5eA0eX5EBDstfm5
	 EmkoKwQe/xqOr1iK6KIBRx/uK8uTNSOhJDUF/l4ihANprJFukhdN/BB+EyViAFIVBu
	 II1KTzX2TOi727lJf+HNGds1rAYo+zyQ7Sw8D2tBVFfpJYgjSfDYSwQ3AS9Rxq8mps
	 3uM5rE4bDgO3ESwbgMzSJoGUiixm9tWevbSCxExkc5ZaEEfacUgnPCbddhDy3wwWbN
	 qmPocVea7NePg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:15 +0200
Subject: [PATCH net v2 10/15] mptcp: remove unneeded READ_ONCE() annotation
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-10-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9eqb5VAzLubwvmVesR3TSDdXsSEDUwLnEuSftEbmfNY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSOgZmApNWy488W/vhy4OpR9PPrZlrX3K4zvJrnv1t
 rutGky2HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMRnsHIcIahMyGtVO2Ra4Rb
 2RNp3hnbHbYufiFU/tNr7ZSIDU9DZjL8L1iqbGCd8fL8zcyptZyTHAPvTY3a8Sel/d26bRyf8zi
 3cwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The subflow->fully_established flag is always written under the subflow
socket lock. Reading such value under the same lock does not require any
ONCE annotation.

Fixes: 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Gang Yan <yangang@kylinos.cn>
v2: no need to cc stable.
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 92f27b9e087a..196a46e7467d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -530,7 +530,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
+	if (subflow->fully_established || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -981,7 +981,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(READ_ONCE(subflow->fully_established))) {
+	if (likely(subflow->fully_established)) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d611af2eb74f..302936ff456a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3886,7 +3886,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
+	if (mptcp_subflow_ctx(ssk)->fully_established)
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */

-- 
2.55.0

