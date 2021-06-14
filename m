Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A32FB2
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 15:58:27 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id g18so45212966edq.8
        for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2JOhERFP3OtnGOj5ksslP9NdTHjMa0Uk8pwEBcZt+8U=;
        b=sGhn4TXuNFJMuhbwQ7udS3Q44zj8jgLyAmzJ9tl8VcvV9xioytHIwIDHZuCAvgtitG
         yZs9/qn5T0Rkfh3d9tjcUmngW32gksUs3SLVSVCs5l83hmjHFKKK8L5kAexBZqCtx3AA
         8zUFd9VIpzU91nx15/bZpvJiK0K2tWw+RRV0ncnlaufsGXQsvR735ACAti9KkAsFLeSf
         T5jsywm58loSQ2+j7X8wE7S8xuRjXazbYKO3nMUggYj+XaCoB+QJOdcxHYBE6sN9fW+N
         JtDc6yjK7ZXc6yydxuadko8/qjZQcKSH/j9SVcG07+MXrZKe4mcwgDOZ4WX3r4NTss3T
         Qttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JOhERFP3OtnGOj5ksslP9NdTHjMa0Uk8pwEBcZt+8U=;
        b=eKGuN6JxMixcmBXeWubdSNAFAKqvYzIn5O0Q1QPlAcOy+cwloeSh66QTvGE+Aj2TvL
         mZ9CuGu3FEWa0gDDu7IHYkgt5w3sPRrys+djbRs76UAW0/n9AVg7h5xVVm0T/G4GnSCF
         9H6Cf9Sb+mwpFG/T+LVrYJvDc1f8R3e+OaGqmf/+uoF5RhgxhSMJk7+phRLOfmnaSNyF
         PUQrl80Cv4jKZKiiDVQzH6iDO8mT5C3v8XtVlyo3k3Fk/9HdCmNfu+EhBiqZaEVPgqHO
         6VhApz9LajI3sXbJegelVTn0OkuOvastWKliXZdNR3sTmmqzFUiMnn/aMJVrpjtLu10J
         p3xQ==
X-Gm-Message-State: AOAM531cjKRMf1slzgREFGhscDKPKfFRLPpPdhBc4aV3hzBdtDNlJPh/
	oJ8b85AOMDrco1r5u0BUmf16zZMFLoZ1jKmM
X-Google-Smtp-Source: ABdhPJxkUkn1JLegOqwRP6h8mxAfoMSu6aJxBTZ/g8nD2P2+DVQ1v0e/sVUh7OgNe6FMN/spr8ffig==
X-Received: by 2002:a50:cc0b:: with SMTP id m11mr17694835edi.297.1623686305635;
        Mon, 14 Jun 2021 08:58:25 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5d72:7de9:b502:1367])
        by smtp.gmail.com with ESMTPSA id ot30sm7587187ejb.61.2021.06.14.08.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 08:58:25 -0700 (PDT)
Subject: Re: Checksum support: default behaviour
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
 <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
 <eb41332a032c3c8191ce6b0d0ce2d2aa93ad5081.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <83da200b-97bf-2102-ef1d-7b196553e5e0@tessares.net>
Date: Mon, 14 Jun 2021 17:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <eb41332a032c3c8191ce6b0d0ce2d2aa93ad5081.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your reply!

On 14/06/2021 12:39, Paolo Abeni wrote:
> On Fri, 2021-06-11 at 21:05 -0700, Mat Martineau wrote:
>> On Fri, 11 Jun 2021, Matthieu Baerts wrote:
>>
>>> Hello,
>>>
>>> With the current checksum support series from Geliang and Paolo
>>> available in our tree, the default behaviour is not to use this checksum
>>> feature.
>>>
>>> Should we eventually do the opposite and have it enabled by default?
>>>
>>> I do understand this has a cost in terms of performances but this could
>>> help detecting nasty middleboxes, i.e. the ones that modify the TCP
>>> packets without modifying MPTCP options if needed.
>>>
>>> On the other hand, I don't have numbers showing if these middleboxes are
>>> rare or not.
>>>
>>> But also, the main issue I see if we enable the checksum support by
>>> default is that we are no longer able to talk to servers not supporting
>>> it (<5.13), no?
>>>
>>> WDYT?
>>>
>>
>> I lean toward leaving checksums off by default, based on what I've heard 
>> from community members. It sounds like large deployments haven't seen 
>> checksums catch many problems? Some actual data about the frequency of 
>> checksum failures would really help.
> 
> +1 on keeping csum disabled by default until we have at least one of
> - performance data (delta)
> - impact proof (csum corruption in the wild)

I agree: it seems to be a good plan.

But if we decide now to keep it disabled by default, could we later
enable it by default? It is a visible modification for the userspace,
not really an API break but well...

>   (side note: even with no middle boxes at all, no app-layer mangling,
> we can have bad MPTCP csum with correct TCP csum, e.g. due to BER plus
> bad luck causing a stream corruption not catched by TCP csum but
> catched by the MPTCP csum).

I guess that would be quite unlucky, no? Lower layers also checks for
corruption, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
