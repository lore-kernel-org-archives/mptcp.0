Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809736;
	b=zIqBiqFEX3kb4hY2eYfj4T9LPa4uPsKvcrkNQ7cwkOXjyqZt5+Ubzj0DcY7NfeKvzKDk
	 y/2imqjhqUn6lGYW/m7gd17xirZdkj/k1ZHh9+bgeVtGV9JbV+FhzpTvclLNBJdN+iHzi
	 sJg0+qkZ8H8zcFEyl8OONzeK/H1jIzMJJmJR2KOWAissx1xB8iPL+1kUEpA/1RdAZeR2s
	 OsDgl5EnYskcV0aZtSsIfioiKLvb9Jn51cUMuytnvqDCb/CM7ibFrgSZ9Ziuaw4ekPFbZ
	 ZmiQAy2V68e9VV4su4hTmmQXBUH3jVDPtlerHm/GoH6ZlOVJBYEgiyGkolivGo3S3Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809736;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uWZNLLbDw4GsHLfqVxlQJLn54ORaBLm7jYidvwcL6hs=;
	b=ZQtL0HVjfA3+dsP69NU7AgzOzPD/h9nGUSsOP3Fhw5ZPZ+7+nUtGGI6JMoCgobBk6xAs
	 OogQzxvolQ1BmYNAPKqCicN27xLQoAap7OGkBjBNHkOFb2ehpQ33iteWn1HPyaSjHQTPx
	 41t2C9nDoD5D/1loavXnTLXtOCGiPhnXpyjV1szEwEFxGYEhTuTUsfLWK32602ZguXNUt
	 rtYaJGtHD/BnZO3KCly0ziCUvONyykAel8BSyTPh/MByKwVeu4Axkx2TW3zFDiRaBWsMa
	 vLYRSXkSxB4ImVCTiHSwFueAY75X1Gz4PBzfJmtYrWDcOK+7KuOwW/Z8B2D7CGc8oVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpSeFoDR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD63606A329
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpSeFoDR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD7E1F000C1;
	Fri, 27 Nov 2026 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809735;
	bh=uWZNLLbDw4GsHLfqVxlQJLn54ORaBLm7jYidvwcL6hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XpSeFoDRxi58SBgTxufH9btHGZEh+VtUAj0PcIHAISF7ZWg90VwTmiI144K4KlMVi
	 BuF8wIjHS7O8GDyADFEfkFYs/u4xJ096L7ndFFupMyH1yRs3BLJPAAvGUo1m0ftuJx
	 DorIPa8/5OyTV/kv9LzJ6Z01RQt+kX9jDhLMGNlaen4SitbMr6g1dhFDrCehjblJVp
	 h8IWfY+bmhNVC4fnaeVLkTurGcyk9GM1oM2fGLWXcHdu0W0kThcp9e8WNNUdLmkqIu
	 NdfOnNK2ioN2IKmXSgqCAWG6q9VgUiNP+v08C0RuU8xtFoz4c8uIiulnXwbK6/IASg
	 w1UBP0SuTZM0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:36 +0100
Subject: [PATCH mptcp-net v4 12/20] mptcp: reset the rtx interval to the
 min RTO
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-12-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4mXuDHQ7drzOmbMUv2Vo21DPQaez/nZfmm+UjQirIdk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H240iLTkbmPYqjdbRW1V4BGlDQyHpC8Jcy7fqGJ4/
 2NEN++HjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMd2X4K7vlo1CzD3e7QLC2
 4JoZjb95cooeqPx3Wb3kbDZfddoXJob/Eb6X0poatFyOLJvkZuG39Ne/6cUsUSX8LjK7tapvLov
 mBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Once all the data has been acked, a DATA_FIN is retransmitted at the
next tick, instead of after the RTO.

When all the data has been acked, mptcp_stop_rtx_timer() resets the
interval of the MPTCP-level retransmission timer to 0. The packet
scheduler sets it again before pushing data, but
mptcp_subflow_shutdown() arms this timer for the DATA_FIN without
setting it: commit 33d41c9cd74c ("mptcp: more accurate timeout") removed
this step, and the fallback to TCP_RTO_MIN when the interval was 0. A
push on a subflow that is already scheduled does not call the packet
scheduler either, and can then also arm this timer with an interval of
0.

The fix used here is to reset the interval to the minimum RTO, as when
creating the socket, and at disconnect time.

Sashiko spotted the issue with a push on a subflow already scheduled,
when reviewing a similar fix for the BPF packet schedulers. This case
has not been reproduced, but the DATA_FIN one has, with a Packetdrill
test: the DATA_FIN was retransmitted right after being sent, instead of
after the minimum RTO:

  dss_fin_retrans_after_data.pkt:22: error handling packet: timing error: expected outbound packet at 0.401059 sec but happened at 0.201774 sec; tolerance 0.100000 sec

Note for the backports: before commit ea4eb2adb0d3 ("mptcp: honour
configured min/max RTO in retransmit paths"), in v7.3, the min RTO of
the MPTCP socket is not set: TCP_RTO_MIN can be used instead.

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: new, for an issue spotted by Sashiko
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7cc1715f49f9..c83c123449fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -502,7 +502,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
-	mptcp_sk(sk)->timer_ival = 0;
+	mptcp_sk(sk)->timer_ival = READ_ONCE(inet_csk(sk)->icsk_rto_min);
 }
 
 static void mptcp_close_wake_up(struct sock *sk)

-- 
2.55.0

