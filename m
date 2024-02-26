Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6956466
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942057; cv=none; b=FsGmtSxiyvMJVVjqQO3gLh9PB21niBk3t28AIHioVw5jxvNTuyX6YliDazpKwukrY8Nx83EwUPhXR2/wTdHxWGESh2VtFgAnyvxZr/Uh1VyFPlhknP8aVrk/TlKlj3CJvrbl/DyBFaZC3ANmtjDa2D2s+N42fQaNVAEnmBAMqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942057; c=relaxed/simple;
	bh=Q3zgYTKktZwnLWTFcBcMy0/lplXkXfyr9oZTGFWI2ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlLFkQ9cqtN4g14Y3idmPLXHE+QPoV4qGaUyq6zpBLLumWJZHQmA6FnvLXL9VhVZJXpiGsAvoUrG6OwTXFodzLWokV/IwazUtUZpvPoxYnW23eD9w8HLekTQGjehVR5XqFdvVQ6TliMMnVT4HIZuT1AuN77ZlaMmPjrCnnO0wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPQSd4QH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPQSd4QH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6787C433C7;
	Mon, 26 Feb 2024 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708942056;
	bh=Q3zgYTKktZwnLWTFcBcMy0/lplXkXfyr9oZTGFWI2ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sPQSd4QH6Ls6rsrEFeSqdwAGgHcB6BiYEW3LDaLMFRfrwtOqt/KMI0hQ11TmVAUw8
	 hwlluclzZa3TQN15io6xS6x5jB4KIktXwEcpo2U5vviyfBgDTX2d9jdOQi6Xu2SHvc
	 oiJI/R+6LI2f2NiCPzHkEPLnh4fgpP0FRc9mCvXnXtfx4jy62iJ6JQQK/TR1Aooz+j
	 E87vMjJESQtpCxoFxLDOVdDHEsN2CTJlnhZqxPDqgBs5uvtQWM9NLxKr+QpaRoaOWm
	 nO3QxsR6FQ/DurYgoZ1wNdkk7Gw/CtJ4loA7oTvGZNMBv4QnCRKed4/rFBI9IdY975
	 EGuuhLayxfj6Q==
Message-ID: <426ebb6d-18af-4a8f-a291-82faddb66b30@kernel.org>
Date: Mon, 26 Feb 2024 11:07:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 6/7] mptcp: add check_id for
 lookup_anno_list_by_saddr
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
 <608dcc5649b212dc1a37c72fa7b465d3e8619316.1708588977.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <608dcc5649b212dc1a37c72fa7b465d3e8619316.1708588977.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/02/2024 09:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper mptcp_addresses_equal_check_id() to test the
> address ids, as well as the address. This can be used to test if the two
> given addresses are identically equal, they have both the same address and
> the same address id.
> 
> Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), pass
> it to mptcp_addresses_equal_check_id(). Then in mptcp_pm_del_add_timer(),
> the input parameter check_id can be passed as the new parameter into
> mptcp_lookup_anno_list_by_saddr(). After this, this condition:
> 
>         (!check_id || entry->addr.id == addr->id)
> 
> can be dropped, only test if 'entry' is NULL is enough.

Or use an extra variable? Please see below.

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5c17d39146ea..7d755c0a32bb 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -324,12 +325,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

I probably missed something, but why not only do the modification here
as suggested in the v1 instead of changing the signature of
mptcp_lookup_anno_list_by_saddr() and introducing
mptcp_addresses_equal_check_id() which is indirectly only used once from
here?


  bool stop_retrans;

  (...)

  spin_lock_bh(&msk->pm.lock);
  entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
  stop_retrans = entry && (!check_id || entry->addr.id == addr->id);
  if (stop_retrans)
      entry->retrans_times = ADD_ADDR_RETRANS_MAX;
  spin_unlock_bh(&msk->pm.lock);

  if (stop_retrans)
      sk_stop_timer_sync(sk, &entry->add_timer);

The refactoring would make sense if you have multiple users of this long
conditions. Here, it looks like it is adding more complexity to get
functions more generic, with more checks, just to handle one particular
case that can be extracted here, no?

>  		sk_stop_timer_sync(sk, &entry->add_timer);
>  
>  	return entry;
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
