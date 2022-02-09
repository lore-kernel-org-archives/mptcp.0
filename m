Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B22F24
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 11:13:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id y3so6322679ejf.2
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 03:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DRZIxE5XETD/h9UNkF8zcSXAymQJGsVNXh9MsovDmM8=;
        b=UDpgsvOu/wPCJyaHIC2Pm4QRBUQy4W+uFnVTQYpMkvKy6Do/rpnkn53XCJzoxHkE9h
         ihf2jVcGZB4LfLxGNzsoKCo6H6blh6f6XluR3pg7gzw2Rfa36X6ZE6gijfxfh+mN73Uq
         ax4Qolq02SlG19q5ORKWv1KP3hHA/1+PeStpe2Ultn1Hpuv5gKys6QL+FMRgOf1dCjAl
         ld/YTgObyh/2xw+CudppNUBBphzUM2FgSFtlfIAzmPOvJC9yR+LXV0tY//JWfXrYh3aV
         iQlZUO/ptv2X21dIz6Q+Fag+y54J5xBVE096LEebZd25mnjR2ulh8FnWXCXZQTF/Ngyn
         vYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DRZIxE5XETD/h9UNkF8zcSXAymQJGsVNXh9MsovDmM8=;
        b=YzeCuXUxAiaP3IN/0OZ35UshhisD9yvMUdk2K+EaP5i867ZEHOT1nzlJz2C1h/Z1rn
         u3aNYCkc2o1qVYltfrA++XLcpgpxI5i57IV3MTDa5hOCKpLNQSmw1tbo/5IE4uCYBNq5
         so1QmqsSa1uO7YbdwkGJwUsDuHL4AVSFXekBCL+tenrIYF8GBBwJ2cSLKcfUXka8xoYV
         cY3MUi9m3nRfqnHWoAqF58kgVWcJRp+Zd4J3CgA6ljb3JvEc2u2J3yz1BTUxC8T1cyXP
         d9bbrC4gHe8dqjx2vv7dkpfu9EMOROvWVy7Cj5wNMQOow5O1X3Sdrp5As9CtHtcpzwGP
         9tJg==
X-Gm-Message-State: AOAM533H0PnUtL8D20HRMbc797KV+qGorQnCrSw19DIYsnj0Kycjlsh9
	XY8reMjg4E1jt8GAOL53Fw6cMEJoj4Ee7A==
X-Google-Smtp-Source: ABdhPJyEe/R4tQ7movugpka8wssD6urwGgZqbN1ft9JaTDkkcYOGIHdZSQ1DPc1TakPTPGFLreNmUw==
X-Received: by 2002:a17:907:3f93:: with SMTP id hr19mr1465761ejc.594.1644405180996;
        Wed, 09 Feb 2022 03:13:00 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:268e:dc63:f3ef:de99? ([2a02:578:8593:1200:268e:dc63:f3ef:de99])
        by smtp.gmail.com with ESMTPSA id v23sm5997721ejy.177.2022.02.09.03.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 03:13:00 -0800 (PST)
Message-ID: <79b19fe9-e576-c4fe-82bb-cb2ca88e1e4e@tessares.net>
Date: Wed, 9 Feb 2022 12:13:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v4 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644396927.git.geliang.tang@suse.com>
 <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
 <55e50da5-25ec-3a66-6264-10d712c5ba6e@tessares.net>
 <20220209105521.GA26714@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220209105521.GA26714@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 11:55, Geliang Tang wrote:
> On Wed, Feb 09, 2022 at 10:23:52AM +0100, Matthieu Baerts wrote:
>> On 09/02/2022 09:57, Geliang Tang wrote:
>>> +fail_tests()
>>> +{
>>> +	# multiple subflows
>>> +	reset_with_fail 2
>>> +	pm_nl_set_limits $ns1 0 2
>>> +	pm_nl_set_limits $ns2 0 2
>>> +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
>>> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
>>> +	run_tests $ns1 $ns2 10.0.1.1 3
>>> +	pedit_action_happened 2
>>> +	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 \
>>> +		$pedit_action $pedit_action
>>
>> Related to my comment in the v2: we should not use $pedit_action in the
>> args we need to verify I think. Instead we should probably then have:
>>
>>   chk_join_nr "(...)" 2 2 2 1 1
> 
> Thanks for your review and suggestions. I updated them in v5.
> 
> We will get this failure in v5 in rare cases, about one percent
> probability

Do you know why?

We invert a byte so it should always cause an issue, no? (we can always
have 2 same hashes for two different sources but it is a very very rare
case we don't have to consider I think, especially when the content is
so close, no?)

Or maybe we need to improve the IPTables and TC rules?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
