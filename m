Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6434CFC7
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847716; cv=none; b=GG1U70mldFnPioOSQlhBOLmPblwj4jVpZDT/LkoBDfNo8DXKn4UHQwiGppmbKE1SJi7itL7CDHuvlnt1XXYWj6cV2u3P53J5FuRROVS9mUWYlqo5f9s1KBBmTPEZJyW5vBY4R8q1tz1lef8sFxs1izzHrGDmhLX3NAcij3CH7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847716; c=relaxed/simple;
	bh=19Qbyd3fEYH/9JletA34+NAQpOsK6F9a8N78VjlJc7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsmty7lLvGko8bQhh3IoaNX1Bx6eowI+01EZs5S8rRxH6QKutV9/oxa3CXQhWQN9uGBZFU3VV4t7St3Jbjfb/QC1UO1FlXSQGGb8o/gb5hMRx/1EFHhelwdM8gwKItZFg7oPE7blaZJxxhc8mQ72iOwNCFHNM2zxINQyvDZ7ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvV4obMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvV4obMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776847714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYRU5BQlWgAtMhVJJDQ45RKfAd9iefagcQp2Om/UneM=;
	b=RvV4obMgi+OX3lAEJhOmncmpP0O86u7AcSJ8qpl5LtdSeUsNb3rUqhxFGdLneJJ19S6Wqx
	Gum4mYvz2kirXMuBuxEL90euxJAdGEh2h0b9cZJ00Gi6IKiFydDjoPx9H8mRlGyRKYUO65
	+7x6XuXLRUBp5H6D+zBCOGieqOM/dCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-dade4kq3Or-m9ZHA7M0f3g-1; Wed, 22 Apr 2026 04:48:31 -0400
X-MC-Unique: dade4kq3Or-m9ZHA7M0f3g-1
X-Mimecast-MFC-AGG-ID: dade4kq3Or-m9ZHA7M0f3g_1776847710
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso50594605e9.2
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847710; x=1777452510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYRU5BQlWgAtMhVJJDQ45RKfAd9iefagcQp2Om/UneM=;
        b=FmC4i+/B1dfC/Gr91zG1wRDv1eMtqwy4V42RnrER27uKYNXAHjHn20Ej2xiojYqRyG
         tWR1bz7/3cRAvCqsgyAjEFXPwX8bxXREoV92Ad3nD/8RfT5+d5ULbxfYF5WwvFvxJq/5
         VsgpYjXpFQDxwURGUbKIKxQO5IACjt3HSuR8V/0/53n+6W7tgsF02GSSG0FlXI2do6HI
         c+0XAKOj/gVt92hT1ffPowcee5YjA/wDJb5sCmu7s92HdK0m0tfYupI1irnCgP63rqYT
         7VS2BGnlhqHYYVau7h19Bfl0+2PPQppxQB7aQ34H8qDw6cTxDp6ken6tKYRRt0n6/Z0E
         9Oiw==
X-Forwarded-Encrypted: i=1; AFNElJ9omN3mgq7OpbYo2UpHFD2jfszMBFi/38P/0AI3tMgQVeO5y1ihT0YPiziTj6xyBNEUIqTfKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvaIBxRJc0koYuvin9+yPHCihOVfd9GU1Azi17M/5UbGBvcl59
	P0evQXtFhgEfjwNP4kzxptel7YADfUuNyTtzuWypkZlonhBmY8F3YjH3tdkoA1xjOeKmSUpBrQP
	safFRRYUQ3kEe7PFRFWHtDJagKYT+rTQ87VEFjsLT4iEot+IwClEZB5jQ
