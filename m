Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1E3FC2
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 17:22:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="220800706"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="220800706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 10:22:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="470627618"
Received: from svuppala-mobl.amr.corp.intel.com ([10.212.165.209])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 10:22:32 -0700
Date: Fri, 10 Sep 2021 10:22:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, 
    Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next v2 3/9] mptcp: add MAPPING_INFINITE mapping
 status
In-Reply-To: <add72c536daafa4fadc76fab88ab437293c163d4.camel@redhat.com>
Message-ID: <901848c-bd52-c78-756c-455a70b44e49@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>   <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com>  <ba53a5abbb43645efa4038eda3abfb8bb386b09b.camel@redhat.com>  <692e5742-1b6c-692d-2927-f0a5aba14ee8@linux.intel.com>
 <add72c536daafa4fadc76fab88ab437293c163d4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 10 Sep 2021, Paolo Abeni wrote:

> On Thu, 2021-09-09 at 17:21 -0700, Mat Martineau wrote:
>> On Thu, 9 Sep 2021, Paolo Abeni wrote:
>>
>>> On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
>>>> From: Geliang Tang <geliangtang@xiaomi.com>
>>>>
>>>> This patch added a new mapping status named MAPPING_INFINITE. If the
>>>> MPTCP_INFINITE_DONE flag is set in get_mapping_status, return this new
>>>> status. And in subflow_check_data_avail, if this status is set, goto the
>>>> 'infinite' lable to fallback.
>>>>
>>>> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
>>>> ---
>>>>  net/mptcp/subflow.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>> index 951aafb6021e..ad8efe56eab6 100644
>>>> --- a/net/mptcp/subflow.c
>>>> +++ b/net/mptcp/subflow.c
>>>> @@ -798,6 +798,7 @@ enum mapping_status {
>>>>  	MAPPING_INVALID,
>>>>  	MAPPING_EMPTY,
>>>>  	MAPPING_DATA_FIN,
>>>> +	MAPPING_INFINITE,
>>>>  	MAPPING_DUMMY
>>>>  };
>>>>
>>>> @@ -938,6 +939,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>>>>  	if (!skb)
>>>>  		return MAPPING_EMPTY;
>>>>
>>>> +	if (mptcp_check_infinite(ssk))
>>>> +		return MAPPING_INFINITE;
>>>> +
>>>>  	if (mptcp_check_fallback(ssk))
>>>>  		return MAPPING_DUMMY;
>>>>
>>>> @@ -1121,6 +1125,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>>
>>>>  		status = get_mapping_status(ssk, msk);
>>>>  		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
>>>> +		if (unlikely(status == MAPPING_INFINITE))
>>>> +			goto infinite;
>>>> +
>>>>  		if (unlikely(status == MAPPING_INVALID))
>>>>  			goto fallback;
>>>>
>>>> @@ -1192,6 +1199,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>>  		return false;
>>>>  	}
>>>>
>>>> +infinite:
>>>>  	__mptcp_do_fallback(msk);
>>>>  	skb = skb_peek(&ssk->sk_receive_queue);
>>>>  	subflow->map_valid = 1;
>>>
>>> It looks like MAPPING_INFINITE has almost the same behavior
>>> of MAPPING_DUMMY.
>>
>> This is something else I asked for in the v1 review, to avoid reusing
>> MAPPING_INVALID in a confusing way :)
>
> I read that ;) I thought 'MAPPING_DUMMY' would be less confusing.
>
>> How about using a switch statement after get_mapping_status() instead of 4
>> if's in a row?
>
> Will be mostly the same, from generate code perspective, I think.
>
> What if we rename MAPPING_DUMMY into MAPPING_INFINITE, and we use only
> a single value? MAPPING_DUMMY is currently used after a fallback to
> implement the sort of infinite mapping we use there.
>

That's fine.

>>> I think we can avoid the new conditional in get_mapping_status().
>>> Eventually we could do all the error checking after the 'fallback:'
>>> label only if the msk has not fallen back yet:
>>>
>>> fallback:
>>> 	if (!__mptcp_check_fallback(msk)) {
>>> 		/* RFC 8684 section 3.7. */
>>> 	        if (subflow->send_mp_fail) {
>>> 			...
>>> 		if (subflow->mp_join || subflow->fully_established) {
>>
>> This condition also needs to check for the infinite mapping case, which is
>> why it seemed useful to have a separate MAPPING_ enum. Fallback is being
>> triggered here in response to the infinite mapping, so the subflow should
>> not be forced to close.
>
> My point is all about avoiding additional conditionals in the 'fast-
> path' / default receive path.
>
> I think we still could do that, and being able to discriminate here
> between infinite mapping received or not:
>
> - get_mapping_status() returns the same value in the dummy and infinite
> mapping case.
> - in the infinite mapping case, get_mapping_status() additionally sets
>  subflow->map_data_len to 0,

  - and in other cases, set it to nonzero.

> - in the above code - under 'if (!__mptcp_check_fallback(msk)) {' -
> subflow->map_data_len == 0 implies infinite mapping received,
>
> WDYT?

I think it works. I'm slightly uneasy with overloading 
subflow->map_data_len from a code readability and maintenance perspective, 
but if the optimization pays off it's manageable with some good comments.

--
Mat Martineau
Intel
