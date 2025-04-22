Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B228137C
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328177; cv=none; b=PjQn4hiX4FMU7n6bU5iysfqoQaTLeB4hcqoSGPIpIVKAd7fMKX3OI9hEqPeMTMU/7Ddu0XT9Gs/uKtdJl0lQJ+jATvD4OxEFLzKuPp+vWIxFXUYhkRXyCADyRzJvAfl8ygvjGKUowHwqZrwgO1tQ/qwU00G0960UBBMXpoeNqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328177; c=relaxed/simple;
	bh=rx9JUGebohPvLLMZ3ZvuKRrofWWfMOYGvlXK2IhCSTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXN3mBmLdqMuGM39B5RC612v7NDL7zrkIqo31Mzd3zB3bKvzVXWwuhuKmj+EA6UvirEtpGp+mayMYJPvzRR1dse6C8tDn4qSWH71Z3jff25hBRIMqr3xJbYHHyvQifkcuggRtk08i7NNP5fSdRJugr0c9zl/ljEdKlezUctlOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9aaFKHa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9aaFKHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55032C4CEE9;
	Tue, 22 Apr 2025 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328177;
	bh=rx9JUGebohPvLLMZ3ZvuKRrofWWfMOYGvlXK2IhCSTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H9aaFKHaKWMo/+ogoKm20UVNi9UiZKeHPmOzAeijkOnazm7KiDeJQM5WhSTWHMiJa
	 bLu0GA56ZoJhTx/Jg/ghmHIWv1s4O0/fY3ZGXJChZu2W7kBiT4p2WE/L0h9bnVjdh1
	 q+fymt8waRzY67PL29VPmJAjNKQ4GjU2OEVn2tWLjGBCbl2ynUxoMh4ZKCYy9AD9UN
	 0BasTUZMNR9FGoULaN1S/nuF0eLGE7HPhx+a/xlS164Au9BCpLG4dEymuP3TzxAV9v
	 +ClNk1zZ2TdoG2aaFXBfRm2gPGRhR3Dd9RlxlLDi437xMmQKxjCdtVJzIn9X/FHasA
	 VLU6YE2DFx9aQ==
Message-ID: <32bf44a4-baf0-4e43-a9e7-77f3506d509a@kernel.org>
Date: Tue, 22 Apr 2025 15:22:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 3/7] selftests: mptcp: refine the 'iovlen'
 handling logic
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1744793332.git.yangang@kylinos.cn>
 <dee8dc73f766bc52c79d32a2dd22e9bc6ae436f0.1744793332.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dee8dc73f766bc52c79d32a2dd22e9bc6ae436f0.1744793332.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 16/04/2025 10:59, Gang Yan wrote:
> In the original version, the handling logic for the 'iovlen' appeared
> somewhat redundant. Therefore, 'iovlen++' is used to simpify this
> portion of the code and improve its readaility.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_diag.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 8a5b7745c58c..2bf13bce59a5 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -91,10 +91,9 @@ static void send_query(int fd, struct inet_diag_req_v2 *r)
>  		.iov_base = &req,
>  		.iov_len = sizeof(req)
>  	};

I guess you could also declare iovlen to 0, then start the increment above:

  iov[iovlen++] = (struct iovec) { (...) };

> -	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
> -	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
> +	iov[iovlen++] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
> +	iov[iovlen++] = (struct iovec){ &proto, sizeof(proto)};
>  	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
> -	iovlen += 2;

For such very small and not complex change like that, I think there is
no need to create a dedicate patch. This can be squashed in the next
patch with a note like:

  While at it, increment iovlen directly when an item is added.

>  	struct msghdr msg = {
>  		.msg_name = &nladdr,
>  		.msg_namelen = sizeof(nladdr),

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

