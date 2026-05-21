Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC85360EDA;
	Thu, 21 May 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334129; cv=none; b=XVtsGKOMIqO6TxRYNXFn8YDpMDFGygNk8clIrBTvRB+qboBoNAT4l8RPTgSFA9l4tb5Yy+iEJe2NoHOLRL4o4bZkCuhJJ3RSxNFNUKUItaoxgfGBhQH8ytFyRFHas3LCkod9nEEXmlxZtW2f86j/htTXetQXGZVoeHBjG0R7Cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334129; c=relaxed/simple;
	bh=ormrvSzueMuYKSsgTMU9bd3BI7psozozyihQjVHLiik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcrpaaTAaV149+Sw/L5jI9Q2ok2ZnD1adEeTSoMOrp63XVGryyr9l4+QQSowtIV4pYBoNEY5mL7aFGBQyttiMfV/hO4ocTlxU2yZNMssokDhN3TKjjhGt7m0UbRIDxhYIkHpicGWLC92fkaVavciZFMnJG5vLdN+0iEUBSetQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njpVL7g0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njpVL7g0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEDE1F00A3E;
	Thu, 21 May 2026 03:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779334127;
	bh=JDwWEszVW0ozbfE62J6M/b2AIbeh5w1dxkRwQ9+6H3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=njpVL7g0BsTXfQ/yXtOUFYMkJKtHoPOZyp/4OezpNBYt6vpSIOeK7+xHEtgIHcB21
	 6zKD+tfa0TNbILeTuzhXKo2Y9DADiRHYJFgInpiYUBujWeB1AoZjpSiSrF6tAwGK5p
	 5//AWnC73I1hzROXZ5/YJjQvC+00xtiBXa/qn50S2AfZU0DimOVjPos02JOidCGTnF
	 opZZUouJrYgM2Fly9Dsipz0M9J7BfynxiutQFNcYDNgxTJO84A98pX7+u7q9YAF3ok
	 sRDyOFsK8HOg/yt79ZnuqAMcGUprPp6Nl2wIpE0hL1Z9NJf2rJeqYACRYnB66sDbiV
	 VmviofOjyMxeg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Gang Yan <yangang@kylinos.cn>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 1/4] mptcp: sync the msk->sndbuf at accept() time
Date: Thu, 21 May 2026 05:19:08 +0200
Message-ID: <20260521031906.740857-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521031906.740857-6-matttbe@kernel.org>
References: <20260521031906.740857-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=matttbe@kernel.org; h=from:subject; bh=qDRSdub3sv4BWfBJw9DcEvzI4fbL9JeAWuiAfUv8qiM=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4Kvd0HDk5SWCznlikb4iJ1vsfM9+WXX5nyCJikXnip p2EYVFHRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER40hgZVnIdtYmblzg/tHjy Og3208FL9vUtf2SyyK1LUc/7zOWprIwMTffSljiyGe0/lmzqWD15sY767W2LlvMuCOR6fHmfv/h ZDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

commit fcf04b14334641f4b0b8647824480935e9416d52 upstream.

On passive MPTCP connections, the msk sndbuf is not updated correctly.

The root cause is an order issue in the accept path:

- tcp_check_req() -> subflow_syn_recv_sock() -> mptcp_sk_clone_init()
  calls __mptcp_propagate_sndbuf() to copy the ssk sndbuf into msk

- Later, tcp_child_process() -> tcp_init_transfer() ->
  tcp_sndbuf_expand() grows the ssk sndbuf.

So __mptcp_propagate_sndbuf() runs before the ssk sndbuf has been
expanded and the msk ends up with a much smaller sndbuf than the
subflow:

  MPTCP: msk->sndbuf:20480, msk->first->sndbuf:2626560

Fix this by moving the __mptcp_propagate_sndbuf() call from
mptcp_sk_clone_init() -- the ssk sndbuf is not yet finalized there -- to
__mptcp_propagate_sndbuf() at accept() time, when the ssk sndbuf has
been fully expanded by tcp_sndbuf_expand().

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260420-net-mptcp-sync-sndbuf-accept-v1-1-e3523e3aeb44@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ No conflicts, but move __mptcp_propagate_sndbuf() above the for-loop
  (mptcp_for_each_subflow()) present in this version, which will modify
  'subflow' used by __mptcp_propagate_sndbuf() in this new patch. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aed6c04c7de6..ff1632d03a96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3451,7 +3451,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4064,6 +4063,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
+
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-- 
2.53.0

