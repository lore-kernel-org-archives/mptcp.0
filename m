Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FE3CAA50
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781708; cv=none; b=jNrJyMQQZ1oD0FauJDeQNx6LGQIYaSfFrSENkH7NgP0MiCt39C2V3KTVOpnVdkFF1Co/IaF+/phDmKKb3KXHfIhnZeiJbJDbHpUXaohakfwsmm1OcdO7XmUlptTa6Wcwr/HMxTVIta7wAu5u1UApwGmnuUUyChU81It8o3RzfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781708; c=relaxed/simple;
	bh=877DW5zm9eYrSagFXzzZ27MlckS0PAXBoyjUE25WyP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka6cF/LxOZNBd9PeZxR37B5BDKes9D/GygUdEvkWEn9SPHuKVBUr46R/ssrA84eTHN56rX/wXfr4VsxcFzBimRT3WJLjdrIRDWmgKBWP4PyCw4Be/7uAjn252IkLSfuCD8EoOfM8saxFoUCQDxmxnE4rViiUkz0vsZEBXYiENvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdxUbZE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdxUbZE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75421F00A3A;
	Tue, 26 May 2026 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779781706;
	bh=kvrpAxbiMNZ3sNGwiJC92247Bo0RuF8o+I8oVPPwrCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hdxUbZE5PpoCxvIvIkXK7GHkF/YcyGSNw4aK1NeDK23o52vUXUTqAWO3Onc+40/i1
	 hA4+j/zYNEx/WgOaN+C3kt+J5fBow7GtfmK0WfxxGwf0axwhDyxROygOETveZAF6Lu
	 EGufVbyvT0AOXoRkB3i2zKMTxeb7Je5TH3nRupeHiyNIQ0VhC/BfkYXtRSTIdLUp0A
	 hA9BynapZsqd0GEn7lY1FPVnwupjXW0PYvcKWwEy79RGg62EySyu08Lt+F8//0yAtJ
	 LQE3uxvVr+Xqlon1JF+Iw1jBzX6soFLxQYfnbFW0Gcc02SGqMQtoH8cyXTNVO2KgFJ
	 A7pBRhGd7B2oA==
Message-ID: <a3849de4-a4da-40e5-85bd-ebeb7e395fac@kernel.org>
Date: Tue, 26 May 2026 17:48:22 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/05/2026 07:43, Paolo Abeni wrote:
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
> 
> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4d72f286a485..97ea4aa37b33 100644
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

Do you need to call tcp_update_max_rcv_wnd_seq() after having updated
rcv_wnd?

See 0e24d17bd966 ("tcp: implement RFC 7323 window retraction receiver
requirements") for more details about it.

If we do that, I guess we can declare "struct tcp_sock *tp" here in the
if-statement.

I can also update the patch when applying it. Apart from that:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

