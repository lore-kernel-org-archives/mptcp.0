Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827127;
	b=VyxF+Dxkui1aVd55yKVEAWz0lY73lejAYW1Nb25Dky5kHGqK250h5XLx051JIVOWjUH7
	 lmQUARh4hgxtIoIdRdE6Tap1voxr4OKEM2W9+xgWknRVV2W+VRBUknzuj6WTQcv6Le6Bh
	 v3x9i7SllGX60d+q5eLS2YbxKKrcbE8EDx0xDNG3pxLgSeV8tIkBzodkjrM0eXHmKX6la
	 UG8Ty+fAxkGot9fVsxJ+gFjBq204bzmy/91ov3aam0Ms6Xs9qsF7TWoDe9b8lgvtW6IYR
	 kXsjWIZQhjfMj/vFcqj4HI5fprP2M+10yTGRsj+lhrYaR/crL77OxGj+w3fFbyFY8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827127;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zCkUSbVaC99ocvtWd6PzxMceqATxYZB4lstxrT642MU=;
	b=JOWOdA3AV4xbI8Q87cXGo9L78srjYwmqTwzau+wLsBCDR0BoANAveu82xOKHQmZBi4Nx
	 YoP7/UMjiEGds37sk1wUD/SfEQI79h8vn4eqo4ndrdjGTunQjEvsVisUOlYlDQUPnzIMY
	 +w2CFXp6HA20bnU+PvXDkYc1+IpjAm61sq4FD2JyScsIoCrPRQq0wjdEZMB3BJyt6mni7
	 nhNygmE+mTrz0P07Ka1odD2nJVKQcxJIIlAYIu16xdSL1qNAjXSpi4WvR/PX6wJFl8t7l
	 9d7YYk+xoYKBrW0w6TY6tKMCD9uZq3iZJXaSVjDvvM/7p+2z7G3ICTSjjY/ZJxYjXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQI8mHez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDE606A88D
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQI8mHez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440601F0181A;
	Mon, 16 Nov 2026 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827126;
	bh=zCkUSbVaC99ocvtWd6PzxMceqATxYZB4lstxrT642MU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iQI8mHez+KYCOXf0rVzi5Dqkf6CrBI334vVfETye75Cw2INIgl+iiMbNPgjoKVuQ7
	 ugwYhSOLpP55kv18sxAWxMQnfsuGHh0crSuPQI4ok/dh8jvh9hNm1uWXoRvFjBxCdY
	 o8w0F+8WQ82GV+1zYo458elFsyntsQ//KDqX1/KvV0Cjx8PePziPuMeSGSDjXLQKYD
	 B6L+cWDUXy0+HlLP4m65MSixJeLHNfPrelZXv+bhWGzYL9hyHJwiPs+sgK9gDpyfRp
	 pF2ZP8WxeSkRO/Yhta05bbKxlbomcgVedU1zOuv/ITQnxYD2slEl1e8gPycNlSfKjc
	 9gN9jYwdlTJgw==
Message-ID: <c504da100dc5c5028bda391a6aabf0485464145c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 32/34] mptcp: fix dummy mapping of overlapping
 segments
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Mon, 16 Nov 2026 19:05:22 +0800
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-32-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
	 <20261113-mptcp-cmason-fixes-v1-32-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Fri, 2026-11-13 at 20:54 +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> An MPTCP socket that has fallen back to TCP can silently lose received
> data if a segment partly overlaps data received earlier, and recv() then
> blocks, returning neither later data nor end of file.
> 
> After a fallback, subflow_check_data_avail() makes up a dummy mapping
> for the skb at the head of the subflow's receive queue, in which map_seq
> and map_subflow_seq must describe the same byte. But since commit
> 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation"), it
> computes map_seq from the first byte of the skb, while map_subflow_seq
> is still computed from copied_seq, the next unread byte.
> mptcp_subflow_get_mapped_dsn() then returns the data sequence number
> (DSN) of the first byte of the skb, instead of the one of copied_seq.
> 
> These two bytes differ for a segment that starts before rcv_nxt and ends
> after it, since TCP does not trim it. mptcp_init_skb() then gives the
> new bytes of this skb a DSN that is too low, and __mptcp_move_skb()
> skips some of them as old data, leaving a hole in the stream:
> 
>     bytes 0 to 999 are received, the skb holds bytes 900 to 1499
>       byte 1000 gets the DSN of byte 900: too low by the 100 old bytes
>         that is 100 below ack_seq, the next DSN that MPTCP expects
>           __mptcp_move_skb() skips bytes 1000 to 1099 as old data
>             ack_seq is the DSN of byte 1400, copied_seq is byte 1500
>               later data starts at the DSN of byte 1500: out of order
>                 the TCP FIN becomes a dummy DATA_FIN after the last byte
>                   ack_seq does not reach it, so there is no end of file
> 
> Fix this by computing map_subflow_seq from the first byte of the skb as
> well: mptcp_subflow_get_mapped_dsn() then returns the DSN of copied_seq.
> 
> Chris Mason sent the same fix in private, and found this issue with the
> help of an LLM. It has been reproduced in a VM, with the reproducer he
> shared, and with a new Packetdrill test: after a fallback to TCP, a
> segment overlapping data already received is injected. Without this
> patch, the new bytes at the beginning of this segment were lost, and the
> connection stalled, with no end of file:
> 
>   reader   30.64: conn 1 BREAK: at my offset 1000 the bytes claim offset 1100: A GAP OF 100 BYTES
>   reader   30.64: READ-TOTAL conn 1 outcome iii-gap-or-repeat bytes 1400 of 2500 [...]
>   [...] end: hang: no data and no end of file for 30 s
> 
> And with the Packetdrill test:
> 
>   dss_fallback_overlap_client.pkt:24: runtime error in read call: Expected result 2500 but got 1400 with errno 115 (Operation now in progress)
> 
> Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
> Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]
> Co-developed-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> [ Combine the commit messages of Geliang's [1] and Chris's versions.
>   Commit message: how the issue was found, and its symptoms. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This fix LGTM! - sashiko has no complaints about it too. Could you please apply
this patch to the export branch first, so that I don't have to carry it along in
every iteration of the "Reduce the differences between TCP and MPTCP for TLS
usage" series? Also, Chris and I both sent out this same fix at different times,
which further confirms from another angle that this fix works.

Thanks,
-Geliang

> ---
>  net/mptcp/subflow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 543368cfc890..64e8f5c36415 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1526,7 +1526,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	skb = skb_peek(&ssk->sk_receive_queue);
>  	subflow->map_valid = 1;
>  	subflow->map_data_len = skb->len;
> -	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
>  	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
>  					      subflow->iasn +
>  					      TCP_SKB_CB(skb)->seq -
