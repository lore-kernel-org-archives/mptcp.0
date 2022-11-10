Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283E1A601
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:16:11 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso4559020wmb.0
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04tsQl2zXO1HLHE4tqpma+pmOBLbKtyJcgaJfAQDIzE=;
        b=WErRB48UL0SXmqG70/k6K3u3Z2UjuyVfxHxwJ4Hh8damxuGXUUeSX5khuY/Zyb0Gje
         tWN+jCmp7gsr2pWJiWwvSnPlt4sn+HBMrFXLYIhNVybp6gDfZVyZZXj2mV8pvvoaMapQ
         ydKhVJcOgirfSJ/x12YBDNKd4XruMq1nIg7VC9RgryMCTg9N81R0q33dsQcH860SUBNJ
         OTTaf7T7NwDOHPjleY1RpbAQZPRrMsNJP/ayOscGER6CEBFTeGKBH0GNIaei2uwYqI+l
         4xU9Qms7/B/hyeB+FibYBJaJeqrXjBl+nOfgV1XRSUnBeLpN1myK7/WvmpwVLAzXzC0c
         Zudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04tsQl2zXO1HLHE4tqpma+pmOBLbKtyJcgaJfAQDIzE=;
        b=sv0HaRyzj18ILofuJ2oAOjcJgZSxrzf7prZAdJvfCMn4aHuSh2gauUc9rQubO1R7au
         8vr0MSajTX2VRrioox1+aO4MOixUFKW73dY8F6aG3fDhZAPSBpdrkBlsFskmgk1KMjzI
         bdbwyCj6LsuvJ/zi6QI5z0in4yJGdWjToJf4zfK5OpbXpib3FyCiZIXz0uTXEUwvjJA8
         nHFhSdZaJj4gWLgUIDr0a1BIErcKTDCb0ec6WMplKzPOEpADpggBPkvOyVz+/r2UeOVN
         6sOIuqCsgNXw5WaNPFVkvjNQYWktmcctNmleRbbE62oXoD2moEMobtt2+CiiJH9mVYpt
         DvYw==
X-Gm-Message-State: ANoB5pmnDXWi+Ux8YngaoiS0PBJEp0HcnJdP0DPtTv+HLfdOJJIr83PT
	AL/CNhWNQD6FOLhg5R9qOmoBhQJImYSKjAV2kjM=
X-Google-Smtp-Source: AA0mqf5V+GJ99MBF2D5/o5P4TJ9QEtUfJVz/i6tEJcKnGlJFnN9i3dyIjz524JSgM8FbX2UpSEWHQA==
X-Received: by 2002:a05:600c:2942:b0:3cf:b1c1:336a with SMTP id n2-20020a05600c294200b003cfb1c1336amr11934256wmd.95.1668100569684;
        Thu, 10 Nov 2022 09:16:09 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a69e:b302:f965:8831? ([2a02:578:8593:1200:a69e:b302:f965:8831])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003b3307fb98fsm166485wmq.24.2022.11.10.09.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 09:16:09 -0800 (PST)
Message-ID: <8cea7adf-83a9-f568-a612-1428eecf4c32@tessares.net>
Date: Thu, 10 Nov 2022 18:16:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/4] mptcp: run mptcp_sockopt from a new netns
 + cleanup
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
 <a1572fd3-3ae2-5f67-4d9a-b561eecfed2a@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a1572fd3-3ae2-5f67-4d9a-b561eecfed2a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 31/10/2022 23:04, Mat Martineau wrote:
> On Wed, 19 Oct 2022, Matthieu Baerts wrote:
> 
>> Here are some small fixes for the MPTCP selftests, no big changes.
>>
>> The first patch is a fix and for -net: if we run mptcp_sockopt.sh
>> after having
>> modified some settings related to MPTCP on the host, we can run into
>> issues
>> without this patch.
>>
>> The second patch uses the new netns for mptcp_inq, cleaner.
>>
>> The third one remove some defined but unused vars.
>>
>> The last one uniform 'rndh' variable because it was declared with
>> undefined
>> variables in a few places.
>>
>> Matthieu Baerts (4):
>>  selftests: mptcp: run mptcp_sockopt from a new netns
>>  selftests: mptcp: run mptcp_inq from a clean netns
>>  selftests: mptcp: removed defined but unused vars
>>  selftests: mptcp: uniform 'rndh' variable
> 
> Ok, with the follow-up discussion and handling Geliang's suggested fix
> for mptcp-next as an additional patch, this series looks good to me:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (fix for net for patch 1/4, feat. for net-next with the
others):

New patches for t/upstream-net:
- c0dbc5e74ae0: selftests: mptcp: run mptcp_sockopt from a new netns
- Results: 21b3ec76c898..5a5c32fdb403 (export-net)

New patches for t/upstream:
- c0dbc5e74ae0: selftests: mptcp: run mptcp_sockopt from a new netns
- 972ae67540f4: selftests: mptcp: run mptcp_inq from a clean netns
- 6af6a13a0afc: selftests: mptcp: removed defined but unused vars
- ca4c25547d92: selftests: mptcp: uniform 'rndh' variable
- Results: d33b3e9215cd..5f9e0bf4aacf (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221110T171431
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221110T171431


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
