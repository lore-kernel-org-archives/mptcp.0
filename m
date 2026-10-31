Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486691;
	b=T6DH3JHbWunngPQO/+fxBtTqCOO+r1W7gWbqlR4/EeCmqVeJeYeccD1gVm38xvm9AbA0
	 VJlGUZEPs183lAz27UuZUFR1xZNa/lZaEZJDxsnVtvquVCRj8GcwcXKc6RbVYO7v2MtBL
	 g7f4TpfdJuIG6BXS727BcY0EWhpr1+zLoif5NCX7rjfkOw3yUDA+O4rQY4pUl4LHlUNcP
	 Xmx/xZ5UveYZHj6DLdoFcMQ6j+kMzXGB0U+GD77psnRUnlYTOCH0vBH/DodO+ZsY36zx1
	 DJ4ixZsSJ7RTgnZxbjHCn8dgi/l0chQFrzNqIpvG9OlHdawWuala9uUU/VA1lyNhD1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486691;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eu8rB7/B9jehHVyR5w59GGdXuac08HDFYLvVcT+vCJI=;
	b=T1bHrNF5myrbXinOehYnnEdrTwbDKn89lmakUPZLO3/kFDIq8liHojvnjGwxaGv7wHbS
	 aZX9b3TClA8vEi7NIvL+pYWW36zS1gwwriqDkTfFnSTuB+NcsJuKEyKcWcSHuItoaF3IY
	 gqc6WRMctbIrcIo4BJJ2iJ5XUMSXFsFsu4IM50Tfy4iTKI/0GYuKZJ0rsMtY+vmVhmSr4
	 uyxfgUj3Zki5RE689D2jzoef8wL3siVoYLSgF0P7HarjKUrKimpE7xBpwHrzZMHnFpjvR
	 BfmgHSXpu0j1hE0J2EGEQgqI6aV1I5l1tuicc6LGqCvRwjPByuFiCmhWEgcidUKLNZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VN+mV/PE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B69606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VN+mV/PE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC371F0093A;
	Sat, 31 Oct 2026 22:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486691;
	bh=eu8rB7/B9jehHVyR5w59GGdXuac08HDFYLvVcT+vCJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VN+mV/PEhaPVn/prVTA5KKEs6o8s9zjHwQDPPfeKDQJNBgyiRi7iu+y0H/CE9wqL3
	 Ot3ZC/LJmDe2t56YZd6UudJWqQVOg9FeicjhKCzwfb+9v/F3T8fdo5fhoqzF0Yi8Qo
	 AKCHnjMK61lROLLjB9f8KM/vvhlwLZBzUKlA2HZEDqkHi7GuetVPvW2IrOdSc1lx6x
	 HXiGQdz7DTwLkaCQP8z3nOL/WgPKXEbZvdOYSVysJb1L29tGg0FABTH9WYR1aM7GXH
	 kT+dwCLaifwJf7ui3xNTk0iDo/9tdXBwm8ApVk9g/yCJji9WQyW2vzcun3wLUlBwm5
	 0Clq+CnEE8erA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:33 +0100
Subject: [PATCH mptcp-next v2 1/8] mptcp: do not use a raised snd_wnd for
 the send window
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
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-1-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aZGT/rxawpdMxpCWU75u0u+d0BPRijwb9nQ7fnPxrM8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5UfXPditej9hvcfZHqGkp9NcUkOkDlbJf6yt9l1Sz
 nnuSYRjRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQOFjIyTP2s8FP0QbuF6lT+
 N1X2V57aSGt/XrkxTtIkbe3COfVP1zP8d3SJeJnupRXlseMaz4Rv1+ZwTBF3+Rnzr2q+ieIzGTs
 LXgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ack_update_msk() sets the right edge of the MPTCP send window from the
DATA_ACK and tcp_sk(ssk)->snd_wnd, but this is not always what the peer
announced: mptcp_check_allowed_size() raises it to
window_end - data_seq, so that TCP lets through what the MPTCP-level
window allows.

That is fine for new data. For data sent again, data_seq can be below
snd_una, and snd_wnd ends up too large by the difference. TCP only
overwrites it when an ACK moves things forward on this subflow, see
tcp_may_update_window(). If a DATA_ACK moved by another subflow comes in
on this subflow before that, wnd_end goes past what the peer offered. It
only moves forward, so it stays there.

The sender then transmits data beyond the peer's window: the peer drops
it (MPTCP_MIB_NODSSWINDOW) after TCP acked it, and only an MPTCP-level
retransmission can recover it, which raises snd_wnd again. The
connection can then stay stuck at a low rate for several seconds, with
nothing in flight on any subflow.

Use the window announced in the packet carrying the DATA_ACK instead.

In my case with BBR, a small TCP rmem, and a second path with a much
higher latency, a lower throughput and some losses, this small change
can double the throughput in the worst cases.

Fixes: b713d0067574 ("mptcp: really share subflow snd_wnd")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adbf8e0773db..b0e8b1200cfe 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1121,9 +1121,11 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
+			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
 {
 	u64 new_wnd_end, new_snd_una, snd_nxt = READ_ONCE(msk->snd_nxt);
+	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 old_snd_una;
 
@@ -1140,7 +1142,12 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	if (unlikely(after64(new_snd_una, snd_nxt)))
 		new_snd_una = old_snd_una;
 
-	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
+	/* What the peer announced: tcp_sk(ssk)->snd_wnd can be larger, see
+	 * mptcp_check_allowed_size(), and is not always updated.
+	 */
+	if (likely(!tcp_hdr(skb)->syn))
+		win <<= tcp_sk(ssk)->rx_opt.snd_wscale;
+	new_wnd_end = new_snd_una + win;
 
 	if (after64(new_wnd_end, msk->wnd_end))
 		WRITE_ONCE(msk->wnd_end, new_wnd_end);
@@ -1310,7 +1317,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 * monodirectional flows will stuck
 	 */
 	if (mp_opt.use_ack)
-		ack_update_msk(msk, sk, &mp_opt);
+		ack_update_msk(msk, sk, skb, &mp_opt);
 	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not

-- 
2.55.0

