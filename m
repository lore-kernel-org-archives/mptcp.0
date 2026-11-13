Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599681;
	b=E6GT/CsuZc6SvQL7RAqMplfXdaXNGooiPXWqKWTFDKUfpTmipOyR4rrg3TzN4yQRfRlF
	 O+qdVj03CKcR510fInIGWz6y0+CJRfs0dPLjGWZbHCTBx2eYUUqb8pBLz1+RpJ1eBw3Bp
	 9DrQNOkBPZY4QjgyXog5LNIKrqeBBeW1HVBqGHApyj3gyH8vewz8a/1WTPzvpG/iyDr/k
	 qp/KzjlRJ/crX4OED36L/z5vvpACVVy1fV6Le2VGO/esrDkw+CRnnpILFLoI2Smnx5cDD
	 Ntg16AKTjzz56YvQZisJDkwri2xnmmlk32SV1ZAi3DDcf+EQpKGP3LT7uARAwpbeOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599681;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PvTUbuQb8MHiVLyqrdeS9xyc96F8bRisytUKyGbJEOQ=;
	b=mI3/AGTzL5W0ubMtSQnWupH1qxM6ReJ4nxEPhHXI/DUcM0cnIP12w+UHwuCEjv8QlISl
	 TpKGmrUAYlWvf71B8iRdNkxZz0dEJ9SZrkPLvq9BNDWgV7WH9G+JdjEPCIjtEprau9hY2
	 X1V0gxTXMN0YKw6N//nn50lE2yL1jtK27ewV2tBNG8L9RAbm5P1jRcG1QQLQZyiNNPxK2
	 2rXTj9kBj29CVGqxbEKUMnx4UNwsV3sfUZ9BSjrTyhG/m6BAkzmcuyoi6BndnjjHSgbgU
	 2y4ye+9csFre1a3CpJEv4Ed+UtTv9oSnb137UvX+LddoShA2c72KP7oCZSXVj9TyGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvl2ahfV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C3606AE95
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvl2ahfV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964551F000CA;
	Fri, 13 Nov 2026 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599681;
	bh=PvTUbuQb8MHiVLyqrdeS9xyc96F8bRisytUKyGbJEOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vvl2ahfVSWgDCL7X9BfU/tbQMGzQFnoDF/XvCeuRa3q0EP/8u+V3vosabdX8/qnZd
	 dfW41yQDWBYlVJnTXS5zaaKyjYkVfOF3ECHHozV4WQuN5XYqIDLhWUT7zeWV//E+UN
	 Bq1CC4M0Jnt78dW6REokGVrq/8zCgtCziKZ3lgzje2Mnub0hTTlrf/A2rDUet6bqbZ
	 RVphiWngW17wPQKKdRILN3pJYWEQBin/4I+QGPBP8pt6WmgTX1MIdKfWld81yb6eF0
	 8/qQtUIbcZxmjFfXFPPsPmvFxnb9s0QB2GD3JQUIbrDyYI/uXTy/LxJ3mF5JueFKP/
	 gIJKOjMI9bfew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:54 +0100
Subject: [PATCH mptcp-net 16/34] mptcp: initialize drop_req in
 subflow_init_req()
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-16-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2851; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PWYUAZdkSfAkh8EC4Mo/jVDZmR8fX9/umHc1wQ2yQhQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z92d86CV43aB5QsnNhWGWdm3mn68dCiJLbB8+5M54
 OdRfoW6jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImkfWZkmL/Eg++r0lNmQT7V
 Re2MXNIri5/XKGTbTOpRnHxfdtqWxQz/XTi5cj8xzBNfoRzx69feghNXPX83H/tmuPvQYbtsG7n
 nrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With CONFIG_MPTCP and SO_REUSEPORT migration, which
net.ipv4.tcp_migrate_req=1 or a BPF program enables, TCP sockets can
leak until reboot, and each keeps its network namespace alive.

tcp_check_req() keeps a child off the accept queue if drop_req is true
in a request socket that an MPTCP listener created. drop_req has one
writer, subflow_syn_recv_sock(), which tcp_check_req() calls before that
test only for an MPTCP listener. But if SO_REUSEPORT migration moves the
request socket to a plain TCP listener, the test reads what the
allocation left in drop_req, and nothing drops the last reference of a
child that stays off the accept queue.

The fix used here is to set drop_req to false in subflow_init_req(),
which runs when the request socket of an MPTCP listener is set up.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user in a user namespace, with
net.ipv4.tcp_migrate_req=1: an MPTCP listener and a TCP one sharing a
port with SO_REUSEPORT, the MPTCP one being closed while handshakes
complete. Without this patch, the children were leaked, with their
network namespace, without any message from the kernel:

  repro: step 3 to 6: 32 SYNs, 16 went to A. A closed, 16 third ACKs. accept() on B returned 0
  [...]
  repro: RESULT: 16 children never reached an accept queue
  repro: one RST for each connection. TCP: inuse 0 orphan 0 tw 0 alloc 16 mem 0
  === exit code 0. The process and its namespaces are gone
  === after:  TCP sockets allocated, all namespaces: 16 [...]

With UBSAN, the original version of this patch also reported:

  UBSAN: invalid-load in [...]/include/net/mptcp.h:144:47
  load of value 14 is not a valid value for type '_Bool'
   tcp_check_req.cold+0xb6/0x189
   tcp_v4_rcv+0x11f4/0x4230

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7b8183b6a13e..543368cfc890 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,6 +151,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
+
+	/* read by tcp_check_req() even after migration to a TCP listener */
+	tcp_rsk(req)->drop_req = false;
 }
 
 static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)

-- 
2.55.0

