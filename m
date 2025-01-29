Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8781DF268
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169042; cv=none; b=kAekDjYbB3jva5rBrLebziRPxrNz+tYIswQ7LKWAIP+I3DahzoVM5/0sJfRkc31PvUGDPfz1tFTzzr5TpXOaBpHHLuLnymAcTNMaNmZmoft70lyipO3x9lzhLlv487CZRGiu6WIr304QTjiYNVK/1FtFEs6YRr0+3A/OYPo5zXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169042; c=relaxed/simple;
	bh=+5Pb6Q8GyxJt7lLB6CyEYcbSMTMhfYvWdsmA1ik6Z2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cXY9ZiIELvyXbOCPoO4u2SLQG7/OAGV+boytA72glPvl1eNLOrc38iXXn3K0dKD0pMqX2vyskHbpEIgv3KOiZq6cqU08xnM4gyasNEoqpgkBzzNvYyxz1ff/Z0dmcGw9T9/H2BRxfI0X4laX2hvKzehhxWM/eFdYiHtu5LHnoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm9o3tg2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm9o3tg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9ACC4CED1;
	Wed, 29 Jan 2025 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169042;
	bh=+5Pb6Q8GyxJt7lLB6CyEYcbSMTMhfYvWdsmA1ik6Z2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Lm9o3tg2/72WRW+H5k0t/EuhTU7Qk/kNA6H5BK3msQ1bKZbCqVf1vnxs+XqhMY/Zi
	 c7R1yQxZcgXeeOldIz024a8bBCEjpjkNeg4qStxkhcfh9vfPv3QtriVzYNvWRRkb6B
	 1g5NLoybbYvhJeXrtKIITk4DUtCeMkynZwUv6rLrfijmhnLqgHmBJDK/SiQd3Yr9Sv
	 UEJ60Ei7PJvULMnbaGwPRNB8Z6vWqwdq1spodAglFQaF7A+zuvxldyNQm1Jt/Vasio
	 KBtM+DpEd3mQ6nXiMVtQ5R261+dEDpUDXKsKxDUaSwZXW80KQZya56fpgJbEqqCGlk
	 8FLq+pu9RXm5Q==
Date: Wed, 29 Jan 2025 08:44:01 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: connect: -f: no reconnect
In-Reply-To: <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
Message-ID: <4b0be50f-8469-240b-608e-41604d355e39@kernel.org>
References: <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Jan 2025, Matthieu Baerts (NGI0) wrote:

> The '-f' parameter is there to force the kernel to emit MPTCP FASTCLOSE
> by closing the connection with unread bytes in the receive queue.
>
> The xdisconnect() helper was used to stop the connection, but it does
> more than that: it will shut it down, then wait before reconnecting to
> the same address. This causes the mptcp_join's "fastclose test" to fail
> all the time.
>
> This failure is due to a recent change, with commit 218cc166321f
> ("selftests: mptcp: avoid spurious errors on disconnect"), but that went
> unnoticed because the test is currently ignored. The recent modification
> only shown an existing issue: xdisconnect() doesn't need to be used
> here, only the shutdown() part is needed.
>
> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
> - With the modification, the mptcp_join's "fastclose test" is still a
>  bit unstable on my side with a debug kernel. I didn't try to fix that.
>  This is tracked by this (old) issue:
>  https://github.com/multipath-tcp/mptcp_net-next/issues/324

Hi Matthieu -

Looks good, thank you:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 414addef9a4514c489ecd09249143fe0ce2af649..d240d02fa443a1cd802f0e705ab36db5c22063a8 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1302,7 +1302,7 @@ int main_loop(void)
> 		return ret;
>
> 	if (cfg_truncate > 0) {
> -		xdisconnect(fd);
> +		shutdown(fd, SHUT_WR);
> 	} else if (--cfg_repeat > 0) {
> 		xdisconnect(fd);
>
>
> ---
> base-commit: ef015705ac0b0da25ea399d87f1fa2f545b2b3d5
> change-id: 20250127-selftests-mptcp-fastclose-tests-af1fdd965826
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
