Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1B2C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 08:54:36 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id t16so798852eds.9
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UxIcxXNtZRil1ruthp61xq7FXyWauu5TCGaDK844KaA=;
        b=WymFFhWCBJ7lZPSukt3K1k+ZW16irnGn9hX0d3kue3ZGHLYU5S9nXgX80rcElKFhTD
         AmWmnAReGoDhj/jwuCdDRAp3W+vk9xmoVJzFlyf3Vu0VFaq/Qmmbf8y89mEQcP4lvmeT
         5zFp1Q5dHX7stgmFnMXUV+HXDpjbou9vSwN8jRfxuAbJVdXA6HGhXxfnlQ/xuIDFnC7A
         p7VB1I8ccVUhUN5iTxXnoZaJMYBWxTjXrbHKVcPjXKj7qk17/wCKmnGNOM9XKVsPYsCw
         IhdvFhLaDdDxJUTreZCwQKQ3VI2hs3A+GKloDuyjWSxEWQAoL4yEzuR9c3sMC5LXb93p
         4d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UxIcxXNtZRil1ruthp61xq7FXyWauu5TCGaDK844KaA=;
        b=Lno3sNoYXxeMrbfaosl7jFcawz6KyUyRu2qNRZxSKlCagLAk13zZ+o27DgRwSUyN7R
         1eAnCtgx+72vFZdYo377wGTVj7QXuF6GV8P2tEU1jlpOsewRDmPWXXB+dZx3uSdUJVeM
         TZhJHo0hyj5iQX+Ly1sBDszgb6lKEAcx3SHM3RyG40HmhD+A8ohbG9sR1dytwyruq8Ph
         Ro76QOreAycAklq2APKwbw9Xf2f/RFh5tNkEFsQL4mO0NI53M3cQ5jrqTpXSiPD8RKX8
         S84i8BoLNRBX9wRvGVUTgMubueMc6kAMJg+Ph8rrCihyeoS5+PHkt6rQK6SJ3yVqs2dX
         SXmQ==
X-Gm-Message-State: AOAM533AY1sTdXfd+9mQdfCAWHLm5GlNT4rBsRqwbWi5LZqwoNbFXyfH
	wgsdYn76F7Kct1O4pMBMFmlHBMBjdqGQFXMBLqA=
X-Google-Smtp-Source: ABdhPJywjiGUGqSqaTXgYhcJKTYCgAjnK8Ra+9j83kkW95mr0NNXTCAHlv22Qvg+I76PcCRn4LGgHA==
X-Received: by 2002:a17:906:b796:: with SMTP id dt22mr5943593ejb.456.1634806474699;
        Thu, 21 Oct 2021 01:54:34 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o3sm2146596eju.123.2021.10.21.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:54:34 -0700 (PDT)
Message-ID: <a4e38a35-8839-0827-498c-44ab1b724c83@tessares.net>
Date: Thu, 21 Oct 2021 10:54:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
 <1050afc1272cfbc66e91e653ef66462963436c0d.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1050afc1272cfbc66e91e653ef66462963436c0d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/10/2021 19:43, Paolo Abeni wrote:
> On Fri, 2021-10-15 at 17:12 -0700, Mat Martineau wrote:
>> On Fri, 15 Oct 2021, Paolo Abeni wrote:
>>
>>> Currently the simult_flows.sh self-tests are not very
>>> stables, expecially when running on slow VM.
>>>
>>> The tests mesures runtime for transfers on multiple subflows
>>> and check that the time is nearby the theoretical maximum.
>>>
>>> The current test infra introduces a bit of jitter in test
>>> runtime, due to multiple explicit delays. Additionally the
>>> runtime is measured by the shell script wrapper. On slow
>>> VM, the script overhead is measurable and subject to relevant
>>> jitter.
>>>
>>> One solution to make the test more stable would be adding more
>>> slack to the expected time; that could possibly hide reall
>>> regressions. Instead move the measurement inside the command
>>> doint the transfer, and drop most unneeded sleep.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> @matttbe: could you please double check this makes simult_flows
>>> tests really more stable in your testbed?
>>>
>>> Now the slack is really quite tight, I think we can raise it a
>>> little more, without loosing the ability of catching regressions
>>
>> I still get occasional failures on my slow desktop VM (lots of debug 
>> features turned on), but a little more slack would help. Most of the time 
>> all cases succeed. If I see a failure, it's just one test out of the 
>> batch. These are each from separate runs of simult_flows.sh:
>>
>> unbalanced bwidth                                           transfer slower than expected! runtime 4500 ms, expected 4005 ms max 4005        [ fail ]
>>
>>
>> unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 4632 ms, expected 4005 ms max 4005        [ fail ]
> 
> Let me elaborate a bit more here.
> 
> Before this patch, I observed 2 different kind of failures:
> 
> - off by few ms. The root cause was the jitter introduced by the
> VM/scripts/tests env. That should be resolved now.

Should we already apply your RFC patch in the export branch then?

> - off by a few hundred ms. The root cause is a little more uncertain,
> but I think it's due to HoL blocking for the faster subflow. I observe
> this kind of failure only when the subflows have different speeds.
> 
> Looking at the pcap traces with wireshark, and doing the time-sequence
> stream graph (Stevens), the slower subflow has a pretty much constant
> slope, while the faster one has some smallish periods with a lower
> slope.
> 
> I'm experimenting a patch doing HoL blocking estimation in a similar
> way to blest. It looks like it improves the situation, but I need do to
>  more experiments.

Thank you for looking at that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
