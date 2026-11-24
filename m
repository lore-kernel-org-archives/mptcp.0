Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557659;
	b=N7HVjpHR3PWPpzcM7GLUEwsVAqubyFaMoDzM8F380SAqc92D9az0I0c72+AlyO/gH9Yn
	 wPyGlTlYP7PTs2ybDILsWrkr8wG6oi2PT/9s0dkbobCB23aQTH5cN9L9OJjd4wI+733+9
	 lujP4f/3jM39DkrNhqDH04sGOkEh7MEKdVqzvUToWvGOIADmPQz9qYPKCzKAvWuGJhaBm
	 78iDqXTNL92WptbHhQoleJm7uopBPO8ObcITEWIuqiuhEIb8hwwXLowtZN3P6sIXELuLe
	 Ml/gJz9vZkkxvzlNZOnfbU2Y6kmBn6FRQ8vQj8a5BA7RPKT/zt0q2yg0h8Ic1Q8S81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557659;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NFHl0WA5e1oy/ZWXXqipZ8X9aveWbffDTV12VSEKKM4=;
	b=Y/L0zLZYu/oaMMIDo4QK+IZ0u4YI/PcYIpN8KdXC8Reh7gm3OacbZfzPJwiaNQi/rV1e
	 3Ufhmu8gUnYpWjiDUUPRvYQmkOg9AG1I59U9QQmiU5pGCSZEJ6wa/Yn4lOXJYcdVwMf6M
	 J5ikDOfKLulTB7ND7uh0IbXhO2zV2ICKNkFY0+h3p8FtHAtLmgQGeyCpuEu1oZBIMlJCQ
	 qIry4ungaqXq/ddBjLHKuDELrfvP/jvsQVA3W4v8iWz/+I3JEWV7jAUsEz4bHHKnAZq5p
	 0wJ8QtqchJ8+mXMFbMTuLQG/3Nx+X4feO1da1l0jV9lSNTeyHPEq5fRA0pNe9yq1c0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwn+WPh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D4606A331
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwn+WPh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53651F000D2;
	Tue, 24 Nov 2026 22:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557659;
	bh=NFHl0WA5e1oy/ZWXXqipZ8X9aveWbffDTV12VSEKKM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gwn+WPh4TthSVM4UwQjkKuOrK15ATzkf6F/b/pv2lV40WHZTRe+BdCNIIhd0bMYmX
	 F+H5tJ6zP2HxQU+cwxpHl3+a42LfStvIeJkchc+eknAgWax4eACeU8uZk6stBabj1t
	 Rc+EV/u0/spztE4YGWtOkJf4nwjlrz3uRZDZAXf0GR6oV5QopxH2WPh76Z6J3H1a/s
	 NMJgDUtqASaiWI9fEAQG2QWuxfj/U6fzk1ZJ4gVeXmcKbP8XOHnUWMnFQ82admM+6u
	 3ZzOyA+FfoQJUsZkofYyGhoDfa4afK6kkEuLRPoQzUMIt4VVlouKuJCweu65Th7S4/
	 zDK9YPvySow5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:18 +0100
Subject: [PATCH mptcp-net v3 01/50] mptcp: keep an orphan while it can send
 its data
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TCaYGg220Y3RmdYx6fWeMluPNm1OOK0qvvDBK1lYD+U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOL47zTm8hePtJKeYritvP/LYnYmoijxua9ewgdFA0
 C5kmnBDRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETq/zAynP07xY1n1b47Pe0y
 NXMd+t62Prq8Mjp94ZOLc1VmVxv938Lwv3jtW1mlq7Ju/r2X7l1bLNtUvWRR2PU4OYGHmpdNDyn
 pcAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The close timeout of an orphaned MPTCP socket started at close(), and
its expiry reset the connection, while some data could still be waiting
for the peer to open its window: a peer reading slowly or pausing got a
reset 60 seconds after close(), and lost the end of the data, while TCP
delivers it.

This timeout is there for the DATA_FIN exchange, see commit d866ae9aaa43
("mptcp: add a new sysctl for make after break timeout"), and for an
orphan that can no longer send anything. So restart it when the DATA_FIN
is sent, and when it expires before, as long as a subflow can still send
the data, which is then pushed again: an established subflow, on which
the peer acked something recently, at least the window probes. Until
then, as for a TCP socket that is not orphaned, nothing limits how long
the peer can keep its window closed, while it acks the window probes.
The timeout still starts at close(): the subflows are not TCP orphans,
so its expiry is the only check that the orphan can still send.

This was reported on GitHub, with a reproducer: a server writes 2 MB,
then calls close(), while the client pauses before reading the rest.
After a pause of 90 seconds, the client got ECONNRESET, while TCP
delivered everything, as MPTCP now does. If the client vanishes instead,
the orphan is now reset as TCP does.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for issue #647 reported on GitHub

Note (Clashiko on v2): when the last subflow is closed in the same
worker run, before the DATA_FIN is sent, the destruction of the orphan
is delayed once, by the close timeout. Not restarting the timeout once
expired would reset an orphan sending its DATA_FIN after a long probing.
---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d64e04245963..944c9d11d211 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2871,6 +2871,28 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
+/* Before its DATA_FIN, keep an orphan while a subflow can send its data */
+static bool mptcp_orphan_keep(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (!sock_flag(sk, SOCK_DEAD) || msk->snd_nxt == msk->write_seq)
+		return false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		/* a live peer acks at least the probes, every TCP_RTO_MAX */
+		if (__mptcp_subflow_active(subflow) &&
+		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
+		    2 * TCP_RTO_MAX)
+			return true;
+	}
+
+	return false;
+}
+
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3208,6 +3230,11 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
+	if (mptcp_close_tout_expired(sk) && mptcp_orphan_keep(sk)) {
+		mptcp_start_tout_timer(sk);
+		__mptcp_push_pending(sk, 0);
+	}
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 
@@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
+	/* an orphan's close timeout is for the DATA_FIN exchange */
+	if (sock_flag(sk, SOCK_DEAD))
+		mptcp_start_tout_timer(sk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 

-- 
2.55.0

