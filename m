Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB302222CC
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330140; cv=none; b=h3dRbdM/URTvnwZx21CV/HZIJUCEGmQCTqk6iTsdJXK857iFnfZRF3ggAL4y+HXlEZxSQYV2kN9UHwDDQs3N8NCU+4M1CkEvvY0z9UNCuK65MUOpsYhCnHbMpzfrI5bwWN+1AO5Ow+RqbJGfVilToiuEaICcf29XQI1Ksboumn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330140; c=relaxed/simple;
	bh=rDXkFibwW9OJSeXhunTKIFP6J/UbODnXQEELnwYM6gc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bybNFBueWguUylj2FKXjreD4qnhnA2WbSA77WEtZglaeF10LUejFtl8P3QOrpUbQNce3VBju5Tdnmi8C1agyq/9qzSBJUskaLTKTjJ2jS9dCSc2cH1glCE7R1241LPksuKNU/g0b0VvlvT5RFsuYh6pX4oM01jeS1ezuNX09iR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgkwiC/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgkwiC/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29026C4CEF5;
	Wed, 10 Dec 2025 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765330138;
	bh=rDXkFibwW9OJSeXhunTKIFP6J/UbODnXQEELnwYM6gc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YgkwiC/J/NuFiP7Ro/iBOtMdBXGnX0qVOiLY3j42Kia3Vl6IX3z91BYKs7PsNJ8/z
	 YFHnICteqSIi3Jj+JYdvK8CoYEwNRcz8B+LR5HlrjcXD5iq2z2Yxit2+Nbjz9WvSoz
	 83ceGOcJ26RfqB/apPnnm8vJgIx7hWhk7jLe8bjkK+JKINWavCBe2c2+IFWnCc+JYm
	 t9z/QXlEjFGnlKiATRKr+JaAZ1LRYn69xQcQ3oCnAToNX2GmCC/Q7ceDf1iMIdpTp7
	 1LwQuVWQ2V4txe73//kgq2t7dA+BjP3GEvzxlHXQCGqWS4SfTebK6i3MRuI0wrJ7cq
	 SJcX3WbIoCauw==
Date: Tue, 9 Dec 2025 17:28:57 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 0/6] implement mptcp read_sock
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
Message-ID: <1dbb7691-d529-950a-665a-0f91646e658e@kernel.org>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 6 Dec 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v15:
> - Patch 2, remove the maximum length limit as Mat suggested.
> - Move tcp_recv_should_stop() helper out of the series as Mat
>   suggested.

Thanks Geliang, series LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

(except patch 2 which I will ack separately)


>
> v14:
> - Patch 2, new helper __mptcp_read_sock() with noack parameter,
> this makes it more similar to __tcp_read_sock() and also prepares
> for the use of mptcp_read_sock_noack() in MPTCP KTLS support. Also
> invoke msk_owned_by_me() in it to make sure socket was locked.
> - Patch 5, export tcp_splice_data_recv() as Paolo suggested in v7.
> - Patch 6, drop mptcp_splice_data_recv().
> - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1763974740.git.tanggeliang@kylinos.cn/
>
> v13:
> - rebase on "mptcp: introduce backlog processing" v6
> - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1761198660.git.geliang@kernel.org/
>
> v12:
> - rebase on "mptcp: receive path improvement" 1-7.
> - some cleanups.
>
> v11:
> - drop "tcp: drop release and lock again in splice_read", and add this
>   release and lock again in mptcp_splice_read too. (Thanks Mat, I didn't
>   understand the intent of this code before.)
> - call mptcp_rps_record_subflows() in mptcp_splice_read as Mat
>   suggested.
>
> v10:
> - add an offset parameter for mptcp_recv_skb and make it more like
> tcp_recv_skb.
> - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1756780274.git.tanggeliang@kylinos.cn/
>
> v9:
> - merge the squash-to patches.
> - a new patch "drop release and lock again in splice_read".
> - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1752399660.git.tanggeliang@kylinos.cn/
>
> v8:
> - export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h.
> - add a new helper mptcp_recv_should_stop.
> - add mptcp_connect_splice.sh.
> - update commit logs.
>
> v7:
> - only patch 1 and patch 2 changed.
> - add a new helper mptcp_eat_recv_skb.
> - invoke skb_peek in mptcp_recv_skb().
> - use while ((skb = mptcp_recv_skb(sk)) != NULL) instead of
> skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp).
>
> v6:
> - address Paolo's comments for v4, v5 (thanks)
>
> v5:
> - extract the common code of __mptcp_recvmsg_mskq() and mptcp_read_sock()
> into a new helper __mptcp_recvmsg_desc() to reduce duplication code.
>
> v4:
> - v3 doesn't work for MPTCP fallback tests in mptcp_connect.sh, this
>   set fix it.
> - invoke __mptcp_move_skbs in mptcp_read_sock.
> - use INDIRECT_CALL_INET_1 in __tcp_splice_read.
>
> v3:
> - merge the two squash-to patches.
> - use sk->sk_rcvbuf instead of INT_MAX as the max len in
> mptcp_read_sock().
> - add splice io mode for mptcp_connect and drop mptcp_splice.c test.
> - the splice test for packetdrill is also added here:
> https://github.com/multipath-tcp/packetdrill/pull/162
>
> v2:
> - set splice_read of mptcp
> - add a splice selftest.
>
> I have good news! I recently added MPTCP support to "NVME over TCP".
> And my RFC patches are under review by NVME maintainer Hannes.
>
> Replacing "NVME over TCP" with MPTCP is very simple. I used IPPROTO_MPTCP
> instead of IPPROTO_TCP to create MPTCP sockets on both target and host
> sides, these sockets are created in Kernel space.
>
> nvmet_tcp_add_port:
>
> 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
> 				IPPROTO_MPTCP, &port->sock);
>
> nvme_tcp_alloc_queue:
>
> 	ret = sock_create_kern(current->nsproxy->net_ns,
> 			ctrl->addr.ss_family, SOCK_STREAM,
> 			IPPROTO_MPTCP, &queue->sock);
>
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it is not implemented in MPTCP. So I implemented it
> with reference to __mptcp_recvmsg_mskq().
>
> Since the NVME part patches are still under reviewing, I only send the
> MPTCP part patches in this set to MPTCP ML for your opinions.
>
> Geliang Tang (6):
>  mptcp: add eat_recv_skb helper
>  mptcp: implement .read_sock
>  tcp: export tcp_splice_state
>  mptcp: implement .splice_read
>  selftests: mptcp: add splice io mode
>  selftests: mptcp: connect: cover splice mode
>
> include/net/tcp.h                             |  11 +
> net/ipv4/tcp.c                                |  13 +-
> net/mptcp/protocol.c                          | 215 +++++++++++++++++-
> tools/testing/selftests/net/mptcp/Makefile    |   1 +
> .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
> .../net/mptcp/mptcp_connect_splice.sh         |   5 +
> 6 files changed, 289 insertions(+), 19 deletions(-)
> create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
>
> -- 
> 2.51.0
>
>
>
