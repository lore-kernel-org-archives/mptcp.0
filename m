Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725843;
	b=OBXKHbGRKkvSTk4ZE92haAZ4wCa2OKxLtx/OgRQ7NZhTFAlTAP1s+xn80KMXyk99uVmZ
	 XxQhIr9/wOqfemPt4XpB42enVmJuXPujfxDX7g2Jjhkt312/uJVLx4pYyyeYNJ2tFHgAH
	 3RD6k7mzeHg6jfd/Zlgn0y//PIdirVQhf2HY/w2ptj0G5GoQnB/cI8snothZ1trfkDMOK
	 PkFM+6EyVUMpP5o2xOIGuo8I3/VGkFnDVO1osj/EGdgt5/x1r9GpwTXt+1I51rr7SQgEY
	 In3MSc7uw/VSdneqSDFeexoGAfUzIHv3FR0rc+a2dBYKv5WeCwujQ7UBIVu+st5vziQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725843;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EBawKmi/RdVVrHAVKPmy9VzogMedHqA1pyvmDuGM2pE=;
	b=emMkQSLdnGaeg4xkBag6/LfFgIbzmpJjfMWkrIDJhvCS0o90s+GUGUDQ+UTdrO9syHJK
	 W8QUPPk+YSIJ49Ve2qe7s8ev1gv4N/V3uR8t6g90g9TBt4lAxW3Nqs9ZH00AXij38VRrP
	 JFV7gjE3VTcsv+GXBlfs3M7e3yHNwklTTKvxVPXmhamXqYmIbuMdzc9pbgYb4dlcG6omW
	 DdzrYF9nFubJF5JkNYIZzcRFMvXXGdxqsVvsrE4YWiUqOsuoS/Kl69UEK+8j/0pAsdKDh
	 9+Kq8U/S1CgV3ksw67W9aLEdiWiPfPLo8LYuuPoZTuE2SFx7zIwJU5Wt9SPvNBUgDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp09yyVG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2111606A69D
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp09yyVG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA051F00893;
	Thu, 26 Nov 2026 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725843;
	bh=EBawKmi/RdVVrHAVKPmy9VzogMedHqA1pyvmDuGM2pE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kp09yyVGektrbT+GO7l4tTPlP8RyTiv+BxaF5hGJolALLU39ksKoybgDjDfjqc3d3
	 JIT7qhkRBvLlYqyd6c5MY4VIJJDBGy1mvsAyzPiF/YPs+MPOnnhpOOlx5w6IqHMd1l
	 hVUP58laBMmp+MPrFg1nxGHDtL14LdU8BKcZ8HQsJIbR93lCqZIs3Sx94F7pYTbBem
	 6MdEi0LdjCK+yOMXewvpqYGBeSnqvf0s2FZ52xnJSFt/8q3zGq0W+7IFZXvayCZBrI
	 1S2h8GD3/sOBUZ0U+94wdpNgu2mtZn75KGgyQlmEcXFlPprHbQ0CfYYqsbR/3dMXpU
	 ApGWr3MTk3m4Q==
Subject: Re: [PATCH mptcp-next v9 4/7] mptcp: handle SO_ZEROCOPY in setsockopt
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:03 +0000
Message-ID: <179572584314.3133.7930166357274276359@kernel.org>
In-Reply-To: <aaf330d9dbfe6e4f8b15542106d5e687e719a8cf.1795591278.git.tanggeliang@kylinos.cn>
References: <aaf330d9dbfe6e4f8b15542106d5e687e719a8cf.1795591278.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds mptcp_setsockopt_sol_socket_zerocopy()
  (net/mptcp/sockopt.c), the first way to set SOCK_ZEROCOPY on an MPTCP…

--

mptcp: handle SO_ZEROCOPY in setsockopt

