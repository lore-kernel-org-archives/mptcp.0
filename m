Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B0303C8A
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271298; cv=none; b=Kc99Mub0gLFjVmCvUenMsj+gCsGUeF7uqH9P2FGsbGRk0U5VY8cjwrcHKhZjTDjq0FvZLaMGHxbz2L7DVVjSdrFqEzPll1PumQMZ+vuOYM3HKntMPZEpKyYT4l5v06ZF0UeeZAmnk6GGQPLbz4vdtZ1av3s90kGduqMOkZ/z2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271298; c=relaxed/simple;
	bh=JxF4669owNMUY+CEy7K/51mFoCCZZMXLWQswP8u8PVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DgROWWaGTri89OZ5922anN9ZG3TdAkaUqpR7mepwRaFB0m/6L1cRkprrR5cfEZKgHN/PqBBIcggEfibf3mVqnsNR6w8Fw13etlFghaGS7RTJawdigFBDllGAgeNETfDNCFcsWYX2dZqiys68YFa13Tfplr6JMVaHZ1t68Oh1fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH06kTVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH06kTVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4F3C4CEF0;
	Fri, 19 Sep 2025 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758271298;
	bh=JxF4669owNMUY+CEy7K/51mFoCCZZMXLWQswP8u8PVM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IH06kTVOaLwAYng++iqctQTq1PpM2dr9KRAqc9S3sIwu9yhvcJO/sypjG4GPSPAm+
	 8KAbuWCDTLDe/321zHsfg5EtabKWPjPkzp1D+CJuupuZ3WhzQ4SwjbXPi/BTv+c/Us
	 sXaf7Js1MiFqWkldh3BMj0UICLPzxmotFXET6RYxjrmoIsaJETVsMWlP0oPLbHSp6K
	 aEP6OFz0oX4JUoBAFaGknRb1khn/SOQXylGXFA1qFrRTivxo7U010LyerswdAvUut7
	 XCtFJmQx+Ea49RWx5SrOBwJusbPmBpe9cNgieYq763EEsxvyAE2VhAsnwKMXUCR2Ru
	 eJIIdKo3hnZMg==
Message-ID: <47a547d4-36cb-48ae-b258-1f6ece3b261c@kernel.org>
Date: Fri, 19 Sep 2025 10:41:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 03/10] mptcp: pm: in-kernel: refactor
 fill_remote_addresses_vec
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
 <20250918-pm-kern-endp-add_addr-v1-3-e12e58770a11@kernel.org>
 <fc0faacf990d5c422dac4525ae02f64a448a8e9f.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fc0faacf990d5c422dac4525ae02f64a448a8e9f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/09/2025 08:52, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2025-09-18 at 19:42 +0200, Matthieu Baerts (NGI0) wrote:
>> Before this modification, this function was quite long with many
>> levels
>> of indentations.
>>
>> Each case can be split in a dedicated function: fullmesh, non-
>> fullmesh.
> 
> How about splitting this patch into two, one for 'fullmesh', one for
> 'non-fullmesh'.

I don't think that's really needed: I'm simply moving what is in the
if-statement in one helper, and the rest in another one. Or do you think
it would really help?

