Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753B6FBA
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 19:24:00 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98e109525d6so1076466866b.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688498639; x=1691090639;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ASsGYOng07s9S4R45sQeSWvCiCV/AlyMkiOdysFSdc=;
        b=1eS0Dd7WMI0HEkDWb0fYNsZe1j0aJObBReq5/4NecYxR68G9zKvDRHhhbmIyC/U5I6
         msn5VpvELdBdleThgYMaxr9uuT6Z1UHjr2aMc1Y6EpqFDeHN9Lwqc35pT0ZNKgpxpyus
         1sKEu9i9lAqAbdN1UJwBi4VpUpE8Jair9rrR0B2JZBnNe32aTeg1KNU3a2LUtQArZXyQ
         ecQE9wtH9f+1XonRkCcwKTqHzyMHIhqXtCiAc/xA3fvfeysqxgUNlwJF87LL9EhWh4eF
         jBpcRnQNT+63fQ3qFcQkBlPcI2gKm8UkzzQyPJpqVI8lJKfnysfuVq6s2UPNiQjcSte+
         7d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688498639; x=1691090639;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ASsGYOng07s9S4R45sQeSWvCiCV/AlyMkiOdysFSdc=;
        b=A9OyEP5KvzvA9nx0d6iUDF4nkCZxBEOweHyMlJOHzbXTmBn4bw0xDDDj2ChU4a6DkJ
         RzKmPFVwP0Y/WYEZwhWXgSEOtu/qFG/w8zf9Ewg6p3tkgN50S4XhjPEVFpbN/tsdC7b7
         SU8DuqHOeCbMomNV7kBBsG3wfOeieszxty8wa/mD7HZGFJOexhc1FCj8A5gX2bPsd8mW
         GcTKAIduIzN8ovS6+qMWjBCz02JyUw0JhYd3RHXmsWEdnj0xdF95yi9epjnFjI34Ur0z
         2srXjXKizMgldZdB9nfKPEMOIPr7Mn563+ywEbEBAvsTNR54xaPG2/6AfGb7rHIhDCZc
         DC+A==
X-Gm-Message-State: ABy/qLZ0ekpmFKQQPk7vwonK46WjF8S83lWGAiRvuMxXVQlVVu+H/trg
	EQQ5veU74PB9m8Y8dX0tyY30ko0pmgJkoZiXH5ql2Q==
X-Google-Smtp-Source: APBJJlH9bfgCwvTQK65e0QBLpG2ltnzz52dPV6bA4GdN1zRdikpbsDB1QLimTgM9bQvYJF3xbfztew==
X-Received: by 2002:a17:906:dc94:b0:98e:3dac:6260 with SMTP id cs20-20020a170906dc9400b0098e3dac6260mr217708ejc.13.1688498638924;
        Tue, 04 Jul 2023 12:23:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7acd:ebd4:27c4:aac4? ([2a02:578:8593:1200:7acd:ebd4:27c4:aac4])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906831200b0098733a40bb7sm13659902ejx.155.2023.07.04.12.23.58
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 12:23:58 -0700 (PDT)
Message-ID: <bfdfac16-b83c-7ef2-bf98-511501470d74@tessares.net>
Date: Tue, 4 Jul 2023 21:23:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: fix 32-bit
 support
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 04/07/2023 18:21, Matthieu Baerts wrote:
> When using pm_nl_ctl to validate userspace path-manager's behaviours, it
> was failing on 32-bit architectures ~half of the time.
> 
> pm_nl_ctl was not reporting any error but the command was not doing what
> it was expected to do. As a result, the expected linked event was not
> triggered after and the test failed.
> 
> This is due to the fact the token given in argument to the application
> was parsed as an integer with atoi(): in a 32-bit arch, if the number
> was bigger than INT_MAX, 2147483647 was used instead.
> 
> This can simply be fixed by using strtoul() instead of atoi().
> 
> The errors have been seen "by change" when manually looking at the
> results from LKFT.

The fix looks simple enough. I suggest to apply it to be able to send it
with others to netdev, hoping to have it backported "soon" so I don't
forget to check if there are other errors in LKFT results :)

I also added the simple fix for the selftests' config.

So now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 1e277517c902: selftests: mptcp: depend on SYN_COOKIES
- ad1a75f2c761: selftests: mptcp: pm_nl_ctl: fix 32-bit support
- Results: 8e89661e0490..cec2abcca31c (export-net)
- Results: a8188147cc02..c44a30e46e17 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230704T191805
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230704T191805

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
