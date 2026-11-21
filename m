Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254149;
	b=HxyYhyyoaa/y04caohj8wtUvmxoR0aNrNWycUr27r5Dtkcihul7iIObA3Igcmvy3mtdM
	 g/XHapqRWGMroVitYNAzagQeOvwEnJwkqpbigcBKgSnhSKeTqJlFf/NJRreoj1zYSr51v
	 aDlyLzUrDOCWaCC9uwkmRw1uBJO2Sgp7ipC69EahEwr5inWDHutfPo4u64YKpMc4iHYJe
	 yb/4DuX5Dihk1C8dK8BVRnxeZl3X08hzOBe0JBvIjShNWSUtEjQwuURCMxSsTxCVjiV8m
	 zOrDLdd53CoDDa8a+Tq+mFNJOMJlniQ2cTPXmy7uBBxDUhVACA252M1q9+HZaBUUM+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254149;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1f7An4Hb+QOdkzOwYoQKBvA2ae7xx/jJtrVwvgtdcLg=;
	b=wuYw9ux0Z91nd+LpkKwlRowEEhB1oclxnvO5cpwC1tR4ez8AV0qOG3ijrHnzjWob/byE
	 ig8QfplmyzbaxYuYHbyy1/bjjgxoFPUGWiNx7Mpgzgnzn1d5LIyiA5BqRDACHpTu8JhZ4
	 f/ACzExv6Q+UNwCRLPgGv73e6Kw1Rkfe9cQhfCBGw3YaAu6aZs/fj13Ch8xWm79W4H21a
	 T9ghe4ist40mTtbi1ctCgycZjxqJK34vne1PohQrnd1eq/tL/XxaMdMqPUl6j4bMneh+H
	 v97BcHM6HVEVki+POwyxjaAjmUx/WD+UWzWuXrioF9XZj6U1vxsOvajf6FoSQRttD8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMKxqBdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE658606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMKxqBdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341591F000C4;
	Sat, 21 Nov 2026 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254148;
	bh=1f7An4Hb+QOdkzOwYoQKBvA2ae7xx/jJtrVwvgtdcLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aMKxqBdcxBLi6n0fdhZbldytBayqhyhqCzL0oblngjDsJ3Ys/XoVA+x5mly5RKva9
	 zOKycOTQR92MvVK+4W3VkklwG3pABSef3yLI7YFlapnXAUq66G2A+UOS/VNwPFEBf5
	 Thxs/4SlQxo6xSljlkgGZRvrRtNvcfkgIXwWr9AOWqW99f+hszfAufPaNH5ZvZ8ZFj
	 +0PCPAy1TwYZ3vUMtNa+MHxCv0S8YKBBeBn+/SuQwQ8lajZIlGdzC2utI5VA4aFnZM
	 9MyfZSpDQnorNa8tQAzGLE1VVO3+oYwgI2lnZxligW2y18NooSMakQbn8QKcrZkYqu
	 df/Xc9Ex126wQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:08 +0100
Subject: [PATCH mptcp-net v2 10/62] mptcp: leave an orphan's DATA_FIN to
 the worker
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-10-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/G9M7hFeReWrFECsxUjtUr0Cr4ovpysIvD7RDt8ltYg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0wN4sgLXNTgt9A3o/PhV8Vjqa9agRU+2eL2cKaPl/
 Wnewf7fHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP57sLI0PF+Af9JtjlBHefz
 hZfHv/CXF8x9pfJtRaVL+kllG9mTExgZjj1/zftIv3S3nKt8eUJGUPGHGy1K1+fmsK+6W/h0+VJ
 rJgA=
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
index 90fbfb258b79..803ed1f9c413 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2364,9 +2364,15 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
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

