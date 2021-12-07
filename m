Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D022C9D
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 18:34:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237597943"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237597943"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 10:18:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="605818553"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.212.226.172])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 10:18:44 -0800
Date: Tue, 7 Dec 2021 10:18:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint
 still available for each msk
In-Reply-To: <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
Message-ID: <983be82e-7d50-4618-2773-be94d9f428b8@linux.intel.com>
References: <cover.1638544716.git.pabeni@redhat.com>  <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>  <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>  <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
 <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 7 Dec 2021, Paolo Abeni wrote:

> On Mon, 2021-12-06 at 11:18 +0100, Paolo Abeni wrote:
>> On Fri, 2021-12-03 at 17:05 -0800, Mat Martineau wrote:
>>> On Fri, 3 Dec 2021, Paolo Abeni wrote:
>>>
>>>> Include into the path manager status a bitmap tracking the list
>>>> of local endpoints still available - not yet used - for the
>>>> relavant mptcp socket.
>>>> Keep such map updated at endpoint creation/deleteion time, so
>>>> that we can easily skip already used endpoint at local address
>>>> selection time.
>>>> This allows for fair local endpoints usage in case of subflow
>>>> failure.
>>>>
>>>> As a side effect, this patch also enforces that each endpoint
>>>> is used at most once for each mptcp connection.
>>>
>>> This seems like a significant change, possibly with unexpected
>>> consequences (but maybe I've misunderstood the new constraint?).
>>> Apparently the topoligies in our self tests happen to work fine!
>>
>> Uhmmm... probably less then it may looks like. We already respected the
>> above constraint in almost every scenarios. AFAICS, the only exception
>> prior to this patch was following scenario:
>>
>> 1) subflow is established endpoint A
>>
>> 2) the peer closes the additional subflow
>>
>> 2) a new local endpoint B is created
>>
>> 3) the PM will create the 2nd subflow using again endpoint A.
>>
>> which is arguibly unexpected, as reported by issues/242.
>>
>>> If you have peer A with one interface and peer B with two, it seems like
>>> this should be allowed:
>>>
>>> Peer A connects to Peer B endpoint 0
>>> Peer B announces endpoint 1
>>> Peer A sends an MP_JOIN to Peer B interface 1
>>>
>>> From the description above, it sounds like peer A would not be able to
>>> create that second subflow.
>>
>> Well, AFAICS the peer A will actually create the subflow, if the limits
>> allow that, both with or without this patch.
>> Specifically:
>>
>> 1) no endpoint configured, add_addr_accepted >=1, subflows >=1 on peer
>> A -> the subflow to peer be interface 1 will be created (with or
>> without this patch) because we don't have any other additional
>> constraint beyond the limits.
>>
>> 2) endpoint configured on peer A matching the MPC subflow source
>> address -> again the subflow towards peer B endpoint 1 will be created,
>> because that will be the first time the PM will use the peer A
>> endpoint.
>
> Thinking again about this last scenario, I think there is something to
> improve:
>
> if peer A connects to peer B using the local endpoint address, it can
> later use again such address for additional sublflows, as the MPC
> subflow is no accounted by the current version of this patch. I'll cook
> a v5 adding such account, too - and possibly a related self-tests
>

Thanks Paolo, that will help.

My main concern is what happens when the bitmap fills up. While 
__mptcp_subflow_connect() can still be called from 
mptcp_pm_nl_add_addr_received() (so, you're right, we can still create 
multiple outgoing connections this way), it won't be called from 
mptcp_pm_create_subflow_or_signal_addr() because select_local_address() 
will now return NULL. The latter case doesn't seem like expected/desired 
behavior.


--
Mat Martineau
Intel
