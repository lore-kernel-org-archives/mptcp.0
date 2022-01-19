Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBB29CA
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642619999; x=1674155999;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=86FlUxmaASiW82Teo8PXrw/Socjn0dorcRsxY5hkbAI=;
  b=oFrKzQ6W9iOsunpuad5ISxA4JSKnruPn6nMqyPOmt+9C2aZGEzmvLiER
   Y94NCOs3N1eAwvT6MaGKQoLhrFU7Ax7dkVlQPhX7aW9QrO4/4kdwP3Eki
   Uwnu1CObHrvCBYzNMrV9mivc+EJtMtPyl06TPT/ZyY0V8dkWEcqgyhTzs
   dMs0Bm3H0Mj3OM0ma4a2NF4aKI5GWSui5pNkMlcp46I0Tb3fIRAOadPKF
   RdhX15VIBZXuAeWYxzV2M3QALUPcpuSJKvPR1Y1Nvzr/ErUVD7x0wCW6x
   NYDtp5UPNippxT9lYK5kOdKZlkmUG4n1IZ4tZdrsPC0KVTldDWFAwgX8Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308503329"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="308503329"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:59:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="493140468"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:59:18 -0800
Date: Wed, 19 Jan 2022 10:59:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from either
 end of connection
In-Reply-To: <d6eb3faa-0838-58c9-8203-a7531d9cd620@intel.com>
Message-ID: <cd2c356-4bd-e954-5c64-e5ffca397337@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com> <20220112221523.1829397-5-kishen.maloor@intel.com> <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com> <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com> <d3b555e1-752a-e125-1654-3d8cbdd20e4a@intel.com>
 <f161df56e10f36dc27403586793c367b29eb7066.camel@redhat.com> <d6eb3faa-0838-58c9-8203-a7531d9cd620@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Jan 2022, Kishen Maloor wrote:

> On 1/19/22 4:01 AM, Paolo Abeni wrote:
>> On Tue, 2022-01-18 at 17:26 -0800, Kishen Maloor wrote:
>>> On 1/17/22 12:59 AM, Paolo Abeni wrote:
>>>> On Fri, 2022-01-14 at 14:43 -0800, Mat Martineau wrote:
>>>>> On Wed, 12 Jan 2022, Kishen Maloor wrote:
>>>>>
>>>>>> This change updates internal logic to permit subflows to be
>>>>>> established from either the client or server ends of MPTCP
>>>>>> connections. This symmetry and added flexibility may be
>>>>>> harnessed by PM implementations running on either end in
>>>>>> creating new subflows.
>>>>>>
>>>>>> The essence of this change lies in not relying on the
>>>>>> "server_side" flag (which continues to be available if needed).
>>>>>>
>>>>>
>>>>> After this patch, server_side is unused except for some debug output. If
>>>>> it's really no longer referenced (see below first), may be better to just
>>>>> remove it.
>>>
>>> I think we'll need it.
>>>
>>> One possible use is to inform the PM daemon of the type of application
>>> (client/server) associated with a connection.
>>>
>>> As we're discussing the idea of creating listening sockets only upon request, the
>>> knowledge that we are on the client end of a connection is something a PM daemon could
>>> use to request creation of listening sockets whenever it advertises an address.
>>>

Ok, makes sense.

>>>>>
>>>>>> v2: check for 3rd ACK retransmission only on passive side
>>>>>> of the MPJ handshake
>>>>>>
>>>>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>>>>> ---
>>>>>> net/mptcp/options.c  | 2 +-
>>>>>> net/mptcp/protocol.c | 5 +----
>>>>>> net/mptcp/protocol.h | 2 --
>>>>>> 3 files changed, 2 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>>> index cceba8c7806d..89808816db06 100644
>>>>>> --- a/net/mptcp/options.c
>>>>>> +++ b/net/mptcp/options.c
>>>>>> @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>>>> 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
>>>>>> 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
>>>>>> 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
>>>>>> -		    READ_ONCE(msk->pm.server_side))
>>>>>> +		    !subflow->request_join)
>>>>>> 			tcp_send_ack(ssk);
>>>>>> 		goto fully_established;
>>>>>> 	}
>>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>>> index 4012f844eec1..408a05bff633 100644
>>>>>> --- a/net/mptcp/protocol.c
>>>>>> +++ b/net/mptcp/protocol.c
>>>>>> @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
>>>>>> 		return false;
>>>>>> 	}
>>>>>>
>>>>>> -	if (!msk->pm.server_side)
>>>>>> +	if (!list_empty(&subflow->node))
>>>>>> 		goto out;
>>>>>>
>>>>>> 	if (!mptcp_pm_allow_new_subflow(msk))
>>>>>> 		goto err_prohibited;
>>>>>>
>>>>>> -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
>>>>>> -		goto err_prohibited;
>>>>>> -
>>>>>> 	/* active connections are already on conn_list.
>>>>>> 	 * If we can't acquire msk socket lock here, let the release callback
>>>>>> 	 * handle it
>>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>>>> index e2a67d3469f6..c50247673c7e 100644
>>>>>> --- a/net/mptcp/protocol.h
>>>>>> +++ b/net/mptcp/protocol.h
>>>>>> @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
>>>>>> static inline bool subflow_simultaneous_connect(struct sock *sk)
>>>>>> {
>>>>>> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>>>>> -	struct sock *parent = subflow->conn;
>>>>>>
>>>>>> 	return sk->sk_state == TCP_ESTABLISHED &&
>>>>>> -	       !mptcp_sk(parent)->pm.server_side &&
>>>>>> 	       !subflow->conn_finished;
>>>>>> }
>>>>>
>>>>> Are changes in this function needed? This code was added to address
>>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/35
>>>>> which was a weird case encountered with syzkaller where a socket tried to
>>>>> connect to itself, triggering the "simultaneous open" code path. It
>>>>> doesn't seem to be applicable to MP_JOINs.
>>>>
>>>> I *think* we can reach here even with MPJ, e.g. if we have port-based
>>>> endpoint matching the src address/port - possibly syzkaller could be
>>>> able to reach such scenario.
>>>>
>>>> Additionally I fear dropping the '!mptcp_sk(parent)->pm.server_side &&'
>>>> check could re-introduce the initial issue, at least for the MPC
>>>> handshake.
>>>
>>> The purpose of this commit is to permit the MPJ sequence to happen at either end of
>>> the connection. The change in mptcp_finish_join() had the most direct impact for enabling
>>> this, so I looked at other server_side checks mostly in terms of establishing that
>>> bi-directional symmetry.
>>>
>>> If the above condition holds only with MPCs, i.e. for the initial connection, then I think it would
>>> be fine to preserve the server_side check. But if it also holds for MPJs, then we might
>>> have to account for both cases. Perhaps replace:
>>>
>>> !mptcp_sk(parent)->pm.server_side)
>>>
>>> with something like this?
>>>
>>> ((subflow->request_mptcp && !mptcp_sk(parent)->pm.server_side) ||
>>> 	subflow->request_join)
>>
>> It looks like 'request_mptcp' is 0 on passive sockets, so:
>>
>>  	subflow->request_mptcp || subflow->request_join
>>
>> should suffice.
>
> That's right. Makes sense.
>

Yeah, good to simplify this even if 'pm.server_side' is still around.

>>
>> Possibly factoring out an helper for the above condition would make the
>> code more readable.
>
> Thanks! Will do so.
>



--
Mat Martineau
Intel
