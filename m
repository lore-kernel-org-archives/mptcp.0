Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676862;
	b=eIVe+nkY8CzAeGyGetBAHNuZ1wQfCVvAACI1l7iOV3r2ZPE5c+8Q4t8sqVud3aDh/1X/
	 mJa7S0GU7meFYyXA/0z5bPE+dZcNcKL81eweFUxPMOMSxxfEbSoFrfSz7jv95FLonlHqt
	 FoxhP5pyrBsAxZwagZGrIkRaHH86GypfPtmc+p+Ak0i5axrQkl8aJLJjtoSo3/4mb8pBk
	 KD62n/kYx5c88Ik/0/mGmWSBQk5PvAUWAJsFWhVt317eua+z13ct3ze13ze8PusT67jKA
	 03OHu3ZnHnIrZaN31NGvPKS15FAfsreJuIP93ckVohve+Uys/kxEb2Fn7EBoqu+YLWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676862;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A2Z7IFT8T5NaQaPNhDqiINIoPxiFp9dgS1HuMHKFtJY=;
	b=TsgGls7qocH38D2JEJutXxNyddxxK49Zut5rAGOEyrN124zKIKKEZVSExfLoR2XLarS2
	 gsBXmWnpGvM39vZdXs7hsAW5usHWOZQ3vYySf3o9zrpi+7h5r7Kt9KT+sLJ+N9RwaRTPY
	 ITZA5xlT3dGN3hcwxEp462eYh1ZH9FwipHIdaIxG+SMKhzdQdywaPoko5dg+p6thQhNWG
	 ZIlL8TeklIMkkYsk8jb6SOAAvBBG11pkW2ODVan3sy3EHfvtw+P9VJC5L3+hkg94SqwdH
	 Qc9eoZU1TERz/hQR7RaXueKz+l0GFCpC95Z6PpdtqANp+eqSNCRphnxnauD3IDOs3nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffcOjmw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C7606A32A
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffcOjmw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307081F000D3;
	Thu, 26 Nov 2026 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676862;
	bh=A2Z7IFT8T5NaQaPNhDqiINIoPxiFp9dgS1HuMHKFtJY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ffcOjmw026mbVJULPRd2yRMuJauKs9SWszuKbhFrWW4NrXKMw7jW+cnmUQpfdcRHj
	 e6a4S3689zkpwbl6Cq3yUKovDYLCNF99iyKjoV4V3bD/HH5Gy+S1QN7YzK98EAJWMc
	 eIA5dl2el7w25ZbDCaVc1EQjZEuosRZEr12jMBYYL6qWzd8y6bgQIykBH2ySqAmMf+
	 Ur/W+kAeXvbd08B5Tdts9Qf0a5NRysxXTQr9z9Snc2tlcyQOhs0qqQKGQS6g7oZCMq
	 1ZE3ix5tq6QkE6V17cuS71sLpewHARBGLRxIFoTch8iPCUiZy32cQEoqIRkGnkCNTl
	 Abm+Gqni/uezg==
Message-ID: <320d80b918c509265516b3264083b99ff0658784.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 20/50] mptcp: don't inherit fastopening
 from a listener
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 15:07:37 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-20-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-20-416c0920c73f@kernel.org>
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
> A new msk is a copy of its listener, made without the listener's lock:
> if the application calls sendmsg() with MSG_FASTOPEN on the listener at
> the same time, the new msk can inherit msk->fastopening, only set during
> tcp_sendmsg_fastopen(). mptcp_disconnect() then fails on this socket:
> connect(AF_UNSPEC) returns EBUSY.
> 
> Clear this flag when creating a new msk.
> 
> This issue has been found by an AI code review agent, while reviewing
> "mptcp: fastopen: keep listeners and connections": before this other
> fix, these new sockets were mostly reset with the listener. It has been
> confirmed with a Packetdrill test, and a debug delay added in
> mptcp_sendmsg_fastopen(), during which the handshake completes. Without
> this patch, connect(AF_UNSPEC) on the accepted socket failed:
> 
>   runtime error in connect call: Expected result 0 but got -1 with errno 16 (Device or resource busy)
> 
> Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good! Thanks.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> v2: new, for an issue found by a review agent
> v3: msg: the new title of the previous patch
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d529cfb582a5..b1072123397f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4005,6 +4005,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  	WRITE_ONCE(msk->local_key, subflow_req->local_key);
>  	WRITE_ONCE(msk->token, subflow_req->token);
>  	msk->in_accept_queue = 1;
> +	msk->fastopening = 0;
>  	WRITE_ONCE(msk->fully_established, false);
>  	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
>  		WRITE_ONCE(msk->csum_enabled, true);
