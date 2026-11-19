Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072615;
	b=IgfC8EJ/X3c8dt7ncpVxrdyexty0F7V5VaGFqIHW+ES4rCvvsGejTHzBlOLYz6bbsdEz
	 adIDpw5Na/1KRMj2FSeU8rzEy/ydL49My6WnnbV4S2T8Rz+7Bd9+OleCL1ZLjfNQynLTO
	 kSIBJ2G4x0NYqDnJMHLtPueD64ki1YmcoiHjP3xRHQ0kwgu4dOpaknvgezZl+x4HshR9P
	 +QghH6JG25Y4OBsS5FS7paR3mLL/xGyduO89oM+3tiA4PAWLeSCnbSeEhxl8s6BeqEcqV
	 c1MjYIWKZEynRO6LpwTpC68VQ+HJ6sMNh+fxu/D3AM8Xvr+hv8Qd+T7M45v4bO0N75w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BfV4B5f0ZbbZlYUsnZWOcvGjN7T23ipEhB0dVBboxDg=;
	b=MbmK3Wu6193/C1NwK4mv8BeGPYR50E8RNbekOBzEacBkG2tgbaTwfcFl1mUpPJDJx/0Y
	 +WoAzM0s9HzUk3J2Ygr507sN6myL4Y2Zq7N0A6tYH9IL4I/Bw8k2Qy+dBAPca0/fxN1qj
	 TCZGl0cDda4TMpMvBXvsCasWVTyMY8UIEAm0pnHjN8Z41oo2sksD309FKq434AU847Xu9
	 YJGjQgBUq3YyuH3hB4MrMOYN2F7eTaezE3Y8ntLlrDRUtgmrv5pZoLGRhFTE0quGrYfRm
	 ai1IUg+m38Z06Snve5ozMNm3n2XEvE0H38eAF+xmBQLf5UgUKbEJUxY+HBUWXWcdrYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K1nMedpM;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26718606A335
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26718606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K1nMedpM
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eff4c37998so16352685ad.1
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795072614; x=1795677414; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfV4B5f0ZbbZlYUsnZWOcvGjN7T23ipEhB0dVBboxDg=;
        b=K1nMedpMt/Fmb0sSKcVUaFBALi/qNuHB+hqK2rusnJR67TCwEZ72u9SduMyZJIBnNM
         J1Curgfu8pXAgn0mOibfcScQxLfsT8SrEtRl/UFSbS5xiynxEagab1uZL7RJhAJOCXpq
         JDFEo45RYSkSoW/l3Io8zO9A8xRLcOBBSpOVtQJsVxVGAUJ8m5VkRN5rls7h2apkEtfX
         1Bqd/27LLKa0mI9xP+tJpXTmb13vLbbqVNQcQqyAtIOEcjtCWxWaSrrc4TzwsUnHwDZA
         3ddpPX0UB82WSjITZiSJ+vYqeC19YokEyPmbnYwJFxPbQZd+AqobjVBXt+0AskVMX88q
         bLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072614; x=1795677414;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BfV4B5f0ZbbZlYUsnZWOcvGjN7T23ipEhB0dVBboxDg=;
        b=gE274iIbEl62uyAc2hkKF+WMRip+5VeZXkMLIIjIMAyPirfr3vAXrP9b/zj2ZN5aMw
         osdoeHBvIqGvYCUqk/4q8LSktgtu2NACaopnnGM/jTJ2zB+feA0SsmqySZhaEqheb6so
         t8aFhqDbGRSKMGSCiw+slvczlo1kA3z5tpS2S66WiIikawQP0w7kRpf+yH/TuKgxVmEC
         /WB+QrN6d9UT7pzqNDxpdSJHYJXR3LV5SXcMbq6iyTK3DtQ2cNOSAjSMSbSkgUUB3LSU
         qrrsz3dMOGB6VjSByY+8F5D+56byME5/3EjAyvHsaLdlW0b/avtq8HNtf2mjA2KjvHDw
         yuGg==
X-Forwarded-Encrypted: i=1; AL+hErE0UUg3SP8jHj1SqRc4bUTMy9xgzKgS9uMFUV5fLEGQPQ1h2kSwMo/yO8xNhjZ4ZG6q6Ty7KQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+IZlHf1b2YoVSfyrI1r7xpcE/HUF9IAa4s6czCkx09cJ1pvZyZ
	qYbTW58raAWvc9kc2uGWOfI4dWaNmQt14MZwIAwE0rCu0Ihyr3rFdAFd3nOM09DfdeYN+42/DHB
	9Vs6VsA==
X-Received: from pldb21.prod.google.com ([2002:a17:902:ed15:b0:2eb:3675:626c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ace:b0:2f0:2aca:6795
 with SMTP id d9443c01a7336-2f02aca68f8mr8991735ad.18.1795072614384; Wed, 18
 Nov 2026 23:16:54 -0800 (PST)
Date: Thu, 19 Nov 2026 07:15:54 +0000
In-Reply-To: <20261119071649.374106-1-kuniyu@google.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119071649.374106-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 2/7] tcp: Don't collapse high density skb.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() starts collapsing skb to a new skb if either
of the following is true:

  1. skb is less dense compared to tp->scaling_ratio
  2. skb has read data before @start

However, this could make situation worse.

The new skb size is SKB_TRUESIZE(SKB_MAX_ORDER(0, 0)) at most,
and with PAGE_SIZE being 4K, its scaling_ratio is 222 (86%).

If 4K-MSS GRO skb updates tp->scaling_ratio, it can be larger
than 222.

Then, even the newly collapsed skb could be detected as bloated
by the next tcp_collapse().

Also, even when only a few bytes are read from GRO skb, it is
collapsed by the 2nd rule, making less-efficient skb.

Let's cap tp->scaling_ratio with the collapsed skb's maximum
scaling_ratio and use unread bytes for bloat detection.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_input.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 838d4f470c94..b4e3d623c4a2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5818,6 +5818,19 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 	return skb_rb_next(skb);
 }
 
+#define TCP_COLLAPSE_MAX_SIZE	SKB_MAX_ORDER(0, 0)
+#define TCP_COLLAPSE_SCALING_RATIO				\
+	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
+	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+
+static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
+				     u32 start, u8 scaling_ratio)
+{
+	int unread = TCP_SKB_CB(skb)->end_seq - start;
+
+	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5849,6 +5862,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
+	u8 scaling_ratio;
+
+	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
+			    TCP_COLLAPSE_SCALING_RATIO);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5865,15 +5882,14 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - bloated or contains data before "start" or
+		 * - the unread portion starting from "start" is bloated, or
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
 		if (!skb_frags_readable(skb) ||
 		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
 			goto skip_this;
 
-		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
-		    before(TCP_SKB_CB(skb)->seq, start))
+		if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
 			break;
 
 		if (n && n != tail && skb_frags_readable(n) &&
@@ -5892,7 +5908,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	__skb_queue_head_init(&tmp);
 
 	while (before(start, end)) {
-		int copy = min_t(int, SKB_MAX_ORDER(0, 0), end - start);
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
 		struct sk_buff *nskb;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
-- 
2.56.1.708.g77570a6a1d-goog

