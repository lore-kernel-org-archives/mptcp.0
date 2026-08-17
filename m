Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA5423EA4
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971834; cv=none; b=rv/ZllDS+rMjrEagtvZ8iSIkWLMTwYvBUp+gPwjELid2pCclemS/AdwJVDU8HdGHbVkg0cjnLeoUdeXx0iOpVSLgL+8Izn5RXXB95ysoxK10naObDdjUyu3REk133QzYKbQsUY9HuCm3vLysSQMpHZN3Cu/Kv3RsLRywotxaWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971834; c=relaxed/simple;
	bh=SbZbvYO34zcar6QyaBY0PKUmiZsWzPxyVD40oaPMm68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcIqSoPTRgWqfm+PxhwGjz7ewVyZcGKBXgS4CH/0jmRnmW49l60datTxHYVIU16/gvApM5sqh5tP4tkKPOkyW1TLb3Da0UloPJJmGclSTFM9NxQS6f+MX590WmWsreu75iL8vmk55NoP6i/FNThFpGYcQk51erftm16Gklw7vuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7pxan/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7pxan/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786971831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEYGcbdA16NTHoWYVk5Degml2wbcMKrVIlgIcZW6n+Y=;
	b=d7pxan/pkol40XVkvhdVOxcbpam+unSEv91LWLQnfqMTksoun86FyVeV8+0512mfO+NzzB
	ntJOK7nQTHQZ5pNhxbhInLISbg20mZHXfNBVxrZPqEF2ZyF6e67U9/m9/q9jPzNzVyOXt0
	Jwl1nhCO3G1FVPEonfQ8iJ8Ex/lqlVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-M_esEO9PM66qFwqN8keCkw-1; Mon, 17 Aug 2026 09:03:49 -0400
X-MC-Unique: M_esEO9PM66qFwqN8keCkw-1
X-Mimecast-MFC-AGG-ID: M_esEO9PM66qFwqN8keCkw_1786971828
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso32576465e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 06:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971828; x=1787576628;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEYGcbdA16NTHoWYVk5Degml2wbcMKrVIlgIcZW6n+Y=;
        b=q5CcOF5up5Yi743GC4KGRykxXSooxFsqBG4utJa0FvFdsQ3BIWYRAVKQUCXl/G4tGL
         TPQyq0lPUTPJ/kjSrFKQofhAklcgRB0Hm5cbyReyhm7wmDfjLp8scyofFNpu2V2oRYLU
         8VGbauJMYNlgZqhd45YyppnRB8QnLuT5X9Qt9roDUjHMM5tkqAU2tAx6/fuZJMHeogPz
         E9b34hY+VUeoafiWvSoQjB4Z45iseoFBNSN4zj0k1EzNihDHWJOU6PCoEJ+r8OqrsjI+
         MQqDq8V/tBY3aeQYfDBURou8yPKXPne2jmX+c3x6WOTVjc3/Q+zhBVWs1oKp2Ib0TN8H
         wzeg==
X-Forwarded-Encrypted: i=1; AHgh+RqFQLgMzvIBTL2hgShbdquqQUbWZ8QNwwlsXbxseNKJISgqKxlmhdkDGH9TsRFTCYnw2gXV7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIT2cFu+xSdOQyiA1xh/I/zKCBhJJBAi1EcJx4BoCwSw5zSBI5
	c3CoImFX+sYLZ7Gs+t8jgHkKfhu+lKbj5gMOGrr6MfrLdAcpTWt35ud6qWEITJjy3uzuaMGL2O/
	odhk8xtnHH5Ar4i+vnEKe+DLWK4jVlTEf/lqWyLow0CuqmCiJQFAnPYDDGX+vXZ+X
X-Gm-Gg: AR+sD13izDJcsaNODUWMocP7RYDEdl28eB8zhIMguzozDMhVvANkxmHQGDbwnkPFCkM
	NbOi2gNK9TxgfONaK0va/UZhp8AhO648/fkoll9YklD7eII6QmRExU4JX8cNtCZA0EmjCr6lZlS
	1KzoRKBMHqU9jw45FHIrhoZF9RcvmDf5JmCE1lv0Ry565+dDNUmFaf+8XLuF3RcpeyuuIf51GG5
	WzIGT7oBgEH5+O6NJRQn92YBuvpWuN26qEuS95egMG/gaYeATLVLQMSRWsWe+omeMl/PsWJEggc
	EmpNoRy//8HlFAP7rV1MDh0/7rAqWrOSpYJ3ReDi0OHPa8B8ymLh3rherCa310JSzMAQ7KN77ln
	r3VWPVSSE/x6uCNkOw4Q+aq6/yHmXrd8L+KrP6lffAnGK/3zS53N3UGRaZ0Dh
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49987981e52mr407207075e9.19.1786971828423;
        Mon, 17 Aug 2026 06:03:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49987981e52mr407205925e9.19.1786971827945;
        Mon, 17 Aug 2026 06:03:47 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm184661465e9.8.2026.08.17.06.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:03:47 -0700 (PDT)
Message-ID: <1434f3ca-ead2-4723-9ef3-e91b99f89e31@redhat.com>
Date: Mon, 17 Aug 2026 15:03:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
 <e277308e-87b5-4c1c-b976-ff73cf4286a1@redhat.com>
 <f5ba94b7-449f-45d1-b98e-c997faefa4ee@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f5ba94b7-449f-45d1-b98e-c997faefa4ee@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 10m3S4LbBT75XmHOvj9c3QiBwTYC146jphPRFknpyto_1786971828
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 11:49 AM, Matthieu Baerts wrote:
> On 17/08/2026 09:27, Paolo Abeni wrote:
>> On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
>>> @@ -91,12 +92,22 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>>>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
>>>  	if (!msk) {
>>>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
>>> +		*reason = MPTCP_RST_EMPTCP;
>>> +		return NULL;
>>> +	}
>>> +
>>> +	/* Stop it early if the subflow cannot be accepted */
>>> +	if (!mptcp_can_accept_new_subflow(msk)) {
>>
>> Side note: the above is inherently racy, the consistency safeguard is
>> given by the fallback check at finish_join time.
> 
> Just to be sure: even if it is racy, is it OK to use it here but
> continuing having the safe check at finish_join time?
> 
> In other words, having such a comment is enough?
> 
>   /* Stop it early if the subflow cannot be accepted.
>    * This check is inherently racy, the consistency safeguard is
>    * given by the fallback check at finish_join time.
>    */

I think so.

>> Minor nit: I'm not sure this check belongs here or in
>> subflow_check_req(). The latter option would avoid the additional
>> argument and possibly produce a smaller diff (and smaller code).
> 
> After re-looking at this code yesterday, I agree with you. Also, I think
> subflow_token_join_request() should only return the msk, and not
> changing anything else from subflow_req.
Makes sense.

Somewhat related: to avoid subflow_check_req() growing too much, it
would possibly make sense move the final mp_join related bits in a
specific helper, and have just:

	} else if (opt_mp_join && listener->request_mptcp)
		return subflow_mpj_check_req(req, sk_listener);

/P

