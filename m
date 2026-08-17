Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41B429CCD
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972158; cv=none; b=XKlssTUj6vzkyTDHi++PM8xDQsll7NEjbti0thps43xhFoewO4c6iNdvVvXfs64UeofnSALmdRG8KjlwJtOtfDRav+bcJVyPgpzNOkShVYPqlj2z2UunQitP0Guzt9v7kUS/kE0AzXnoCcw1RatFnK3j0k9geT8hllBca3i0Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972158; c=relaxed/simple;
	bh=DcBfCNVH6HBKfjEdGvUthMpZdX8kgitAYeYhzxZWsi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR6DrdoShWDi590XcDZh67hED9NNJHHmSA0chqWdE0OjVUXMPdQfWmDCvUnBDLr8CfpCHXq4bBRN0Kkl+9uD9X3QtA/fBrxI6DDS2p3qNkXOjSCsKFwuelLU3kf4Kqy+yGjFqPVv4z5ti1TPd273vSUrbCBSqTthXhs+M/EkMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqqEmrMJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqqEmrMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786972155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5K+FnoFHYawGyFMspdTTl5E+H4Jg3Om+Gk+WBP8MLxw=;
	b=RqqEmrMJfX41PSCnnxQZSiKkERG7s4iA60uuv7z0zTDxB6mbyEz54QJQZe8JI5WEXAYtcR
	xSSI+UieJZ0+0HDoibaSfHJfGwAS4msAvxHlcRax2Ilno8Vs6gY0yGb9yg/W0KbYJrcHKt
	p0VETI6ZVbGDAinTpeeeBVSxJoLFCqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-7dpagX2gMteM26wsOaHXaw-1; Mon, 17 Aug 2026 09:09:12 -0400
X-MC-Unique: 7dpagX2gMteM26wsOaHXaw-1
X-Mimecast-MFC-AGG-ID: 7dpagX2gMteM26wsOaHXaw_1786972151
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-481514be433so1221339f8f.2
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 06:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972151; x=1787576951;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5K+FnoFHYawGyFMspdTTl5E+H4Jg3Om+Gk+WBP8MLxw=;
        b=d1/bmCCDKLHnCQQxSm7wHgWQ9VATERAw3PZfSATTnY7jbWZM52pxjOJe15xkLbhFNt
         JCA6eOEYi1QNU4+oKPjkqODRUEfePOhTV+6DtLeOtZofrqbhxyGgF9UNwRJxB6oQUYIo
         wajud2o5XVUuoqKOEZubT0rz9Hpq3RkmpgVg7/dSaHO7op/t+luM54I23qvQy/eHUPxP
         He8imexl8C2jtjoCl6M2ZJ0VMmLhXL0SMCqlYV9sfFE+NUv0nCnmhd0eaIdBSt3BLc6Y
         X4PSSC+eQWv9Lnyzv/jFEPnmhYHakfzIwIunxTn/IsZslv+ObTEBjaZ1RO4H8J7vH7Oh
         RBqA==
X-Forwarded-Encrypted: i=1; AHgh+Roy++w7kff26Qj/3d8LKgFuc8fj4IIlojCAQiznj9jrZx1S9+beyTCoGeiTb46YqvlQwCAqzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3lvS3FRIgcP0crcPZL9eMh7VN5L0tWVgkqDmsQ9HHiZawti8w
	T10k683Q9b8KbwvpfhCevGK01jL9+oqkK8+0G7elMz/5t9RcQDoO1QzxG14vssw4yqaGwisjesi
	jn4HEYaDi51FqZHeiGBRVx8Btl4XNMvX6GXGH9cRXUDokAKevyokyrEob
X-Gm-Gg: AR+sD10l309rqUIKmWnKbRGG933MnLoQV/ajnHvPvPTz4F6nVEuKwJW5GWsWAAODDdN
	P7wnJQwopdlXG1nHCLmim9t4GBhGwJLel007KQ/58HXFQtFBeS86xYABNX29Xv07xIUQZbK3viH
	rkxK2MMn8gK51z6feVx8xncwLNIjWZczm+YdmIa9HfhwVh3Dg/MllcaIRl1azh3SNcA4dJm2prn
	w0cj6wsQTtb6tFFj4KW14dSkD8U4H9EWFSETw3+GwLas8An5iHuXHItdlWKK0R640GCy+hJ55mU
	XofL+2PZK/9PAIYJEzv6e7YLQqjlKB5t/H6n4E16aR84LQjp8CvVZ7Da/SHvXAKIZxCJOa/wz+1
	RxwW0MsWRPWoetiVwk9nln0dDKI/Xdva0ANwDhuI12jHcO4msCg9g2LRFSIADnSK7EARcp0OQ9H
	A=