Until now MPTCP setsockopt() rejected SO_ZEROCOPY with -EOPNOTSUPP, so on
MPTCP sockets MSG_ZEROCOPY quietly fell back to copying. This patch adds
mptcp_setsockopt_sol_socket_zerocopy(), which checks that val is 0 or 1,
sets or clears SOCK_ZEROCOPY on the msk and pushes the flag to every
subflow. sync_socket_options() also copies the flag to new subflows.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..3391f7a9d9834 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -184,6 +184,31 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
>  	return 0;
>  }
>  
> +static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);

[Severity: Medium]
This is the first way to set SOCK_ZEROCOPY on an msk. That means
unprivileged userspace can now reach the ubuf dfrag path in
mptcp_sendmsg_frag(), which the earlier patch in this series, "mptcp: add
MSG_ZEROCOPY support", added. Does that path handle memory pressure
correctly?

In net/mptcp/protocol.c:mptcp_sendmsg_frag(), every dfrag goes through
tcp_wmem_schedule(), including pure zero-copy ones. The early exit is then
skipped for ubuf dfrags:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
	avail = tcp_wmem_schedule(ssk, copy);
	if (!dfrag->ubuf && avail <= 0) {
		tcp_remove_empty_skb(ssk);
		return -ENOMEM;
	}
	copy = avail;
    ...
}

tcp_wmem_schedule() can return 0 in two cases: when sk_wmem_schedule()
fails with sk_forward_alloc at 0, and when the subflow already has at least
tcp_wmem[0] queued.

Plain TCP avoids this by skipping the schedule for pure zero-copy skbs, and
by treating 0 as wait_for_space:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
			if (!skb_zcopy_pure(skb)) {
				copy = tcp_wmem_schedule(sk, copy);
				if (!copy)
					goto wait_for_space;
			}
    ...
}

When copy is 0 on the MPTCP side, mptcp_sendmsg_frag() still does this:

		get_page(dfrag->page);
		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);

		if (dfrag->ubuf && !skb_zcopy(skb)) {
			skb_zcopy_set(skb, dfrag->ubuf, NULL);
			skb_shinfo(skb)->flags |= SKBFL_PURE_ZEROCOPY;
		}

So a zero-size frag is added, and page and uarg references are taken for
zero bytes.

On the alloc_skb path, __mptcp_alloc_tx_skb() has already called
tcp_skb_entail(), so the skb is on the subflow write queue. The function
then writes the mapping:

	mpext->data_len = copy;
	mpext->use_map = 1;

and returns 0 without calling tcp_remove_empty_skb(). RFC 8684 reserves
data_len 0 for the infinite mapping.

The other two early returns in this function call tcp_remove_empty_skb()
to avoid exactly this state. __subflow_push_pending() treats ret <= 0 as
"stop pushing" and does not remove the skb.

Could mptcp_push_release()->tcp_push() then send a zero-length data
segment carrying a data_len 0 DSS mapping? That segment would also be
counted in packets_out and could be retransmitted by RTO.

The triggering sequence would be:

setsockopt(SOL_SOCKET, SO_ZEROCOPY, 1)
sendmsg(MSG_ZEROCOPY)
  mptcp_sendmsg_zerocopy_iter()  /* dfrag->ubuf != NULL */
  __mptcp_push_pending()
    mptcp_sendmsg_frag()

This needs tcp_wmem[0] or more queued on the subflow, sk_forward_alloc at
0, and __sk_mem_schedule() failing. The last condition can happen under
global TCP memory pressure above tcp_mem[2], or with a tight memcg.

On the reuse path with !can_coalesce, the same thing appends a zero-size
frag to an existing skb. If sk_forward_alloc could go negative here, copy =
avail would also wrap to a huge size_t value. I couldn't confirm that
sk_forward_alloc goes negative on this path, though.

The code is still the same at the end of the series.

Would it make sense to fix the ubuf handling in mptcp_sendmsg_frag() before
exposing SO_ZEROCOPY? For example, skip tcp_wmem_schedule() for pure
zero-copy dfrags as TCP does, or handle a 0 result with
tcp_remove_empty_skb().

> +	sockopt_seq_inc(msk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
