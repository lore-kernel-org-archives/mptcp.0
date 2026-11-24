Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557704;
	b=Th8F9Qn29mv+SvO+jUXWY/PJS3Hd6zf5XWBq7j7/DkyU4LS+76Ej8nfIlEqJItoVD7L/
	 KZFttm7DjbMNvF8YmvxAz93HVFnt4A00ROmSh/jSYdJBuxE5Z1OfeKP28JOKH293x/LrU
	 X2g+jAPyl/C/1/iQUev69Cwy4N9MaH+vOPyUQYw2UVlBb3uCv9ozZv2DGS6lbQJnRJbyL
	 xQ+OcnVRDkNR4KcZPiCLsEnESDRxKGB9oRB3swVjm50vlBwGHY8LpsLQyWi9k6eS3j8zF
	 tbG8SZI1Gmqkms+ZJsbS+D0O/nvHssaZIe7WAOBfs7wuzX2VhkfcWROXCz5UGxDBvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557704;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=akgy1IF03oHhfH3dm+WDYpmchl+tz47+k9fmEJhAutc=;
	b=MRcIBfPF182yw63qe5Pd5I9BMqZudM2bv2dbivnrJiyLmheU/qonBvC8Ispqf9yc3fsp
	 kKmr7lW1DK81g2SwYsmUcoDUdTcN/XJY5SIxU72/rFrJQd2Fcc0R3N1HtJEqLI8x00s6Z
	 qkhQIdtdGSNFysBdwzjmahrgnPPUkFuxbRdXZ/zSy5rS1BwJX8IIVBfgpQtYkA0/+KaK5
	 S3PJB+wXwuz6DBZpFaPOIprcFYlSgUqWONS54G7xI4We/bj01zjoJrq6+PPFrlNQzxvea
	 cPwX9l96q9zTIiI1qx4wiWxWVZpn2Z0I1G+fU6mmyfDVpWLl8NIaqEG7PYfaQGRfZhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB4+6JAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278CA606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB4+6JAL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1551F000E0;
	Tue, 24 Nov 2026 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557703;
	bh=akgy1IF03oHhfH3dm+WDYpmchl+tz47+k9fmEJhAutc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jB4+6JAL/iy3VSxkrzy6Ldlpu9WDkHCoIccSypsCg180DSnA5j1sm9hO0WKO4eJ/T
	 FqNHxon0gaSmpVpiVpIZt7hzZgC4K5kkZM4VoQaAwyywSJJcI6TuPNpoWgZlniSz1t
	 dzPssH6XXh0XPFghWIhLlV9oA++ETz8JKzP43/96hlLblGp/PJb9ukHG3LCVr6cfMm
	 EfzQ9FUvJjuJ5cApToWLAyzyYUkx9GD4uR5WZKhRryTCZNNwTlurOHgBMLe2tSNx/b
	 hU7tsZW5B1Et1uUcJdVu1+GlNPFSmHi1Asn+64vk3L5JE8wVsxvvV0Cu+ztXj6NoQC
	 jFI5aP5IuTMjA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:54 +0100
Subject: [PATCH mptcp-net v3 37/50] mptcp: keep the first byte after a
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-37-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m9vYyuwRYUYQmAg3qxcuoaeUuW7/Pj4Md9dE9Bxlrdg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOPk4Na0u+Cy0+7IqZvGpO+675p5SmnlM90rf5RVpr
 z28KgQWd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkWSPD/4C2gCMNzqz/v/Ev
 i5rWJ31UiT+qzHPimp3RNhVdx6/FpDP84RKfqfeu0EVX++s7OTXGZydXnNy+7UZ2WBKP2fozSvN
 keAA=
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

Note (Clashiko on v2): ssn_offset is not set if the crossed SYN-ACK
cannot be built: theoretical, it needs a simultaneous connect and an
allocation failure.
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

