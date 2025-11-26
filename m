Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D031B817
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150132; cv=none; b=EKpNZ4o9XuqlRvyACngebWdIVoa9mGoh2dq5jAEUblZwHzIAiwTTA7DiYzvDUzIgyhX+ng0aIBQLG+2XcYaXcocmyKX/IUfysvgTdQYrniV5nfiYr8UY7fmlDi1Z4Lfv0Yg3TyuB/zxDYdux1xpH3/FA2TOES/JfvzXS0/h6bgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150132; c=relaxed/simple;
	bh=GEfREnqZvIiO60erFzS59ctM0V+32EHMKtTtOj66tNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRWoNzpOvdNdjrH/gd1pCawQMGe4hBX6PUWaA8nbbO4JWNi9XLwPb7urJP6p9Sm8ZvTeRLZ2KpzTO63rvgryY2DXxIo+Zv6jI69WVzk7FYABdg5/wkO3bfJv8FcuBmypC5mX8E6m2tH8A77tRkAasJ5UTpjuU7wwVeFYi1ND394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4HHhb+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4HHhb+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137B7C113D0;
	Wed, 26 Nov 2025 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764150132;
	bh=GEfREnqZvIiO60erFzS59ctM0V+32EHMKtTtOj66tNM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m4HHhb+6Zamco4nD6sRdIAamb4dYA2jsxrJRDppM07otYbdVUMfWeWzTlXhD2DgNc
	 8RW8lTbPJ8zeB45U483uCiN7eZCicJXJlQjHee+Zpq+6MIsv9Y0EGkXugSi95CAymI
	 mlM29AmERhHXaCdolfvJI7Mah+Vbs5xtgIybWTmRNdetWueSBniA2iPdtH1cc754ne
	 u1nm1ZXPYs4xH9m+lcCpozjYPxSkaZzX0C/p9tjhjzNrhuuMvCRAal1qOkMVbz93nL
	 fB5rO2wB2vkju4YO6gOKcuzOYW88+H6oAXtzd/fxa/ZdTGHmTragUflkk3fRbsd/CC
	 K+j2/huXq+ueA==
Message-ID: <d7b2572ae9bb7dcfd74b15fa4c49f20369cc3276.camel@kernel.org>
Subject: Re: [RFC mptcp-next 6/6] nvmet-tcp: clear MSG_DONTWAIT for MPTCP
 (TODO: HELP WANTED)
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, hare@suse.de, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 26 Nov 2025 17:42:08 +0800
In-Reply-To: <cfdce3d91ca30abcf2ff9b77ecc146ad48f31d07.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
	 <cfdce3d91ca30abcf2ff9b77ecc146ad48f31d07.1762485513.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-11-07 at 11:37 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When running the tests from a previous commit in a loop, there is
> about a
> one in ten chance of reporting the following "timeout" error:
> 
> '''
> [   32.867710] nvme nvme0: I/O tag 1 (0001) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.867929] nvme nvme0: starting error recovery
> [   32.867994] nvme nvme0: I/O tag 2 (0002) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.868112] nvme nvme0: I/O tag 3 (0003) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.868359] nvme nvme0: I/O tag 4 (0004) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.868446] nvme nvme0: I/O tag 5 (0005) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.868592] nvme0c0n1: I/O Cmd(0x2) @ LBA 1046528, 8 blocks, I/O
> Error (sct 0x3 / sc 0x70)
> [   32.868817] recoverable transport error, dev nvme0c0n1, sector
> 1046528 op 0x0:(READ) flags 0x2080700 phys_seg 1 prio class 0
> [   32.868976] block nvme0n1: no usable path - requeuing I/O
> [   32.869038] nvme nvme0: I/O tag 6 (0006) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.869119] nvme nvme0: I/O tag 7 (0007) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> ... ...
> [   32.877945] nvme nvme0: I/O tag 122 (107a) type 4 opcode 0x2 (I/O
> Cmd) QID 2 timeout
> [   32.878025] block nvme0n1: no usable path - requeuing I/O
> [   32.878079] block nvme0n1: no usable path - requeuing I/O
> [   32.878128] block nvme0n1: no usable path - requeuing I/O
> [   32.878180] block nvme0n1: no usable path - requeuing I/O
> [   32.878238] block nvme0n1: no usable path - requeuing I/O
> [   32.878296] block nvme0n1: no usable path - requeuing I/O
> [   32.878350] block nvme0n1: no usable path - requeuing I/O
> [   32.878403] block nvme0n1: no usable path - requeuing I/O
> [   32.878455] block nvme0n1: no usable path - requeuing I/O
> [   32.883603] nvme nvme0: Reconnecting in 10 seconds...
> '''
> 
> Through debugging, I discovered that setting the MSG_DONTWAIT flag
> leads to
> MPTCP returning EAGAIN in mptcp_sendmsg.
> 
> This patch addresses it by dropping the MSG_DONTWAIT flag for MPTCP.
> I know
> this isn't an ideal fix, and I need your suggestions.

Good news! With help from Paolo and Gang Yan, I have finally solved
this issue. It turned out that the write_space function, overridden by
NVMe, was unable to be invoked by MPTCP.

This can be fixed by making the following modifications:

--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -973,7 @@ static inline void mptcp_write_space(struct sock *sk)
   /* pairs with memory barrier in mptcp_poll */
   smp_mb();
   if (mptcp_stream_memory_free(sk, 1))
-      sk_stream_write_space(sk);
+      INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);

I'll send out v2 of this set soon.

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  drivers/nvme/target/tcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 854b70b4a6f4..683a451bcb08 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -645,12 +645,15 @@ static int nvmet_try_send_data(struct
> nvmet_tcp_cmd *cmd, bool last_in_batch)
>  
>  	while (cmd->cur_sg) {
>  		struct msghdr msg = {
> -			.msg_flags = MSG_DONTWAIT |
> MSG_SPLICE_PAGES,
> +			.msg_flags = MSG_SPLICE_PAGES,
>  		};
>  		struct page *page = sg_page(cmd->cur_sg);
>  		struct bio_vec bvec;
>  		u32 left = cmd->cur_sg->length - cmd->offset;
>  
> +		if (cmd->queue->sock->sk->sk_protocol !=
> IPPROTO_MPTCP)
> +			msg.msg_flags |= MSG_DONTWAIT;
> +
>  		if ((!last_in_batch && cmd->queue->send_list_len) ||
>  		    cmd->wbytes_done + left < cmd->req.transfer_len
> ||
>  		    queue->data_digest || !queue-
> >nvme_sq.sqhd_disabled)
> @@ -694,12 +697,15 @@ static int nvmet_try_send_data(struct
> nvmet_tcp_cmd *cmd, bool last_in_batch)
>  static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>  		bool last_in_batch)
>  {
> -	struct msghdr msg = { .msg_flags = MSG_DONTWAIT |
> MSG_SPLICE_PAGES, };
> +	struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES, };
>  	struct bio_vec bvec;
>  	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
>  	int left = sizeof(*cmd->rsp_pdu) - cmd->offset + hdgst;
>  	int ret;
>  
> +	if (cmd->queue->sock->sk->sk_protocol != IPPROTO_MPTCP)
> +		msg.msg_flags |= MSG_DONTWAIT;
> +
>  	if (!last_in_batch && cmd->queue->send_list_len)
>  		msg.msg_flags |= MSG_MORE;
>  	else
