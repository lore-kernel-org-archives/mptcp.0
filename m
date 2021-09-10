Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14113FC2
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 00:21:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220625579"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="220625579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:21:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="470317464"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:21:56 -0700
Date: Thu, 9 Sep 2021 17:21:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, 
    Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next v2 3/9] mptcp: add MAPPING_INFINITE mapping
 status
In-Reply-To: <ba53a5abbb43645efa4038eda3abfb8bb386b09b.camel@redhat.com>
Message-ID: <692e5742-1b6c-692d-2927-f0a5aba14ee8@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>  <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com> <ba53a5abbb43645efa4038eda3abfb8bb386b09b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Sep 2021, Paolo Abeni wrote:

> On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
>> From: Geliang Tang <geliangtang@xiaomi.com>
>>
>> This patch added a new mapping status named MAPPING_INFINITE. If the
>> MPTCP_INFINITE_DONE flag is set in get_mapping_status, return this new
>> status. And in subflow_check_data_avail, if this status is set, goto the
>> 'infinite' lable to fallback.
>>
>> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
>> ---
>>  net/mptcp/subflow.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 951aafb6021e..ad8efe56eab6 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -798,6 +798,7 @@ enum mapping_status {
>>  	MAPPING_INVALID,
>>  	MAPPING_EMPTY,
>>  	MAPPING_DATA_FIN,
>> +	MAPPING_INFINITE,
>>  	MAPPING_DUMMY
>>  };
>>
>> @@ -938,6 +939,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>>  	if (!skb)
>>  		return MAPPING_EMPTY;
>>
>> +	if (mptcp_check_infinite(ssk))
>> +		return MAPPING_INFINITE;
>> +
>>  	if (mptcp_check_fallback(ssk))
>>  		return MAPPING_DUMMY;
>>
>> @@ -1121,6 +1125,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>
>>  		status = get_mapping_status(ssk, msk);
>>  		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
>> +		if (unlikely(status == MAPPING_INFINITE))
>> +			goto infinite;
>> +
>>  		if (unlikely(status == MAPPING_INVALID))
>>  			goto fallback;
>>
>> @@ -1192,6 +1199,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>  		return false;
>>  	}
>>
>> +infinite:
>>  	__mptcp_do_fallback(msk);
>>  	skb = skb_peek(&ssk->sk_receive_queue);
>>  	subflow->map_valid = 1;
>
>
> It looks like MAPPING_INFINITE has almost the same behavior
> of MAPPING_DUMMY.

This is something else I asked for in the v1 review, to avoid reusing 
MAPPING_INVALID in a confusing way :)

How about using a switch statement after get_mapping_status() instead of 4 
if's in a row?

>
> I think we can avoid the new conditional in get_mapping_status().
> Eventually we could do all the error checking after the 'fallback:'
> label only if the msk has not fallen back yet:
>
> fallback:
> 	if (!__mptcp_check_fallback(msk)) {
> 		/* RFC 8684 section 3.7. */
> 	        if (subflow->send_mp_fail) {
> 			...
> 		if (subflow->mp_join || subflow->fully_established) {

This condition also needs to check for the infinite mapping case, which is 
why it seemed useful to have a separate MAPPING_ enum. Fallback is being 
triggered here in response to the infinite mapping, so the subflow should 
not be forced to close.

> 			...
> 		__mptcp_do_fallback(msk);
> 	}
>
> 	skb = skb_peek(&ssk->sk_receive_queue);
> 	...
> WDYT?



--
Mat Martineau
Intel
