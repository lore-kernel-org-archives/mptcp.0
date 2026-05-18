Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF02ED84A
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087701; cv=none; b=ZKH65dhJj5U1ALDlWK3xXnn6yEV6b1dhPr9Bbf1JtLXXYYfeJclt8tkHq9RwVyu5eIz27vZk1XfsJgd4hIViqhVJPLsB0+T/BWyjJKetWcjzXa6vLzSG5W56vSIXORtEM4P0v9wEXfQ1YcbmeL2Y4mXx5otYeSbkmUidnc0iFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087701; c=relaxed/simple;
	bh=l76T53aM27a7tQgBdTbwNsKLyspVBk+M6RWAIoCG25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOvYCNg8aY2kYMRlk5T5zoVqOE89A9E8kdcL47aWBl/0T7To2x/5RYTDV+3yGQOK84qmJsRlpO8DcBgMVDKZmQNHR7bFGvXrXrH4BnjzSz/JdVOOkrNIbHmH9l84wZhXae3YbeEcOu+mTC3KBqsZaDvi4GvagJ8XDJGaPf5nyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogQUrUJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogQUrUJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB52C2BCB7;
	Mon, 18 May 2026 07:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087701;
	bh=l76T53aM27a7tQgBdTbwNsKLyspVBk+M6RWAIoCG25A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogQUrUJgxsH4DUhgRzxpp9FsOC63iQTLmfxuPTupWibgYo04gJF2cXAMKL5utJ9Sr
	 MKkU8O9dAm/MyZQ8p3PVhp8+dO1pPjguwhbRMosZjLxOFlyJOP+vQcXxGukkUyJzld
	 nZu+SZYp4YTtelgA3xkfvkp/h+AgDOHnycxGwHCjwVbtqKSrJ6KC0ZS6eA9DAV/yWH
	 jEdwjEJDhc5VHMvRcsOSwKdhaQOjnexO3t+Z1MoIKsQvSC7LsBPWCD9ehjR26oVlVz
	 q1QW5ZgT3xoxTsZAcUmlY0Mk6Awq8b0lTBRC7/YHfjMMMvvyVmTAGL9MevDbLsWWN6
	 5j9ZVQrxFaOyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 01/11] nvmet-tcp: use tr_ops from nport in done_recv_pdu
Date: Mon, 18 May 2026 15:01:20 +0800
Message-ID: <f60490bc4dc3845ede83a41e36b0006340c502fa.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In nvmet_tcp_done_recv_pdu(), nvmet_req_init() should use the transport
operations (tr_ops) from the nport structure instead of the hardcoded
nvmet_tcp_ops. This is necessary to support multiple transport types
(e.g., TCP and MPTCP) where different operations may be required.

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..ebd7aa689c5a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -211,7 +211,6 @@ static LIST_HEAD(nvmet_tcp_queue_list);
 static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
-static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1081,7 +1080,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->port->nport->tr_ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
-- 
2.53.0

