Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557691;
	b=Izvk55Alm3p1z3fFd+IGtTN653vrIc0CSmtb3AXRalxwy4NTR06/3PCHNyP78DfDOTFy
	 HCoZP6z5GvnfY4+Nn7T3RJvDXn1h74XWMrXaGzzhA7jpHFg+so3KUbCnDlgm+faLxKpmQ
	 /pXit4pO9kZXJ/uI23JrDlPYoqq/Xg0tOzyCbArKrfSuYiN9eoqjSPYvRiDyv6vteQjSa
	 wHSKhstTmQTBrPe7fKrO7TG1f0BHXsRl0uT13BZNihVNBKAhEFDzz61gzc/SOXh8GA39g
	 Cfyu7gFG+K4fH/MKCqcwr5D3Yo6aGP7LpfjCLu7HY5zJrJ/3V2KiVbaYzU6rEzI75TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557691;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8rGcvMb/ci9H+FeLt1r90ebY+DfeaHXwhwvO3CL7YsI=;
	b=qDY64tjahHSE1sF12rxzqUZFULWFyOcCHWdSyv9GbJrnWCT00HCy0DJR2eEpLoOnSMri
	 3BV3hsFeL+VIb3nmvOs9UXNdAouxMJquYn9xVAY5watJdbqgYBkC7hnS9oXZqsv+AKAyK
	 myaWgnsxMamsF+ioDZsjSscMCuGkNWgewfk2LyqHvC+3TGrLEzTZvgF/v/5sfNd+9y8li
	 8KS2pxDCi9YK4+qvBgODSh8YHY1sI0o7gggAQpQAthF62xBDNpFj8Shy+z+Lck8NmsZ2j
	 Fab4C2Ks1FDCgbzabXBfjK2CnBpwwRcF89EFQH6rK6lTuTRuiXsL2vaKTOrLAdIyAhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxbh0PZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB147606A32C
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxbh0PZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375151F000D2;
	Tue, 24 Nov 2026 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557690;
	bh=8rGcvMb/ci9H+FeLt1r90ebY+DfeaHXwhwvO3CL7YsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bxbh0PZEHEyjlL2y/UoOd4FCh230kwmQV3G7nVAxkssJX/U1g64g3G5dujgNBNS6d
	 TFVwg9Idtqk+bFzL/TLJyPVl7qkjNVy3LeBlS28C1dLbc2zNiPqwFbYdf3pLzvq8CO
	 mxq8JUcfOTefPc35u7pUGn5Y+tbTI9aIb/DieNlKYKnofH/U3A1cb9UAuHYlsIEiIf
	 8R5Dt+G7kuT0z/ff3aX7pg3rHQg29ioiuGPW8fTSj60hXSXZLJd4ofF5gCEQ69KST7
	 A86xhOA/Ku+1nOa+LUmM239Reecma7HKMgTUJ6hjZDAjkhG2MWOWRK1gES7ArqVfus
	 I0PNCo8o5n2yA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:44 +0100
Subject: [PATCH mptcp-net v3 27/50] mptcp: do not fallback while old data
 is in flight
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-27-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9121; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OeXCnNe7JxwjJWiMcirJ+96Z1LyJat0vWuQbRMlA8YY=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGsGCQfIU7TowPB++rO5BXPpetoHj7DEPLwB12FgcxOlPLXva
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmsGCQcACgkQfCLwwvNHCpcYEAEAwi5A
 99GO8B71sp9kxXV5pUAuQroPcmgodhUKDJWSOAABALHp9jtWrtET8FU5RXl+/89d8Nm929b2DMb
 9YxAL7usB
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

This only prevents a fallback of this side: if a middlebox removes the
DSS of these old bytes, the peer can still fall back on its own, and
deliver them as new data, as it cannot tell that they are old. The next
commits limit this case, but cannot prevent it entirely.

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
  fallback". Commit message: the peer can still fall back alone. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: commit message: the peer can still fall back alone (Clashiko). Only
    clamp to one MSS when sending the infinite mapping (Sashiko)

Note (Sashiko on v1): an infinite mapping can stay pending, but nothing
waits for it: an MP_FAIL is only accepted before any join or MPTCP-level
retransmission, so TCP retransmits the data in flight.
---
 net/mptcp/options.c  |  6 ++++++
 net/mptcp/protocol.c | 20 ++++++++++++++++++--
 net/mptcp/protocol.h |  9 ++++++++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6b1a3994fb49..9133e3d6e5d9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1333,6 +1333,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index 39490ff40aa4..7df5a2863555 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1486,9 +1486,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	/* After the fallback, the MSS no longer includes the DSS option of the
 	 * infinite mapping: send it in a single segment.
 	 */
-	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map))
+	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map &&
+		     !mptcp_subflow_ctx(ssk)->old_data_pending))
 		copy = info->mss_now;
 
+	/* after a fallback, the subflow got all data below snd_nxt already */
+	if (unlikely(__mptcp_check_fallback(msk) &&
+		     before64(data_seq, msk->snd_nxt)))
+		return min_t(u64, msk->snd_nxt - data_seq,
+			     info->limit - info->sent);
+
 	skb = tcp_write_queue_tail(ssk);
 	if (skb && copy > skb->len) {
 		/* Limit the write to the size available in the
@@ -1569,6 +1576,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -1599,7 +1612,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
index 888ee9d66967..6dbd912e08d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,7 +605,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 9;
+		old_data_pending : 1, /* old_data_end not acked with a DSS */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -633,6 +634,7 @@ struct mptcp_subflow_context {
 				     */
 
 	u32	subflow_id;
+	u32	old_data_end;	    /* TCP write_seq after the last old data */
 
 	unsigned long	fail_tout;
 
@@ -1346,6 +1348,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
+
+	/* queued old data would be sent without mapping after a fallback */
+	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
+		return false;
+
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 

-- 
2.55.0

