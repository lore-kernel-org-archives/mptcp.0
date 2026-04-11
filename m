Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891A21E091
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879388; cv=none; b=bJFtrXz1jXv+LBQLX0wAEqp4H77JFrLCRl/gQj7/D3wRvJLmgTZtQAsq29wN4saq5lP7iHnHKgmR8FjcMSTXYC8legGXQXfaMV9SAJsF+N0fBxhw/OrkFH15PQ/Hf4IdjiiXA8THYTrVEQLl7a29U75bjITgv65ldhiIktCEfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879388; c=relaxed/simple;
	bh=d9JPc1B8Jh62jVBuK2SkYCEKFYpVLC+uBht7K4PRaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN15MLDI0L76pFbdoAN+gVlAIoqEsP+ixWLtdBl5wdtDlnl2Lowcgp8S743l0zl9RZBonliFUCrHyiRyExPMN0NA5nqWj3C/cAjj0dKES/MNlUYum0wrqCW5N/K4MY3yr11l/fuHZbu9iu4gS+e55ZFuazhS6euHERlWAtH4OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pc650lgP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pc650lgP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775879384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyYxWWPmEXwCiAw2A5XpCWQKadPpXI3oo1ifsXeyqk8=;
	b=Pc650lgPsHsGTgzS6aC+xeMQEHso8PhGralpQO4MFL/eKgq6J8Dn1UFyqVoSv9WqrclX/k
	8NYfP0Xn9aDU4SUSdVKs1EO5gIU/Zmg1LI4XVr80tU0jrMD/MsZyeM9zfsAO25fUbsCZL2
	nL58ud6mLx6omVJvBuLWP4gbBybfrYY=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v4 1/2] mptcp: sync the msk->sndbuf at accept() time
Date: Sat, 11 Apr 2026 11:48:59 +0800
Message-ID: <483c31e532e8e63a38fec5bf6501c9f69ff66052.1775878944.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775878944.git.yangang@kylinos.cn>
References: <cover.1775878944.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

On passive MPTCP connections, the msk sndbuf is not updated correctly.

The root cause is a timing issue in the accept path:
- tcp_check_req() -> subflow_syn_recv_sock() -> mptcp_sk_clone_init()
  calls __mptcp_propagate_sndbuf() to copy the ssk sndbuf into msk
- Later, tcp_child_process() -> tcp_init_transfer() ->
  tcp_sndbuf_expand() grows the ssk sndbuf.

So __mptcp_propagate_sndbuf() runs before the ssk sndbuf has been
expanded and the msk ends up with a much smaller sndbuf than the
subflow:
  MPTCP: msk->sndbuf:20480, msk->first->sndbuf:2626560

Fix this by removing the __mptcp_propagate_sndbuf() call in
mptcp_sk_clone_init(), as the ssk sndbuf is not yet finalized there.
Instead, call __mptcp_propagate_sndbuf() at accept() time, when the
ssk sndbuf has been fully expanded by tcp_sndbuf_expand().

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..6b486fc94c16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3594,7 +3594,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4252,6 +4251,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
-- 
2.43.0