X-Received: by 2002:a5d:4d0e:0:b0:481:4f9b:282b with SMTP id ffacd0b85a97d-48160764a5amr30232104f8f.21.1786972151186;
        Mon, 17 Aug 2026 06:09:11 -0700 (PDT)
X-Received: by 2002:a5d:4d0e:0:b0:481:4f9b:282b with SMTP id ffacd0b85a97d-48160764a5amr30231996f8f.21.1786972150640;
        Mon, 17 Aug 2026 06:09:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b51asm3965346f8f.11.2026.08.17.06.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:09:10 -0700 (PDT)
Message-ID: <d8a12a12-de80-4283-937f-b3ae49171d66@redhat.com>
Date: Mon, 17 Aug 2026 15:09:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
 <d1a6a67f-41c0-4650-b62e-6a4476bab86b@redhat.com>
 <2e2b6eff-0d2c-40b9-b66c-f650bb5d1104@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2e2b6eff-0d2c-40b9-b66c-f650bb5d1104@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nkjvJVrQq3rSJMYss9nQENrvDQVNiZmir7--ls6qWFM_1786972151
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 1:07 PM, Matthieu Baerts wrote:
> On 17/08/2026 09:39, Paolo Abeni wrote:
>> On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
>>> When iterating over each MPTCP connection after having manipulated MPTCP
>>> endpoints, there is no need to operate on closing (or not ready)
>>> connections.
>>>
>>> We can then safely skip those.
>>>
>>> Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
>>> fully_established state, but it is better to check the connection state,
>>> which is what mptcp_is_fully_established() is doing.
>>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>>  net/mptcp/pm_kernel.c | 16 +++++++++++-----
>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>> index d3014bf57bf3..c185e53fe42b 100644
>>> --- a/net/mptcp/pm_kernel.c
>>> +++ b/net/mptcp/pm_kernel.c
>>> @@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>>>  		struct sock *sk = (struct sock *)msk;
>>>  		struct mptcp_addr_info mpc_addr;
>>>  
>>> -		if (!READ_ONCE(msk->fully_established) ||
>>> +		if (!mptcp_is_fully_established(sk) ||
>>>  		    mptcp_pm_is_userspace(msk))
>>>  			goto next;
>>
>> I'm a little double-minded here.
>>
>> The add/removal operations are issued by the user space to update
>> subflows, as a consequence of endpoint addition/removal.
>>
>> Possibly removing the subflow even for not fully established connections
>> could be the right thing to do, I'm not 110% sure either way. Possibly
>> worth to call this out with a comment?
> 
> Indeed, I'm also not sure. Initially, I only converted this
> READ_ONCE(msk->fully_established), also because later in
> mptcp_pm_create_subflow_or_signal_addr(), mptcp_is_fully_established()
> is used.
> 
> Probably best to stick to this one.
> 
> On the other hand, I just noticed that there is no check for "fallback
> done" here: so the operations leading to a notification (ADD_ADDR,
> RM_ADDR) will send a dup-ACK (pure ACK without MPTCP options), and
> adding an MPTCP endpoint will lead to... the creation of a new subflow,
> even after a fallback, e.g.

Sorry, I was not clear enough. I'm specifically doubtful WRT the remove
operations (i.e. mptcp_nl_flush_addrs_list,
mptcp_nl_remove_id_zero_address,
mptcp_nl_remove_subflow_and_signal_addr) and _not_ vs the 'add' one
(mptcp_nl_add_subflow_or_signal_addr). I'm fine with the check change there.

>> Also the asymmetry with the user-space PM is a bit strange. I can't
>> recall why it was needed in the first place?!?
> 
> Are you talking about all the mptcp_pm_is_userspace() checks? If yes,
> they are required because the pm_type sysctl could be changed, and we
> could end-up with a mix of msk handled by different PMs in the same
> netns.
> 
> It would be better to do the opposite I guess:
> 
>   if (!mptcp_pm_is_kernel(msk))
>       goto next;
Yup, I prefer the check this way more.

My doubt is that user-space will allow creating subflow even for not
established msk.

/P

