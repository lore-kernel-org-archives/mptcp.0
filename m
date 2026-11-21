Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254154;
	b=KiKG+uuD0+8EJJ71adHG8n+MUX3Xl34Sf2/uFdI5AcM01oZzORbZExpRRBTlmNhBAsPL
	 rs0jVpybz5lZICH6J8dXYcNFSueZcnlDttuT3JDtSnAgZGg0TDrtJtQYbBWqzmPmAk7Wy
	 Yq/sZToW9Up4AP93FDTUqzVdD7k7nwuj7AoIdAZQIE8BkRnO63Bo54z1p6mquaEq2hImE
	 CgzP9hFmqQ1OuLzTKuDN0GCt0uW5Yo26rpTgGY0v+eSxcr+WEqZxO8IEJoz9L1QunFdDl
	 ekCCt4PJi+Gh5IT5ffnqGCZNxCT1+z+0cvUzLiaAUYB9DI8+tdp6TNp1XUuvmAAO9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254154;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6qXs6K/0c2om8ks3+LZuoCm1mZz32FbP1xscDNAlqZ0=;
	b=K7OR0XRXpqJfVAZt9Iq9qPnuPaU/1o0uM12+ZQX/QMDg1F3AUvlILN5yMt7+vi7cXMCW
	 mR4loKLVxdLeuIBkGkkJqhQ6CxD6qZNA4qMn6EwU5sVOcvQbyg6pHfWVgX/3GPqVh1Cfh
	 /PEySm0ZBZeLSo0d1ULynvSZkpkgH5lwxhQhLtj/H5M5J/Wr0otLFm1vcPm6cer34Mgb3
	 KWeehGc1cTNhMq62DL2IeUUEmZyCNPUQXriSWgS8D8v1LiPjDxTbs21D8bcJy8j/ZaGHl
	 4jPY1mTGMEw3YfwDfnOT/Mz6KQCE/whe2aGnOwU5NgC5SBDokTu/8Xx6noavNX37OuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzQk7kHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D58606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzQk7kHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105111F000C6;
	Sat, 21 Nov 2026 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254154;
	bh=6qXs6K/0c2om8ks3+LZuoCm1mZz32FbP1xscDNAlqZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CzQk7kHdnfLcKJ0MPv3bnRXMc/0LJywVvsKhzQYg3Iv5JExKvi7Tw54C+TSI30R92
	 kCewEZ+sLL46xgGsPXnAjVHeZ3zZidZCjagVbKXqWl1zzG6HTFwEIzx34dWPZfKClI
	 ywd9xfZpZXXvYlKHA9FZ0IQhonNm64mnE0RMHx7OZEIg1sXKLvjpFapm6HDZ/mdlUb
	 sE9kEMsRyB9Brsgf2OxRlOPcmZIoDJV/3fmm5rM24z+ewzG8V2DTFQ3LchPZI7fqjn
	 6yCwGteEA/2AF0TOhdVdgEsVVfNidYqn8Eo/LWueH0AqGVeiVKffQ2xltQBCTDwbRx
	 7chrv9GeJQjJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:15 +0100
Subject: [PATCH mptcp-net v2 17/62] mptcp: reset the subflow on abort after
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-17-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uwaAtsk/k6ZJsP6boV94Mf2V+eEhVKCU4Dlfa1D+rv4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ00OTGfatXH1+l4Gk5Lff88OXX1C8sj8yRmTC/c6Li
 bceFdoLdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkNJyR4XLtM/9/2su7tYuM
 pSYKiZW+WZyQ9P+u0NqWnoMpVruupzD8LxBiXeG2x/JwYFjLju2HWWSe9szxKIhi8knguBB8jUu
 CAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, closing an MPTCP socket with unread data, or
with SO_LINGER and a zero timeout, did not reset the connection as TCP
does: the data still in the MPTCP send queue was dropped, and the
subflow was closed with a FIN. The peer then got a truncated stream,
followed by EOF, without error.

mptcp_do_fastclose() sends a reset on each subflow, except after a
fallback: send it in this case too. No MPTCP option is added after a
fallback: this is a plain TCP reset. Its other callers, on disconnect()
and when the close timeout of an orphan expires, were already resetting
the subflow after a fallback, via tcp_disconnect(), in most states: the
reset is now sent as without a fallback.

This issue has been found by an AI code review agent, while reviewing
another fix, and confirmed with a new Packetdrill test: an MPTCP client
falls back to TCP, receives data, and closes the socket without reading
it. Without this patch, a FIN was sent instead of a reset:

  v1_connect_tcpfallback_close_unread_data.pkt:19: error handling packet: live packet field tcp_fin: expected: 0 (0x0) vs actual: 1 (0x1)

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 541bf23d1bda..201e77772bdd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3245,10 +3245,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	mptcp_backlog_purge(sk);
 	msk->fastclosing = 1;
 
-	/* Explicitly send the fastclose reset as need */
-	if (__mptcp_check_fallback(msk))
-		return;
-
+	/* Explicitly send the fastclose reset, a plain one after a fallback */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 

-- 
2.55.0

