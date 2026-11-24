Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557689;
	b=U1XaUlBMa0rA34aQNSYFsmqzcpeOSJ0Iz77hTOF6nhF8F8JLk3WSwM4TAUUbMSoKTTW+
	 UQeOB5L28zCMaIIBa7AFRxYOMEJKdRYhs0ilGMB7xpt7oB1OxBPdAs/X1id4CiHzG31ak
	 y3yKsqwtyyTLS0/vMmV8C411ASGGxYDyFGMz/qu9fZDg/hlhXLQoWIk6e9AqKrv4lHirC
	 ArMUxXoGhS7kCHdilRKAAmw8O8ERcT3z6/sSRoabbBSrhFMTEJSW4oPdQMdnL0pBg/wTM
	 sRGPWq8Sv677ezNJddAYGesHhFme/3ZXtAaf7Y6V7BYHiaQtHCPzePY3xb7S9bccVbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557689;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RJprxeXxyucQuy5lqkBXvIeEc+aUniQtjNH6khMRghI=;
	b=0Xz2ct2Avv+Ijzb8hrVScARKdHtRq0o2ZyVP/In1E04MECqjZSavkPy42gdncsum8aZ7
	 Qg0wmXpSoYReGZlAG+0sB0J7aQkE4an1maPqcZGq28Lovt5n3njWgceQTsp3/d30knAIK
	 G+br/Lo2kSABitK3N/+bAvZmXRNKgoQWuaXw65/acJqK39IIDFSk/QIEMj35lewiHm976
	 b7pww/NC4fm6kFNCeTnPZQyyzNMJ3YfAoFy3Zj9kRnBYk5NcniGcCAk0FnNtx0Ww6Y+HL
	 ZB9lQTfdbbSLzCEM8VtuplNrgR6J6lwiRWdJB1chAY0KVmssBWn6kHDJ39VNeotKReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljtTZRAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC630606A32A
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljtTZRAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0093D1F000D2;
	Tue, 24 Nov 2026 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557689;
	bh=RJprxeXxyucQuy5lqkBXvIeEc+aUniQtjNH6khMRghI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ljtTZRAy1QgxHftEamQDxbdd7ADxzYRB8Iy2pXwBx8wuUeoze313c2dR/pP3PYeXw
	 gLxVrNvCx8dUvfZGnFEykBC09drPEXIIwrWci4r7dRKMvf8JjI5uzALe+1Nw72kIdr
	 32hWaDAw+kBCIR80UW+6NJlUixSmH+y/ljssg9txbFQddzfDJupzRnTnHM9KJv0x3l
	 5YrgTdW8ASYIJ7j0ugWXq7kdeGRcFzdNoDUwz0Ol57NCM44uAhqlEHQ/YZ0s9MZPTa
	 F8k/LAD/YbLB50LWmALbqPz6zqXfn+hNFjILaC5g/CEPrc/8RjfjzWehb6gzUXLlZn
	 gTyS+4Nbm9n2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:43 +0100
Subject: [PATCH mptcp-net v3 26/50] mptcp: keep room for infinite map after
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-26-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8j1aeXy1DDB0f43SBFOhenjCy1aW8DKuxdgYIOVGjzs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZONk4T9caL8t1ZU35oxtkbPD0z3aHKsstH7Z3WMi+S
 Zst9eRYRwkLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERmujIybF6bbOextTozWnnP
 yT/s3t/+btHbpcZ0N31BxMdiDZeuJww/nvnEMNuX+ibHzqp0rEmqSFQJafqTs/tSba3SpnLnJEY A
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
sent, when computing the MSS. This room is only kept until the skb
carrying the infinite mapping is created, not until it is acked: an MSS
decrease in between, e.g. after a PMTU drop, is unlikely right after an
MP_FAIL, and this connection would then stall as with a PMTU black hole.

This issue has been found by Sashiko, while reviewing "mptcp: send the
infinite map in a single segment", and confirmed with a new Packetdrill
test: an MP_FAIL is received before any data, then data without DSS.
Without this patch, the infinite mapping was never sent:

  dss_infinite_map_after_fallback_server.pkt:27: error handling packet: Timed out waiting for packet

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko
v3: commit msg: why an MSS decrease before the infinite mapping is
    acked is not handled (Clashiko)
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

