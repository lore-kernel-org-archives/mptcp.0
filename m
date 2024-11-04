Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F31CC899
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747287; cv=none; b=h1+4kc8iZT31BGUdQziN7/WrvHQ5MWFJLNn2mkkVq/9VfZJ+zJfa92wrnjO6BXREc7eT/+0DxT9p8Mgpppio+zSnk4YzuoXUiqpOdH/o020Q9gsXIilNkKdg1UDGjBYNVF40by0OztOxqpvz+62UvekxQQm3X5T1MWb7Pilhjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747287; c=relaxed/simple;
	bh=6BGW/GwR6JpPsY46QlcZQ8cIwYneKjUP0696pkozaX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETpOKSvYeZf1YClbqy/Nhioam4LkipHJxDy9BU+azXlD6JFOzIpRYFHpHZctXkN+wvc2F7PSUWd6xJSI+OtLFlCrm91fn1QdiTnBrS7TUoQhb5DxzgoUkBiE3lwptkJZl4XvW+C2ugtnC2T64FV7EVUINTzYySh1opYqa8S/P+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+gpWb0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+gpWb0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6B0C4CECE;
	Mon,  4 Nov 2024 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747287;
	bh=6BGW/GwR6JpPsY46QlcZQ8cIwYneKjUP0696pkozaX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l+gpWb0bMsKhSkoUH6qmgSiXmrZ8fI/33wGmmvNDrUWgKECV+NQx5LP19OpIwWTEl
	 hF6MrydVp3Oos7LwxIayjuFpyFx1sSowkGZU1XBZRdCFqcaEzA7YuUYS2MxkYHBAeK
	 K0r2m+8a73rCkDSP+xqXl5XAyAFQpj7M5DK4ww7/4Xb45tv9b/b8m+90J+1ABm5Hb8
	 rFj/KCqFVItbdzcMyniC0JhA73lE5t+HoEJoensUGtmZ6ug9zUqEYM4E5flSXgNFJ+
	 JkfDBlYyPFaKDHjad8497QwfnnvO+oLeX+UNgjMKWNFo8NSJZvQ+RLXLFVfqU4c4BM
	 3hG9P11PJrahQ==
Message-ID: <4661b240-9a9c-47c2-9dc0-362d22baad83@kernel.org>
Date: Mon, 4 Nov 2024 20:08:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 23/36] mptcp: drop struct mptcp_pm_local
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The following code in mptcp_pm_nl_subflow_create_doit() that assigns struct
> mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local variable
> "local" is not allowed in BPF if we use the same code to implement the
> subflow_create() interface of a BFP path manager:
> 
> 	struct mptcp_pm_local local;
> 
> 	local.addr = entry.addr;
> 	local.flags = entry.flags;
> 	local.ifindex = entry.ifindex;

Here as well, I'm not sure to understand the issue. Is it because you
cannot allocate this structure locally with BPF? No alternatives?

> We should avoid this type of assignment from struct mptcp_pm_addr_entry to
> struct mptcp_pm_local.
> 
> In fact, there is no need to add a dedicated address entry type for local
> address entry. All its fields are the same as struct mptcp_pm_addr_entry,
> except that it lacks a "lsk" for the listening socket. So we can use struct
> mptcp_pm_addr_entry directly. This makes the path manager code simpler.

There was a need for this structure, see this discussion:


https://lore.kernel.org/mptcp/587e096f-0e76-40fd-9220-6d8dd2930838@redhat.com/

and the changelog in v5:


https://lore.kernel.org/mptcp/20240726-mptcp-pm-avail-v5-13-fb1117ddeef6@kernel.org/

In short ...

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c   | 22 ++++++++--------------
>  net/mptcp/pm_userspace.c |  7 +------
>  net/mptcp/protocol.h     |  8 +-------
>  net/mptcp/subflow.c      |  2 +-
>  4 files changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 287e715bcf68..15f97e7af182 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -721,7 +715,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  
>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  {
> -	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
> +	struct mptcp_pm_addr_entry locals[MPTCP_PM_ADDR_MAX];

... we don't want that: that's reserving too much memory, and we don't
need half of it.

*If* it is really needed to change it for BPF (I'm surprised there are
no alternatives), then maybe we can change the signature of
__mptcp_subflow_connect(), but not change the code here.

In this case, only one "struct mptcp_pm_addr_entry" will be needed, and
the "struct mptcp_pm_local" can be defined in this pm_netlink.c file if
it is only used here.

But please mention that in the commit message.

>  	struct sock *sk = (struct sock *)msk;
>  	unsigned int add_addr_accept_max;
>  	struct mptcp_addr_info remote;
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

