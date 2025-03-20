Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16612557C
	for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475344; cv=none; b=Qle6UZfBGkg+iZuJZ1/mMRmdixVQJ1PW0AZICshe9THUyj2VstlSQ3X7SCLBuYZwkOFHqRy8rK9TQK43ZCM64Ye/vOuJxitSrQZpsU9yJkpoYylzSjowL8BYL7i+IWyUOWUPLozwr/rgDeGDbhtwuchdOKdVtR8AfKRkr/8DLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475344; c=relaxed/simple;
	bh=XqnyCkR9PaLdrirpUUgfbS1fw8JcxnFYqckykpD0OFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcCJtiGVqDcjuJJy331tTrPhaL5iuy2PmFnLtYC/jesplL4zi4rS4rDbUJYkMW6phdfu/z2yCwyOar/fn9D46/cN+vUFXh9pkTAVyEigvECGTvxC3X8RSmF0Y3bmOaGsL1LUx7OGCZKsGOI5xfalh5d7yl3gV9mGaGpEQe2OC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOumW9nO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOumW9nO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742475341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uU76Eu9ghlyg5AgC3XDLkiwwMGgB66PTcG6tUKpdUeM=;
	b=SOumW9nOebqC2LnFonrSKDSyHX4FGc4z0npwwxYDCBPGevPXHPFrQ1IPBzXsNBNNsGz90e
	uEPTTtlHMAHsqqxcKEfI3B60qJJ8iZ9T0QFZEGWT/GjrOx3tkJRuAFpCM5LWwqrBpxjnKh
	22FM7eIl2L0WEvXv+aqvRxuDGc1NhL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-tF_aNNFzONS0jhhT8Hin6w-1; Thu, 20 Mar 2025 08:55:40 -0400
X-MC-Unique: tF_aNNFzONS0jhhT8Hin6w-1
X-Mimecast-MFC-AGG-ID: tF_aNNFzONS0jhhT8Hin6w_1742475339
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so3955915e9.0
        for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 05:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475339; x=1743080139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uU76Eu9ghlyg5AgC3XDLkiwwMGgB66PTcG6tUKpdUeM=;
        b=S/wJRd3PGnbPmcH+HhPjaJ3QfupvUVWAashSMcjunLhRG2mcJbOZLAXAXCDzRtG/dt
         iULw53a0GDrxjNa/0mwSo8UhNR2zny7xbl8/6Cis9BXPaPabojGlLQxAD/Y2Gp5v9Y7E
         c847BmJl2ihBwV4KHXQdpR1S5ZB2oOF1s0v/nxpPOcADjQPWka3Jh0/7ux67nWGs0Wv9
         8e096D4S6axtWnvQVWor2oN0S46zpIV/yvLF9fGCuEA/SosESDg5YswwG4dJEiKPmPWg
         FYvODONNk5qrpySbJB5yaT6oK2/WCrbNaJJ3uRqGiIv9Ei81A2vpy5+Y5gnL/N3CQiKl
         7ftA==
X-Gm-Message-State: AOJu0YzAaQc3Ej7s805YPYON+xHb5gEqQWGaZhFrKFFNxixparJNEz7S
	YQfT3mJ69AodgVqbVdOH36/hA1w3wyA0JGbEQqkiCLgUdrbrmYQAUEj0cfbxlTL8M52ohqEgr0s
	L1EfijMbalycRNJRhm8Zcb4nZkxt4W5gaqXF4XJd5JTY7MwhXLP22
X-Gm-Gg: ASbGncsHU2fQLsw/TB9A+WvAmxhBR0mJpscvb9cFFlIOnd2xKWGY3JZAQVwS+bjsHyn
	CdPVI2uvt5R56Mp/pbdxanvl3hDdfll1zUw9RgadEMHFaX9L9ZY+BdEC41KNUENymTYa942hv1G
	Qgs/ChGpUBwBKPuJHXbD59aQ6vw1coO0myJxgt5d038SQ6FPZ+F9/UTM1sOpZ2CcFczraazsmsO
	MuctJKDLGX626TA5mzPxrBfOqqMCeB9q95KcCZDG9uSQKBDHaUcrRV3vewYAKpJEe292s+P181J
	GriBC2zW5kUsBVcb7nG3a04Eamm4M/pfyiJ/kbGVtaGf6g==
X-Received: by 2002:a5d:648e:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-399795add2dmr2937677f8f.25.1742475338811;
        Thu, 20 Mar 2025 05:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVyhKnTFE+P2/7j9GGvHMrQKyFkRwtXXAFWRCzOhdCzCZGUHga7gonRw/o8WPG2tCQOD4bkA==
X-Received: by 2002:a5d:648e:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-399795add2dmr2937650f8f.25.1742475338377;
        Thu, 20 Mar 2025 05:55:38 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm24137143f8f.96.2025.03.20.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:55:37 -0700 (PDT)
Message-ID: <1811bd9a-846a-48f4-95f3-6badc3e063f0@redhat.com>
Date: Thu, 20 Mar 2025 13:55:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
To: Matthieu Baerts <matttbe@kernel.org>, Simon Horman <horms@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>
 <20250319153827.GC768132@kernel.org>
 <a2b61202-a257-4317-b454-799da27951e8@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a2b61202-a257-4317-b454-799da27951e8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mz1YoJID67v58US4xdv6Uzm08CEvZxXyoZpdDmuF3d0_1742475339
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:26 PM, Matthieu Baerts wrote:
> On 19/03/2025 16:38, Simon Horman wrote:
>> On Fri, Mar 14, 2025 at 09:11:32PM +0100, Matthieu Baerts (NGI0) wrote:
>>> When adding a socket option support in MPTCP, both the get and set parts
>>> are supposed to be implemented.
>>>
>>> IPV6_V6ONLY support for the setsockopt part has been added a while ago,
>>> but it looks like the get part got forgotten. It should have been
>>> present as a way to verify a setting has been set as expected, and not
>>> to act differently from TCP or any other socket types.
>>>
>>> Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
>>> to check the default value, before doing extra actions. On Linux, the
>>> default value is 0, but this can be changed with the net.ipv6.bindv6only
>>> sysctl knob. On Windows, it is set to 1 by default. So supporting the
>>> get part, like for all other socket options, is important.
>>>
>>> Everything was in place to expose it, just the last step was missing.
>>> Only new code is added to cover this specific getsockopt(), that seems
>>> safe.
>>>
>>> Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
>>> Cc: stable@vger.kernel.org
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Hi Matthieu, all,
>>
>> TBH, I would lean towards this being net-next material rather than a fix
>> for net. But that notwithstanding this looks good to me.
> I understand. This patch and the next one target "net" because, with
> MPTCP, we try to mimic TCP when interacting with the userspace.
> 
> Not supporting "getsockopt(IPV6_V6ONLY)" breaks some legacy apps forced
> to use MPTCP instead of TCP. These apps apparently "strangely" check
> this "getsockopt(IPV6_V6ONLY)" before changing the behaviour with
> "setsockopt(IPV6_V6ONLY)" which is supported for a long time. The "get"
> part should have been added from the beginning, and I don't see this
> patch as a new feature. Because it simply sets an integer like most
> other "get" options, it seems better to target net and fix these apps
> ASAP rather than targeting net-next and delay this "safe" fix.
> 
> If that's OK, I would then prefer if these patches are applied in "net".
> Or they can be applied in "net-next" if we can keep their "Cc: stable"
> and "Fixes" tags, but that looks strange.

As per off-line discussion I'm going to apply only the first patch in
this series to net, and leave the other for net-next.

/P

