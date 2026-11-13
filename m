Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599673;
	b=IF7MiL/pcjtrVsU9BvM/jieRB3+ZQPC7zI8NNWJtEbcrkl9bL8Hr9KE8E3XDo174BiIF
	 tf7JUC8rQFeh+iUojFugsuBwPVfkrCglVE4jwcWQglRNheil8PnJcV17tVwwQE3W+A08S
	 j2QDCEAK/p8VKdjTE4/VnMLA1t9AvgJzLvwS3e+Emi8v9wLLUGxDKBDYGicUpSLWiG48y
	 z2UXuqopZKqkjlkFikyO5PGVF02GtR1ev9opGCtu8RgcS6J64meN6Q/oFqRRM4t/VvwSa
	 9t0I1vTITNZj5b69b0NIhQaWIuqlysdKy1pseWIRaLWTEqd4Zpu0P5gdXKpWEQLbseg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599673;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1xsih8J5PZwsEr5ofTOoK85D29iep0KBRC9JrtfExbg=;
	b=1VrsttJ2hv2KTSSgem3MJWQ9QzXNgL7TofAjl21sojscQp/PhiILqVHTViqsTzvAeqeG
	 qj/2x6+/liUnAZkH5VoNda6TAq1lfWj34C8GJC//oUzRMIDoO9EznJuCgPrbOwiPSO9S2
	 VphirCU3OlLZJddkT8nHs3p2X4yE1L/WHbQvMc1vtV52Y1UGdLoQWOWovbcHfGrdx2bDA
	 +IvWx9GtVk/BKcDcYUFLn01cLsuPUav0+vm9LqARoaGlJh9W0LI23+cbmTAQrA0ruWqZ3
	 ov/StxRMR20jkDrL7+Vda9D8tsdp1RHEUZ+fE0U8mqgyn22WvXuw6tdpLD1UkjNuiRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tk1TjdE/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53C606A335
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tk1TjdE/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2E81F000C5;
	Fri, 13 Nov 2026 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599673;
	bh=1xsih8J5PZwsEr5ofTOoK85D29iep0KBRC9JrtfExbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tk1TjdE/tCXrZ84eT06y1Xwp/mrtbvopPS5e25MoguZfIlKxOa0l/hqREuJQ8a2Ed
	 TXlfjxbCQPlMT0tYmHx5M6/ZxV7DS7jE82zhpGNPJr2k6LqbD8y6YknbQhVYJGRgS9
	 sd9haOzGxvQ8o3mSBCi6wpWgwUqKKs7vNPe6U3S9RN/nBGkUgmiXkPRYxcNZQMZ7kh
	 YMuqmYpL04lY0qGVWwnUKgffRdBlUM5pvQiIxYRtnD+TRV62fkzZYuiF59ai0/VoBZ
	 9ov3n/vzJzJfSMLkORfSVPEnzl4AsdmMYCLCHp7yvguvs52WtZkTbKTxXrELBY4kT8
	 MSx2BKgckQezA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:47 +0100
Subject: [PATCH mptcp-net 09/34] mptcp: leave an orphan's DATA_FIN to the
 worker
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-9-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JTWlyZr+lb1AF30QveWluMciOjPrBXiiZCI58AIGu24=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z934yi0rb7U+413P70kLubteGz66+tkk6cB+BZHSI
 /8WrNC36yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIzg9Ghm83Luy53ydgdrhg
 6421zxYs+aSuKqTKaH2N+cS3I1KnH81h+M3uqDvb/Urnn6LFHCf0fSdJKJz5riBr+bGDgbmqtXO
 3KBMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

Closed MPTCP sockets can leak until reboot, with the data in their
receive queues, which can exhaust tcp_mem and stall other TCP
connections.

Once close() has returned, only mptcp_worker() destroys an orphaned msk,
and only in the run that moves it to TCP_CLOSE: a later run returns at
once, and mptcp_schedule_work() queues no work for an msk in that state.
The receive path, in softirq, puts data on the backlog while the msk is
owned, and release_sock() calls mptcp_release_cb(), which passes the
backlog to __mptcp_move_skbs(). But __mptcp_move_skbs() calls
mptcp_check_data_fin(), which can move the msk to TCP_CLOSE, and by then
the lock owner, here the worker, no longer looks at the state:

    receive path, softirq             mptcp_worker()
    =====================             ==============
                                      not in TCP_CLOSE: no destroy
    last data, with the DATA_FIN
      the msk is owned: backlog
                                      release_sock()
                                        mptcp_release_cb()
                                          __mptcp_move_skbs()
                                            mptcp_check_data_fin()
                                              TCP_CLOSE, never destroyed

The fix used here is to queue the worker in __mptcp_move_skbs() if an
orphaned msk has a DATA_FIN to handle, instead of calling
mptcp_check_data_fin().

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
200,000 connections in which the server accept()s and close()s, while
the client reads the end of file, sends one byte, and closes. Without
this patch, some MPTCP sockets of the server stayed in the CLOSE state
for good, with their network namespace:

  === connections so far : MPTCP sockets of the server in the state CLOSE: 200000:722,
  [...]
  RESULT [...] | left 300 s behind the end: slab_MPTCP=722 sockets_MPTCP=722 [...]
  [...] | veth_end_left=1 slab_net_namespace_left=2 | [...]

Fixes: bc68b0efa1bf ("mptcp: move the whole rx path under msk socket lock protection")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d6ed293f6e5..16824bed85b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2363,9 +2363,15 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (moved)
-		mptcp_check_data_fin((struct sock *)msk);
-	return moved;
+	if (!moved)
+		return false;
+
+	/* Only the worker can close an orphan, as it must then destroy it */
+	if (!sock_flag(sk, SOCK_DEAD))
+		mptcp_check_data_fin(sk);
+	else if (mptcp_pending_data_fin(sk, NULL))
+		mptcp_schedule_work(sk);
+	return true;
 }
 
 static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)

-- 
2.55.0

