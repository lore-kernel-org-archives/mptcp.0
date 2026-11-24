Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557674;
	b=2Vcw2CvbAKzN1A1Kcb0CPcCPNxKtsPnAQF4oDRk1QkyoyRFj2v+AoXoGAz3H6PKp+LY5
	 Zffv6xHUwiujDeYfa0uE6ME0FneFTthrJcSfF3u1L+1kQJ7lRdg2YSGw2LLMKxfDn1iif
	 2S9AhohRYZCB42zU2/gqLtywwSm6Nsli9MKCkz4VvPvYvb3/b0BL9Mjf5eGOk+msGO7Fn
	 pQzo+Vn5SgpiYddViPXFCkJfTotAvSbAKl3IaOFAUknrpetnrP8U4XY2a4em2Gl45LGm/
	 beBQXLxUTiNsvQ+FZV7wLBXdryFL7qbmcef7tfvEr2x1TcVmstx1yuLJQ6h6OPqBecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557674;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J2Pi9VeF/VYEu9eEthqrKh2elfEgGfDuPCcE+HSqs24=;
	b=2TxZEUebwNec4M3I64xsCs/0+KjQuOHoTnZwN3GVcc2ALz28ktNWuQEYbY3ZQV1V6PGL
	 o9F/qttoFb2Bgf6CCTS3CwU0MMquccVb/5Wg5xp/Jgz0x3M9MkhalCkyIty7XvEkoDSnH
	 HYuh0ZYSWVBfYNK6BjLtILZWpPVsx1+RAcmVXaTWxkcbecrPhMqdD/hpf8YjjKeVbXb7J
	 nGLihMQmI57eMJCRGuIAf7lOtrA3Ce0Om31IhlDnY0753lVeL2XWQgz9aBGsZwysFHRu5
	 lqIG7G+Zd4Cj+4DS4leyisBXdi5e1lOxR+zJ3B1RKUU941yzwrPrV8GyZc0Ti3LmH+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvUEXLO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78760606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvUEXLO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC051F000D3;
	Tue, 24 Nov 2026 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557673;
	bh=J2Pi9VeF/VYEu9eEthqrKh2elfEgGfDuPCcE+HSqs24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kvUEXLO7X8crew8j9z4FpAiUEWyGNLVTPHerGOoRadIMqAWBhx/mVwkUSN5d4sF3G
	 MqXAmE6gWURa4jIGBRCSuXV4KmGD52C3dL+l1prpjB+duCExavahSoLkVlI8S7NHOe
	 758i3YeyfGhn6xlzEZDrbe3+imB1BbtMLAzBl4fnLBIBIUjuWt5zJ/MUUaB6Ptpig8
	 mYIapUOSeCK76Yqbhm3V1YOVF0gu1sUFpnYsJkvDTfBpbO5QvNPVTUZLyZ+YUz0dPo
	 2v6o7FJNRGIx2vORhu7m541kguoDlo0lN1F68vJQNKJ+g6qZ8+Ut+5aP280fHm5EZl
	 XZ1woHjZS2dlw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:30 +0100
Subject: [PATCH mptcp-net v3 13/50] mptcp: process pending close events at
 accept()
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-13-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4gz7rOE4zURxO/8snDfO1uDWyhvLGxiEqY9lK6qaKws=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP6trIlcOiMn1kSgpdH89tdP8969ObQ5aHbs/xlOc
 5rcXjjzd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEwIuRYYvr9wuztD/JTOj/
 O1FbZAfnyfk/7weEiaqtOiyz2f7uXmGG3+zLv4RPP5vrKbA2cb/1+wvvZqQ5e8/T29zTv01n84f
 wRGYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the only subflow of a new MPTCP socket has been closed before
accept(), e.g. reset by the peer, mptcp_stream_accept() moves this
socket to the CLOSE state, then closes the subflow. A DATA_FIN or an
MP_FASTCLOSE received before, but not processed yet by the worker, was
then ignored: the code processing them before closing an MPTCP socket
without subflows, and the worker, skip a socket already closed.

recv() then returned ENOTCONN after the data, instead of EOF after a
DATA_FIN, or ECONNRESET after an MP_FASTCLOSE alone, as TCP does.

This race has been found by a review agent, and confirmed with
Packetdrill scripts and a debug patch delaying the worker of the MPTCP
sockets in the accept queue: data, a DATA_FIN or not, then a reset with
an MP_FASTCLOSE are received before accept(). Without this patch, the
second read() returned ENOTCONN in both cases:

  With DATA_FIN: runtime error in read call: Expected result 0 but got -1 with errno 107 (Transport endpoint is not connected)
  Without DATA_FIN: runtime error in read call: Expected errno 104 (Connection reset by peer) but got 107 (Transport endpoint is not connected)

To fix this, process them before moving to the CLOSE state, with
mptcp_check_rcv_close(), as done when closing the MPTCP socket without
subflows.

Note for the backports: before v6.19, this helper, added by the previous
commit, is not available, and mptcp_stream_accept() closes the subflow
before moving to the CLOSE state.

Fixes: 63740448a32e ("mptcp: fix accept vs worker race")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent

Note (Clashiko on v2): after a fallback, a reset received before
accept() was not reported when the worker processed it before accept():
pre-existing, fixed by the next patch.
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b57d0f82b416..8edff68ec650 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4703,8 +4703,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 * deal with bad peers not doing a complete shutdown.
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
-			if (unlikely(list_is_singular(&msk->conn_list)))
+			if (unlikely(list_is_singular(&msk->conn_list))) {
+				mptcp_check_rcv_close(newsk);
 				mptcp_set_state(newsk, TCP_CLOSE);
+			}
 			mptcp_close_ssk(newsk, msk->first,
 					mptcp_subflow_ctx(msk->first));
 		}

-- 
2.55.0