X-Gm-Gg: AeBDieuTT0huk88xmp9pfk7hIlpofTWDVl51imfVUoH6hNNGMJrFvfN1ooxyZIxDWjV
	lRz5GkY2m4YYPKmJT/Av/7hNPsqbMShuGYDCKmAsPJ/iWAv7NjM3wa/MJey2yPrJTrbQuK7lfYU
	jo4yK06VAb+3tQPOhIttW/VwS57gyhZgoGiCoB4vNclmjNsaITUgIFGecGe99oOzHMmHLUZAILC
	8Kx2Tv//OmuqinfoKdKEZ/uvCd9rJ+o5SaH4BNnA/4dWtXpLyCcH9k0uLsQZh+P0A7yAH2G0Vph
	jFkEFvz0tQkFG9XvwcG303iP7/5c8FWoszQzuVzhuMHTIZylkU3SnxAOiQprP1SnC7dGx65OrTH
	GZ/H8Vekb1pOTAflk68jdzwWKhqDJHHfhPCtCHySXPDkiOV7ESK+FP4TGFiSLj3HYGHU=
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488fb77faacmr266982185e9.20.1776847709969;
        Wed, 22 Apr 2026 01:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488fb77faacmr266981705e9.20.1776847709429;
        Wed, 22 Apr 2026 01:48:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891ffd2030sm59441735e9.20.2026.04.22.01.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:48:28 -0700 (PDT)
Message-ID: <b0a882d8-3d33-47ae-9376-857f92bef86c@redhat.com>
Date: Wed, 22 Apr 2026 10:48:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to
 subflows
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-2-devnexen@gmail.com>
 <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
 <88df3189-4aa0-41fa-9a58-0d17fb736c87@kernel.org>
 <a7234091-4141-46ee-8db6-cf01baa25800@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a7234091-4141-46ee-8db6-cf01baa25800@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O-JmmnaqvTs2TSUWYo4wfEauvtsnBJDLfzNxDb84Qco_1776847710
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 10:35 AM, Matthieu Baerts wrote:
> On 22/04/2026 10:32, Matthieu Baerts wrote:
>> On 22/04/2026 10:05, Paolo Abeni wrote:
>>> On 4/22/26 12:33 AM, David Carlier wrote:
>>>> Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
>>>> IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to
>>>> existing and future subflows.
>>>>
>>>> Apply the matching sockopt according to the subflow family so mixed-
>>>> family subflows stay aligned with the parent socket configuration,
>>>> including disable-time errqueue purge semantics.
>>
>> (...)
>>
>>>> +static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
>>>> +				       sockptr_t optval, unsigned int optlen)
>>>> +{
>>>> +	struct mptcp_subflow_context *subflow;
>>>> +	struct sock *sk = (struct sock *)msk;
>>>> +	int ret;
>>>> +
>>>> +	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	lock_sock(sk);
>>>> +	sockopt_seq_inc(msk);
>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>>> +		bool rfc4884 = optname == IPV6_RECVERR_RFC4884;
>>>> +
>>>> +		ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
>>>
>>> The above looks a bit overcomplicated?!? It looks like you could
>>> leverage mptcp_setsockopt_all_sf() in  and drop the
>>> mptcp_subflow_set_recverr() and mptcp_recverr_enabled() helpers.
>>>
>>> @Mattbe: it's not clear to me why mptcp_setsockopt_all_sf() does not
>>> call sockopt_seq_inc(msk) or sync the setsockopt_seq, possibly an
>>> unrelated bug?
>>
>> Oh yes, good catch! And a lock of the sk (msk) before iterating the
>> subflows, no? Same in __mptcp_setsockopt_set_val()?
> 
> (Not the same in __mptcp_setsockopt_set_val(): the sk is already locked)

AFAICS for mptcp_setsockopt_all_sf() the msk lock is acquired by the
caller. Same for __mptcp_setsockopt_set_val().

Side note; AFAICS a few other paths apparently lack the setsockopt_seq;
that is minor problem/not a real issue: worst case it will cause a
redundant mptcp_sockopt_sync_locked() call at finish_join time.

The missing sockopt_seq_inc() instead looks really bogus, as it will
caused missing synchronization for later subflows.

/P

