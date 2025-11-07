Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B913D891
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486695; cv=none; b=ib4D7HCvLuF5f5EHuamxXuShkMm46e/uG23m97TrZbGGQSMEXgat0W0pC2VP5xdeTsxky4/+Mtz5ydqAU3jbjUccYaHKgybVkmw/jroIKFq3QMhOWFuZ063Vyk4tK4jVTuKySS9CU6c23QYFKkYCx5QO5HQ9VN8WQrZCMHZzsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486695; c=relaxed/simple;
	bh=mFSXEgORr33xEfFsLfkZVniXeb6eqzeMzPyvO0vjOSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTVvZYUafFyFEKip2I3KryG5a5qwrNtiFIwEV5p/rfJG1yZWKRY4Dv67Gr6/K5trCIYRa8ubAfbsksoLPwipZUVSZEHHlEPqEESU5IIwyCfFfc8FiyE7hXxgJsaaRlX8CjNhC1cfxLb1lg6QWp+guKC/zx70cD47rkPWNb0XT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5rpM3CL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5rpM3CL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF07C4CEF7;
	Fri,  7 Nov 2025 03:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486695;
	bh=mFSXEgORr33xEfFsLfkZVniXeb6eqzeMzPyvO0vjOSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5rpM3CL9zcM5qjZ7XDvFu9tV5n+au7jB3MEeP1rBgHRuD1jw+CdSFfh8NLE02+6m
	 0kvYAIMbDDatRrTuz7WJsDv4A0WaBRQgQEW8+RH1+PPYb4clCvnWNJ7xI4h98neT5l
	 4FG01IPHNDjiF3A0aJEE/1cdQlliCLPb6WDruEEeU9pVp+qvTc6pUt/ySLDvtJHgwM
	 7DRLJSBPuAu8OE6CbgvOpM1e2zSJE9+xfx1Te4ItRUyXt3DesvzNMEM/iF6CHClkXZ
	 MGbaMW/Y3WQREZpn2F9+v20QOXQJy/cC1nu4Ax8rm4tnlJTaVjVuRMbUvbK2UTstXT
	 WWpMkwFC9N9Tg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 6/6] nvmet-tcp: clear MSG_DONTWAIT for MPTCP (TODO: HELP WANTED)
Date: Fri,  7 Nov 2025 11:37:37 +0800
Message-ID: <cfdce3d91ca30abcf2ff9b77ecc146ad48f31d07.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When running the tests from a previous commit in a loop, there is about a
one in ten chance of reporting the following "timeout" error:

'''
[   32.867710] nvme nvme0: I/O tag 1 (0001) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.867929] nvme nvme0: starting error recovery
[   32.867994] nvme nvme0: I/O tag 2 (0002) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.868112] nvme nvme0: I/O tag 3 (0003) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.868359] nvme nvme0: I/O tag 4 (0004) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.868446] nvme nvme0: I/O tag 5 (0005) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.868592] nvme0c0n1: I/O Cmd(0x2) @ LBA 1046528, 8 blocks, I/O Error (sct 0x3 / sc 0x70)
[   32.868817] recoverable transport error, dev nvme0c0n1, sector 1046528 op 0x0:(READ) flags 0x2080700 phys_seg 1 prio class 0
[   32.868976] block nvme0n1: no usable path - requeuing I/O
[   32.869038] nvme nvme0: I/O tag 6 (0006) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.869119] nvme nvme0: I/O tag 7 (0007) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
... ...
[   32.877945] nvme nvme0: I/O tag 122 (107a) type 4 opcode 0x2 (I/O Cmd) QID 2 timeout
[   32.878025] block nvme0n1: no usable path - requeuing I/O
[   32.878079] block nvme0n1: no usable path - requeuing I/O
[   32.878128] block nvme0n1: no usable path - requeuing I/O
[   32.878180] block nvme0n1: no usable path - requeuing I/O
[   32.878238] block nvme0n1: no usable path - requeuing I/O
[   32.878296] block nvme0n1: no usable path - requeuing I/O
[   32.878350] block nvme0n1: no usable path - requeuing I/O
[   32.878403] block nvme0n1: no usable path - requeuing I/O
[   32.878455] block nvme0n1: no usable path - requeuing I/O
[   32.883603] nvme nvme0: Reconnecting in 10 seconds...
'''

Through debugging, I discovered that setting the MSG_DONTWAIT flag leads to
MPTCP returning EAGAIN in mptcp_sendmsg.

This patch addresses it by dropping the MSG_DONTWAIT flag for MPTCP. I know
this isn't an ideal fix, and I need your suggestions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 854b70b4a6f4..683a451bcb08 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -645,12 +645,15 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 
 	while (cmd->cur_sg) {
 		struct msghdr msg = {
-			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+			.msg_flags = MSG_SPLICE_PAGES,
 		};
 		struct page *page = sg_page(cmd->cur_sg);
 		struct bio_vec bvec;
 		u32 left = cmd->cur_sg->length - cmd->offset;
 
+		if (cmd->queue->sock->sk->sk_protocol != IPPROTO_MPTCP)
+			msg.msg_flags |= MSG_DONTWAIT;
+
 		if ((!last_in_batch && cmd->queue->send_list_len) ||
 		    cmd->wbytes_done + left < cmd->req.transfer_len ||
 		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
@@ -694,12 +697,15 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 		bool last_in_batch)
 {
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
+	struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES, };
 	struct bio_vec bvec;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->rsp_pdu) - cmd->offset + hdgst;
 	int ret;
 
+	if (cmd->queue->sock->sk->sk_protocol != IPPROTO_MPTCP)
+		msg.msg_flags |= MSG_DONTWAIT;
+
 	if (!last_in_batch && cmd->queue->send_list_len)
 		msg.msg_flags |= MSG_MORE;
 	else
-- 
2.43.0

