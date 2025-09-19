Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB51212575
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275464; cv=none; b=sSh2LKqxrdQIZxJAWf6RcBQKQ4VaH4ioPHABJgTI1XACRoRBpa+wVx1bVUNdUQJJZkY9WwTsW8JRzdHE2ERxGYT8EdybyZxEh31YJhPEBtEbiZT56Bf/Tk40NwT5e32wfTks55sklm7XFQ3H99B2p0WxkLoT2mLM94VAsK/ZiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275464; c=relaxed/simple;
	bh=wS/Di6JJ4nQK5XcMS4aiVE7TsgXkimqMcSu3nAePfQM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHMGGkcsZXaf7XHPDVjiGWjm8AwBHI7z6LheIte5IGUkytIsZBR4AJ85jZrNm50Zot1uL8su2kn/1hXXbH0kyKlqPnEMGIrhpQfVtJQ7ukzM4X8WkK6P4udjyrxr2SykKedExx7GcFgggjBKecoDxglfDloeIYSJv2LhX4v686E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsmrifLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsmrifLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21A3C4CEF0;
	Fri, 19 Sep 2025 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275463;
	bh=wS/Di6JJ4nQK5XcMS4aiVE7TsgXkimqMcSu3nAePfQM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=OsmrifLjY/fQYM8P0tXQOUqL1zbKt/fNe1/hazfqy/PeZAGcffXoopKE9hyI5VkQM
	 7KRgVmDTFN3M5gYvOZPILIAFoJGk5fWssk/9m3LFp2ClnKq1ayPrrAeU2pLYcO/Ax9
	 0mF4zQi2B6l0YPja/5FRpNtFzREfrE9dK9DUkJB640Gf+hpIJ8gy4hg6yjvR+1nMFq
	 6ti0YfuUYnCBvXNCsyEkM/u9R0AMN7gKx83C4pYYBTHRah4/mJ0JlUIwh5wZzj9xz6
	 zMdMCpXRB3j0lSdU+0Z5MWzUkSBZ2ZDyba93jhuELiG6F/rnS0/yrLW3SqWeskjIGY
	 U0a87YPp48peQ==
Message-ID: <5c661ecc62a6326912f787a0ae6fe8b4fe94a438.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 07/12] mptcp: minor move_skbs_to_msk()
 cleanup
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 19 Sep 2025 17:50:58 +0800
In-Reply-To: <7874130ef3d034155655104b22712fa3c3c1d028.1758214564.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <7874130ef3d034155655104b22712fa3c3c1d028.1758214564.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-18 at 19:14 +0200, Paolo Abeni wrote:
> Such function is called only by __mptcp_data_ready(), which in turn
> is always invoked when msk is not owned by the user: we can drop the
> redundant, related check.
> 
> Additionally mptcp needs to propagate the socket error only for
> current subflow.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/protocol.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 66ad9a38a6082..02be42d3d11e6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -810,12 +810,8 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  
>  	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
>  	__mptcp_ofo_queue(msk);
> -	if (unlikely(ssk->sk_err)) {
> -		if (!sock_owned_by_user(sk))
> -			__mptcp_error_report(sk);
> -		else
> -			__set_bit(MPTCP_ERROR_REPORT,  &msk-
> >cb_flags);
> -	}
> +	if (unlikely(ssk->sk_err))
> +		__mptcp_subflow_error_report(sk, ssk);
>  
>  	/* If the moves have caught up with the DATA_FIN sequence
> number
>  	 * it's time to ack the DATA_FIN and change socket state,
> but
