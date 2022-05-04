Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E333DF
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651705356; x=1683241356;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4KxNtIxsA3vtGDk5CEez5Y+ZwIZ+bccpv49nIeq4EDo=;
  b=HEBXgK4OTRhN3nPpaaDw4UyWzFOCaFtm8PvgEaFDY9z2koPIxP6v9wT1
   Pyeoy4NxOlfloWbEHEjNuI71WlNj+QY0V1ZfOX8i51wXwHOITR+FFfwi1
   J5lqKWXYMZOCCSXaw512I9KOcqnpuHFdYsASPDTkZ/r/+naQAU9cD0PSJ
   FAZUcTddRlhbseT4umcKcC1yZX3SYDjem5QPrz6qE0HI0BQAiDOsB3yTj
   LsVRq0mEyijvUNrIDrIGdjnr7yDUdMMCfhwVh5CBa5OYklmfD0nPbJoOl
   DTENQn9ujuoAOOqj5MT3ZhEcrZFNijllev4wsofsrGQzIyF9l7e38y9+1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247832488"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="247832488"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:02:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="568322397"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:02:35 -0700
Date: Wed, 4 May 2022 16:02:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: fix MP_FAIL test-case
In-Reply-To: <CA+WQbwsFFBZ3Xik1VaSKzWu0K+QUG3-v6+jrq0vgasChZnyDjg@mail.gmail.com>
Message-ID: <2e881c7a-7b79-4215-bcda-5b5dd8dc33e@linux.intel.com>
References: <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com> <CA+WQbwsFFBZ3Xik1VaSKzWu0K+QUG3-v6+jrq0vgasChZnyDjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1512375610-1651705354=:21003"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1512375610-1651705354=:21003
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 May 2022, Geliang Tang wrote:

> Hi Paolo,
>
> Thanks for this fix.
>
> Paolo Abeni <pabeni@redhat.com> 于2022年5月4日周三 17:07写道：
>>
>> The mentioned tests sometimes fails because the data
>> transfer completes before any packet is sent on the 2nd
>> link (the failing one).
>>
>> Address the issue reducing the "virtual" b/w available
>> on the primary link.
>>
>> Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
>
> As Mat suggested in v1, this patch is better to squash to "selftests:
> mptcp: add MP_FAIL reset testcase".
>
> I just tested this patch with a 500 times loop, it works very well.
> The test log is attached.
>
> The only difference is that in my test, the test files size is reduced
> to 128K, to make the test faster.
>
> Tested-by: Geliang Tang <geliang.tang@suse.com>
>

Likewise, it's running well for me even with the smaller file size.

Paolo, are you ok with having this squashed in "selftests: mptcp: add 
MP_FAIL reset testcase"?

- Mat

>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>  - slow the transfer even more (Mat)
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index b703b61562bf..c4121a721b54 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -2707,7 +2707,7 @@ fail_tests()
>>
>>         # multiple subflows
>>         if reset_with_fail "MP_FAIL MP_RST" 2; then
>> -               tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
>> +               tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5
>>                 pm_nl_set_limits $ns1 0 1
>>                 pm_nl_set_limits $ns2 0 1
>>                 pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
>> --
>> 2.35.1
>>
>>
>

--
Mat Martineau
Intel
--0-1512375610-1651705354=:21003--
