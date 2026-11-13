Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599675;
	b=v4E2vxuHP6txmxcqcmMw6qPaEwG5XLbq/Zl5RoLVPph5vEoPcXg0csE9yBKCqwal3SQ5
	 yJUK7/GsiooY44RXDYCMARMVMOGob1S5/I+3sTW7mU8S0G/U4VWqjSXbZ+qj/DJ2u1XOs
	 k6EHlupb/IWC13qvR/qQnsu9tsdDcOm8kZTy4kb1HuJ6QdS6aD5SKK2tQUZW2ubIC9MIh
	 9HbX7DZ9r1l6pJ7pFuz4hZrOcMllg/Tf0/dUvRUD3J14dhIQp7k1K+yJUdaC51b08E67f
	 cOi0bZUJCElUOO+JdDRcJ0FtO6vgTgogcUOrlzE5mhzMkIhx1o6+JnoyJutc/isg/JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599675;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8Lxk2leFGI5ZQWF4W1kNNO2MPur9K1wnOp9pbPXwSHs=;
	b=Q2ITb63K9Mnxcb259IzL5TAicPXe5icn9brftkHPC0rc+Hb+5D+k/8IHfacKMGvDdYdp
	 C2UTs6zB5THaQcNoxAoqAqniD2WkwXBIBfMKUoFYs9Bq0Cm41YxLcWGK5jukrfUdWMxtj
	 ILtMjPZgZDbXJodFOeSA6TB8q27T2G2qUqK6SVdswWC/NRcPCyzhMiZEbf5h2CA80jLpd
	 tfWYNJpD3uDc+O9opq+tcb7mGOdFrIak+DntTlxWreQnWYoB9P0sjYHkmKAZhvFZSR+ik
	 w3L1BJhn9bdLHjLqP3fWKrBwk2JzPdluGLeJF2BCXTfvbQ4G8U7xDmlC3W86I2h2PhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzB86FiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE16606F37A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzB86FiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9CD1F000C4;
	Fri, 13 Nov 2026 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599675;
	bh=8Lxk2leFGI5ZQWF4W1kNNO2MPur9K1wnOp9pbPXwSHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mzB86FiN38pRZj+Ke1IuOkmB2wwd+Id1aADCkSeQ+Uk8OWj5G1j/FDT9J3tXsCI/y
	 Rpi5GLV1ysEi9E1x+iCxYKa2PozGAFHmNRP+qRzzJsA+OuxbEyGcZCp9r31LP/jVtV
	 ZcawDzv7oI+8ZHdeTkGeiK3T+j7S2fxA5T6nk6i/SU7cqadddfS9oisyMd3mmAZGQ3
	 m93Ug2ZYRa/un/DILeKpzNzKpO7h/pOj6Yv+v5gRHHzKYp/gBEel+OguB6u6uLw+Ld
	 GHb5WI4dgY7YTt+rFp2O5hx/fZYBCFk1r4pIZNESO6hHUGTwURzxYcPGWieDWr3k/m
	 SDPvon84bsrFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:49 +0100
Subject: [PATCH mptcp-net 11/34] mptcp: do not use a raised snd_wnd for the
 send window
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-11-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y4cht3Zrr/MZq0iXxTj59uQzUB0cKXZS8Asa5QTlug4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z9387SSVKtBX4v7O2c1nbr78nlKFd/ztvbuW/bE46
 3jo9kfHjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlE/mFkeKKfMaGu7nncwyUc
 v5pdmbqt/gWrPFmpOqE6Mdk+SnDud4b/GffV30pN9FjHFc1XULSy5GlWlKX5gtCXj9VKLQL2Ot5
 nBQA=
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

This raise has been added by commit b713d0067574 ("mptcp: really share
subflow snd_wnd"), but snd_wnd could already be too large before: when
nothing moves at the TCP level, tcp_may_update_window() ignores a lower
non-zero window, while the peer can announce one with a DATA_ACK that
moved, keeping the same right edge.

Use the window announced in the packet carrying the DATA_ACK instead.

In my case with BBR, a small TCP rmem, and a second path with a much
higher latency, a lower throughput and some losses, this small change
can double the throughput in the worst cases.

The issue has been reproduced with a new Packetdrill test, on a single
subflow: the data is acked by TCP, then by MPTCP with a lower window,
keeping the same right edge. Without this patch, the 2000 bytes written
next were sent, instead of the 1280 bytes up to this right edge:

  dss_dack_window_server.pkt:23: error handling packet: live packet payload: expected 1280 bytes vs actual 2000 bytes

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 71579238a951..b4b3292fb4dc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1121,9 +1121,11 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
+			   const struct sk_buff *skb,
 			   struct mptcp_options_received *mp_opt)
 {
 	u64 new_wnd_end, new_snd_una, old_snd_una;
+	u32 win = ntohs(tcp_hdr(skb)->window);
 	struct sock *sk = (struct sock *)msk;
 	u64 snd_nxt;
 
@@ -1144,7 +1146,12 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		     after64(new_snd_una, snd_nxt)))
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
@@ -1314,7 +1321,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 * monodirectional flows will stuck
 	 */
 	if (mp_opt.use_ack)
-		ack_update_msk(msk, sk, &mp_opt);
+		ack_update_msk(msk, sk, skb, &mp_opt);
 	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not

-- 
2.55.0

