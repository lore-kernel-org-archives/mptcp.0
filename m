Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D97FBDB
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532423; cv=none; b=XHbg4edAqahb1UPJEaK6zBTPDRZWQi5K/7E8thBim8557SX6jyombNZpRkzDFGr+p0nMmnFG0ATN6r2C3x5Dasvd/3aQMht/2tRGanWGNlhUAbC8xOsl0+qRYaTUFDVntJDRAdd9itKB/V/BrSlvAqZ07uyi/dXLlf3de7+RJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532423; c=relaxed/simple;
	bh=thmJOehbRuF6cEg89N+id5KOtO8oL9vHj1bQSDSscRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdt70XmMxphhx6fOcQowE5RPPW1mI0JKvn7kYu5tzUpYrmUQOt6TfzuonvEQQDZMfLVsUpNpYkcP8uzHjerbARvVRR8H6qZD1guNTfsV9mj6zZwFGcqfru+dNSSv6ToGYL88IK9BCWEitX+JTSnVK2saeeT2W/zphvTq7wHlFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaAJHAI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaAJHAI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A3FC43390;
	Wed, 21 Feb 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532423;
	bh=thmJOehbRuF6cEg89N+id5KOtO8oL9vHj1bQSDSscRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eaAJHAI6Q3WgArqOrqNtJLGMmTY66uRbF4cs4D1ryjXHk0uurEf/Axihe8PLxQhOl
	 oTCClO6cK1E8v5UqCEvX+WDySt40WCnZ+tNDPuJnvE2ks5HCX1tqmLKnatluutQoW2
	 dAc6lBnTYwaUH7aRikvtazweDTBFXjqVtecljfnQRS4iyDYcK9F4qTyKzws1nufGzE
	 zTqq3epk73fR/PwNU7J7WVoOsXPdTb2Y40nZmlzaje4LIMlnpSK3yat71R4ZHntTXb
	 eZm24IN6MttnU3A5we1bpdyQGlcOb4RIKblaPbmHsP435Jq+43WhJaIqw3GVMbXwA5
	 9zR2e7jpajdwA==
Message-ID: <20f8644c-eb3a-47e0-8dac-1f05f27f6860@kernel.org>
Date: Wed, 21 Feb 2024 17:20:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 7/8] mptcp: add check_id for
 lookup_anno_list_by_saddr
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
 <fe35233e351bbe2db9c3eb98dc13fff8ea5c60df.1708497039.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fe35233e351bbe2db9c3eb98dc13fff8ea5c60df.1708497039.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/02/2024 7:31 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
> pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
> the input parameter check_id can be passed as the new parameter into
> mptcp_lookup_anno_list_by_saddr(). After this, this condition:
> 
>         (!check_id || entry->addr.id == addr->id)
> 
> can be dropped, only test if 'entry' is NULL is enough.

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1bf5c3440f84..4519dfa79775 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -329,12 +330,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  	struct sock *sk = (struct sock *)msk;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -	if (entry && (!check_id || entry->addr.id == addr->id))
> +	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
> +	if (entry)
>  		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
>  	spin_unlock_bh(&msk->pm.lock);
>  
> -	if (entry && (!check_id || entry->addr.id == addr->id))
> +	if (entry)

Instead of all these modifications in mptcp_addresses_equal() and
mptcp_lookup_anno_list_by_saddr() just for this specific case here, can
we not use an extra variable?

  bool stop_retrans;

  (...)

  spin_lock_bh(&msk->pm.lock);
  entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
  stop_retrans = entry && (!check_id || entry->addr.id == addr->id);

  if (stop_retrans)  // or in one line, merged with ↑ ?
      entry->retrans_times = ADD_ADDR_RETRANS_MAX;
  spin_unlock_bh(&msk->pm.lock);

  if (stop_retrans)
      sk_stop_timer_sync(sk, &entry->add_timer);

>  		sk_stop_timer_sync(sk, &entry->add_timer);
>  
>  	return entry;
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
