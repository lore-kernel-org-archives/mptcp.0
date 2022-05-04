Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03633DF
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651705246; x=1683241246;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=HEG4CUPn1xXioS9Vqh2BXiimJbmBTyjQT1n3DgkXdD4=;
  b=d93xZWESGHNMJTExPdKsK8+5E9gQ6yLWDtjC6+zOYkoJzlcHg54d7Gn7
   chXmYr/wkoanM//p2/qVL0swtQYVruSAZ0fLGzuoXoIyFpk2ENHTO918T
   YcDsbc/CLoRObxEyL8zEw2rf45AO7Y+NRURkZyR3mxywbss0XYFdr7hP3
   Ph6lESwMu3X61aSoQeLkAq8CdU1Grv8x0bFxGtdulC1sl/WSXMrt0ki3A
   WDk81DTxFpyVex++aATCXXt0WgpJ1Nvetx+2j9zSO6bn5PhPJsu8CmFSF
   AQ9GeNxmmy4QpVmfxlEVXT9qWQ+uvpmaE8rYgZthkzQ4ysT+b+iJYnPun
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267807600"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267807600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:00:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="568321407"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:00:45 -0700
Date: Wed, 4 May 2022 16:00:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL
 reset testcase" - cleanups
In-Reply-To: <CA+WQbwscUM8LJx=sye_QpNr-GAzgTdDE+NqXAHnvLOHGsvE31g@mail.gmail.com>
Message-ID: <65c6e3d4-795a-17e0-8a2-337da6e6cfac@linux.intel.com>
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com> <20220504121429.GA18870@bogon.HOST> <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com> <CA+WQbwscUM8LJx=sye_QpNr-GAzgTdDE+NqXAHnvLOHGsvE31g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1887405172-1651705127=:21003"
Content-ID: <9845cf-67da-48c1-f129-4bf35cc89943@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1887405172-1651705127=:21003
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <9746493-32bd-6054-4f47-5817d381b8dc@linux.intel.com>

On Wed, 4 May 2022, Geliang Tang wrote:

> Paolo Abeni <pabeni@redhat.com> 于2022年5月4日周三 21:04写道：
>>
>> Hi Geliang,
>>
>> On Wed, 2022-05-04 at 20:14 +0800, Geliang Tang wrote:
>>> On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
>>>> Two small cleanups for MP_FAIL reset test case:
>>>>
>>>> Reduce the test files size from 1024 to 128, to make the test faster.
>>>
>>> The original commit log needs to update too:
>>>
>>>  1024KB -> 128KB
>>>
>>> '''
>>> Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
>>> reset case. Use the test_linkfail value to make 128KB test files.
>>>
>>> ...
>>> ...
>>> '''
>>>
>>>> With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.
>>>>
>>>> Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
>>>> extra checksum failures now, no need to add '+'s anymore.
>>>>
>>>> Depends on Paolo's commits:
>>>> [1] net/sched: act_pedit: really ensure the skb is writable
>>>> [2] selftests: mptcp: fix MP_FAIL test-case
>>>>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>
>> I noticed the the time increase. Unfortunatelly, it may be necessary to
>> be reliable in all environment, comprising the slowers one.
>>
>> Mat (M.) was able to reproduce some failure with b/w == 10Mbps and size
>> == 1M. I think/guess he could hit the same failure even with 1Mbps and
>> size == 128K.
>>
>> We need at least some additional testing for this one.
>
> If so, let's continue to use 1024k test file sizes.
>

It's reliable for me at 128k so far. I'm fine with squashing the patch 
as-is, we can increase the file size if CI (or humans) complain.

--
Mat Martineau
Intel
--0-1887405172-1651705127=:21003--
