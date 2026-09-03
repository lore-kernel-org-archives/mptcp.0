Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E74B2CBE;
	Thu,  3 Sep 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444510; cv=none; b=Op8VuLz3nCGqtsXS18s8APwz8j3ngZky2c3rxPXoNIHrL+hyJrfYxYhSMwCzFH75+X/E9vQUh54yYQ4kryLfESCPZQEGzwPgd3LCB/n96Fu5c6xJz4nlwSdRzuGNHnHrQopd6XP9e9fveaFcCz3Y6Rqq9/Ebx/rnVs+zGvheiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444510; c=relaxed/simple;
	bh=HqtucKQs69uqiusNuysC+GtgjKkDe2ZAuZ41UEfxXLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFyuiKwBVLFJoGEZLOeyOHKFCgrrYTpcMeLmxKOLWA2c3CaiaWJoVytWHYr9v2E/RMWtFnNTiU+hI5dnT2o+VSy1tPlfZnuQALcHGs4wyhv1HARPFdS+/GVDeRZzRIwA6hszeLA5VeKODVvtAcsg56/JvEvNH4EV3+EzDOlFQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCRSsA/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCRSsA/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A31F00A3D;
	Thu,  3 Sep 2026 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444498;
	bh=bswW5OkwpdCoGKq55o4iM/KzpAShp90fQkCwndVvvQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WCRSsA/G8YhL+bb0udQ0zge7fD/f+NDTV6TYfQ4+StIogIK+JIYmiOtRyjTaDxgRF
	 rLZjtoXIZ6c1CwT/DwdCWW5fna2j9IYBaq96YjvoDHjlhg2IW+YHnx2sfzkke54RSv
	 h36hQ9G4CRQTDbLB1uFn05RAZv4Xj57oCE8eeW3WaH06q/SeHeI7phyB9pJrUbrScH
	 tEyXmBvSDYiej3KrxNuuBDt+1ZwTRwV0IyFT05yk3VnJBI/EBzrgOSyfHmZy34mzyi
	 6KzkOmwCb1bSNRtwpbAgm/BlJUax/2TuqqSsXd4C7mKAgixmrahM/Bwbql18zd+TTF
	 D/RUKOuoNfpmg==
Message-ID: <37501367-99e7-4ce0-a590-b8d5c1f9be0e@kernel.org>
Date: Thu, 3 Sep 2026 16:08:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: pm: userspace: cap
 extra_subflows on Netlink subflow creation
Content-Language: fr
To: sashiko-reviews@lists.linux.dev, Tao Cui <cui.tao@linux.dev>
Cc: mptcp@lists.linux.dev
References: <20260903131416.1112393-1-cui.tao@linux.dev>
 <20260903131416.1112393-4-cui.tao@linux.dev>
 <20260903132757.5A7C11F000E9@smtp.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260903132757.5A7C11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 03/09/2026 15:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the error path unconditionally deletes and frees a local address entry, even if the address was pre-existing and shared among multiple subflows.
> --
> 
> commit 147f86e2aec9bdeead6dcc987672ad229b2286ec
> Author: Quanye Yang <quanyeyang@proton.me>
> 
> mptcp: pm: userspace: cap extra_subflows on Netlink subflow creation
> 
> mptcp_pm_nl_subflow_create_doit() also increments the u8 extra_subflows
> counter without any limit: a client with CAP_NET_ADMIN can create more
> than 255 extra subflows via Netlink and wrap the counter back to 0,
> with the same effects as the MP_JOIN path now bounded separately:
> the underflow guards warn on the next subflow close, and
> mptcpi_subflows_total reported to userspace is corrupted.
> 
> Link: https://lore.kernel.org/all/20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me/
> 
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index f723a134356f3..bede75a2e2586 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -427,6 +427,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>>  	local.ifindex = entry.ifindex;
>>  
>>  	spin_lock_bh(&msk->pm.lock);
>> +	if (msk->pm.extra_subflows == U8_MAX) {
>> +		spin_unlock_bh(&msk->pm.lock);
>> +		GENL_SET_ERR_MSG(info, "too many extra subflows");
>> +		err = -ENOSPC;
>> +		goto delete_addr;
>> +	}
>>  	msk->pm.extra_subflows++;
>>  	spin_unlock_bh(&msk->pm.lock);
>>  
>> @@ -434,9 +440,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>>  	err = __mptcp_subflow_connect(sk, &local, &addr_r);
>>  	release_sock(sk);
>>  
>> -	if (err) {
>> +	if (err)
>>  		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
>>  
>> +delete_addr:
>> +	if (err) {
>>  		spin_lock_bh(&msk->pm.lock);
>>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> 
> [Severity: High]
> This is a pre-existing issue, but does this error path incorrectly delete a
> shared local address entry if the address was pre-existing?
> 
> When mptcp_userspace_pm_append_new_local_addr() is called earlier in
> mptcp_pm_nl_subflow_create_doit(), it might match an already existing local
> address instead of appending a new one.
> 
> If the newly added extra_subflows limit is hit (or if
> __mptcp_subflow_connect() fails), the code jumps to this delete_addr error
> path.
> 
> Because mptcp_userspace_pm_append_new_local_addr() did not allocate a new
> entry but simply reused the existing one, unconditionally calling
> mptcp_userspace_pm_delete_local_addr() prematurely frees the shared address
> and decrements the local_addr_used counter, potentially corrupting the state
> for other subflows relying on it.

Correct, but there are pending patches from Geliang fixing that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

