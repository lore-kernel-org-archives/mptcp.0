Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809723;
	b=VKGcLm2jSjl/wPmX5/7NxGLyzk1LrbxXRZYmoC1Kc+GtkNECa77jUMV7Pc/rWtBwTR89
	 UF6QqfLrecFiveQucpzQmASGudYZTMAH2wnBVCuG9CW8aiSh7FQYpUGcvgd+FUdObqh5l
	 KycKf1R6m0rw0osIuTvj5yoDPoh20pJQKc7X/Hxkq0CcUHio0Rqn1jeX0Bffl4LMUWbTi
	 GxLYTE3h3Qak6ZmTPJ0MWMnNOsyJDDXbg7+NVSXrZ3PN4JlA42nLqS89LrQYEJpLtsAYC
	 ItudbxRpZU2pR8AjLM6SjnTH6C82dACONOrGlN3pbsiO2MrkpaSOdXjClQpszf1QD4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809723;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FQ5w2SUxywiqMrDkCCejR9SSKq/5tnkQBi9liSw1uhU=;
	b=0LwehsV+iHXGnQNiUDtoUB0LoQf09YVpOK0/h1c/UnqJZQN0prhc1UrU5+Dme4UhpTSn
	 OQ9jtHOgXZSM5/e1ki1puikdVYbsoMp9KNhm3rU92wnANJ6edgBDZmcnVrDAK1AX+h0D9
	 ikJDguKdxcMjOkbBm3LsjZMEgpuVfmmsjGmgR29E+KaDnlJgMQR1SN/UfXxokNhOID+JR
	 Qa2y4Oh2qKDWDyjz13CAvdKfgD/GJhDVH3Rr+Lb/XF/bTqOwopwYFjOZ/E7yw51WTIpPD
	 5vXdbYP3bmgGP69QdSvTYKZZHx9L2sYY9UuyJaDqGYRaS7HIPKW1tXlBJlzAe4avKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDesfVqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF850606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDesfVqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217A1F00893;
	Fri, 27 Nov 2026 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809723;
	bh=FQ5w2SUxywiqMrDkCCejR9SSKq/5tnkQBi9liSw1uhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QDesfVqMKhMb0lUA4Nr6pHEeKsYPWGHEy5zQOIM8ikHo9ddB1X5HqVenii/4awTaM
	 R9J2HzQSpHmw8glYf/62OdjvnUHNCX8W8224Tg6GtjNFu+oH46e3DAZFpr8PSNBOTG
	 4lRP+H3qMRinCc9aYepzHcxSaUc7X1OMh5NTtQuViu2kIXKLotNEJ/isA2xdoSYeIG
	 DPcLr1hS3KOl4dT0pGnfKF/uYSNiKGFdV8i6ZWasnvqvyF9igeMkiKpOq3soVcJaU2
	 u+LmdvDXaOu33VxMXRQkdiEIgejPCingxxAgTZIJfc6/f5Yp0A1X3F60LI5mICrqu/
	 xV0KIs3Jt6EiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:25 +0100
Subject: [PATCH mptcp-net v4 01/20] mptcp: reset MP_JOIN subflows on simult
 connect
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-1-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3779; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jfw+AhUvPgIXsZht9rHxepZgorV+VaZqj/AHILLNjfY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5Hy57bpCpcionSbiTS9Jf8UXO0ZI103TK7SRXHUyQb
 KzZtn99RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESsnzD8TxHRvDXj7y5lA8F3
 R1inzvK8cbW7pua9ofk/l0s8kp78Qgz/y+K1pq9/4y8WuWzJ8lgum/R3uy27/Wx7lk26Ltd+t7a
 aHQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the SYN of a new MP_JOIN subflow is answered with a SYN instead of
a SYN-ACK, TCP handles it as a simultaneous connect, and the subflow is
established without the MP_JOIN handshake: the peer's HMAC, normally
checked by subflow_finish_connect() when receiving the SYN-ACK, is never
received. This function is only called on the next packet, and then
resets the subflow, but the packet establishing the subflow is processed
before: with data, or urgent data, a warning was triggered in
subflow_data_ready(). Without MPTCP options, or with a reset, in reply
to the SYN or after the crossed SYN, the whole MPTCP connection could
fall back to TCP, depending on the peer's sequence number, while it
could still have other subflows.

The peer, or an attacker on the path of this new subflow, could then
trigger this warning, or force a fallback to TCP. Reset such subflows as
soon as they reach the ESTABLISHED state, before processing the packet,
as done when the SYN-ACK has no MP_JOIN option, and ignore the MPTCP
options received before.

This issue has been found by an AI code review agent (Sashiko), while
reviewing another fix, and confirmed with new Packetdrill tests: after
an ADD_ADDR, an MPTCP client creates a new subflow, and the peer replies
with a SYN, then an ACK with data, urgent data or without MPTCP options,
or a reset; or directly with a reset. Without this patch, the warning
was triggered:

  WARNING: net/mptcp/subflow.c:1656 at subflow_data_ready+0x11d/0x1a0, CPU#3: packetdrill/183
  Call Trace:
   <TASK>
   tcp_data_queue+0x768/0x10c0
   tcp_rcv_state_process+0x190/0x1730
   tcp_v4_do_rcv+0xd1/0x300
   tcp_v4_rcv+0xbff/0x1200
   (...)

And the connection fell back to TCP, e.g. after a reset:

  mp_join_client_syn_rst_seq1.pkt:32: error executing `test $(nstat -azj | jq '.kernel.MPTcpExtMPCapableDataFallback') -eq 0` command: non-zero status 1

Note for the backports: MPTCP_MIB_MPJOINSYNACKNOMPJOIN has been added in
v7.3: the line incrementing it can be dropped before.

Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: new, for an issue spotted by Sashiko
---
 net/mptcp/options.c | 4 ++++
 net/mptcp/subflow.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 05b9c66aaed6..34eb70298bac 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1008,6 +1008,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		goto check_notify;
 	}
 
+	/* no MP_JOIN handshake, e.g. a reset in reply to the SYN */
+	if (unlikely(subflow->request_join && !subflow->mp_join))
+		return false;
+
 	/* we must process OoO packets before the first subflow is fully
 	 * established. OoO packets are instead a protocol violation
 	 * for MP_JOIN subflows as the peer must not send any data
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 85695fe00cc3..ddf1c3b92db2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1987,6 +1987,15 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* simult connect: the peer's HMAC was never checked */
+	if (unlikely(subflow->request_join && !subflow->mp_join &&
+		     sk->sk_state == TCP_ESTABLISHED)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPJOINSYNACKNOMPJOIN);
+		subflow->reset_reason = MPTCP_RST_EMPTCP;
+		mptcp_subflow_reset(sk);
+		return;
+	}
+
 	/* Rx queue processing is unneeded, error reporting will take place at
 	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
 	 * fallback: subflow_sched_work_if_closed() would be a no-op.

-- 
2.55.0

