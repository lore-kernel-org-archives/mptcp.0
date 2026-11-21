Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254164;
	b=uSAhyJiSUVo56iPvsUrEphBWTrff2dDyA3HhdQDTSoP5PEkJMlLHsiPAPRT6EQGIX8ay
	 VPkYAj53EE6RBLU9a63Oc/SNpX3KEBqGcJomsJv0JSDQZBNHUrioq0Lk11FDUpyh+ZGCp
	 MshbClYFwdIiBRbFEkubpw+LK8dnv891TcX9dk8i1rDtu1oW1eyP45Uvjela6gMWAfNoz
	 wlmDINxOwij5V+Hm80qkHHJiL0xYyixps/x2huTZ/aVMXlqoll52wyW6UHHfXTVdUXvcf
	 HJPam4WhLLHJ4IkUfZEoxBr/E88p1IhoDS4b//4HpVGSPeqJuvJLy4kqaiUQSBwopvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254164;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wN3nt6sNoe1nldDn32wakmoGrveqSpy35I6dQm6HgRA=;
	b=IBSWlmQz5UprTsE3jVNSemBENFvvecyGiiKvlq/Dh0i0w1JAcLY8ZIas0M1QN6FWayNa
	 ObQH5UELieR5FZYFt1L/ZFcwTMt5kImvZ/HFxfcjZqFyMoAeVbYZ8ujj1ebHNYR1+2QCP
	 p9ZBGx4uokpup3vQm/5MQ3WxexV/PJmGQCM30PJhoKFCCPsv/pWcU/cuF0zX6G3qZ1NDS
	 8qW6Hfn+IO0efKYL78d1RYPO15V4xXU1ac+shgBhIdgKwogpEHp0O8V4RLBiE4/1OhF4z
	 6k9cin4UZ/oN6lSZwM65jJpkQPRTFPasmjGu2W82mIT/5uVKFWnIFtZ/6pkbYL42uMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcQs86An;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76753606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcQs86An
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36411F000D0;
	Sat, 21 Nov 2026 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254164;
	bh=wN3nt6sNoe1nldDn32wakmoGrveqSpy35I6dQm6HgRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AcQs86An4LFahCsYvkBKTz0qWNrlMZOpGYqQ010L1vxkClk29M9kLFgU94GZ2xjzp
	 3tImixFLFJJZNErEYVUxwr2vDri9E+oLpDAqtOcXpQHZxnParEeUNbQfXkmQghpfvc
	 oLe5kbpUEZvcW0aNppwRoqB55hFTF9ywEulkZZj+mcPma7KZeM9Y4z9vsm0Lpjwhbb
	 fPHgSQRhtTTOnvZGKrSvccBuy/8ndudkSH5spXhG413CIHt2pkAfRi8wUGnVA4mjo3
	 jAz9qskufzSn6DA2yK5WcqNkcr8ygOXZBJDZCc08K40pd9CAGRFeUSSJDeRNstRqiL
	 oCKJq+b53bb3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:27 +0100
Subject: [PATCH mptcp-net v2 29/62] mptcp: keep listening after
 MSG_FASTOPEN errors
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-29-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eIh3RdkWkGqKKaScoHEAm6QpB4rGvVfFOPB1nakjSP8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ02O39ySquCYqXvu/96p75NeVW7sEK1dtEzrS/rfl3
 rTW4LO9HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxk2T4pzvz7PNHyQmVh/iD
 pvt+fnsie6nkqZM5JmLXiqQ4cr13RzAy7N5vGid15/lFlbY/RgrrdsxWvXQiJ7N1cdens7+3yx5
 exwoA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A sendmsg() with MSG_FASTOPEN on an MPTCP listener fails, e.g. with
EISCONN, as with TCP, but it also closes the listener: after any error,
mptcp_sendmsg_fastopen() retries the disconnect that could have failed
in __inet_stream_connect(), while there is nothing to retry for a
listener.

Skip this disconnect for a listener: it keeps listening, as with TCP.

This issue has been found by an AI code review agent, while reviewing
"mptcp: report sf aborts during deferred connect", and confirmed with a
new Packetdrill test: sendto() with MSG_FASTOPEN on a listener, then a
SYN. Without this patch, the SYN got a reset instead of a SYN-ACK:

  listen_sendto_fastopen.pkt:14: error handling packet: live packet field ipv4_total_length: expected: 60 (0x3c) vs actual: 40 (0x28)

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55ff0298e5dd..6f4e418d712c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2004,11 +2004,12 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		 */
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
-	} else if (ret && ret != -EINPROGRESS) {
+	} else if (ret && ret != -EINPROGRESS && sk->sk_state != TCP_LISTEN) {
 		/* The disconnect() op called by tcp_sendmsg_fastopen()/
 		 * __inet_stream_connect() can fail, due to looking check,
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
+		 * A listener is not disconnected there, as with TCP.
 		 */
 		if (!mptcp_disconnect(sk, 0)) {
 			sk->sk_disconnects++;

-- 
2.55.0

