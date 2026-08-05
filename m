Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2543BD643
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948211; cv=none; b=qIkORuNYAMBALO9jTRpbn74tzR64iUs0vLj3uTO2gCx/slb9dPbzRQLKOunJY3k1Pbc6Uuw19hdMTPqCXkWOQA1GLxED6Ah0AMP4kHWkNyE72sZuK+hUkLQpmywUtvIbjEsF0ELgccmIDemwUIjaAPpI//KlPM7+Zci9RQtjsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948211; c=relaxed/simple;
	bh=HFp9b3fyFj6TUY1liv5fx2joDDSi1B3KK+XEl22WFEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CgyQWY50mWoG7c8Mrr7Q5HxzlDUMMHPgUYhi7bvr7w5ObV/dwNXw/j1OD/H1vKk27MowRN43mMSI43kIrhWa4XUcAnc83K6dg5rcni4bkmB//Zz8ONIx6ChSpecFNLZfkK5hrC64xYAgzGA4LgiLzK1MCh7smkFYSdUd6ncRLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La7GQSxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La7GQSxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D61F00A3A
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948210;
	bh=A+58uySFn+GP5sG515r9oAkbziyN8Bsi7b7JfCLOueU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=La7GQSxOEGyTJZ9i6GRC8gJsQXnnlIwXQg2m4oRgEWNGpbGhizBvqY2TfDuy6OuTO
	 CoiNLy9tUL6H8GVcM88C1JnKez3Q6yU3pJfSL4yWuidkmMCMR1alFGjzd/MsaKyh+W
	 hJUslmphUqcr43y+tDbELhb8XExQ0P4pCF6vFRSpxqhiuFhCA0gQVmYmmuCxRpyCZj
	 126o4hFBXRW0GILnhjc7+cVyo4Qke+e9avG4EJfq3MQL3Jcv+IZCxCd3iCPeq4CvwD
	 GBzQMaQCKFwf5NeO0B0B6ZwKwSbySntuAUS7RGrKW6pnrGAgNhLNkeqlVZX02Eyl3i
	 /a21K4ya6JU+A==
Message-ID: <ac1c48e0-de2f-4794-8661-b529e69e713e@kernel.org>
Date: Wed, 5 Aug 2026 18:43:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/6] mptcp: pm: userspace: allow announcing ID0
 addr
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
 <20260727-mptcp-pm-userspace-id0-case-v1-2-9877f02a9bae@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-2-9877f02a9bae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replying to Sashiko's review:

>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 6e6eeda91ade0..4c96433590e36 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -212,12 +212,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>>  	if (err < 0)
>>  		goto announce_err;
>>  
>> -	if (addr_val.addr.id == 0) {
>> -		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
>> -		err = -EINVAL;
>> -		goto announce_err;
>> -	}
>> -
> 
> If userspace deletes the initial subflow via MPTCP_PM_CMD_SUBFLOW_DESTROY,
> which removes the ID 0 entry from the local address list, can userspace then
> announce an arbitrary IP address with ID 0?
> 
> Since the original ID 0 entry would be missing, it seems
> mptcp_userspace_pm_append_new_local_addr() wouldn't find an address or ID
> match:
> 
> net/mptcp/pm_userspace.c:mptcp_userspace_pm_append_new_local_addr() {
>     ...
> 	if (!addr_match && !id_match) {
> 		...
> 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
> 		msk->pm.local_addr_used++;
> 		ret = e->addr.id;
> 	}
>     ...
> }
> 
> Would this incorrectly append a new entry with ID 0 and an arbitrary IP
> address, bypassing the validation mentioned in the commit message?

Yes, but the RFC8684 doesn't specify if the ID0 can be replaced by
another address, once removed. But it says: "A host wishing to replace
an existing Address ID MUST first remove the existing one". In this
condition, better to let the responsibility to the userspace daemon.

I can add a note in the commit message.

> Does allowing ID 0 announcements here also create a state inconsistency when
> trying to remove them?
> 
> Looking at mptcp_pm_nl_remove_doit(), there is a hardcoded fast path for ID 0:
> 
> net/mptcp/pm_userspace.c:mptcp_pm_nl_remove_doit() {
>     ...
> 	if (id_val == 0) {
> 		err = mptcp_userspace_pm_remove_id_zero_address(msk);
> 		goto out;
> 	}
>     ...
> }
> 
> Because mptcp_userspace_pm_remove_id_zero_address() doesn't call
> mptcp_pm_announced_remove() and ignores msk->pm.anno_list, would this
> leave the announcement un-cancellable and leak the state in anno_list?
Removed in the next patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

