Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809737;
	b=x4y0uFfrAh2AzmoCr0g3TrCgyNNkc6a7PmCdWMlho2nnxRgl5t7pk6TafHSrcc9x+eoN
	 IoV/DggLLayhAx6hgLMzRiA0hDQgA7ZCfcbclwimiTpbtvKbl3gAXOVQPrf4G/Iupc6kH
	 0mWPGARZArWPTqZsnlx31pfQKO+gQLl0h0MlWU7CHhlsytReeNKr+3WgQo7gMNuFaevup
	 USF7TcPmwlBeCCXbcimoNHWMfKbi8tXxAEmK11pTqe4yz3YRCrGLRX6BJB0HcWeCeJHjm
	 Shx2mhH5oZB/WTLs9G0OivhGnPKpWMZw24HnvHf+lH+zhy3XUqtJ3AqHzDlhzFc3ZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809737;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pbkFg5Qq1vOCWpPJ8PK9U6ASoLutRVaSSpiEA6DCS/U=;
	b=dGDZUocq0YSb6zGJbl0M+GDSnhgq3Z5Oj0LCpzrpa+0PLp2pSg24UtMBNeedHQHlEzBW
	 4rvNkXVHG937rllrzGURkNqO1kKEzyjtEGR7108S+lp4xp29ep7ttEZZRpVkun+ZncJC9
	 PdPbxpJi7dHNQPBsFBNtEyqA/qW6+fIU6ab39EQSDvGoL+yLMlqofvKalZn1IVmIehRe0
	 JH1fxPluzJFpz+JtXPqugf/EL0ptdeu72wKYS6UwA1ZJ4Gvj27Dij+zugaN7VFWHzyt3t
	 GMlxanCyCmR1Eq8BsOPb20gHeNWfFBXsL/hFdGINfSr2Tuf/tYpXtpt6N5KIKk5Y92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1CK63wR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F587606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1CK63wR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DDA1F00924;
	Fri, 27 Nov 2026 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809736;
	bh=pbkFg5Qq1vOCWpPJ8PK9U6ASoLutRVaSSpiEA6DCS/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U1CK63wReK+DDgyQV0xTlW4qoqH3WQIxv28KPp7cViSsCQJ8ul8fflPyb9MujQrFo
	 DcUjaG1Z+YOAXBBgeGXRfUcR+3caRogubKICFTpNTBhV2OG2DDFKGVO9CjTf/wabFg
	 BzBMRz1TRkIxtwdg7qC3kqNPVGylgI7CPquJcQX6zal7r6UurhkSzkVeRZ/bCDx+2m
	 zuafaIMWavGzIrqYmM3/C6VYrngvapj5KXHKQn9jVpx6bqEkNmFXyfi+pX3V3bPyyj
	 6T4gL8iHmTHfoy7dySA565TKkXHuYIKJWvTdaljIcEZNdlqW0q8RlXw5+e6HLDP3kR
	 IgDDoh4BfN/3w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:37 +0100
Subject: [PATCH mptcp-net v4 13/20] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-13-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5490; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eQteMsL6mjtW+2daGRDK146efxgAK8k7NgMdi+2wUmk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H26yeq/KvutP51WGOokYO6Vz2/h3rDoq0v3GkPV5k
 ZdpYylDRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwES23Gf4X+kdcmPpqZ1TFqYe
 3XXLrddKYlrn7J1/PvO8eWhhfto9r5KRYcrW5141O5++NVzQ4LMz3e9up43B2YATxy+bSnQ01Dn
 F8gIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

mptcp_subflow_get_send() computes the linger time of each subflow and a
running average of its pacing rate through a u32 "pace", while
sk_pacing_rate and avg_pacing_rate are unsigned long: the rates above
4 GB/s are truncated, skewing the subflow selection on fast paths.

The running average can also wrap: on 32-bit, the uncast product of
sk_pacing_rate and burst wraps at ordinary rates, and on 64-bit, the one
of avg_pacing_rate and wmem wraps with a high rate and a send queue near
the 2 GB that sk_wmem_queued allows. The fastest subflow can then look
like the slowest one.

