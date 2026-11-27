Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741474;
	b=gWEw/BC9g2IwgaCmKRc0QFeAztP2ilOYR2pvbdPYHrY5eu+uL2PcUdpLLfkpuY/DU5EJ
	 /L+82JqDP5NZirOj5dlP7ZCNRKWj3Tgz7UwB9ZyjQBXLlIPWqSFyaF2EE0xoSC8YjZJuI
	 Vm58EndC1xvX8lXKLlx5FOpqgtTSCJqSWv+v5g8E/cdkjxwLTT6fqeeE+CaBLJKYqbhQK
	 MoVKZFWOQUI1jqUiJrK5y2Uy+WB+JPUVMw/zETfkwrx/A/YEbhiWssb1W01Asbbw20cYx
	 nqgqS8UEZWNYDAypyEhKnJaj1J2PTH6TZkgokfp+4H8q9IQ/UAjb8u969i2zXLrQiOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741474;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=03eBnxUYsO2SO4nQmCh11XMiLR91u0sckE259CzZfKY=;
	b=iwRqcuSRk7g8e/Uuo6KC6kfytNODfVMhU5lOnxReZmzl9C0AqPI2qnjiihPefSm4gPy/
	 mx46RwBbW70nLACSgo0LuXWSW5gSoHO3ukWpJCMYI4+K1LqtwxoRtKsRgHXbCXkzDGljE
	 eZudx31oWrTB6wC448qBynQuMww0taalrC0CFfUWLxhf+xBFpvOicpFiJAJlJFWHKRZ6y
	 e8SMs79dl83IXzDRyzebN6rx9iTX6i/GLx3+biIo0gm7yoGmFggmzV+7c4oTpSikg59kU
	 WuTgl375rqM/2uF9cnIqUOFIAuc8TnQqa1awnxbYCKCdEgNoGoPDIqzMGzWa0nlGr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ijaaxyjm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65B606A31E
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ijaaxyjm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B05A1F000C1;
	Fri, 27 Nov 2026 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741474;
	bh=03eBnxUYsO2SO4nQmCh11XMiLR91u0sckE259CzZfKY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Ijaaxyjmajx9rmJpXyD5pYSjO7b56rBt+VqdwdJ+EQJ+GtYodHflD4/rmW2II80Sg
	 ohxUGg+BbMTh7O9NgUl1ye9kwEvyFOM/DW2hU0Byc7WxwJfqy5cP9cs3UggWNEQ+qI
	 A19JcxeYK5hUbrRQDu+rQ6yclO2DjgwaAU1gNvd6q4zfaltEP9mNE7aSpGWxCdIf/W
	 6yd7434sEln2Y8P6c1CxpmkUcHlttEn206XzPi7l8ZDctVErybAT10YgRNchgH20On
	 H2x8s52NA5ggs1jjkIxD+MyKpfoguEfhwM0xxA9/ThaRLqEOJea40mrCEiiDwIvMAV
	 WnDvkWtv60xIQ==
Message-ID: <4c7662d165a2b62ffeca74f57ae0ac3350917ead.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 14/50] mptcp: report errors received before
 accept()
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 27 Nov 2026 09:04:29 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-14-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-14-416c0920c73f@kernel.org>
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

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> After a fallback to TCP, when the subflow of a new MPTCP socket has been
> reset before accept(), and the worker processed it before accept() too,
> the error was lost: read() returned EOF after the data, instead of
> ECONNRESET, and after a FIN followed by a reset, SO_ERROR was not set to
> EPIPE, as TCP does.
> 
> subflow_error_report() skips the MPTCP sockets in the accept queue,
> without a socket attached. Before v6.19, the error was then reported
> when accept() closed the subflow again. Since the commit below,
> mptcp_close_ssk() is used there, which skips this subflow, already
> disconnected, since commit 280d654324e3 ("mptcp: avoid dup SUB_CLOSED
> events after disconnect").
> 
> At accept() time, when the subflow has already been closed, report its
> error, after having processed the pending close events.
> 
> This issue has been found by an AI code review agent (Clashiko), while
> reviewing the previous commit, and confirmed with a new Packetdrill
> test: after a fallback, data and a reset are received before accept().
> Without this patch, the second read() returned EOF:
> 
>   v1_bind_tcpfallback_reset_before_accept.pkt:21: runtime error in read call: Expected result -1 but got 0 with errno 22 (Invalid argument)
> 
> Fixes: 48a395605e08 ("mptcp: do not miss early first subflow close event notification")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v3: new, for an issue spotted by Clashiko
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8edff68ec650..ff1dcf306723 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4705,6 +4705,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
>  		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
>  			if (unlikely(list_is_singular(&msk->conn_list))) {
>  				mptcp_check_rcv_close(newsk);
> +				/* not reported in the accept queue */
> +				__mptcp_error_report(newsk);
>  				mptcp_set_state(newsk, TCP_CLOSE);
>  			}
>  			mptcp_close_ssk(newsk, msk->first,
