Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1424F4F
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 17:34:59 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id d9so2669504wrm.13
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooufSPGVDziMNTcgIDfI9GwXEmLX2uSOI+99ywk9m1E=;
        b=jbEu7wcgvXaOlox97FF395YQ5C5iJnthpJTyHqaT2XaOCanZWd2ekZatw1W+0i5WDZ
         nvsyMG/Io0YcjAU1tor8EpqBZmLh/naQQHGkSqA4cPM0or+5whnIaErJ+Nw0/xAvpLQ3
         gpIKiofyH+7ej09D3oAqoABuRVxx3YyRoy8cNtF6t46yW4gIjqV2L6GlA/bOh+2AIOdd
         N50jPbmYs4I2VYeDRX2NavNr473Pgv8kuMa0cm4QM235wOuPIS7D9tK7uw1gtTHRNKWd
         aJThqwTb+9Wnchsm6N0MnYXRe9YZlPJ0AnKfApsBtqO30CXrQKorvNDGqLo5BQtVxONr
         y5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooufSPGVDziMNTcgIDfI9GwXEmLX2uSOI+99ywk9m1E=;
        b=WbJgq1HTx4P6Q5ReZsOFPrjTW9TnMKYDF4Vpedn99fknlkoFHrFH+9imm01+nomlI2
         RqB21lO9eXEsqjo04pCCa2tKQ/fANAZLTFo3gOUK5ZT/4/ut1K090I9JJsAY8UZGDlE7
         luA1kU4pG5EmZroYkm2ViFzU5qaGu3h2XrOmKfDQl/eHgPf8JhuqF5bba9oXKqBxij3W
         bYfsgPEkyyRq9dsOC3nutcToO//De2xMHF2YVw63M4BKxXoEClE9k8YFmhkxOFoDD6FN
         w6khAS4HjS4Av8bR1PYbte0XfBqReuz4uAZsAqonvQ02CQIQcMoZ2vQyuWRbLq130Bjt
         KdUQ==
X-Gm-Message-State: ANoB5pmT/jWo+GupS1KsJrV6Cu51Hfy0N9YHEfRo1EdvPjfPofNIHHFe
	qa5mjdzBV2vM0rLGVdKMNMGSLqjeeuZZxxMOa7E=
X-Google-Smtp-Source: AA0mqf5ro6OYu1yugQJP1swE2qJUCtID3cq/tEfrC/Yu8Nadk5obV2BZzGN1dJJENt6T8sUXHLXvfw==
X-Received: by 2002:adf:f502:0:b0:238:c1d5:3293 with SMTP id q2-20020adff502000000b00238c1d53293mr1854007wro.446.1668188097513;
        Fri, 11 Nov 2022 09:34:57 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:3b3c:e57d:4c0a:213e? ([2a02:578:8593:1200:3b3c:e57d:4c0a:213e])
        by smtp.gmail.com with ESMTPSA id s13-20020adfea8d000000b00228d67db06esm2452751wrm.21.2022.11.11.09.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:57 -0800 (PST)
Message-ID: <d4843f73-8298-57bb-59ba-8debad6db7bb@tessares.net>
Date: Fri, 11 Nov 2022 18:34:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix mibit vs mbit mix up
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
 <b7b6bf8e-0db9-4573-b8e8-9b7e26a6dd2e@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b7b6bf8e-0db9-4573-b8e8-9b7e26a6dd2e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 11/11/2022 02:13, Mat Martineau wrote:
> On Thu, 10 Nov 2022, Matthieu Baerts wrote:
> 
>> The estimated time was supposing the rate was expressed in mibit
>> (bit * 1024^2) but it is in mbit (bit * 1000^2).
>>
>> This makes the threshold higher but in a more realistic way to avoid
>> false positives reported by CI instances.
>>
>> Before this patch, the thresholds were at 7561/4005ms and now they are
>> at 7906/4178ms.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/310
>> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Looks good to me, if you can make one small adjustment when applying!
> (see below)
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
>> ---
>> tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> index af70c14e0bf9..34362c4644ff 100755
>> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> @@ -249,7 +249,8 @@ run_test()
>>
>>     # time is measured in ms, account for transfer size, affegated
>> link speed
>                                                              ^^^^^^^^^
> Think this is supposed to be "aggregated"? Might as well fix.

Good point, I didn't even notice the typo before, I must have the
auto-correction on! :)

Thank you for the review!

Now applied in our tree (fix for -net) with the suggested fix:

New patches for t/upstream-net and t/upstream:
- 1e7c2317154b: selftests: mptcp: fix mibit vs mbit mix up
- Results: 4bc0063504d3..a89943a1df52 (export-net)
- Results: e33b4398ef80..bd41b66dc9e6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221111T173159
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221111T173159

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
