Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254141;
	b=V+EQuO+cXYECLA43uvk0A++K0TziLZeWAWAWfxnVmcOfs6Od3CvdTDX9QEisdWAGJdsu
	 EqADFwkWFQY7vw2dmZceYJ0ky5FReT6l3HSlGcm547tH0cC+vE49Zg1M0IqW8BAUNKc1B
	 7kt9NUWv4YDClp9xfuoYzwvFv4sDJpHu9QvGLXHO2UZNgsZAo2PzFUpXr+RrOSBippmg5
	 hQyIYiYiYhb67AYi1TtW6kiKwhhMMU3MBdxArrx3UaZylFPsABm8CWqQjprgRYe0hc+Wm
	 iv1DbCVTu4yIcOcqAxxWKV3A2m04B4mbnQzFayNqdO1FSg82SfcfK5N9ymO8FcWxykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254141;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WxsmbNMicaVwMZEG5JHAy06m1AL8tBuQiO8AbzOL7eE=;
	b=VzhvuANLxVV0CVQs6XISPj2g5mJ+r9SPgOjRzA7psLZi3zj6LKXef282kXn7TrC979hx
	 CwfMRGvU1L9dPp8OGVMxYs7iv/MOLDK6Bd/BxgfEKoWUx462i5i/HFOOfnKQJrKD/1acC
	 nWlm160b66VDLCIBGCHzDJiHlca7uERfY992JJjGxwsq85QxRzC2C8762I03GdDvEdiM4
	 FFcV+qDwji07g2wtPn1MMLmc05Vd4ieszukmG4Nc9i3MNOReIUTPr0ZcrHHRZR/GH1uJR
	 M391ijbF6bSPMdYyS+s+GQGB0FHZXwwt3tPbS7iEFlxCNYxDGHu+JrjJpYKaHitg/2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nO51gOnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B274606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nO51gOnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F31F000C4;
	Sat, 21 Nov 2026 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254141;
	bh=WxsmbNMicaVwMZEG5JHAy06m1AL8tBuQiO8AbzOL7eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nO51gOnkZTmFLCT+ZsBRwBCjMHHsB/ftZawy0r1aCb5pxf8MgJ6DONhJOmgKTWpfc
	 UeRqcYKVLUbwGSMS62Y07ZnbyGmIGihxzuL32gHf2aIGoUJ/Aq1hrCVzERZ0VZxsuf
	 Cnjqzinl0ILy87b5R8j7B/qR5RU9nTxVTap+2IQbbhjJaQuImXkYFx+VHbb+TZb7pZ
	 YyLOfMrEY1RONxFdtmGzvXfN7S8lhIynvYqkBV74eFVg3MY1Jo9j1O+Li1QEC9YXbE
	 8WbMB3xRiLhYRehmoslaMDTSMrjY6B0/ADpbBAS29xtA2arS4gH4DdGKvTD/wKYLEH
	 /NUswAGlIRakA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:00 +0100
Subject: [PATCH mptcp-net v2 02/62] mptcp: drain the queues of a listen()
 that fails
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-2-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8rExIGGyB9E4T4HHurHBbodR4Zj5UvBwD2NP5qj7ZoA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0z3zcz21Hv2fO3nRjYinL2tjvl/k05zn/Xm17KZZy
 e85ff6ydZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyEw4iRYVmbCs8t/Z0T+SJa
 ZgS8fVly6vj7u3e6M2+W/OYsPygo4svIcECldA3DCZ/282uVD4R4v/Z0mBm4i5/nRmXh1u0Vjr5
 xjAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

Sockets and their network namespace can leak, if a handshake completes
while listen() fails on an MPTCP socket that has listened before.

mptcp_listen() passes the first subflow through __inet_listen_sk() to
inet_csk_listen_start(), which sets TCP_LISTEN, then calls get_port()
and hash(), and sets TCP_CLOSE again if either fails. Until then the
subflow is in TCP_LISTEN, so a request sock of a previous listen() that
still points to it can get a new child and be added to the subflow's
accept queue. But neither close() nor the next listen() frees what is
queued, and the earlier commit "tcp: drain the queues of a listen() that
fails" only purges the RST queue of an MPTCP subflow, which needs
mptcp_subflow_queue_clean() before a drain.

The fix used here is to call mptcp_subflow_queue_clean() and then
inet_csk_listen_stop() on the subflow in mptcp_listen(), if
__inet_listen_sk() returns an error with the subflow in TCP_CLOSE.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer of the previous commit, modified to use MPTCP
sockets, on both sides. Without this patch, sockets were leaked, and
network namespaces too when each round was in its own one, without any
message from the kernel:

  result: request socks: 10000 made, 1151 left. Sockets: 64982 made, 5755 left
  [...]
  result: namespaces: 1000 made, 923 taken down, 77 left

Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Add a Fixes tag. Commit message: how the issue was
  found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: commit msg: reproduced, with MPTCP sockets. Only the accept queue is
left, after commit 342e62fd34c2 ("tcp: purge Fast Open RST queue when
listen() fails").
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d05..08c3b005949d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4383,6 +4383,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
+	if (err && ssk->sk_state == TCP_CLOSE) {
+		/* inet_csk_listen_start() leaves this drain to MPTCP */
+		mptcp_subflow_queue_clean(sk, ssk);
+		inet_csk_listen_stop(ssk);
+	}
 	release_sock(ssk);
 	mptcp_set_state(sk, inet_sk_state_load(ssk));
 

-- 
2.55.0

