Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7B28EA55
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058505; cv=none; b=iebJpiOH7PfEEC42+n3t2rgEoKo3upuVA2mvJwk5nHCouywPJXMgzBhNQ7DATtRygCqM/ZYp8W3Q6Rz9FVSFbxZx0f1ITZNQDE0/kgec3aFPkSRGVLEOH0vJtzxppK/ekuLXWYez2atc98lJuyEPc6W+k+E6kq0a0MEe4bxdmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058505; c=relaxed/simple;
	bh=qVWN6k/g/4aveu5bQqe2R/kqQPDv9DlcoKqExzxT5as=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ki8z3RnAVpjwEZJ8IoAR2y2KWw7WqIIc+2tqxzHoorpQSUbBGn7+7ZUSLPr8M/1Wlz4bzhBE/ye1PkP2xaBPNxaPtlNy88rir9Z0bIV3NZUY49U+FJMPrR5VibZast0M7snn7PzesyO4fY2fOwCL3KYItxKiXPmVxWzIDjvNoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkWcjS81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkWcjS81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C7C4CEEF;
	Wed,  9 Jul 2025 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058505;
	bh=qVWN6k/g/4aveu5bQqe2R/kqQPDv9DlcoKqExzxT5as=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QkWcjS81IPnvZr8pv9j+IYs84CGVOzEsNcILwo2NOabewtT0AO8A0knQyqaixAG7O
	 yoAssDfxetoc0iN97A6v+97tlUQES3rVmqKxHdPEr2sxw91eHs1nLD8yw6oF4wIFIm
	 PtCHLYIkBo77CkHf9t7qFRsDRoZuMA8aRLNSWfw0UbjF1pZxXtwe8Vg4OdK6wk85x3
	 U17u9F/P9yhPaJLzv0Xl4uHjFyiNrw1tLyvYQWjDLWXiWWAFBlKFqR4Ezq1TGZTMC+
	 FtodrQR6LX+40GCbPwRDTPyo0aEAK6VGFvg/l+RwGjGMNRdlFQxLGcGvhmksGj/5tM
	 e4ye5SH1grFqw==
Message-ID: <2ca68c8e-2553-4693-816c-1a1633d91caa@kernel.org>
Date: Wed, 9 Jul 2025 12:55:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 4/5] mptcp: track fallbacks accurately via
 mibs
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
 <a6b76e9d-b84f-428b-b0bc-bc9d9aa782f7@kernel.org>
 <279b70c8-603a-4fda-af5e-30cf4df7ebed@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <279b70c8-603a-4fda-af5e-30cf4df7ebed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 11:55, Paolo Abeni wrote:
> On 7/8/25 5:56 PM, Matthieu Baerts wrote:
>> On 05/07/2025 09:24, Paolo Abeni wrote:
>>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>>> index 0c24545f0e8d..064f5eaf0595 100644
>>> --- a/net/mptcp/mib.c
>>> +++ b/net/mptcp/mib.c
>>> @@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>>>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>>>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
>>> +	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_DATA_FALLBACK),
>>
>> Should it not be prefixed MPCapableFallback like others above?
>>
>> Maybe: MPCapableFallbackData / MPTCP_MIB_MPCAPABLEDATAFALLBACK?
> 
> Fine by me
> 
>>
>>> +	SNMP_MIB_ITEM("MD5sumFallback", MPTCP_MIB_MD5SUM_FALLBACK),
>>
>> For the name: is it limited to MD5Sum? Or any TCP AO?
> 
> To be more accurate should be MD5_SIG_FALLBACK, or just MD5_FALLBACK

Do we fallback to TCP when TCP AO is used? Or maybe it can be used in
parallel? I don't remember.