> 
>>
>> To remove one level of indentation, msk->pm.subflows >= subflows_max
>> is
>> now checked after having added one subflow, and stops the loop if it
>> is
>> no longer possible to add new subflows. This is fine to do this
>> because
>> this function should only be called if msk->pm.subflows <
>> subflows_max.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm_kernel.c | 112 ++++++++++++++++++++++++++++------------
>> ----------
>>  1 file changed, 63 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> 5bdcfcc26308841c49375ce35205097f30592279..8d5df9b98589e5cd69f16dc54e9
>> 140e88a1835e2 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -159,74 +159,88 @@ select_signal_address(struct pm_nl_pernet
>> *pernet, const struct mptcp_sock *msk,
>>  	return found;
>>  }
>>  
>> -/* Fill all the remote addresses into the array addrs[],
>> - * and return the array size.
>> - */
>> -static unsigned int fill_remote_addresses_vec(struct mptcp_sock
>> *msk,
>> -					      struct mptcp_addr_info
>> *local,
>> -					      bool fullmesh,
>> -					      struct mptcp_addr_info
>> *addrs)
>> +static unsigned int
>> +fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info
>> *local,
>> +		 struct mptcp_addr_info *addrs)
>>  {
>>  	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
>> +	struct sock *sk = (struct sock *)msk;
>> +	struct mptcp_addr_info remote = { 0 };
> 
> This breaks 'Reverse X-Mas Tree' order.

Good catch, fixed!

> 
>> +
>> +	if (deny_id0)
>> +		return 0;
>> +
>> +	mptcp_remote_address((struct sock_common *)sk, &remote);
>> +
>> +	if (!mptcp_pm_addr_families_match(sk, local, &remote))
>> +		return 0;
>> +
>> +	msk->pm.subflows++;
>> +	*addrs = remote;
>> +
>> +	return 1;
> 
> How about still using:
> 
> addrs[i++] = remote;
> return i;
> 
> here, to keep it consistent with other fill_*_addr helpers.

We will only fill one address, then no need to declare 'i', no?
It looks clearer to me like that, so we clearly understand only one
address is filled, no?

> 
>> +}
>> +
>> +static unsigned int
>> +fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>> +			       struct mptcp_addr_info *local,
>> +			       struct mptcp_addr_info *addrs)
>> +{
>> +	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
>> +	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>>  	struct sock *sk = (struct sock *)msk, *ssk;
>>  	struct mptcp_subflow_context *subflow;
>> -	struct mptcp_addr_info remote = { 0 };
>>  	unsigned int subflows_max;
>>  	int i = 0;
>>  
>>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>> -	mptcp_remote_address((struct sock_common *)sk, &remote);
>>  
>> -	/* Non-fullmesh endpoint, fill in the single entry
>> -	 * corresponding to the primary MPC subflow remote address
>> +	/* Forbid creation of new subflows matching existing ones,
>> possibly
>> +	 * already created by incoming ADD_ADDR
>>  	 */
>> -	if (!fullmesh) {
>> -		if (deny_id0)
>> -			return 0;
>> +	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>> +	mptcp_for_each_subflow(msk, subflow)
>> +		if (READ_ONCE(subflow->local_id) == local->id)
>> +			__set_bit(subflow->remote_id, unavail_id);
>>  
>> -		if (!mptcp_pm_addr_families_match(sk, local,
>> &remote))
>> -			return 0;
>> +	mptcp_for_each_subflow(msk, subflow) {
>> +		ssk = mptcp_subflow_tcp_sock(subflow);
>> +		mptcp_remote_address((struct sock_common *)ssk,
>> &addrs[i]);
>> +		addrs[i].id = READ_ONCE(subflow->remote_id);
>> +		if (deny_id0 && !addrs[i].id)
>> +			continue;
>>  
>> +		if (test_bit(addrs[i].id, unavail_id))
>> +			continue;
>> +
>> +		if (!mptcp_pm_addr_families_match(sk, local,
>> &addrs[i]))
>> +			continue;
>> +
>> +		/* forbid creating multiple address towards this id
>> */
>> +		__set_bit(addrs[i].id, unavail_id);
>>  		msk->pm.subflows++;
>> -		addrs[i++] = remote;
>> -	} else {
>> -		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID +
>> 1);
>> +		i++;
>>  
>> -		/* Forbid creation of new subflows matching existing
>> -		 * ones, possibly already created by incoming
>> ADD_ADDR
>> -		 */
>> -		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>> -		mptcp_for_each_subflow(msk, subflow)
>> -			if (READ_ONCE(subflow->local_id) == local-
>>> id)
>> -				__set_bit(subflow->remote_id,
>> unavail_id);
>> -
>> -		mptcp_for_each_subflow(msk, subflow) {
>> -			ssk = mptcp_subflow_tcp_sock(subflow);
>> -			mptcp_remote_address((struct sock_common
>> *)ssk, &addrs[i]);
>> -			addrs[i].id = READ_ONCE(subflow->remote_id);
>> -			if (deny_id0 && !addrs[i].id)
>> -				continue;
>> -
>> -			if (test_bit(addrs[i].id, unavail_id))
>> -				continue;
>> -
>> -			if (!mptcp_pm_addr_families_match(sk, local,
>> &addrs[i]))
>> -				continue;
>> -
>> -			if (msk->pm.subflows < subflows_max) {
>> -				/* forbid creating multiple address
>> towards
>> -				 * this id
>> -				 */
>> -				__set_bit(addrs[i].id, unavail_id);
>> -				msk->pm.subflows++;
>> -				i++;
>> -			}
>> -		}
>> +		if (msk->pm.subflows >= subflows_max)
>> +			break;
>>  	}
>>  
>>  	return i;
>>  }
>>  
>> +/* Fill all the remote addresses into the array addrs[],
>> + * and return the array size.
>> + */
>> +static unsigned int
>> +fill_remote_addresses_vec(struct mptcp_sock *msk, struct
>> mptcp_addr_info *local,
>> +			  bool fullmesh, struct mptcp_addr_info
>> *addrs)
> 
> How about keeping this unchanged:
> 
> static unsigned int fill_remote_addresses_vec(struct mptcp_sock
> *msk,
> 					      struct mptcp_addr_info
> *local,
> 					      bool fullmesh,
> 					      struct mptcp_addr_info
> *addrs)
> 
> This can make the patch smaller.

I don't think that's needed, for the same reason.

> 
>> +{
> 
> -	/* Non-fullmesh endpoint, fill in the single entry
> -	 * corresponding to the primary MPC subflow remote address
> 
> We can keep this comment here.

Indeed.

> 
> -	if (!fullmesh) {
> 
> ... and test "!fullmesh" just like the original code.

It looks "strange" to treat the opposite condition first, but if I leave
the comment, I can keep '!fullmesh' I guess.

> 
> Thanks,
> -Geliang
> 
>> +	if (fullmesh)
>> +		return fill_remote_addresses_fullmesh(msk, local,
>> addrs);
>> +
>> +	return fill_remote_addr(msk, local, addrs);
>> +}
>> +
>>  static struct mptcp_pm_addr_entry *
>>  __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
>>  {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

