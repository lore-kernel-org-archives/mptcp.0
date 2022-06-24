Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4129AA
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 15:04:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso2016989wma.2
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=2/7nvv148zKSk394HCCgycs1RtYWchcVhr9gcH88FVE=;
        b=i1gbBjvclNPqWZ9LqmB05MD7GYQJUflrB+sweUfk7hkBNeJqt109fQ/rimnej5gqSO
         6sJcPzFaIXBZigaKOa13PGmtgsGBv0gpY2m1AyZJJ7vKx2tiQ67NZUoaUzKYpEbjETYh
         acFvTPsBMazSFfI4K43X/D/mNdpbl4jBaYxOIOkcfYaLnhOA7WL55BJQEzM/oJr8eIeY
         99AovHMttuLC2YwYRXjIyGdx5aefJ3o1E/C8JBQmqXQiQERz90S2jQs/Ahp3Qps/Rg0b
         ipOA0j3N9GRvDei4LiJESRXlPJtgNJtjq9SfQsknYfDG3iNGsr5WsaoAP7W6vRvubcFD
         CSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=2/7nvv148zKSk394HCCgycs1RtYWchcVhr9gcH88FVE=;
        b=POSjwZSIl375hcAUa09gfPcC+79yeaZQfq9nhd3cIlt7JqHeJ34q2Uq8WM8w7AAx2h
         Fpt+O4BIN20i7GC2rbDns4VZAnvuAJFnl9ktuHk93qOMhprb+RmBf4Zh3W/OZUiFdRS3
         OJmFFaI6CXDWJpX1DypDfOIpoeIwrSgmH16xOVNAv+JFw4d0AHzGMr9rwDmezZ9K2C0u
         TtfeoSj4nOoOYe441KGHlvoCDSL5CfZ1Amk1aBjFGVtfnSq8la5aMT8qwFXCa8dUSdI0
         C0Gt93DsCJf+zs7zVjoTrGn4XS8rAAh5OGhIEpq66l3K//v3oFqmTtUEEwjaj2Gqclkq
         5mQA==
X-Gm-Message-State: AJIora9I1KK4Lta+5SWRsia7IV7pNBKdxPNvLdAIo5B1xylqBFFMbz1O
	q0v/ZHpVp/65JFkdiPtrp7PYuIv7qr4c/w==
X-Google-Smtp-Source: AGRyM1u1Is9zm8XSXCUtPScCdo3+aBAk0HubWPClOsfkum3E2BpvXpyghvOc39pfJPHhYtz+kofS3w==
X-Received: by 2002:a05:600c:1990:b0:39c:81f0:a882 with SMTP id t16-20020a05600c199000b0039c81f0a882mr4454297wmq.72.1656083060114;
        Fri, 24 Jun 2022 08:04:20 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b0021b956da1dcsm2497163wrr.113.2022.06.24.08.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:04:19 -0700 (PDT)
Message-ID: <c2dbb9d3-47a2-aebf-e133-15d6d3c12d0d@tessares.net>
Date: Fri, 24 Jun 2022 17:04:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Should the MIB_RMSUBFLOW commit go to -net?
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <ad151d35-f094-675d-5ced-71df98ea5857@linux.intel.com>
 <437af8add242099c84cf106108ab4988a65010ff.camel@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <437af8add242099c84cf106108ab4988a65010ff.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 24/06/2022 10:40, Paolo Abeni wrote:
> On Thu, 2022-06-23 at 16:19 -0700, Mat Martineau wrote:
>> I was preparing the patches we had agreed to be ready for net-next in the 
>> meeting today:
>>
>>          - [f1eb3f2cb4d2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy (Geliang Tang)
>>          - [f3c5dde10031] selftests: mptcp: userspace pm address tests (Geliang Tang)
>>          - [92378ff55152] selftests: mptcp: userspace pm subflow tests (Geliang Tang)
>>          - [1908a4ccaa2c] selftests: mptcp: avoid Terminated messages in userspace_pm (Geliang Tang)
>>          - [bac5548c7c47] selftests: mptcp: update pm_nl_ctl usage header (Geliang Tang)
>>
>> I think the selftest commits are definitely best for net-next. But for the 
>> first one ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy"), should we add
>>
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
>>
>> and include that in a patch set for -net? Seems like it would be good to 
>> improve the MIB accuracy with the userspace PM in 5.19.
>>
>> Link to commit in patchwork: 
>> https://patchwork.kernel.org/project/mptcp/patch/723d61d82730b996132925686b43f9c3c79bc747.1655355422.git.geliang.tang@suse.com/
>>
>>
>> If that patch goes to -net, it would also require waiting until the next 
>> net/net-next sync before sending the selftest patches listed above.
> 
> I would vote for keeping the process simple and keeping all the above
> patches on net-next.
> 
> If we choose otherwise, I think we should also update a bit the
> ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy") commit message to
> something more tuned for -net. Alike: "The user-space patch manager
> currently miss the required update of the subflow destruction MIB,
> address the issue "...

I think all commits fixing something should have the "Fixes" tag and
target "-net". That's not a must of course depending on the complexity
and what the fix implies. This should simplify stable versions
maintenance somehow if we know all fixes are explicitly linked to a
feature: the stable team can do the backport if they think it makes
sense to do that. We can also avoid messages like: ah yes, in v5.19,
don't look at this MIB counter, it is not correct but that's fixed later
in vX.Y.

But I understand the issue with the sync of -net and net-next.
Could it help to send the conflicting patch in both -net and net-next?
'git merge' might understand the same modification has been done on both
side.

Or explain in the commit message/cover letter there is a conflict with
-net and the fix is not urgent?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
