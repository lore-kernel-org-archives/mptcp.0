Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231021EB2F
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916211; cv=none; b=bxeI4j/HAZrQhCkH+krt75attbZQgL1+f7xRePOv96kqAL8A6M4xbIRHEBeubxYUiaqvj/lFr2RCHxZiFdToCZhbj3j2VoKGRGQzjzQV+8+LKvIaP51QqNSglTjfyDSWmVS8mAWuyuOOVZFD4WmX9aN1p8FvigIdbklmSIrgJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916211; c=relaxed/simple;
	bh=4DDKH+FXoWUTsTR7gkxwX/z+pvY/YAK/YFd8tC6H1CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N8MxE59g8QN05a/5x8Dv7gl/sbTsZvWCSg1stY3XYZfVJuH4ZusZGcEd5FAuf1x9DFrmiFq8nO/CDXxt6cE0QsC8eeHMGUTZsfT1an7gZn9D3Fouo5woqYPTGb9ofH74EKo61DoEbGZwM/8emBwuTj6xjKaVuFunkob/qgftHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3dGW/uu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3dGW/uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721916209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw9b7YXeKtw0xwId0UQl51MCcL9Z0HWrSvd1DENURgA=;
	b=E3dGW/uu5PZwRxBWPfal00OQkwytn5PybumpbYAN1nHq6G9jrrTQRp+34psSVOl9Ol5gkS
	0+iOJmkIsqvvoPL07MMXLNdUDmyspiNida8caOa/clOFQSEgeWB3o0POehkb7zKSWdSEPP
	75L2um2zRFxNwaUeCz0SSlWsDV7oB00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-660kCQBwO8S2hwbBBSXIiA-1; Thu, 25 Jul 2024 10:03:27 -0400
X-MC-Unique: 660kCQBwO8S2hwbBBSXIiA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265e546ca9so1726725e9.3
        for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916203; x=1722521003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw9b7YXeKtw0xwId0UQl51MCcL9Z0HWrSvd1DENURgA=;
        b=gnKwNxso2MkAhUVeeqd4OtVfgbsnt8eeBrzCmuLY1Vap3I1CZcmKQxVr6LjYZUxb18
         nHtiHQoJvk3z02+C/T6bADvwf+wMa1fa7HHidEljpdgkR8efXRK/oOCxC97KRB6m6WCB
         9exWN2KqmRsd8SvsyyO8+Z993EhoUsa8qfdzC3834YoT0V/G0RmQjM9modzx7WSQI4wi
         8pqFdYJ4eE5vqmo8Xy9Jm87kGJe5B1GWvgTBelO1ZHcvHd6ejAFxjnLoYFz9smVmpVI/
         ohyWtgSQW2YJ15EFoYUgFkbpSQfGQADRlnOUXUKH36lxhZzOW5xRKwwfqzCJCKLCbLZf
         JVBg==
X-Forwarded-Encrypted: i=1; AJvYcCWuBX44aOtU/v347eFORF6VzkOe6olRbTdvyNKOvRSP+u+6CY347bmPpe1Dko4p7pVS1LajZZUPlpxmtglio8ZPYI3sogs=
X-Gm-Message-State: AOJu0YxNihI4FDJVaPDFKVDrJdTeW/UisctJAU+rIhQjVbqn1GPr6vjM
	2mSZ4teqkPDAh9R7dr0ahbruJtG9nUddy96/kEjnKaHkRqcfv1w9KSbUUNUDxYYh5dYhX8sjjR7
	wXl7jrScIPJcoGBnsvUQAAIrNrla6Q9bc26VGrsxKChoalzNOILUX
X-Received: by 2002:a05:600c:4447:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-428054ff3b9mr11007095e9.1.1721916202649;
        Thu, 25 Jul 2024 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEesCkrJxnIw0zrqJ8ncc0EgDahGfx9gkSOhFZlSPSGdKUbker2eh3JUNDeyEDWzNf8sxzt4g==
X-Received: by 2002:a05:600c:4447:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-428054ff3b9mr11006165e9.1.1721916200635;
        Thu, 25 Jul 2024 07:03:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93594b6sm79640515e9.5.2024.07.25.07.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:03:19 -0700 (PDT)
Message-ID: <587e096f-0e76-40fd-9220-6d8dd2930838@redhat.com>
Date: Thu, 25 Jul 2024 16:03:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: pm: reduce entries iterations on
 connect
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
 <45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com>
 <4f926139-2872-4869-8ece-fd72cec3c83a@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4f926139-2872-4869-8ece-fd72cec3c83a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 17:55, Matthieu Baerts wrote:
> On 22/07/2024 17:14, Paolo Abeni wrote:
>> On 7/19/24 16:26, Matthieu Baerts (NGI0) wrote:
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 1b0e1617e90a..9fed7c92e52b 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -633,8 +633,9 @@ static void mptcp_pm_nl_subflow_established(struct
>>> mptcp_sock *msk)
>>>     */
>>>    static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>>>                             struct mptcp_addr_info *remote,
>>> -                         struct mptcp_addr_info *addrs)
>>> +                         struct mptcp_pm_addr_entry *entries)
>>>    {
>>> +    struct mptcp_pm_addr_entry new_entry;
>>>        struct sock *sk = (struct sock *)msk;
>>>        struct mptcp_pm_addr_entry *entry;
>>>        struct mptcp_addr_info mpc_addr;
>>> @@ -655,14 +656,14 @@ static unsigned int
>>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>>                continue;
>>>              if (msk->pm.subflows < subflows_max) {
>>> -            msk->pm.subflows++;
>>> -            addrs[i] = entry->addr;
>>> +            memcpy(&new_entry, entry, sizeof(new_entry));
>>>                  /* Special case for ID0: set the correct endpoint */
>>>                if (mptcp_addresses_equal(&entry->addr, &mpc_addr,
>>> entry->addr.port))
>>> -                addrs[i].id = 0;
>>> +                new_entry.addr.id = 0;
>>>    -            i++;
>>> +            msk->pm.subflows++;
>>> +            entries[i++] = new_entry;
>>
>> 'new_entry' is escaping the rcu protected section, dereferencing
>> 'entries' after the rcu unlock below could cause UaF.
>>
>> Note, AFAICS we already have a similar problem in select_local_address().
> 
> Good catch!
> 
> And with select_signal_address() since the beginning as well, no?

Yep.

>> One possibility would be to do a deep copy of mptcp_pm_addr_entry, but
>> that will waste a lot of memory on the stack. What about to copy the id
>> separately?
> 
> Is it not what is already done here? Before, only 'entry->addr' was
> copied, now the whole 'entry' is duplicated with the 'memcpy()' call
> above. Is it not enough?

Yes, it is. I got lost into the incremental diffs.

> I'm doing that because we also need the 'flags' and 'ifindex' info from
> this structure -- which has 3 additional pointers we don't need, but I
> thought it was OK to re-use it -- on top of the address we had before.
> 
> BTW, I just realised the copy is done twice (entry -> new_entry ->
> entries[i]). Same below. I can fix that.

Yes, would be better to avoid multiple copies.

The additional memory user is a bit concerning for the 
fill_local_addresses_vec() case, where the total amount of data on the 
stack grows from 192 (already quite big) to 384 (quite concerning)...

Paolo

