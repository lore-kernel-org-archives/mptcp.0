Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599693;
	b=OMSI3B1smy/7CJSuMnwu5Pc9C2XeivBJoqlJxP94nUplLSsdzewRYGpzFwty5aCk22bM
	 nyqYl7bEXJrydFWu/gw4dmfk/ggRMBMHdVRg2H6gFD/gJXNLFzxunbQ6/KyrXr9YDkLo1
	 pSa9ZGaNpCYiQyIq9BodRbQO7Ou1R1UdAcQo+uBEIy44X6pzaaB1VAmY+X7uS3W/nFaG+
	 b+K+hMM38wIvvTM51BWnLbrDfT4+/hbnz1ndOWU5Oi6/i7sMpXyBcFgRQJX+nKGCap+jl
	 s0xK2+UDXIEVvGahJQtYTHQh8L3W6w/RCmlufp1o0deGaF3oJssQuUQrtHwrqlY6OZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599693;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RXyfarQm91RWVJovkOcaSl9U1kxbBlrNXjsV7TSVacE=;
	b=NNz9d/5W7aQB1twO4gBvFN1NcIpsU0BNsgoJ1xvYX8ysUb3F574PsR7MwQ8pRn3JDPFN
	 JAYcTA4QLWdn7B7sLUkY+jHdIXMB35g1pczzWprKSaA9dW3U8c7BiSbYMlI6QpkRPADX0
	 45oiPmO5hU+Xr/o2aZoDSvYFQ1badfLCNsJFHiSADRcWD2Ql5PgWL4K7awyMvMgCL8sKv
	 kRwKkVIhgnskStHAY9w4eklOL6+Vz6OjWrhFvxhqtVsiOEBA4Q8Fd0RtLrcQKhJ5Si/Al
	 nbcc80t8lcc5k7Qv0JdHTkQRJDYAHsk4iQF6YWwr1arV6tgCWlGY0ULN6MYxU/jyBgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cf6wUp5F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB04606D0FA
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cf6wUp5F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ADE1F000C4;
	Fri, 13 Nov 2026 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599693;
	bh=RXyfarQm91RWVJovkOcaSl9U1kxbBlrNXjsV7TSVacE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Cf6wUp5FH6Rrsql7TK70OIV0W0fifnFAqRLT+FdKIuW3IG6SZ8+M/i0g7IDGCJfWB
	 3IQtEmjfGJrY8xCEgalbgTbZxHsRnFj59gteqAckXTOID4692nnQSx9VaRzMnlMnel
	 MvcLwH0vjF3QPmT0EBOhsZy1T8x3qRYbnlUv4GLz/2vbaAnELZE6kb/CEDVpiyOvq7
	 gypuiG7tYkUxT+ck4tdptrVyGlaqTE5XLcfvagv7Rgsaevjk5UE9X0f2eynmT64H82
	 90FYJzQDbiJI0RudNGyCULUnVTSfVHHOCZobxoS6Isp94VH1O9MaBcwb/fef9T+Yas
	 Gx26hUucyTfQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:04 +0100
Subject: [PATCH mptcp-net 26/34] mptcp: don't send a FIN before the pending
 data on fallback
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-26-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jqibTObWwJ+hwhTwzQ1+5CEC/4YRaITgXK4sdRphLFI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz2RTC0IsU56+2PlpReh+auE1zcdNT3+aMqnDbndu
 f/jO9iYO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyQ5SR4cZGhuL5gpk/D0h6
 Zi94euaQyf1dznwn067dOC8v18f4Zgsjw2tDU5blXZPOv1ZYO33+xjSlc5MnXL/I8H7m0WW77Zd
 vkeUGAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an MPTCP connection falls back to TCP after having been shut down,
the data that is still in the write queue of the MPTCP socket is lost:
a FIN is sent at fallback time, and this data cannot be sent after it.
This can happen with TCP Fast Open (TFO), when a server writes data and
shuts the connection down before the third ACK, and this ACK has no
MPTCP options.

When the MPTCP socket has been shut down, mptcp_try_fallback() also
shuts the subflow down: if the DATA_FIN had already been sent, nothing
would send a FIN on this subflow otherwise. The commit introducing this
only considered the case where all the data had already been pushed to
the subflow.

The fix used here is to only shut the subflow down at fallback time if
no data is pending. Otherwise, mptcp_check_send_data_fin() will do it
once this data has been pushed, e.g. by the previous commit.

This issue has been found by an AI code review agent, while reviewing
the code of the previous commit, and confirmed with a new Packetdrill
test, where the server writes data and shuts the connection down before
the third ACK, from which the MPTCP options are removed. Without this
patch, a FIN was sent right after this ACK, and the data was never
sent:

  inbound injected packet:  0.240127 . 501:501(0) ack 4103187975 win 450
  outbound sniffed packet:  0.240207 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  1.347800 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  2.499829 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  4.739843 F. 4103187975:4103187975(0) ack 501 win 1050
  server-tfo-fallback-shutdown-before-3rd-ack.pkt:27: error handling packet: Timed out waiting for packet

Fixes: d51991e2e314 ("mptcp: fix shutdown vs fallback race")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e61b6a3a955d..d76eaed4f01e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1339,7 +1339,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
-	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
+
+	/* no FIN before pending data: see mptcp_check_send_data_fin() */
+	if (READ_ONCE(msk->snd_data_fin_enable) && !mptcp_send_head(sk) &&
+	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
 		/* we are in a atomic (BH) scope, override ssk default for data

-- 
2.55.0

