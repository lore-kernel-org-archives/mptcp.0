Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741624;
	b=Acm2NKPCcPAI2xuitPfB3CeisUlVLe5NCLdKJE9X0ZjMLntVbQ7OunvfFLZY7UyUUX6o
	 fDKokBTCgM/4u1snLxb+YWCU3CVqiUWE1/ibpIMkktLp74Kuo3hvu5PrsuQw1Aem9z3kJ
	 DTnLiiRrilFjGNKLqtenRmNkeTkDHafy4PQ81JN2oQm7Dz/U706N+HL+QORGobwe3QVj9
	 fChEOlecwb9E50ktuhN2ouvQRnJJUN/nOsFBsAR0GEkrYr/8BUhcRg438EKvk5vQxsrvX
	 QkxIFgOAMdvSpLWN0vdleoL+RCV/icik4zWgGSZ2Ji1ZyBDsvCNYNPLEASo4yzwWRMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741624;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7z9VdcdlACvezVUUSbp2+c3iHd0AJarVopGAMeDrpdA=;
	b=EzbrbdAwF1lf+rLVaGCjS55iQdzugNgzMzUML10BWsyN09c8QYvHNqLnULbXrCWxnsR+
	 oltf4n35a6ugnvCL7ePqqkZ0Cm0+kg49Mre/qQY2BuClWMsoSAHg02AiUGlEcK2rXCdlL
	 ljcYlIZ4gHnrNfj5YZZ8RLytVmWZ2OVHe05mBF3L5q1iUi/DbIkM4wdbvFXrk6TePygKd
	 uhQ/GQzX/opsPDlxAFoe18fozUPEfdAwPQqD9nDuDVVF9VuLkDiVLycshafsbCSeNuMbs
	 j9z29My9DI8XvgM+uQIWE+bS15VIqxQ+oPChGjX+l4G3e+fcsjbHLZfCFPUodebZvZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0Z9yQUs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F095606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0Z9yQUs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B439F1F00899;
	Fri, 27 Nov 2026 01:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741623;
	bh=7z9VdcdlACvezVUUSbp2+c3iHd0AJarVopGAMeDrpdA=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=W0Z9yQUsqGca7aGlzalMsPucScw95oczdgTO5Q0OaCH9nicyZwnk120pHyRZniGls
	 3XFb5O7jJf45BsOvEibsrlnlCvxvSazNBNGi8TmvPTPf+fbuwAi8UfVzAYSKnkuu4j
	 J1hcUNxVqmnCOHT4bDpJI2S6i0M2WBCjOapTGKuPbFIWa3Po0vZikrirIHdyONLZxg
	 CmVMEsMGbmsR2ZcjVr0+GHWHvMasrE5GJQtXYH1Y+Ui77oal69mi2eA6md5iX6Einf
	 KJ8vBRpebO4PDRIHLWnPex4yvcit391VbM6IHuUGeJX9MdYq2ucaK8lhHGOaFBp5o6
	 gTM7cN4nDHtLg==
Message-ID: <d75af8e5f769b8305b5e745af659f873cc435b20.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 13/50] mptcp: process pending close events
 at accept()
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 27 Nov 2026 09:06:28 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-13-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-13-416c0920c73f@kernel.org>
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
> When the only subflow of a new MPTCP socket has been closed before
> accept(), e.g. reset by the peer, mptcp_stream_accept() moves this
> socket to the CLOSE state, then closes the subflow. A DATA_FIN or an
> MP_FASTCLOSE received before, but not processed yet by the worker, was
> then ignored: the code processing them before closing an MPTCP socket
> without subflows, and the worker, skip a socket already closed.
> 
> recv() then returned ENOTCONN after the data, instead of EOF after a
> DATA_FIN, or ECONNRESET after an MP_FASTCLOSE alone, as TCP does.
> 
> This race has been found by a review agent, and confirmed with
> Packetdrill scripts and a debug patch delaying the worker of the MPTCP
> sockets in the accept queue: data, a DATA_FIN or not, then a reset with
> an MP_FASTCLOSE are received before accept(). Without this patch, the
> second read() returned ENOTCONN in both cases:
> 
>   With DATA_FIN: runtime error in read call: Expected result 0 but got -1 with errno 107 (Transport endpoint is not connected)
>   Without DATA_FIN: runtime error in read call: Expected errno 104 (Connection reset by peer) but got 107 (Transport endpoint is not connected)
> 
> To fix this, process them before moving to the CLOSE state, with
> mptcp_check_rcv_close(), as done when closing the MPTCP socket without
> subflows.
> 
> Note for the backports: before v6.19, this helper, added by the previous
> commit, is not available, and mptcp_stream_accept() closes the subflow
> before moving to the CLOSE state.
> 
> Fixes: 63740448a32e ("mptcp: fix accept vs worker race")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v2: new, for an issue found by a review agent
> 
> Note (Clashiko on v2): after a fallback, a reset received before
> accept() was not reported when the worker processed it before accept():
> pre-existing, fixed by the next patch.
> ---
>  net/mptcp/protocol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b57d0f82b416..8edff68ec650 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4703,8 +4703,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
>  		 * deal with bad peers not doing a complete shutdown.
>  		 */
>  		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
> -			if (unlikely(list_is_singular(&msk->conn_list)))
> +			if (unlikely(list_is_singular(&msk->conn_list))) {
> +				mptcp_check_rcv_close(newsk);
>  				mptcp_set_state(newsk, TCP_CLOSE);
> +			}
>  			mptcp_close_ssk(newsk, msk->first,
>  					mptcp_subflow_ctx(msk->first));
>  		}
