Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28D27003F
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659415; cv=none; b=gVh1JdL5Tu2mF/FBQ+IrETs6M6cs9bx7WmRuJtnJU/AVHG63Qj4o+L+ae2HhWf1si7QCL09WwnPfdKblUzHRiOzyoQpq47Co36cqZLGzmuKL9uV6OXJl+AuMkPv/h+q75Bxbwg1+kqxJBzw92fMC0pK/PizRi9dd62jyuvXt0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659415; c=relaxed/simple;
	bh=rm4ugH/FKDLNZ6oCi/J7RZxRaEQCCZahpNZ2TbWsYU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJdwJA2JtVxDP094fgQip5hVbU0dLnwMQE7C025yWwcCBGhCggMXT0J+ZFIDM2LU0rBfefKw5vnyi1d/oxU1DuapEgu72XCKMegdZqaUkYIw6iUNm9s4Li+uL1ILLVI+FwTMATn6nRncr8DGuxkO+j3QvC0OJNo2hUeorTq+bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV9yC7CQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV9yC7CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE2EC4CEDD;
	Thu, 27 Feb 2025 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740659415;
	bh=rm4ugH/FKDLNZ6oCi/J7RZxRaEQCCZahpNZ2TbWsYU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pV9yC7CQKavpkgoAX1ClmuBGGDBlZKNL7FM4Xf2kJWGYpUDsGWm/xXpJFlWr+j1ag
	 1D9U0QGTBoeNGjMdIe4CLwbc7daWA3n0BMVz6naiKpzp7TUx9B/yw3u0lruQ0QR+py
	 cC9a7lhhf7vtqpVxJGTpcuX450M9zYCFxjLk4djgT3qYV+HvGUtW2TkfmAfvKcILS5
	 qIlfTi6lZJgWI20dTf255gV8/SaQWXtOzwohAxqrJpHUrVb6AJVy8K68h59vhnZkyO
	 /ZH3fO6Uo2mSHx59p3upZXUV/dnQ+5+JotBxeqUX+24GTvbIXwnOuQ0Tqsjl4L9Aej
	 YyKIwEhOu38Yg==
Message-ID: <3289d2da-4953-4b35-8024-4163663d8bc1@kernel.org>
Date: Thu, 27 Feb 2025 13:30:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 6/6] mptcp: pm: in-kernel: drop changed
 parameter of set_flags
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
 <1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/02/2025 07:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To drop the additional "changed" parameter of mptcp_nl_set_flags(),
> store "entry->flags" to "remote->flags" before modifying it in
> mptcp_pm_nl_set_flags(), so that "changed" value can be obtained by
> comparing "local->flags" and "remote->flags" in mptcp_nl_set_flags().

Here as well, no need to change the code: it doesn't make sense to deal
with 'remote' as a workaround to have the same interface that is not
needed from what I understood. No?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 053f2bec9042..2f22c3bf88e2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1916,13 +1916,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
>  
>  static void mptcp_nl_set_flags(struct net *net,
>  			       struct mptcp_pm_addr_entry *local,
> -			       u8 changed)
> +			       struct mptcp_pm_addr_entry *remote)
>  {
>  	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
>  	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
> +			   MPTCP_PM_ADDR_FLAG_FULLMESH;
>  	long s_slot = 0, s_num = 0;
>  	struct mptcp_sock *msk;
>  
> +	changed = (local->flags ^ remote->flags) & mask;
>  	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
>  		return;
>  
> @@ -1987,12 +1990,13 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
>  		return -EINVAL;
>  	}
>  
> +	remote->flags = entry->flags;

(I guess you wanted to use "remote->flags = changed" or something like
that, but this code should not be modified I think, it doesn't make
sense to deal with a "remote" here)

>  	changed = (local->flags ^ entry->flags) & mask;
>  	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
>  	*local = *entry;
>  	spin_unlock_bh(&pernet->lock);
>  
> -	mptcp_nl_set_flags(net, local, changed);
> +	mptcp_nl_set_flags(net, local, remote);
>  	return 0;
>  }
>  
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

