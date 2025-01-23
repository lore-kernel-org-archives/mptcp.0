Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46E381AF
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632226; cv=none; b=ppdlobN4BAMIXHx7GzmlPsbd0H0KMVs3Ex3WpIc5y5S0D2T7rOSCgvBLtE4YRl84GqlE/fXg5LgEeC6o2AeTJXyp7SddMHuihG8U8Dmo0lfybbM2kBdkG+dcutlPE/6HvrpHQ11KeJsPuh5R+PjTsrycfuFcl1Fjs2lDIWGsHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632226; c=relaxed/simple;
	bh=CAS5qzh93qxx/xh2YnoScvvnQxj8YRyL7CNquZH/RI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT9ooF8xt/FUObi9o1cA8uYgq8Xzrk1xHgLOwvx+XdmbzbF5Y+MC2X/Oq1tnvkC8DMNh4op1mRaMdX+rBRaWPgRJmJNu/41Cs8eI1uS3xCiKcvSOj0sFZvT9TAoiXTFyRxvh62iwvxfLYi0GibeDlqzD5d5ngZT2xfCGvDa3ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hECV0VRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hECV0VRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD6FC4CED3;
	Thu, 23 Jan 2025 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737632225;
	bh=CAS5qzh93qxx/xh2YnoScvvnQxj8YRyL7CNquZH/RI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hECV0VRHu1vIM7T+Sy0FhhShZB+GVQ/42d0mdpYN3N5xvnf/aIsF0R9p2eVk1B1lg
	 BpKNJb0s0kLE4fMBE1s4VIPtSMoy9oL1eQPpLTQVHjcPnUsx/Etl4k1MyzSfrKsJpy
	 KaVI3hyEi9Y4mK34B0ti5N34CTQHaQy/B7GoaEXSvIeddsfBdLTw25fBiUOlYbznQL
	 QSk4KqnDPBWwN5Et8MYEAtG8jxATMOUtgfrHbyHu8Cb557B0GOE58Bd3gUiLOcKAgj
	 7Ix56UN1c7waFhO84E7M42LaETnWLmEBsU56OvaNQtR7DofgWouHM8YP+9ufqVHqD7
	 KItL3W6B0nuQw==
Message-ID: <fe08c069-c54c-4791-b84f-5c3de42fae85@kernel.org>
Date: Thu, 23 Jan 2025 12:37:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 1/7] mptcp: add mptcp_pm_genl_fill_addr
 helper
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
 <ad956e331f2ee8dc8898f5beaebdcf673fd3e355.1737012165.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ad956e331f2ee8dc8898f5beaebdcf673fd3e355.1737012165.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/01/2025 08:26, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To save some redundant code in dump_addr() interfaces of both the
> netlink PM and userspace PM, the code that calls netlink message
> helpers (genlmsg_put/cancel/end) and mptcp_nl_fill_addr() is wrapped
> into a new helper mptcp_pm_genl_fill_addr().

I'm OK with the suggested modification here below (just one small
detail, please see below), but ...

> This helper will also be used in BPF path managers.

... that doesn't sound right: I don't see why a BPF PM has to dump
addresses via Netlink. In your cover-letter, you mentioned the
dump_addr() will not be implemented in the BPF PM, so I guess you left
this line by accident, right?

If not: with the in-kernel PM, it is needed to dump the endpoints to
know what has been set. With the userspace PM, the dump is useful for a
userspace PM daemon to recover from a restart. For these two PM, Netlink
is used between the userspace and the kernelspace, so that makes sense
to continue to do so. With the BPF PM, I don't really see the point: all
the communication (configuration, status, decisions, etc.) should be
done via BPF, no?

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index fef01692eaed..afd517ff260c 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1798,7 +1798,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
>  	int id = cb->args[0];
> -	void *hdr;
>  	int i;
>  
>  	pernet = pm_nl_get_pernet(net);
> @@ -1813,19 +1812,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  			if (entry->addr.id <= id)
>  				continue;
>  
> -			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> -					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> -					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> -			if (!hdr)
> +			if (mptcp_pm_genl_fill_addr(msg, cb, entry))

Even if technically, it is correct, it feels "strange" to see:

  if (foo())
      /* error path */

It feels a bit like having:

  if (success())
      /* error */

If the goal is to stop in case of error, better being explicit about that:

  if (foo() < 0)
      /* error path */

>  				break;
>  
> -			if (mptcp_nl_fill_addr(msg, entry) < 0) {
> -				genlmsg_cancel(msg, hdr);
> -				break;
> -			}
> -
>  			id = entry->addr.id;
> -			genlmsg_end(msg, hdr);
>  		}
>  	}
>  	rcu_read_unlock();
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 277cf092a870..b50462b527bd 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -641,7 +641,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
> -	void *hdr;
>  
>  	bitmap = (struct id_bitmap *)cb->ctx;
>  
> @@ -657,19 +656,10 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  		if (test_bit(entry->addr.id, bitmap->map))
>  			continue;
>  
> -		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> -				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> -		if (!hdr)
> +		if (mptcp_pm_genl_fill_addr(msg, cb, entry))

Same here: < 0

>  			break;
>  
> -		if (mptcp_nl_fill_addr(msg, entry) < 0) {
> -			genlmsg_cancel(msg, hdr);
> -			break;
> -		}
> -
>  		__set_bit(entry->addr.id, bitmap->map);
> -		genlmsg_end(msg, hdr);
>  	}
>  	spin_unlock_bh(&msk->pm.lock);
>  	release_sock(sk);

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

