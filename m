Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED622FAF
	for <mptcp@lists.linux.dev>; Sat, 14 Aug 2021 00:37:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="237696630"
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="237696630"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 17:37:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="639950504"
Received: from varunjai-mobl.amr.corp.intel.com ([10.209.34.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 17:37:03 -0700
Date: Fri, 13 Aug 2021 17:37:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: full fully established support after
 ADD_ADDR
In-Reply-To: <5b996b3fc540926a129c2f0c45634def94074f01.camel@redhat.com>
Message-ID: <33124a29-dadf-4c5a-d141-7e2be538e5d4@linux.intel.com>
References: <20210812162757.282366-1-matthieu.baerts@tessares.net>  <cb97b91e-99d-d7b-4338-a83ddba4e83b@linux.intel.com>  <e8ce0aa4-c8a5-8907-396e-be420aec6fe4@tessares.net> <5b996b3fc540926a129c2f0c45634def94074f01.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 13 Aug 2021, Paolo Abeni wrote:

> On Fri, 2021-08-13 at 13:06 +0200, Matthieu Baerts wrote:
>> Hi Mat,
>>
>> Thank you for your review!
>>
>> On 13/08/2021 00:30, Mat Martineau wrote:
>>> On Thu, 12 Aug 2021, Matthieu Baerts wrote:
>>>
>>>> If directly after an MP_CAPABLE 3WHS, the client receives a valid
>>>> ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
>>>> are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
>>>> the client and server keys.
>>>
>>> The ADD_ADDR HMAC is validated after the call to
>>> check_fully_established(), so I'm not sure this condition is fully met
>>> with the patch as-is. Looks like an ADD_ADDR with a bad HMAC could
>>> change the fully_established flag when it shouldn't.
>> That's a very good point.
>>
>> If I'm not mistaken, we have the same issue when receiving a DATA_ACK:
>> here we just check if one is present, not if it is valid, no?
>>

I see Matthieu's point about validity vs. presence when using the ADD_ADDR 
here. Maybe we had different ideas in our minds with "valid" meaning "a 
properly formatted ADD_ADDR option w/ HMAC" vs. "an ADD_ADDR with 
validated HMAC".

An invalid HMAC would be like an out-of-window DATA_ACK, so we're not 
creating a new problem if the connection becomes "fully established" due 
to an ADD_ADDR with a bad HMAC.


So, if only the presence of the HMAC is important:

* the patch should check for (mp_opt->add_addr && !mp_opt->echo) to ensure 
the HMAC is present

* commit message and code comments should refer to ADD_ADDR w/ HMAC being 
"present" rather than "valid"?


>> Should we delay when we mark subflows and msks as "fully established" or
>> is it not an issue to be in "fully established" too soon?
>
> I *think* we could/should start with this simpler implementation/fix -
> eventually adding a comment explaining the problematic scenario.
>

I basically agree, with the tweaks above.

> A more correct state handling requires more extensive changes, likely
> too invasive for a resonably timely fix.

We could call add_addr_hmac_valid() from check_fully_established() to do 
an extra HMAC validation *if* it offers any benefit - extra CPU cycles but 
a very small addition to the code.


Thanks,

--
Mat Martineau
Intel