>>> +	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSS_FALLBACK),
>>> +	SNMP_MIB_ITEM("SimultFallback", MPTCP_MIB_SIMULT_FALLBACK),
>>> +	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACK_FAILED),
>>
>> Do you think it would be worth it to check in the selftests
>> (mptcp_join.sh?) if any of these counters are incremented when they
>> should not be?
> 
> Could be a nice follow-up! (which I don't plan ATM).

I just created this:

  https://github.com/multipath-tcp/mptcp_net-next/issues/571


>>>  	SNMP_MIB_SENTINEL
>>>  };
>>>  
>>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>>> index 250c6b77977e..99c8788694c3 100644
>>> --- a/net/mptcp/mib.h
>>> +++ b/net/mptcp/mib.h
>>> @@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
>>>  	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
>>>  	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
>>>  	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
>>> +	MPTCP_MIB_DATA_FALLBACK,	/* Missing DSS/MPC+data on first
>>> +					 * established packet
>>> +					 */
>>> +	MPTCP_MIB_MD5SUM_FALLBACK,	/* Conflicting TCP option enabled */
>>> +	MPTCP_MIB_DSS_FALLBACK,		/* Bad or missing DSS */
>>> +	MPTCP_MIB_SIMULT_FALLBACK,	/* Simultaneous connect */
>>
>> Maybe clearer with CONNECT or CONN in the name?
>>
>> Maybe: SimultConnectFallback / MPTCP_MIB_SIMULT_CONN_FALLBACK?
> 
> Fine by me.
> 
>>
>>> +	MPTCP_MIB_FALLBACK_FAILED,	/* Can't fallback due to msk status */
>>>  	__MPTCP_MIB_MAX
>>>  };
>>>  
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 4680d980e605..c9e1f3ec3772 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -978,7 +978,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>  		if (subflow->mp_join)
>>>  			goto reset;
>>>  		subflow->mp_capable = 0;
>>> -		if (mptcp_do_fallback(ssk))
>>> +		if (mptcp_do_fallback(ssk, MPTCP_MIB_DATA_FALLBACK))
>>>  			goto reset;
>>>  		pr_fallback(msk);
>>>  		return false;
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 0dc55a17f274..5f99f02c827c 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -67,6 +67,27 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>>>  	return &inet_stream_ops;
>>>  }
>>>  
>>> +bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib)
>>> +{
>>> +	struct net *net = sock_net((struct sock *)msk);
>>> +
>>> +	if (__mptcp_check_fallback(msk))
>>> +		return true;
>>> +
>>> +	spin_lock_bh(&msk->fallback_lock);
>>> +	if (!msk->allow_infinite_fallback) {
>>> +		__MPTCP_INC_STATS(net, MPTCP_MIB_SIMULT_FALLBACK);
>>
>> Is the name OK? To me, a counter with this name should be incremented
>> when __mptcp_check_fallback() returns true just above, no?
> 
> Typo above should be MPTCP_MIB_FALLBACK_FAILED.
> 
>> Here, we now try to do a fallback, but we cannot, a reset is probably
>> needed instead, but that's not because we try to do the same fallback in
>> parallel, no?
>>
>> I guess you wanted to use MPTCP_MIB_FALLBACK_FAILED, no?
>>
>> Anyway, even with 'fallback failed', because in the first patch, the
>> helper is now also used to check if a fallback can happen. It means that
>> here we can be in a "normal" situation where we just want to fallback if
>> we can. If not, that's not an error.
> 
> Modulo bugs it's either:
> 
> - mptcp_do_fallback() returns false and we reset the subflow
> - It's an early fallback and mptcp_do_fallback() should not return
> false. Corrently the code does not even check for `false` return value
> in this case, but we could/should add a WARN.

Good idea :)
> In any case it's not an error, but it's a fallback failure: the code
> path should have caused a fallback, but instead the socket has been
> reset. I think we should track the exceptional event with a MIB, and
> FALLBACK_FAILED still sounds like a valid name to me.

I don't think it is always an error, see when you set
MPTCP_MIB_DSSCORRUPTIONFALLBACK (mptcp_dss_corruption) or
MPTCP_MIB_DSS_FALLBACK (subflow_check_data_avail), no?

>> In other words, I don't think we can have a generic MIB here. If we do,
>> this counter will be incremented in parallel to one linked to a subflow
>> reset, e.g. MPTCP_MIB_DSSCORRUPTIONRESET.
> 
> AFAICS some reset i.e. in option.c and in subflow_finish_connect() don't
> get their own MIB incremented. Even what that happens I think it's good:
> having more mibs incremented allow understanding what happened exactly.
> Not that there are already other exceptional events where multiple mibs
> are incremented (IIRC even in the MPTCP code).

Sure but it might be confusing to see that the "fallback failed" when it
was not supposed to even try to do a fallback at that stage of the
connection.

>> I wonder if (1) this helper
>> should not be renamed to avoid such confusion -- see patch 1 -- and if
>> (2) another argument should not be passed to increment another counter
>> linked to a subflow reset or an abort (MPTCP_MIB_FALLBACK_FAILED can be
>> passed if that's not normal). Or maybe clearer to add one new helper to
>> do a fallback or a reset + increment the right MIB counter depending on
>> the situation? (And another helper to do a fallback if possible, and if
>> not, only increment MPTCP_MIB_FALLBACK_FAILED?)
> 
> I would not over-complicate the code here. The reset depends on the
> caller, having that separate AFAICS makes the code simpler.

Fine by me.

> I'm ok to rename [__]mptcp_do_fallback() to [__]mptcp_try_fallback(),
> but I would not do that in patch 1, for backport's sake.
> 
>> (also, detail: why not doing that after the spin_unlock?)
> 
> So we don't need to lock/unlock BH again to update the MIB>

Ah yes, you use the "__" version of MPTCP_INC_STATS, missed that.

>   			 */
>>> @@ -1424,7 +1423,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>  			WRITE_ONCE(subflow->data_avail, false);
>>>  			return false;
>>>  		}
>>> -
>>
>> Maybe better to remove this line in patch 1/5?
> 
> Fine by me.
> 
> /P
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

