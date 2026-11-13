Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599701;
	b=kSQERUHVey1CV6Uz6VsW+bHeNUN1B+QbzgHj6+7V6fpneSmGWc0Wbc5gWM+ueIooslL4
	 54vqSrnuyVkpg69VLo1SJQnAA2LsuOSQzBqSWaJ7fGylmQHziHMnYR7yb79y5FlNMMzGy
	 xamkFBQinroCdK4Pilwg1WKmu1zgigV5T2o+WRlwI7MkFViZqxO8K356I1VE9YXKeiDDz
	 qyopzKwvK23ZHoFtn/0NTx6+EIYVAe2mUX+MuiDxAPuhg0EYrQCXzxE7bfYiU9FRr1G+7
	 8JlCBVDbDHq758hxYpAXkwKSEsExIwkivdoWPekp5Ij+NLWkIM96WmR9aa0A+oEYo3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599701;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4tW2S835loq7Wl7i1dtmVg485j77mIPCe+v47v3nVHw=;
	b=GouKe7aHNWIZ2uBc9n5Vu3k4nahemHQk+gJAvUQqnRxVKmT2EaFCYsmEDy4ztpozZv64
	 IHUNw/kdaEGsLLviDo50E4Tjlna0861ukkMZdlaMY2dpW1B/KaJwbPNUrcVxc4xaPNMPS
	 WeLxTgJdo7aORUadALUgUlg7nbmOe4xERAdupl9NdUgsw5gNBFJd57q1CzPgqelL8X383
	 e7YEZKPW4ES9YWnGb4abkIvZRHWjxEOh4MSAcNhca38MqnatU5AwqxtbQstYl9j01aaus
	 qifggEFvdrTa9oeYI5laBnKBZD0rl/YGMUz3a2PTml6G/67qC6hN74yD0WGiISLVfNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NqxaN/yp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB0606BCE8
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqxaN/yp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6922D1F000C7;
	Fri, 13 Nov 2026 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599701;
	bh=4tW2S835loq7Wl7i1dtmVg485j77mIPCe+v47v3nVHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NqxaN/yp9IT0fl3cJf0k1rlFmxxN1mfghvaJNgj8xG+N1UJkWmNHMran35Q36mcy2
	 AfiVMXCO5MS26y+21DQvHphGh065tA1wVaV+j3nOqYO2OFyp9Y5dU+K4ChagQicYdE
	 ilXPeUwVEPCx0lTcLz70KsXAJrjN/Lo4LVdj9UFdU6F6QHoczpAtwU+UEq8AcfWw8X
	 y8z1xJ5vWjKcPse1IccFE0muH5RoV/WdQiwEirEcUl53HN66gwt4RIWOjTtcb5ZuTU
	 6xT6M6eu85k9TzlkpPS1G9/E7RZ5I/xHLtCNv1OUlayO9swnGGQ39AD7XMoS0rSHCt
	 kKXiK296HR2yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:11 +0100
Subject: [PATCH mptcp-net 33/34] mptcp: continue the last mapping after a
 fallback
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-33-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7098; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oGSx4xgFBLKeRtjHSptsuqQYOFhNbd+CsQ+BTOkQmMk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z71K3PFxlXrOCe9TCSa79dTKcu7HV12eMFv61dNjp
 5xjWtmPdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwk9zTDH172R/Ex3vW+YVUZ
 Ppf8t051Ffx7uf+SmOKzowd8m3P8Ghn+e2gtyDvcaLzdtXe1wBIrObcfz5pZ5D0rT0RfE4npVWD
 jAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

An established MPTCP connection that falls back to TCP after a zero
window probe or a reinjection can stall in one direction, so that recv()
returns neither the remaining data nor end of file.

After a fallback, subflow_check_data_avail() gives each skb a dummy
mapping, at the data sequence number (DSN) iasn + SSN - 1, where iasn is
the DSN of the peer's first byte and SSN is the subflow sequence number.
This is right only as long as DSNs and SSNs advance together, but a zero
window probe or a reinjection maps old data a second time, which takes
new SSNs and no new DSN. Each later dummy mapping is then too high, so
__mptcp_move_skb() treats all further data as out of order:

    data    SSN 1 to 1000    DSN iasn to iasn + 999
    probe   SSN 1001         DSN iasn + 999, dropped
    ack_seq                  iasn + 1000, the next DSN expected
    dummy   SSN 1002         DSN iasn + 1001

