Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B71846
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667520282; x=1699056282;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HGNkPaH99ocZyu81yFc2FPY2nBQgWqSCFYadtc+xI6g=;
  b=Ld9B1GZ4ri54GDsn26K+QxDHVQwSn3p4baua7EGJnJfT5DCOR/YFCa4/
   uqt2ccO2AuyOjHwZUsIWYJsybQUSStn+IChp2/VpzsOofJo7bMwGt6ncS
   GIq/wFik0sPPbJsmB8s0hJuhsLEj03i2sdETi0y/rv0mPEo7sVxBcv2u0
   GTNf7YHZjH7oEseywojPXRNqNUpszBUk4IzP6f+JyWLNLzvOUlC+Rm3EB
   5jt0dw+lHQWse3PJZWptx9A8rALq/hzsCRfzABHlACYDEQxH7LuK6C6xV
   PfMQm64DrAiMItply9kPqUxYH74vHWS1ZNT7bbc5STClfSeaPas5lxlrn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311572105"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="311572105"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:04:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760137651"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="760137651"
Received: from saisiddh-mobl1.amr.corp.intel.com ([10.209.49.248])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:04:19 -0700
Date: Thu, 3 Nov 2022 17:04:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Menglong Dong <imagedong@tencent.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
In-Reply-To: <e0768153-ee97-f0f6-4b17-49ee02a4d3f0@tessares.net>
Message-ID: <2db2587f-987b-c720-bd21-aaa09c0aedb7@linux.intel.com>
References: <20221103110649.299284-5-imagedong@tencent.com> <20c04c0d-8110-535b-0ce9-65eca5bda725@gmail.com> <e0768153-ee97-f0f6-4b17-49ee02a4d3f0@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-973917123-1667520259=:40204"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-973917123-1667520259=:40204
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 3 Nov 2022, Matthieu Baerts wrote:

> Hi Menglong,
>
> Thank you for the v6!
>
> It looks like the CI is not happy with it:
>
> On 03/11/2022 14:21, MPTCP CI wrote:
>> Hi Menglong,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal:
>>   - Success! ✅:
>>   - Task: https://cirrus-ci.com/task/4909154062565376
>>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4909154062565376/summary/summary.txt
>>
>> - KVM Validation: debug:
>>   - Unstable: 1 failed test(s): selftest_diag 🔴:
>>   - Task: https://cirrus-ci.com/task/6035053969408000
>>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6035053969408000/summary/summary.txt
>
> As you can see:
>
> ----------------------------
> (...)
> # all listen sockets                                [  ok  ]
> # after MPC handshake                               [  ok  ]
> # ....chk remote_key                                [  ok  ]
> # ....chk no fallback                               [  ok  ]
> # chk 2 msk in use                                  [  ok  ]
> # chk 0 msk in use after flush                      [  ok  ]
> # check fallback                                    [  ok  ]
> # many msk socket present                           [ fail ] timeout
> while expecting 200 max 201 last 1
> # chk many msk in use                               [ fail ] expected
> 200 found 0
> # chk 0 msk in use after flush                      [  ok  ]
> ----------------------------
>
> I guess one socket is still present after the 'check fallback': you
> probably need to modify flush_pids() to wait for the processes to be
> over, as suggested on a comment in your v5, no?
>
> https://lore.kernel.org/all/b3f3c01e-4010-d5ce-970d-394711bcd0e1@tessares.net/
>
> I don't think it is a good idea to wait for >= 200 except if it takes a
> very long time to have the previous socket terminated. If it does, maybe
> we should re-order the test or re-create the netns instead of re-using it.
>
>
> About the patch 3/4, note that the SIGUSR1 is probably stopping the test
> earlier than expected because the interrupt will cause some actions to
> stop but still good to check for the 'quit' variable.
>
>
> Also, one small detail for patch 4/4: can you add "...." at the
> beginning of the new lines you print in the selftest, similar to
> "....chk no fallback"?
>

Menglong -

Thanks for the updated patches. The test ran ok on my local system, but 
the CI is slow on the debug build which makes the timing trickier. I don't 
have anything to add to Matthieu's comments above, seems like his 
suggestions will resolve the CI issue.

--
Mat Martineau
Intel
--0-973917123-1667520259=:40204--
