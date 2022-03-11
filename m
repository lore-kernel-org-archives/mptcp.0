Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C97E
	for <mptcp@lists.linux.dev>; Fri, 11 Mar 2022 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646961374; x=1678497374;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ijDiato2rOaZZ66SHVqBl+lO6xoclfSs/mjZ42GUzAo=;
  b=OBwy6IYHjR4o6eC4aKGs4RISRe0tsvPtuuG+YZGzR8YknEy9k4yvBMxg
   09JxVjBRPzb4eH8fdCKr+sOx0/bwvYFuRoyUqwxKlk1T/FIU3CC3ttvLI
   ZqzkfbmnFYNc8kKDiLovFnW0U78gTcVUOT9wHdXFxP1vHP2iVJYY6mfK3
   DQm7sHnqG5vm+I0QPkWbxFde1shMRol3JNqY0GQ2jmhUk+FVLwI14H28D
   A54rqtZnxufZfJpUGX933yG/tkR6i4xJ6zks1n+jOkSGxL8yDM1ZvP5oX
   QIZGSpRDBdasmErLJYM+JVuF2QrqZImC/lxh7CVoIOCB2bQkMgxltHkZQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255197496"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255197496"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:16:13 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="496556140"
Received: from pschuste-mobl.amr.corp.intel.com ([10.209.118.252])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:16:13 -0800
Date: Thu, 10 Mar 2022 17:16:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
In-Reply-To: <20220309213730.GC26501@breakpoint.cc>
Message-ID: <95ec2750-4d11-9ffc-532-df2e51dc060@linux.intel.com>
References: <20220224155010.23676-1-fw@strlen.de> <20220224155010.23676-4-fw@strlen.de> <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com> <20220308184531.GA22024@breakpoint.cc> <d796fef2-d380-c92a-7516-617992a20460@intel.com> <20220309125351.GB26501@breakpoint.cc>
 <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com> <20220309213730.GC26501@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Mar 2022, Florian Westphal wrote:

> Kishen Maloor <kishen.maloor@intel.com> wrote:
>> On 3/9/22 4:53 AM, Florian Westphal wrote:
>>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>>>> Over a newly established MPTCP connection following listen(s1), the PM can issue an
>>>>>> ADD_ADDR with B. In light of this change there would be no listener created for B.
>>>>>> But if the remote endpoint immediately established a subflow in response (to the
>>>>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>>>>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
>>>>>
>>>>> Why would that fail? You can bind x:y even if there is an established
>>>>> connection from x:y to q:r.
>>>>
>>>> If I establish an MPTCP connection using mptcp_connect individually as
>>>> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's
>>>> addr+port [1]. Why is this the case?
>>>
>>> Whats [1]?
>>> I suspect this patch series needs following addition in patch 3:
>>>
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>> @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
>>>  	if (!tb)
>>>  		return -ENOMEM;
>>>
>>> +	ssock->sk->sk_reuse = 1;
>>> +	ssock->sk->sk_reuseport = 1;
>>>  	inet_csk(ssock->sk)->icsk_bind_hash = tb;
>>>  	return 0;
>>>  }
>>>
>>> After that, follwing sequence should work:
>>>
>>> 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
>>> 2. announce p2
>>> 3. receive join on addr, p2
>>> 4. bind(0.0.0.0, p2)
>>>
>>> 4) should work because sk used for endpoint in 3) has reuse flag set
>>> and is not in listen state.
>>>
>>> cf. include/net/inet_hashtables.h, line 47:
>>> 2) If all sockets have sk->sk_reuse set, and none of them
>>>    TCP_LISTEN state, the port may be shared.
>>>
>>
>> Wouldn't 4) fail if the socket being bound at the time does not have the SO_REUSExxx flag(s) set?
>
> Yes, it needs SO_REUSEADDR set.
>
>> If so, that would be application level thing and in that situation we don't have a way to
>> avoid a race.  Whereas when we require an explicit listener, we could have the kernel take a step
>> back (and not create a listener) to break the race.
>
> Uh, what?  Sorry, I am totally lost.  I have no idea what the problem is
> that we're solving here.
>
> EOD, I am out of ideas.  Feel free to toss this patchset, I have no idea
> what to do.
>

Hi Florian -

After the meeting discussion today, I think we should shelve the pernet 
listeners for now. This series did get us a lot closer to "handle MP_JOINs 
everywhere" behavior, but the corner cases seemed to be pulling us in to 
more TCP changes.

More details: 
https://lore.kernel.org/mptcp/48686ee-4d79-c9fd-35d5-593b9ec9742b@linux.intel.com/


--
Mat Martineau
Intel
