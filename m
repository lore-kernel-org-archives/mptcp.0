Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254160;
	b=pYNA04EmDAy/dbdoYP4NNx8rp3hRgnJB7tbGaAdLFASp2zfIfF8miWsVVsMClFgN+Vd7
	 aqZF0spdV/OyMGqwyuVdeLqoXeTsGOirAzRLL6FCS5/C2EOKhdCIDseM4DrHz7CChwD58
	 ZRgKflj6LjXjhxZYEcL5xwCKdvE/qCS3gmXKmLGtgn8MMeFn1gghSOM8lLGZIfgVMFaMN
	 ZBWi75uGtlQBLQpNNsLHBOodL1g8WcTc1qpieVzBaC4W18WGpGfCQmhkOeWXevNkmpF9r
	 Hn+1yu6FKn0LYqrgC4rb90eiAgxaQb08QQcFw01sKcpVTdsvUDRhRVwDnKJqubIrnxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254160;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1yzzdBxRNXwXwFRGHrVaGLBPDR7oDdyW2VC62tjTlZM=;
	b=TgW2pn4TfCH6jkyLl5Uz0NOfhplrktkoxT0oKrZdn5+Mt7f56Z3OpTlVi/E0EJb1/yoo
	 P9mtPX1rGl7h84lke2j2HPk4yjzP81L4jnmRHViO9vrpJk0+6PvkGRIO2w45E7A1VJrIn
	 k8dek5vKP1cBWaqUgkhRVoIWf/p4yeJkItxXu9pJ+BIX5CFTcrgNzX6wzbfdETN9lhoAY
	 79mh7hvnuPew8RUU2mxIox2xEJLh6Fe4LrsOkYWmrXg+BWeeqF2BMlYVdfvEQ/AocvkWL
	 CbIrfUYR2PFrA16KPFrg4LQ/Yn2n0b2xsvRXo/j/HqPQMohVuqaGMd8WKVsTJBHcKsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9IdP5Es;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E53606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9IdP5Es
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63231F000C0;
	Sat, 21 Nov 2026 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254160;
	bh=1yzzdBxRNXwXwFRGHrVaGLBPDR7oDdyW2VC62tjTlZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d9IdP5Es5E/4J5/dE5kn4bI+RsFjMbDCDoEkAyRZSHb7gag9o2hDsz02BbXcjrfQ7
	 SuYy6d7Btv3AseBA/AGV/5xFuzoNjC7aQZ8T1HH+EhthlLl+WiItQcaKDrHtwa05EH
	 0D5Ei61hbVYBBL72yKLzTaNpvmWBoAizLJ6aoknbzuv/fcwDr5uhwRlNZyo+wqCRW6
	 E5o8bW4QmibdpcBy1xx7d5znTMhl5OiUKWddBvPKlLEg5A1p7Jp0hGCizUE4Uzyn/W
	 iwGl6V5kZssMhaHTUs9mVknEskqqBmlzDrzXcbvfjzSkGVEeE6MCQDxVL9Bh0idore
	 GTEJoTpElY/5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:22 +0100
Subject: [PATCH mptcp-net v2 24/62] mptcp: process pending close events at
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-24-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PXMzScb/ikkOHhotgT0uVp1mVlCO6ryzxXyKVDqp2tI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ06M+X76wfEevEZ+QzhXLWxX3JZR+FOeeum+5o/zSt
 Zdl2Zd3dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkigEjwwf+hgdGfy4rCNhe
 TXm87pCc9YeSTYc2vDqZGG2b5L0lxYbhv19Lz6P0zRyqiaGsv2adrrxV4/bTNKh3+u2NW55/rQi
 v4gUA
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
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4dbe6d3a466..7700265a13ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4679,8 +4679,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
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

