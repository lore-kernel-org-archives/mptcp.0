Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254184;
	b=T4OtO9pxas9ZuF1Bj+fFGAzEcML6AliZJw3WnD50zPvaOTCfL2PYUZNuaVG9vqS0N5ll
	 5WTn7RFp3lpVI6YO0lxqcKBrddkkOr479iYO60zNm1Z9RH/2W2oPr6jETyn0uL43DSSID
	 gOtN8g/SBx2VHWQ38imZfarz9NQO7llHns0cILO+N3vLhbfJ+x4fKLVVGqfRn9hjqxucV
	 7vZS1uacDGzma3FF5OYjfioV686F5dzefEXjp3ZvCLyalGCami9q+S1sjl5lXo4j+JeM8
	 JrDtuplmzQ+4bx/kBzWvbY6KbeGSkytJltxye2OW6fkcfhSFiv1g/3MswTGIcOyXkpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254184;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LV8KRQP6HGlpp4MHS+udQcFpOfdFxrAxkEL4pL+12Zc=;
	b=T8Zo5NH06TxZ5ZztqPGeyG1FNanvHK14PWWjs15y+lDSFb+0pl/rKX1D3jc/Ki0xfuzb
	 LNN7hH9rg8s6rv5bay6jWw/d31NMfq9EogQNS1p0HAVfIdWk6r310BddpKP46b83TF6zb
	 TAVbqqZkqBxvjW5gk5dW0RYAPjZY0GroMTYg3IBYdWTbj5DbEC97i/JZXySp9YSdA/nBP
	 BQL5jrmTZxCwhUBhU2lAQd0g8nmrZUtp0/nKoWl/GvMsdHB38WXW7nlS1u1B5P8/RXDoz
	 GiFN236tHCAwUpn6unYPUOpx+cMrt2VZXB60gtgf2BDpMBE6RyitXaE+emPSBbF90mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+is8cZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56C606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+is8cZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB21F000C6;
	Sat, 21 Nov 2026 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254184;
	bh=LV8KRQP6HGlpp4MHS+udQcFpOfdFxrAxkEL4pL+12Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W+is8cZlziFmWrt+/UZyIBrpGydJZLC528myMsmf26a4GwwJ9zCXaf+C1YPK7sDV7
	 sG746UrQqZ9JzSsI2bzr9Ac4+/ZP7MqVVFKvtryQ2Uw7JVRkoWJOxIoCe7jjveV2vm
	 QQ+PjWNSHh9ClHUtHD3W+CTYDXR9Rl3t11jzkVDpj0s/v2l1ZuPa/WQNk+PgCLti60
	 GnZIbia8Oey31Uc8rUUZSxXVuNKKvmFyNkPa2H2rEqu97k455/0i0Z3GxK0KAZ5m0t
	 IONhTrJURaEFbtFSY+O2o6pvWMnUiCFTwcyMXjB5dGRLbWUCIJKMn/oD++idV2LISI
	 XJoNl3I/kbsDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:49 +0100
Subject: [PATCH mptcp-net v2 51/62] mptcp: keep the first byte after a
 simult connect
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-51-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XX2gdrmjZ78yWy8Y5Iz+qk6/TDt3hK4TAf4G+2wKbhM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0/PPrXF6ffKN8Gn/boP636dVU+7pnlAM/pp6Wzc4Z
 LvB6UNPOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSdYnhf0DOa2H1eX5/nX6l
 2KyPLd7vVRsRvWTK24/+j227j7w/8IyRYd489Q3+AsV7ew/+td+icO7i57nvtd9IeKr8ZJYLX6X
 wgx8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A simultaneous connect leads to a fallback to TCP, decided when sending
the SYN-ACK from the SYN_RECV state. The received data is then mapped
with dummy mappings, based on ssn_offset, the peer's ISN, normally set
by subflow_finish_connect() when receiving the SYN-ACK. But here, it is
only called on the next packet, received in ESTABLISHED: its sequence
number was then used as ssn_offset, and the first received byte was
dropped.

Set ssn_offset when sending the SYN-ACK after a simultaneous connect,
and only take it from a SYN in subflow_finish_connect().

This issue has been reported by Sashiko, while reviewing another fix,
and confirmed with a new Packetdrill test: after a simultaneous connect,
10 bytes are received. Without this patch, only 9 were read:

  simult_connect_data.pkt:24: runtime error in read call: Expected result 10 but got 9 with errno 115 (Operation now in progress)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko
---
 net/mptcp/options.c | 5 +++++
 net/mptcp/subflow.c | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 05b9c66aaed6..41eb39968a9a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -474,6 +474,11 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	 * in mptcp_established_options_mp()
 	 */
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
+
+	/* simult connect: the peer's SYN-ACK will not set ssn_offset */
+	if (unlikely(sk->sk_state == TCP_SYN_RECV))
+		subflow->ssn_offset = tcp_sk(sk)->rcv_nxt - 1;
+
 	if (subflow->request_mptcp) {
 		if (unlikely(subflow_simultaneous_connect(sk))) {
 			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f73e4b8deca4..439a11d92281 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -591,7 +591,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->opt_ack_seq = tcp_sk(sk)->snd_una;
 	subflow->conn_finished = 1;
-	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
+	/* simult connect: not a SYN-ACK, see mptcp_syn_options() */
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
+		subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);

-- 
2.55.0

