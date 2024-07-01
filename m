Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DD10F9
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859688; cv=none; b=DMl37r+UO4pZgxYltJKkICrImq4WaW1INr8/t3V3FBXpN6y7ZR7fjozszRif8281aNLjbdraqOjrQsZnTUD1BxfhPlWs2vKT2CNTQXhqzw2cHEEv0uNHFDgxGITmyTInZy40E2+4AAcWO5T/Jpq1oEKcebOy8PyVXZ6/0oTjY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859688; c=relaxed/simple;
	bh=F7HU8Pi8r8d8cS8ZhRcY7pQoyd4bpXKec3qa87tbM08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKVvZYj3LFTfzVNLdW6T8CGMBkCOvpjGnOfdtuy58ul+i7ofP/KHCdnhNFq7W6AyJik5fm7yHE+p9kxRnK33NgyF4fYpoPAo1M/p6OO/8ytepAZoQZ7k1daxhyoHF0iYqAKpNChOTHcJWiLMmetnGiiE1iLdSDuQbZs5waVRagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esj2Z5aO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esj2Z5aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB6C116B1;
	Mon,  1 Jul 2024 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719859688;
	bh=F7HU8Pi8r8d8cS8ZhRcY7pQoyd4bpXKec3qa87tbM08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Esj2Z5aOnV+z5YGz6PPeFEhfPE6zGtQ6EQPbaqqUdXrq2NI5Ar6ycR/L7N7+cAlEP
	 k0kxz0ueTZLISZ66GJeouRS/u0dHSbLYNANJEJvdnU9eamvLwliaTGQDLLUdYG5/si
	 GPQIvCxqNBe/gIGmVX/Hghu9JfQSXwdxpH6tl2De7G7Z6JFGNqV08oU/bXDI7iHlvw
	 r248hVGNvkkkT+OSIVUVM0Xzf2Fs1xTVcGfrh2g3eBB0V3G83aYpHdaWnXzrw+O8Ja
	 aQv8sWgnVtMSuDP5Y5YOMpscSXDar5owGl1d8gjZ/rwYmfkU7FOFedQAwLOslM98cC
	 GtLKu0vXwdzUg==
Message-ID: <09b48662-9334-41e3-a825-3d555110ae35@kernel.org>
Date: Mon, 1 Jul 2024 20:48:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] selftests: mptcp: add close function in main_loop_s
 function
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Liu Jing <liujing@cmss.chinamobile.com>
References: <20240701181646.252683-2-matttbe@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240701181646.252683-2-matttbe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Liu Jing,

Thank you for this patch.

I have some comments, please see below. Can you send a v2 please?

Please send such patches to MPTCP mailing list, as mentioned in the
MAINTAINERS file: for us to be able to track and review these patches.
And for our CI to validate them.

On 01/07/2024 20:16, Matthieu Baerts (NGI0) wrote:
> From: Liu Jing <liujing@cmss.chinamobile.com>
> 
> in main_loop_s function, when open(cfg_input, O_RDONLY),When the open(cfg_input, O_RDONLY) function is run,

"when open(cfg_input, O_RDONLY)" is duplicated.

> the last fd file descriptor is not closed if the if (--cfg_repeat > 0) branch is not taken

Could you limit the lines to max 72 chars for the description and around
~50 for the title please?

  selftests: mptcp: always close input's FD if opened


Also, it looks like it is a bug-fix. Then please add a 'Fixes' tag, e.g.:

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")

> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

(In your v2, please drop my SoB that has been automatically added when
sending this patch to our ML)

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index d2043ec3bf6d..48b7389ae75b 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1119,7 +1119,8 @@ int main_loop_s(int listensock)
>  		if (cfg_input)
>  			 close(fd);
>  		goto again;
> -	}
> +	} else
> +		close(fd);

I think it would be clearer to move...

  if (cfg_input)
          close(fd);

... before 'if (--cfg_repeat > 0)' (with an empty line in between): so
first we 'close(fd)' if needed, then we check if we need to do it again.

Note: Please run 'checkpatch.pl': it was complaining about this line:

 https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9749324582

 https://docs.kernel.org/process/5.Posting.html

>  
>  	return 0;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

