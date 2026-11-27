Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741982;
	b=w/xB9FKrd/JrSmGI97gAPusqzkOyfrp5kmiXT91k7iq4jR3jR6gxl46+mfCRDaAZpZQv
	 LY8x5XrumOzOkHx7sHmWJgU81WBWoSyERj4EOAYkUGdIsdKTI+T8P6xPEDtr6OXZMTr84
	 /kd/L02HgSYeAQcEmpM5lFglMGTnxMxLDD8gvodenx3krVo3M3ezinAiiR8v666kLve17
	 OJuB5L9lwGGhdDznlxBKmWWHksNyiqfEUKRIbGFRk0wiqAtpQs3xeAHbjd+1xxoF4/YQE
	 +ld/GCQw7FDxPVLQFXXXn3sY3fWdLanwWdlaSD50YE/gBR4/BbnlD6l8vz9ivWlTFug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741982;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Ix7dqKMK2OTXiLUsgsxICvfjGLA0F0KQqeqmpiWbAU=;
	b=T2rOGTSApkQukpv6lFs01szQDmsSxCutrv8TYZvbn+RZbzsNGt/cowC3IAJEvXx/cQj6
	 jd1Ou7F6ELH8NmTUDtY6SDHzWB7UxqJKrOEwkPcfaorwP0kBT839TV41mWMpsIxUdw5kW
	 HNsHyQzzhG4O2nfuZANFcFzBMO4D0PohIwYCgubICWELA5EY7B2X7fAIte9Fd8KJxYShs
	 F43zWx7FTLEhst/8Z2GrLMhuVJK8ltmPZlZgSPdb/STCQVjWsXEJF+Z4a7uD2ftGfymYD
	 ml8c4sY/9Y1K5r+rBeCr+3+NnrzHAWPwQthUuUAjtFoCWOpJpUwd4wwESzmrEtsJK8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ozm7Bsmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B06606A31E
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ozm7Bsmf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F411F00897;
	Fri, 27 Nov 2026 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741981;
	bh=7Ix7dqKMK2OTXiLUsgsxICvfjGLA0F0KQqeqmpiWbAU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Ozm7BsmfrkFw+3+jaJuBvmi1mgq0z0/qq60gs/4gNOluClSFwmGr+EdCCTPw5CQQB
	 L9DRNiMOy0irRaHPjZfhR0QLSQApm9S91t4OrYwpL37UTtalMm4BBZMIr6O2aWAaKX
	 RAV2/PZ9TYNDPguWFhrkJziCxcMcYZqba+eNxdgFcB6EKRcPFIe/WcEt1feija169O
	 lLQDMnvkXegk2WPCox4dZW5kxm7tGLkNiAtoKsQYkr+6gpLOKeteGSqea3InNjO2Nf
	 w2w46TVU9jbqeEvYH3HYWfMcChgzdVzFGj+rGF7Ym6nHv26dHX042cZjwj95kPXofJ
	 quzd0he4zuY0Q==
Message-ID: <6f9057868b35286ebf0e487787b5b0e15f1582c6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 11/50] mptcp: no sf left: process pending
 MP_FASTCLOSE
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 27 Nov 2026 09:12:52 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-11-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-11-416c0920c73f@kernel.org>
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
> When the last subflow is closed while the MPTCP socket is no longer in
> the ESTABLISHED state, e.g. in CLOSE_WAIT after a DATA_FIN, the MPTCP
> socket moves to TCP_CLOSE. But this subflow could have been closed by a
> reset carrying an MP_FASTCLOSE, not processed yet: if this reset is
> received while the worker is running, after mptcp_check_fastclose(), and
> before __mptcp_close_subflow(). At the next run of the worker, the MPTCP
> socket being closed, the MP_FASTCLOSE is ignored, and no error is
> reported.
> 
> This issue has been observed with the "fastclose test" subtest from
> mptcp_join.sh: after the DATA_FIN from the client, then its
> MP_FASTCLOSE, the server, still having data to send, was killed after
> the timeout:
> 
>   [FAIL] client exit code 0, server 143
> 
> Since commit "mptcp: wake up blocked senders when no sf left", this
> subtest no longer fails: SEND_SHUTDOWN is set in this case, and the
> server gets EPIPE when writing, which is expected there. But the reset
> is still not reported. This has been confirmed with a debug patch
> keeping the worker busy until the subflow is closed, and Packetdrill
> scripts sending an MP_FASTCLOSE in this window: in CLOSE_WAIT, SO_ERROR
> was 0 instead of EPIPE, and poll() did not report EPOLLERR; in
> FIN_WAIT2, read() returned ENOTCONN instead of ECONNRESET:
> 
>   fastclose_close_wait_race_err.pkt:26: runtime error in getsockopt call: Bad getsockopt optval: expected: 32 actual: 0
>   fastclose_fin_wait2_race_read.pkt:28: runtime error in read call: Expected errno 104 (Connection reset by peer) but got 107 (Transport endpoint is not connected)
> 
> To fix this, process a pending MP_FASTCLOSE before the close, if the
> socket is still in use.
> 
> Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: new, for an issue causing a flaky selftest
> v3: msg: the subtest no longer fails since patch 7, and the remaining
>     issue, checked with Packetdrill (Clashiko)
> ---
>  net/mptcp/protocol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5d916c6b43f4..bcdad00d3573 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2705,6 +2705,8 @@ static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
>  	mptcp_data_unlock(sk);
>  }
>  
> +static void mptcp_check_fastclose(struct mptcp_sock *msk);
> +

Would it be more appropriate to move the definition of mptcp_check_rcv_close()
helper from patch 12 into this patch?

static void mptcp_check_rcv_close(struct sock *sk)
{
	mptcp_check_fastclose(mptcp_sk(sk));
}

WDYT?

Thanks,
-Geliang

>  /* subflow sockets can be either outgoing (connect) or incoming
>   * (accept).
>   *
> @@ -2817,6 +2819,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  			mptcp_schedule_work(sk);
>  		} else if (sk->sk_state != TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
> +			/* After the close, an MP_FASTCLOSE would be ignored */
> +			mptcp_check_fastclose(msk);
> +
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			WRITE_ONCE(sk->sk_shutdown,
>  				   sk->sk_shutdown | SEND_SHUTDOWN);
