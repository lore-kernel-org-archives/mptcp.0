Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA83C1F
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385136; cv=none; b=N5LQIc/HPSYR4bkyNhBTjKCTsdJzzkOAoWC8d5EfltYdC/xkWuUOCQkm+bqHjZdoLuqtYj4eYU2mVLv+HRNDDBIiBBsUfAqUro2DUXab7Fd1GxZT8I4EOgQg/1w2K4T84CwtyeGlWOLyyAJFtoj6geXhFA3dYs9qXCjkxB4QzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385136; c=relaxed/simple;
	bh=PVBrtAO0auVQOViPXfWPiqCMZN29jt78ahxgnU3zvPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDo2i2zO/I6xBYslvynMGlDErBVk6XlI/TwZrUVwKzkRPlBDOn1oZwcV4Q+mkc9pG0SS99PU99OyLcMw+VT0US8+MamPltpB9/Z5W5+wb+40u0MJA127lUYSHKqsf7acYqKBEIPI5imb7hogBNSwVhWzoICgrwRxw+/KWBE/3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlsiQy/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlsiQy/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F181F00898;
	Tue,  2 Jun 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780385135;
	bh=bCyz90QcAn2hIy97evlWJyp2faq20hW5zhT8C8urzWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nlsiQy/GZxPP9VHWav0b767wfigcajMpOaPywz8q6Y/bCyg1JQNvhQQSQ7X9SZIY8
	 7Z2is+tybzpxEY76A5ELxdRFbLXD5sD7lEGFN1+Vl3DxTCZK89GRbeVSMC15ut4He8
	 gXnoaik8rWiT0TqSjC6qKB/GerBbLmdIneOhmUwWyLrELx3ZS7OXGfpPAtVHk4L253
	 kOgjUoN2U7n+F5z48Y20mltDB6xRW7BwJXyR/U4qJIY8yrV918Ylu7itvSssWr8XO3
	 puOOTqdwWSQsITTZpSkE5BV+tg44OMHAkXuWWsjC1VFRw6wKchQAuPwO7bWn0mDQe3
	 T6AvMFxS2Oprg==
Message-ID: <2caac8f2-f9b5-480b-9764-45ff9818be8c@kernel.org>
Date: Tue, 2 Jun 2026 17:25:32 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 04/10] mptcp: allow subflow rcv wnd to shrink
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-4-a5ae7791754b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-4-a5ae7791754b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

(-Cc Netdev)

On 01/06/2026 13:10, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> In MPTCP connection, the `window` field in the TCP header refers to the
> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
> constraint is enforced at DSS option generation time.
> 
> At the same time, the TCP stack ensures independently that the TCP-level
> rcv wnd right's edge does not move backward. That in turn causes artificial
> inflating of the MPTCP rcv window when the incoming data is acked at the
> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
> 
> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
> even when the sender is not misbehaving.
> 
> Prevent such scenario forcibly allowing the TCP subflow to shrink the
> TCP-level rcv wnd regardless of the current netns setting.

(...)

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 5c228344e83f..12cbd98c7111 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	struct tcp_sock *tp = tcp_sk(sk);
>  	unsigned int dss_size = 0;
>  	struct mptcp_ext *mpext;
>  	unsigned int ack_size;
> @@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  	if (dss_size == 0)
>  		ack_size += TCPOLEN_MPTCP_DSS_BASE;
>  
> +	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
> +	 * wnd soon: ensure that the window can shrink.
> +	 */
> +	if (skb)
> +		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;

Claude has a comment about this new block:

---------------------------------- 8< ----------------------------------
Could this assignment perturb the old_win snapshot taken shortly after by tcp_select_window()?
I
n net/ipv4/tcp_output.c, tcp_select_window() begins with:

    static u16 tcp_select_window(struct sock *sk)
    {
            struct tcp_sock *tp = tcp_sk(sk);
            struct net *net = sock_net(sk);
            u32 old_win = tp->rcv_wnd;
            ...

and later uses old_win to drive the zero-window transition counters:

            if (new_win == 0) {
                    tp->pred_flags = 0;
                    if (old_win)
                            NET_INC_STATS(net, LINUX_MIB_TCPTOZEROWINDOWADV);
            } else if (old_win == 0) {
                    NET_INC_STATS(net, LINUX_MIB_TCPFROMZEROWINDOWADV);
            }

After the new write in mptcp_established_options_dss(), tp->rcv_wnd no
longer reflects the previously advertised window but the amount of data
received since the last window update.

Can this cause LINUX_MIB_TCPTOZEROWINDOWADV to be missed when rcv_nxt
equals rcv_wup (old_win observed as 0 even though the previously
advertised window was non-zero), and conversely cause a spurious
LINUX_MIB_TCPFROMZEROWINDOWADV when the assignment yields a non-zero
old_win on a subflow that had actually advertised a zero window?

Would snapshotting tp->rcv_wnd before the assignment and restoring it,
or moving the shrink into tcp_select_window() after old_win is captured,
keep these counters accurate for MPTCP subflows?
---------------------------------- 8< ----------------------------------

I don't think that's a blocking comment, but I prefer to have your point
of view if that's OK.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

