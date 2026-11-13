Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599685;
	b=o4BQQWzZOlbuxG+rEl54M5+3U24Hj+FgY6q0rM92HQrQpBPs2j5jPNhMKk5zras18gOT
	 RjkVTxnUn3pRR0pF0GuZ35FajjWPxcZfyITPBrsgnmZ/1D36Dodyxup18VYINlpPbhP0I
	 WQwSBt4wJEEPD+rVJGGFOa1+5/Coa5d6JLaF7xk8agXlNQBvymgODuUZi/MMelmcxxWfA
	 UnHjRM/IFsgBEGbmjkqJWTlLS/hcLO2E3Z7RKd8zbHsqFMznx4S74LFWVKYGkh4WpM/0u
	 eyli82ru/Y54nqmiYxeN+CbMfpOZqKDvv1gs9aodOGhc2ScYYRyJi4llGlN0LbeTXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=imrHokibfbJUigTYinrScpriEfwVQrmZYyhf64nR94o=;
	b=qiOMNCjvYS9MLpHtMtjEu6flT64VBAUQkx9IG8kpgcTKDMT6v/H4Qihc6qCZon+MOuK+
	 99LfxNYuclNIr34ArZyG/vKXpRdxC7kJT7w36D/LC0+YAJTYpYM26ByeKUEwskUj8cXbR
	 YjxRCK16nGilZh7yNbMcOjetUkRoM7h+nudVuPfuXu2kk2zdHq+mcuuzB2uX4gdrUqPf6
	 6CUvk8woOVwBVu/Z71IM7gZkhh0MS6Jqa0L8S9aAacO4s6wZYJq9bxrQjZ7z56ZCyRU5q
	 jdhuAqzyAi8OEiVhy1OWKCEWpOs8OC6i/pQ6wiXFzgYGNxGEJSyq26W7e5w2/+Moe5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTshLBCA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4060A3809
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTshLBCA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A6A1F000C4;
	Fri, 13 Nov 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599684;
	bh=imrHokibfbJUigTYinrScpriEfwVQrmZYyhf64nR94o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HTshLBCA8untuX59EDlYgWjIDnV6qCtKHjzfNbxaTkWEyIyZt9c1CVmJyBJ0oMI/J
	 72PodRrIYiStPyJ2fDbDCLzkgxGhdXAp/Cfq48xtpi6ncQOvD8e+J0Qd7VsP2VekDQ
	 Fc/TCQDqYQRCDOGhvIMTItAYEs3K1CFQH7IWjP9qQ1P0UugOuWXWQiMttOJPNL9gvm
	 q41hM/ZzasGeWHZr2PBImZabNHY3Tc7LEx/PoBIYd7H0KAUpIu6XImJHaEb8PUl0i6
	 2HHiELknAz0umilo1g1Vq9Pq89uSnjQpiBVrGHY9usMAKoAmGZSByLKIAuUKAYhCSc
	 7w+iIz2KrTV0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:57 +0100
Subject: [PATCH mptcp-net 19/34] mptcp: do not fallback while old data is
 in flight
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-19-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8308; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NcNLfFtAD2iC34O32qNaGX1T4AF5wd0pN+2JeOTKac8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z93n3H+vj7/kkOYmRbE5CktEn5mFLau00P63rsM9f
 h3nQ3+vjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl84GT4X7bTYPPt7+Wry3V8
 BTnObLwnefzo9E2zIjvWuGxcl/RH6gDD/zjmi592/HBsEo/omFgdZhq1z0Jl85K98beOLewofMt
 6jQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

If an established MPTCP connection falls back to TCP while a zero window
probe or reinjected data is queued or in flight, recv() can return data
twice with no error, so the stream is silently corrupted.

After a fallback mptcp_established_options() writes a DSS option only
for an infinite mapping, so an skb that mptcp_sendmsg_frag() queued with
a mapping to data sequence numbers (DSN) is sent without that mapping.
The receiver treats the bytes of the subflow, in sequence order, as the
rest of the stream, so a fallback is only correct if the subflow carries
each byte of the stream once. But allow_infinite_fallback, the flag that
permits a fallback, stays set in two cases in which old data is queued
again on the only subflow.

First, a zero window probe is a copy of the next unsent byte, mapped to
the last acknowledged DSN so that the peer drops it as a duplicate.
Second, when a subflow whose MP_JOIN handshake has failed is closed,
__mptcp_retransmit_pending_data() marks all data that has no DATA_ACK
yet as unsent, although no second subflow has joined. If the sender
falls back while such bytes are queued, they are sent without their
mapping and the receiver delivers them as new data, as here for a probe:

    sender                            receiver
    ======                            ========
    queue a probe, a copy of byte N
    get data with no DSS, fall back
                                      read, open the window
    send the probe with no DSS
                                      no DSS: fall back
                                      deliver byte N
    send byte N as data
                                      deliver byte N again /* corrupt */

