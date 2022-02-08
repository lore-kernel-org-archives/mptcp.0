Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956B2F27
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644346203; x=1675882203;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i2tyJr2E53rls3kxsJJc4g0M0POJHUCP6zPrY72I0EU=;
  b=jaReOsQV85/R9jscb+g7hL1g6BoODWNO2UcFH7Q+W72KpKZASHCDwsQy
   vI5yWS5RUhFQQhVabfV2xhfL62nM3230FfpFsoSmWY/s7vkIPHUx6NHw8
   lJy0tW303IHlTCNKW7j8wfHRc9M7DOQsszkZZlPRz9y/V9nMlXv4iI9e0
   hDipP7KLsgtyNcGlMZD4QeidXb+AAf0eU3l3f/nU9o0dnLz8YPm6BoUE/
   rGlhh71F4EavPYyEvf5zrbTTgOg+ayusTSfvn7I6DoLcqmse3sZJNCj37
   MZgNgaawuZbH9V01SqmtmXMbJ/ioUDaeWEuTZleWjbPWhEQo3duYuKHLR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273556316"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="273556316"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 10:49:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="700946174"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 10:49:47 -0800
Date: Tue, 8 Feb 2022 10:49:47 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: increase timeout to 20
 minutes
In-Reply-To: <aaf31301-4f25-b08e-6344-c3b837eaba43@tessares.net>
Message-ID: <1af96a3-f56-c473-6b70-79919abaab4@linux.intel.com>
References: <20220208091013.749627-1-matthieu.baerts@tessares.net> <aaf31301-4f25-b08e-6344-c3b837eaba43@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Feb 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 08/02/2022 10:10, Matthieu Baerts wrote:
>> With the increase number of tests, one CI instance, using a debug kernel
>> config and not recent hardware, takes around 10 minutes to execute the
>> slowest MPTCP test: mptcp_join.sh.
>>
>> Even if most CIs don't take that long to execute these tests --
>> typically max 10 minutes to run all selftests -- it will helpi some of
>> them if the timeout is increased.
>>
>> The timeout could be disabled but it is always good to have an extra
>> safeguard, just in case.
>>
>> Please note that on slow public CIs with kernel debug settings, it has
>> been observed it can easily take up to 45 minutes to execute all tests
>> in this very slow environment with other jobs running in parallel.
>> The slowest test, mptcp_join.sh takes ~30 minutes in this case.
>>
>> In such environments, the selftests timeout set in the 'settings' file
>> is disabled because this environment is known as being exceptionnaly
>> slow. It has been decided not to take such exceptional environments into
>> account and set the timeout to 20min.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>     On my CI at Tessares, another machine is now used with a different host
>>     kernel. mptcp_join.sh selftest is now regularly taking more than 10
>>     minutes when testing with a debug kernel.
>>
>>     v2:
>>      - from 1h to 20 min (Mat) and adapt the commit message to explain why
>>        this don't cover all cases that have been observed.
>
> I hope you don't mind if I apply this patch now so my CI stops
> complaining about all modifications of the export branch. I can fix it
> later if needed.

No problem!

>
> - 87dac6279023: selftests: mptcp: increase timeout to 20 minutes
> - ec54f23ec607: tg:msg: fix typo
> - Results: a206ca2f7274..7b9f56739735
>
> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220208T091856
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
>

--
Mat Martineau
Intel
