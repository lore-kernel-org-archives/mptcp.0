Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557664;
	b=lxatMn8dxUnKaq8XJ4sNiq7ZmKP7hx4bdmdqn/bsb0HiTX/08fr9YDfS9joTHWz5O7td
	 nX8hQDRT3kVotHLco4ibWrNg1iwyIq3HWa9tZLOFwiWr3yoWZFZXTq00jgk1KiHdyLdTP
	 idW4P2GFiSnJbV7yc0fq1B7koVlC1qMKhl/xMBEXW9d037K3aCBy01Fd/z/YEQn6/ZDgj
	 UPwGVHffvfMt8mS0SRocnNjpRxNuG6HGJ+ruCMEV5ARy+RwqoWXUrlD6SfBaRcbkGRL56
	 atp0e7XPD6e3bD8CQ4ZQzXdL8ktoqP2e2a7rk2/W869kHzJ5/XV+UjeP+dHJaUqFyiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557664;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=08HOn/tspRTQoLt/ywNuNCp3wuOGGAg3BYX9BFMUL1s=;
	b=gWqORfMyCwPF+grPI1jaA/oXCyqSgiMF6tSUBRGA7LLBvoP7Y8ucTrZuKDTFZPHxYCrz
	 2gM2WMDvGw/Ze/mnqesggmcWfMzczCkJ/K0LSfTtC+JMMAnPbhHZS9RKlLb/7YmPdkSd+
	 eXHPc9LLH3vag9MU7MVrgr/nBUy/N900tyaw8rRItjuyW2OMyxkkN9qx894gwsU0LaBzD
	 jO4a6quo1mU5BnAd0biu8y2U5GdRqQyhEwPq2ZVuzr1pB4r/KxPSVcb9vPUqAuTGiDLp7
	 TZG3VxkpZUP0PAbhcz6gqq38NHOyRpo1B345iGyyDuinFiBYk3rM7St6AvFeYhpdo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGpcMmgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D07606A323
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGpcMmgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1411F000C0;
	Tue, 24 Nov 2026 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557663;
	bh=08HOn/tspRTQoLt/ywNuNCp3wuOGGAg3BYX9BFMUL1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kGpcMmgO6NOw1EH8A6xPp8kBr8ghNmaqHy3cy1q2E2q4MCF2FD76bZ1uSIZNraj9y
	 Y28ge72HhJVt6R7oeUEJQIvMmAsTfcxk8PQ0APNg3j9MVYC5XSlVPxXGVJhvAut7w1
	 29RWbn0qw/72rIVuf0x1MG4qOpxRKjuS35a29cQRq3wb7FnXkKNvsRoiU9CEAlNRVl
	 vMormYbnhTZOasZ9+katKGrRVjkyUb8k0mRRZquB5TSEAKkglpNFQ2XftHRgQBEkOV
	 cJoEXGLPuWmQUUJVf0H99YBqlrDoxnfhqYvNLmwglazUp3p/PO4M4nihsXfvfQD6pQ
	 bQue0AG62U78Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:22 +0100
Subject: [PATCH mptcp-net v3 05/50] mptcp: let TCP send orphan data after
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-5-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3098; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8t4K8hM8sjEIUgkebgtzt6uPvXe4abmymSdoEdNF4oA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH7+vf6x91Hq14yyL7Xzt17OOJtUEvnCY7LzM/M1t
 wp39Vgf7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIAzWG/7nZl3Q7eXuK3/lt
 ma/At4B3TT6ThyCfVdcu+eDimqL17Qz/Mz6aKRnxfkrWDRPa37OjZbvLDPHa9Rq3Ba3bb/67KhD
 DBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, once an orphaned MPTCP socket has given all its
data and the FIN to the subflow, the rest of the transfer is in the
hands of TCP. But when the close timeout expired, the subflow was reset,
and the data it still had was lost, e.g. with a peer reading slowly,
while TCP sends it, within the limits set for its orphans.

Close the MPTCP socket without reset in this case: the subflow is then
closed as after a graceful close, and TCP sends the remaining data.
Unless data received after close() has not been read: as in
__mptcp_close(), a reset is then needed. Before checking that, the
subflows stop passing data to the MPTCP socket: what is received later
stays there, and TCP resets when closing them.

This issue has been found by an AI code review agent, while validating a
fix for a similar issue, and confirmed with the reproducer from the
linked GitHub issue, adapted to a fallback: the writer is an MPTCP
client connected to a TCP server. The server got ECONNRESET after its
pause, while it gets everything with a TCP client, and now with an MPTCP
one too.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for a similar issue found by a review agent
v3: stop passing data to the msk before checking for unread data, not
    to ack data received meanwhile without reset (Clashiko)
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index de6da0b6c4ca..f28262f07282 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2951,6 +2951,30 @@ static bool mptcp_orphan_keep(struct sock *sk)
 	return false;
 }
 
+/* On fallback, TCP can send what an orphan gave to the subflow. As in
+ * __mptcp_close(), unread data requires a reset, also in the backlog: stop
+ * passing data to the msk first, TCP resets on what is received later.
+ */
+static bool mptcp_orphan_handover(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (!sock_flag(sk, SOCK_DEAD) || !__mptcp_check_fallback(msk) ||
+	    msk->snd_nxt != msk->write_seq)
+		return false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		subflow->closing = 1;
+		release_sock(ssk);
+	}
+
+	return !mptcp_data_avail(msk) && !READ_ONCE(msk->backlog_len);
+}
+
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3298,6 +3322,10 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_push_pending(sk, 0);
 	}
 
+	/* TCP will close the subflow, as with its own orphans */
+	if (mptcp_close_tout_expired(sk) && mptcp_orphan_handover(sk))
+		mptcp_set_state(sk, TCP_CLOSE);
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 

-- 
2.55.0

