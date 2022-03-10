Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4B7A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646872640; x=1678408640;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K1E7Y+PLEuKNJoe18MvVPlfkrkkBNo4bXnbp5tYI8p8=;
  b=DVDPnilSY82eU14AYGQSotsVkB3zg2oZm0mAHCOTYkcKMtZPS+46ZYeH
   m8FQU+0o6CDI9IL+XC0NbnkTceZYHgzu444l9UxZbX1DJSBqc1Tw918JH
   07nNHiXmLhChwOA3ljSpyS9dulZ26woVq91JqjvpSuUsT2l7X/mf0KMW8
   YbbU4fblyAibRHhzVj1XMrpfekwmyIu9zbw+H1oKxNoKGWpWHhMoq/eCN
   AQWePbPEcGJJL2Kf1/zXua4tqy006RN2NU4nZMuq5VRB1eluu/22wgma2
   Ejzi016aj0v2fFOFCCiI66KEUYmowmYk0OJCtJ5+Dh6XdM4BCDQfQr5mW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235731837"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235731837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:37:19 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513757728"
Received: from amadhuso-mobl2.amr.corp.intel.com ([10.212.252.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:37:18 -0800
Date: Wed, 9 Mar 2022 16:37:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
In-Reply-To: <642225f9-f179-9947-49d1-2ee6ce7cd40c@intel.com>
Message-ID: <aa986cb4-4ba4-7924-d090-d2d615b15649@linux.intel.com>
References: <20220224155010.23676-1-fw@strlen.de> <20220224155010.23676-4-fw@strlen.de> <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com> <20220308184531.GA22024@breakpoint.cc> <d796fef2-d380-c92a-7516-617992a20460@intel.com> <20220309125351.GB26501@breakpoint.cc>
 <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com> <20220309213730.GC26501@breakpoint.cc> <642225f9-f179-9947-49d1-2ee6ce7cd40c@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Mar 2022, Kishen Maloor wrote:

> On 3/9/22 1:37 PM, Florian Westphal wrote:
>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>> On 3/9/22 4:53 AM, Florian Westphal wrote:
>>>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>>>>> Over a newly established MPTCP connection following listen(s1), the PM can issue an
>>>>>>> ADD_ADDR with B. In light of this change there would be no listener created for B.
>>>>>>> But if the remote endpoint immediately established a subflow in response (to the
>>>>>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>>>>>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
>>>>>>
>>>>>> Why would that fail? You can bind x:y even if there is an established
>>>>>> connection from x:y to q:r.
>>>>>
>>>>> If I establish an MPTCP connection using mptcp_connect individually as
>>>>> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's
>>>>> addr+port [1]. Why is this the case?
>>>>
>>>> Whats [1]?
>>>> I suspect this patch series needs following addition in patch 3:
>>>>
>>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>>> --- a/net/mptcp/ctrl.c
>>>> +++ b/net/mptcp/ctrl.c
>>>> @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
>>>>  	if (!tb)
>>>>  		return -ENOMEM;
>>>>
>>>> +	ssock->sk->sk_reuse = 1;
>>>> +	ssock->sk->sk_reuseport = 1;
>>>>  	inet_csk(ssock->sk)->icsk_bind_hash = tb;
>>>>  	return 0;
>>>>  }
>>>>
>>>> After that, follwing sequence should work:
>>>>
>>>> 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
>>>> 2. announce p2
>>>> 3. receive join on addr, p2
>>>> 4. bind(0.0.0.0, p2)
>>>>
>>>> 4) should work because sk used for endpoint in 3) has reuse flag set
>>>> and is not in listen state.
>>>>
>>>> cf. include/net/inet_hashtables.h, line 47:
>>>> 2) If all sockets have sk->sk_reuse set, and none of them
>>>>    TCP_LISTEN state, the port may be shared.
>>>>
>>>
>>> Wouldn't 4) fail if the socket being bound at the time does not have the SO_REUSExxx flag(s) set?
>>
>> Yes, it needs SO_REUSEADDR set.
>>
>>> If so, that would be application level thing and in that situation we don't have a way to
>>> avoid a race.  Whereas when we require an explicit listener, we could have the kernel take a step
>>> back (and not create a listener) to break the race.
>>
>> Uh, what?  Sorry, I am totally lost.  I have no idea what the problem is
>> that we're solving here.
>>
>> EOD, I am out of ideas.  Feel free to toss this patchset, I have no idea
>> what to do.
>
> Sorry, what isn't clear?
>
> This series was meant to address perceived pitfalls of kernel listeners, such as
> race conditions which were discussed. So, I believe we are trying to assess if
> these changes indeed do that, or if anything further needs to be done.
>

Responding to both Kishen and Florian:

I think Kishen's summary here is accurate - the way the current PM code 
uses listening sockets, and the expanded use of listening sockets in the 
userspace PM code, led to some hard-to-troubleshoot situations where 
in-kernel listeners interfered with applications expecting to bind() the 
same addresses / ports.

And I think what Kishen found while testing the userspace PM patches is 
that the "pernet listen socket" approach still has some bind() failure 
corner cases that application programs (and programmers) might find 
surprising, and that the kernel can't solve these cases. In comparison, 
with the in-kernel (explicit) listener sockets, the PM code can see some 
of those failures and work around them to some degree.


> It seems we've thus far identified one change as a result of this conversation to avoid a
> race, i.e. setting the _reuse_ flags inside mptcp_init_join_sk(). Is there anything else to do, or
> are we now confident in these changes?

Kishen, to be sure I'm parsing the above question correctly, "these 
changes" == the "replace per-addr listener sockets" series this email 
thread is part of?

If so, yes I think the reuse flags are part of moving forward with this, 
in addition to what you mention below.

>
> I think the group needs to make a call on our path forward (one way or the other) so that
> we can also progress on other related work.
>
> On a separate note, I brought together my entire userspace PM series and this on a
> tree to test and found a couple of glitches in this patchset. A few userspace
> PM subflows tests would fail due to that. I can respond later on this thread with the
> specific modifications after I clean things up on my end.

We will talk about it again at the 10-March meeting, but it sounds like 
you have some modifications to propose that might be important to consider 
in a final decision. Do the fixes you have to this patchset involve the 
bind() issues above or are they totally separate?


--
Mat Martineau
Intel
