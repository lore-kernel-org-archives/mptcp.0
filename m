Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254173;
	b=IjkUsDni6iUOMWY34OjIxAj91wgcB3Nt5w9Vv9hlzNN+8tWFmjEp03/lNCIvyKY0mG1d
	 IWRTM8s3q8zO5551vpSXqHx8AnN2CwT0psc//nTDGSWWlBa+t4PxYFrbden5NyjTlpl/e
	 +T3xcxHj+hUrqUqUhWDAUnSmZtwH+ihWYyrTjQ8QsKGD0snhnoxrlpoMjHKSspXd+FADX
	 B5NOA/PAaYCiD8/fAuhos8NlEE3Axvjkk620VgrVnM23zviCU+b3/h/UHQ0afUK91nnGS
	 GeKiftKMMC+uza0xmivS5BPmdeUMj4xzSQ9w2i5dnyC8e6R/yd31xocv3x5M9uSvYWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254173;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=D4PNlodOsPzocv5muUm7GL4betBacQs9eIXnIBRmIaU=;
	b=0GTYeeQcWSfdjery3V39KNtcm9QJRiPqesEQCV9C5bszQ7q2/fknyFhbRBiNpYyAXDVs
	 GZgiQkjtK9Lguko5gjhuSRn5iDoif32LwuZzipvBtFesHlth6WgUHG95wnO8/oGxo6jdP
	 Ya6rx+FLGOmukXJrHa8O4TxrqfqV2JK20rbpaQ2lACDDab60HEgeVHzUTs7tmja5llRoN
	 Yl4jK8C/czpU7Z0V4oMV+sO6FICbXI1lIuVwO3tZCtgyWTTNpoRBY3OI/ziQvIVGCJsvq
	 hchtUHzPRXKydIMsI0E3NV2nlYIszi8TeFkZIWSiij75/EvYofZEn9KxWKHaamsQ6pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0DTwwBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E497606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0DTwwBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F1B1F000CF;
	Sat, 21 Nov 2026 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254173;
	bh=D4PNlodOsPzocv5muUm7GL4betBacQs9eIXnIBRmIaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0DTwwBHs5mOk2leQeWzypiS+CnMK7ibyK4Jj7D+YRALoRzomygouV3E+jw/r9vNX
	 mYY0+oleN04gNqh7T5OT4JhqAS53nPU7v+28xMeL7Xoo5MjxyaHvDy8LMepEzxkycY
	 RrfRRX6y8wVp9R0qDNoHjcpZ0FxzM9eJdLHMgt+ql293DQqZh4jKjqNeCs0huMGxB0
	 DfiO4nprNCf0rbZUsrPVEf+u9BhfXquqeZlpFMvOuTcTRHiokwMU9sS8yMfFzXykYi
	 +exmYvYNVHHs0jZuHy7CXyeYks51OFeHicCIwnH2FSUy78ltU1I4ZZ7BWoCW7LobeU
	 wKrfEzPsGEobQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:37 +0100
Subject: [PATCH mptcp-net v2 39/62] mptcp: keep room for infinite map after
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-39-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KG3m0ePxfVDTguUKurT89h0c9KRYrnsKmepsItyeU0o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ01NPBToc6WHYLnnsS1hyj/oKPY1jykEvamysVKWdP
 3moa53tKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIiaOsM/w2mTbD6I5zk8vbVX
 xymh29fwLuu07u12qVHp13er7g7dwfA/b/LJ0GUbPu2OZt2+c8KEY0I//WN1hf0/GrsksK6buau
 PHwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After an MP_FAIL, the infinite mapping is sent with the next data. If
the MPTCP socket falls back to TCP in the meantime, e.g. after having
received data without DSS, the size of the next skb is computed without
room for the DSS option, as no MPTCP options are sent after a fallback.
But this skb still carries the infinite mapping, with its DSS option:
its segments are then bigger than the MTU, and dropped, while the next
ones wait for them. The connection then stalls.

Keep room for the DSS option while the infinite mapping is still to be
sent, when computing the MSS.

This issue has been found by Sashiko, while reviewing "mptcp: send the
infinite map in a single segment", and confirmed with a new Packetdrill
test: an MP_FAIL is received before any data, then data without DSS.
Without this patch, the infinite mapping was never sent:

  dss_infinite_map_after_fallback_server.pkt:27: error handling packet: Timed out waiting for packet

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 736e55532296..6b1a3994fb49 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -891,9 +891,11 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	opts->suboptions = 0;
 
 	/* Force later mptcp_write_options(), but do not use any actual
-	 * option space.
+	 * option space, except for an infinite mapping still to be sent.
 	 */
-	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
+	if (unlikely(__mptcp_check_fallback(msk) &&
+		     !mptcp_check_infinite_map(skb) &&
+		     (skb || !subflow->send_infinite_map)))
 		return 0;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {

-- 
2.55.0