The fix used here is to:
- keep in the new member dsn_base of the subflow context the first DSN
  of the peer's last mapping, minus its first SSN, plus 1
- compute the DSN of a dummy mapping as dsn_base + SSN - 1
- keep in the new member dsn_end the highest end of a mapping of the
  peer so far
- make mptcp_try_fallback() fail while the peer's last mapping ends
  below dsn_end, so that the caller resets the subflow

32 bits are enough for both: the dummy mapping only takes the lower 32
bits of its DSN, see __mptcp_expand_seq(), and the end of a mapping
stays within a window of dsn_end.

One case is left: if only the receiver falls back after a zero window
probe or a reinjection, it now delivers the first MPTCP-level
retransmission of data that was new when first sent, as new data, before
the sender resets the subflow, see "mptcp: stop resending data to a peer
that fell back". Without this patch, the receiver stalled instead.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
and with a new Packetdrill test: between two unmodified Linux hosts,
nftables removing the MPTCP options after a zero window probe, a DSS
checksum failure, or a failed MP_JOIN. Without this patch, the reader
stalled for good, the data staying in the out-of-order queue:

  receiver  22.764: READ-TOTAL outcome ii-right-so-far-then-nothing bytes 2670592 of 8388608 [...]
  [...] end: hang: no data and no end of file for 20 s
  RESULT [...] R: DssFallback=1 [...] OFOQueue=204 NoDSSInWindow=145 [...]

And with the Packetdrill test:

  dss_fallback_after_probe_server.pkt:25: runtime error in read call: Expected result 2000 but got 1000 with errno 22 (Invalid argument)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Signed-off-by: Chris Mason <mason@kernel.org>
[ dsn_base and dsn_end on 32 bits: struct mptcp_subflow_context grows by
  8 bytes instead of 16, and lent_mem_frag stays in the same cacheline.
  Shorter comments. Moved after "mptcp: stop resending data to a peer
  that fell back": alone, this patch turns a stall into data delivered
  twice, when only the receiver falls back after a probe or a
  reinjection. Commit message: mention the remaining case + how the
  issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  9 ++++++++-
 net/mptcp/subflow.c  | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18222dd78fed..f0b93c31b16e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -578,6 +578,8 @@ struct mptcp_subflow_context {
 	__wsum	map_data_csum;
 	u32	map_csum_len;
 	u32	prev_rtt_seq;
+	u32	dsn_base;	    /* MPC: DSN - SSN + 1 of peer's last map */
+	u32	dsn_end;	    /* MPC: highest end of the peer's maps */
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
@@ -602,7 +604,8 @@ struct mptcp_subflow_context {
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
 		old_data_pending : 1, /* old data not acked with MPTCP opts */
-		__unused : 8;
+		map_old : 1,	    /* MPC: peer's last map is below dsn_end */
+		__unused : 7;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -1332,6 +1335,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 
 	msk = mptcp_sk(sk);
 
+	/* the peer might still be resending old data */
+	if (subflow->map_old && !__mptcp_check_fallback(msk))
+		return false;
+
 	/* queued old data would be sent without mapping after a fallback */
 	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
 		return false;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 64e8f5c36415..728b27be1ad0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -540,6 +540,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	/* for fallback's sake */
 	subflow->map_seq = subflow->iasn;
+	subflow->dsn_base = subflow->iasn;
+	subflow->dsn_end = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
@@ -1434,6 +1436,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	return true;
 }
 
+/* Fallback: dummy maps go on from the last valid one, unless it is old */
+static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
+{
+	u32 end = subflow->map_seq + subflow->map_data_len;
+
+	subflow->dsn_base = subflow->map_seq - subflow->map_subflow_seq + 1;
+	subflow->map_old = before(end, subflow->dsn_end);
+	if (!subflow->map_old)
+		subflow->dsn_end = end;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1467,6 +1480,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (unlikely(!READ_ONCE(msk->can_ack)))
 			goto fallback;
 
+		subflow_update_dsn_base(subflow);
+
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
@@ -1497,6 +1512,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
+			subflow_update_dsn_base(subflow);
 			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
@@ -1528,9 +1544,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
-					      subflow->iasn +
-					      TCP_SKB_CB(skb)->seq -
-					      subflow->ssn_offset - 1);
+					      subflow->dsn_base +
+					      subflow->map_subflow_seq - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }

-- 
2.55.0