The fix used here is to refuse the fallback while old data is in flight:
- when mptcp_sendmsg_frag() maps bytes to a DSN below snd_nxt of the
  MPTCP socket, set the new bit old_data_pending of the subflow, and
  store the TCP sequence number after these bytes in its new member
  old_data_end
- clear the bit in mptcp_incoming_options() when a segment with a DSS,
  other than an infinite mapping, acknowledges that sequence number
- make mptcp_try_fallback() fail while the bit is set, so that its
  callers reset the subflow
- delay the infinite mapping that answers an MP_FAIL, and the fallback
  that comes with it, to the first data that is queued with the bit
  clear, and send plain mappings until then
- after a fallback, skip data below snd_nxt in mptcp_sendmsg_frag(): a
  reinjection that has not reached the subflow yet does not set the bit

A consequence: if the old data reached the peer with its mapping, but
the DSS acknowledging it is still on its way back, or lost its options,
a fallback attempted meanwhile resets the subflow, although it would
have been safe. This window lasts about one round trip, or as long as
the acknowledgments lose their options.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
between two unmodified Linux hosts, nftables removing the MPTCP options,
e.g. while a zero window probe is pending, or after a failed MP_JOIN.
Without this patch, the reader got some data twice, with a regular end
of file: the stream was silently corrupted:

  receiver   4.692: READ-TOTAL outcome iii-repeat-or-gap bytes 8388609 of 8388608 missing 0 twice 1 [...] end: eof
  [...]
  receiver   8.611: READ-TOTAL outcome iii-repeat-or-gap bytes 26000 of 14000 missing 0 twice 12000 [...] end: eof

Note for the backports: this patch depends on commit 119d51e225fe
("mptcp: fallback when MPTCP opts are dropped after 1st data") and
commit f8a1d9b18c5e ("mptcp: make fallback action and fallback decision
atomic"), two fixes which may have already been backported: they allowed
the fallback in the reproduced cases, once data has been acknowledged
without checksums, and after a failed MP_JOIN.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Move old_data_end to an existing hole, after
  subflow_id. Commit message: mention the reset that can now replace a
  safe fallback + how the issue was found, and its symptoms + note for
  the backports. Moved before "mptcp: continue the last mapping after a
  fallback". ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  6 ++++++
 net/mptcp/protocol.c | 17 ++++++++++++++++-
 net/mptcp/protocol.h |  9 ++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b4b3292fb4dc..682a7b93d962 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1317,6 +1317,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			return true;
 	}
 
+	/* DSS acking the old data, not an infinite map: no peer fallback */
+	if (unlikely(subflow->old_data_pending) &&
+	    !(mp_opt.use_map && !mp_opt.data_len) &&
+	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
+		subflow->old_data_pending = 0;
+
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f954a752797..7329deb43c62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1472,6 +1472,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
 
+	/* after a fallback, the subflow got all data below snd_nxt already */
+	if (unlikely(__mptcp_check_fallback(msk) &&
+		     before64(data_seq, msk->snd_nxt)))
+		return min_t(u64, msk->snd_nxt - data_seq,
+			     info->limit - info->sent);
+
 	skb = tcp_write_queue_tail(ssk);
 	if (skb && copy > skb->len) {
 		/* Limit the write to the size available in the
@@ -1552,6 +1558,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
+	/* old data mapped again: no fallback until acked with a DSS */
+	if (unlikely(before64(data_seq, msk->snd_nxt))) {
+		mptcp_subflow_ctx(ssk)->old_data_end = tcp_sk(ssk)->write_seq;
+		mptcp_subflow_ctx(ssk)->old_data_pending = 1;
+	}
+
 	/* on skb reuse we just need to update the DSS len */
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
@@ -1582,7 +1594,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
-	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+
+	/* the infinite map implies a fallback: wait for old data acks */
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map &&
+	    !mptcp_subflow_ctx(ssk)->old_data_pending)
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..75d4c2f82501 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -602,7 +602,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 9;
+		old_data_pending : 1, /* old_data_end not acked with a DSS */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -630,6 +631,7 @@ struct mptcp_subflow_context {
 				     */
 
 	u32	subflow_id;
+	u32	old_data_end;	    /* TCP write_seq after the last old data */
 
 	long	delegated_status;
 	unsigned long	fail_tout;
@@ -1330,6 +1332,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
+
+	/* queued old data would be sent without mapping after a fallback */
+	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
+		return false;
+
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {

-- 
2.55.0

