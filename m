Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5D5B1E0
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074475; cv=none; b=TwE2InHyyOA8yxB+3qt8V5//ZghJTgjROjt9tItLW5zLx2k1/z1rhJuE4CChF/wNYCwtnvBtJ9qOIJud4rDISUnecSobuFaDHtuxKI0iQYICQpEdZL3I1vn7q8ps29F5RDn4dNzSkrpejYaBicUYNPJuu1G0+SxLVZRQDmob5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074475; c=relaxed/simple;
	bh=h3r49JzmDktiuCXNiSZCj7QA4/08mFZmlS4b7vGdmuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEDS1FFlniC/2oE/Rz6Pou5tb+94yUF4BZqbc62QMN+3v1gCUyP5WP/KlXD5EUbmDZ+Yqb3nwOqFB2z37tTXzKCBw5+3WVC3MYKdPd6emNbW4bVI8rjITmhx442P2wn8Tl1vcTXy37KDQGr29xwt8JZPVHxDV/2Cll3qhFuzLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUaRLKy+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUaRLKy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970D6C2BBFC;
	Tue,  7 May 2024 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715074474;
	bh=h3r49JzmDktiuCXNiSZCj7QA4/08mFZmlS4b7vGdmuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUaRLKy+BNZE2FKcZqrkfojDpxh0ql2CX4DEP+GVLchK9UE9QuLA72BV/TcBuG9c7
	 HpXlDp5ysLxXqdWRknZSiLZIco/2Zs1WaRMGoCGxvj4g6TGuzqu2WwHaSnbKMJ7sMg
	 3hODVJQpFkict57pxZt6VMnSdZjcWFADEWScE5Ud+6x558/JE7RUR2T1x/Db4yTCWr
	 MymiiImwAuTHBXv9H9G33ZY0RW1SKPQIjUVp16GVKHWiEo76xQaTnzWR6FT33JkS/l
	 brgTZg5Q/9HYLQoQpGsML2Ni9ExO6Wi/oMbVR/CunquRuFLton8yIHVprpz63fIfK0
	 7fCMxdq5tHg0w==
Date: Tue, 7 May 2024 17:34:28 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martin.lau@kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] mptcp: fix the default value of
 scaling_ratio
Message-ID: <Zjn1hZVgE9QHwn8X@T480>
References: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
 <7f9f2b7f-9bb5-4c17-bdef-c96fe2707d27@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9f2b7f-9bb5-4c17-bdef-c96fe2707d27@kernel.org>

Hi Matt,

On Tue, May 07, 2024 at 10:12:41AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (+cc Paolo who wrote the commit mentioned by the "Fixes" tag)
> 
> On 07/05/2024 05:46, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > BPF tests fail sometimes with "bytes != total_bytes" errors:
> > 
> >  test_default:PASS:sched_init:default 0 nsec
> >  send_data:PASS:pthread_create 0 nsec
> >  send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
> >  default: 3041 ms
> >  server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
> >  send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
> > 				has_bytes_sent addr_1 0 nsec
> >  test_default:PASS:has_bytes_sent addr_2 0 nsec
> >  close_netns:PASS:setns 0 nsec
> > 
> > In this case mptcp_recvmsg() gets EAGAIN errors. This issue introduces
> > by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The default
> > value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO, not U8_MAX.
> 
> It looks like you are modifying the max value, not the default one.
> 
> Also, please always explain the reason: why should it be X, not Y?
> 
> > 
> > Fixes: b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > v2:
> >  - I finally found the root cause of this issue.
> >  - cc Martin too.
> > ---
> >  net/mptcp/protocol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 579031c60937..d00cd21e8d3f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1981,9 +1981,9 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
> >   */
> >  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> >  {
> > +	u8 scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> 
> With this modification, you are limiting msk->scaling_ratio to
> TCP_DEFAULT_SCALING_RATIO. That's probably not what you want. See below:
> 
>   (...)
>   mptcp_for_each_subflow(msk, subflow)
>       (...)
>       scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
> 
>   (...)
>   msk->scaling_ratio = scaling_ratio;
> 
> 
> Do you mean that in your case, msk->scaling_ratio was assigned to
> U8_MAX? Or it was assigned to a too high value (>TCP_DEFAULT_SCALING_RATIO)?
> 
> Please add such info in the commit message as well.

Sure. Here's the new subject and commit log:

'''
Subject: mptcp: fix the max value of scaling_ratio

BPF tests fail sometimes (a probability of approximately 1%) with
"bytes != total_bytes" errors:

 test_burst:PASS:open_and_load:burst 0 nsec
 test_bpf_sched:PASS:Scheduler name too long 0 nsec
 test_bpf_sched:PASS:burst 0 nsec
 create_netns:PASS:ip netns add mptcp_ns 0 nsec
 create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
 sched_init:PASS:create_netns 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link add veth1 type veth peer name
 endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.1/24 dev veth1 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link set dev veth1 up 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.2/24 dev veth2 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link set dev veth2 up 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns mptcp endpoint add 10.0.1.2 subflow
 sched_init:PASS:endpoint_init 0 nsec
 test_bpf_sched:PASS:burst 0 nsec
 send_data_and_verify:PASS:burst 0 nsec
 send_data_and_verify:PASS:burst 0 nsec
 (network_helpers.c:613: errno: Resource temporarily unavailable) \
                                        send 5608500 expected 10485760
 (network_helpers.c:661: errno: None) recv 2755984 expected 10485760
 (network_helpers.c:669: errno: None) Failed in thread_ret -11
 send_data_and_verify:FAIL:send_recv_data unexpected error: -4 (errno 0)
 #162/9   mptcp/burst:FAIL
 #162     mptcp:FAIL

In this case, mptcp_recvmsg() gets EAGAIN errors. This issue introduces
by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The max
value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO (128), not
U8_MAX (255). Otherwise, scaling_ratio is assigned to a too high value.
'''

Thanks,
-Geliang

> 
> >  	struct mptcp_subflow_context *subflow;
> >  	struct sock *sk = (struct sock *)msk;
> > -	u8 scaling_ratio = U8_MAX;
> >  	u32 time, advmss = 1;
> >  	u64 rtt_us, mstamp;
> >  
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
