Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EF43AA2
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459983; cv=none; b=EILbQOzYKakL4N6/o0f1oZDjFirF+Nb/Cj9nOB6Xj3TIm2YNPTXKn/Aa+ufWtWcUtLdlChyUS0zTuOlAP/hAPsiyvbOOYOX9Y5yVNtTZlzPnxwUuu0HZ5iFmTP86fjQUEXAeAmAgLe/+9Mwu8KJHSmlSS3/bMV2AIH1jPc4cqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459983; c=relaxed/simple;
	bh=YY1nVoRiu/NNWWU099MdvJoHhWQ/yeSfSkzZ7WNM5+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i5hHfH9/ITONrLyW4cCuO304KtfaSy6A/M6bJJP1z4Cic0K8yKBYBJtgDoYtw6i9ww5GmDcQPM+sWWvWYanB/i0ov42VbMA7wfGrXwmu34JIL+WmO0rtRTFJSTHdkGlRNH8DG48lvgk359y/KDA6an/awqeSDbPs0KkkJuSCboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp9CsN1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp9CsN1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F405C113CC;
	Thu, 18 Apr 2024 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459983;
	bh=YY1nVoRiu/NNWWU099MdvJoHhWQ/yeSfSkzZ7WNM5+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Kp9CsN1G9/gtlic4cc4qP6yehzD1D5FNzcxHqligrwMk92l5pEpCx7QK4686MNtzS
	 Kl+zSqRBXW4fC1FS9nGDbhmqiDoRS5abGs84CBSI8eIMp7JsBOJFZ/AeUGxVxNJ15K
	 cr1Plu9+CeLley12RWrsFpYXqAZKtUPMHBY110ytpzn9p327dC8FF1shKEjlElviZP
	 oxOJhx/0mhYkxe+tc+m54Nj+pnb5Zi5A0rq8LixnpVGka70ZlaxMNYEE46YJm3gasb
	 jR7b9EWKi8RzuTDB24C24HYPHZ0IgT5kHM56+yCP10r9SmeHqzjlLSrx1w1K7nrJhr
	 9MXEDrwukfFeA==
Date: Thu, 18 Apr 2024 10:06:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: info: stop early if no
 buffer
In-Reply-To: <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
Message-ID: <e10a438b-a286-3bb5-4818-b2537acecf65@kernel.org>
References: <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Apr 2024, Matthieu Baerts (NGI0) wrote:

> Up to recently, it has been recommended to use getsockopt(MPTCP_INFO) on
> an 'accept'ed socket, for a server app to check if the client requested
> to use MPTCP.
>
> In this case, the userspace app is only interested by the returned value
> of the getsocktop() call, and can then give 0 for the option lenght, and
> NULL for the buffer address. An easy optimisation is then to stop early,
> and avoid filling a local buffer -- which now requires two different
> locks -- if it is not needed.
>
> Note that userspace apps should use getsockopt(SO_PROTOCOL) in such case
> instead: it looks less like a workaround, and it works with any kernel
> versions, while the MPTCP_INFO method requires kernels >= v5.16.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/sockopt.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1fea43f5b6f3..b0d1dc4df0c1 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -960,6 +960,12 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
> 	if (get_user(len, optlen))
> 		return -EFAULT;
>
> +	/* Opti when used to check if a fallback to TCP happened on an 'accept'
> +	 * socket. Userspace apps should use getsockopt(SO_PROTOCOL) instead.
> +	 */
> +	if (len == 0)
> +		return 0;
> +

Makes sense to skip the work, LGTM:

Reviewed by: Mat Martineau <martineau@kernel.org>

> 	len = min_t(unsigned int, len, sizeof(struct mptcp_info));
>
> 	mptcp_diag_fill_info(msk, &m_info);
>
> ---
> base-commit: 69582b96be671a6d87ab1e96e86c26225f1ec12a
> change-id: 20240418-mptcp-getsockopt-info-opti-1232118bb417
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