Widen "pace" to unsigned long, and compute each product of the average
with mul_u64_u64_div_u64(). Dividing each term first would avoid the
wrap more cheaply, but the quotient becomes zero once the queue holds a
second or more of data: exactly the bufferbloated subflow this estimate
needs to describe.

Sockets also start with sk_pacing_rate set to ~0UL, until the congestion
control sets it, and the scheduler can pick a subflow before that, e.g.
after a passive MP_JOIN. Without the truncation, the average would be
seeded with this value: this subflow would then always be picked, and
look like the fastest one for long. The average is then only seeded once
the congestion control sets the rate, and once the RTT is known: e.g.
without timestamps after a retransmitted SYN, tcp_update_pacing_rate()
does not divide the rate by the RTT until the first sample.

The running average has been added later, in v5.17, by commit
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation"): before, only
the truncation of the rate is to be fixed.

Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[ Do not seed the average with the initial ~0UL rate, nor before the
  first RTT sample. div64_ul() for the linger time, the full rate in the
  tracepoint, one Fixes tag, and a shorter commit message. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/trace/events/mptcp.h |  8 +++++---
 net/mptcp/protocol.c         | 29 ++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c47fa2672b84..bd2b4a8fc271 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -31,7 +31,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		__field(bool, active)
 		__field(bool, free)
 		__field(u32, snd_wnd)
-		__field(u32, pace)
+		__field(u64, pace)
 		__field(u8, backup)
 		__field(u64, ratio)
 	),
@@ -57,12 +57,14 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		}
 
 		if (ssk && sk_fullsock(ssk) && __entry->pace)
-			__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
+			__entry->ratio =
+				div64_u64((u64)ssk->sk_wmem_queued << 32,
+					  __entry->pace);
 		else
 			__entry->ratio = 0;
 	),
 
-	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
+	TP_printk("active=%d free=%d snd_wnd=%u pace=%llu backup=%u ratio=%llu",
 		  __entry->active, __entry->free,
 		  __entry->snd_wnd, __entry->pace,
 		  __entry->backup, __entry->ratio)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c83c123449fb..7d9031940360 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1693,7 +1693,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u32 pace, burst, wmem;
+	unsigned long pace;
+	u32 burst, wmem;
 	int i, nr_active = 0;
 	struct sock *ssk;
 	u64 linger_time;
@@ -1718,13 +1719,20 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
-			subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
-			pace = subflow->avg_pacing_rate;
+			pace = READ_ONCE(ssk->sk_pacing_rate);
 			if (!pace)
 				continue;
+
+			/* ~0UL until set by the CC, and not divided by the srtt
+			 * until known: not to be averaged
+			 */
+			if (pace == ~0UL || !READ_ONCE(tcp_sk(ssk)->srtt_us))
+				pace = U32_MAX;
+			else
+				subflow->avg_pacing_rate = pace;
 		}
 
-		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+		linger_time = div64_ul((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
@@ -1757,9 +1765,16 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		return ssk;
 
 	subflow = mptcp_subflow_ctx(ssk);
-	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
-					   READ_ONCE(ssk->sk_pacing_rate) * burst,
-					   burst + wmem);
+	pace = READ_ONCE(ssk->sk_pacing_rate);
+	if (subflow->avg_pacing_rate) {
+		/* 64-bit arithmetic overflows at high rate with large queues */
+		subflow->avg_pacing_rate =
+			mul_u64_u64_div_u64(subflow->avg_pacing_rate, wmem,
+					    burst + wmem) +
+			mul_u64_u64_div_u64(pace, burst, burst + wmem);
+	} else if (pace != ~0UL && READ_ONCE(tcp_sk(ssk)->srtt_us)) {
+		subflow->avg_pacing_rate = pace;
+	}
 	msk->snd_burst = burst;
 	return ssk;
 }

-- 
2.55.0

