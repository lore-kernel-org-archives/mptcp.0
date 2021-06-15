Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CE173
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 19:34:27 +0000 (UTC)
IronPort-SDR: t09zWRHll0dtEbI/eMQfylMCurvb0gVaDmIlQ2NqlHJYhiQtlrAmhULk/x+I2noTYp+ZNQXCAP
 TY75GM5W/Kxw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="186432810"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="186432810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 12:34:26 -0700
IronPort-SDR: dMO5oj56v2gcSMRrfdzPFDWRXV3nifrNkrwsA0iQP5CfW+Rrtbi6ghiFb0gqls2fvgkL9Ljsop
 wTHvkEJG210A==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="487882986"
Received: from reschenk-mobl1.amr.corp.intel.com ([10.255.230.223])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 12:34:26 -0700
Date: Tue, 15 Jun 2021 12:34:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix bad handling od 32 bit ack
 wrap-around.
In-Reply-To: <de101616524d72d1bd83addd6a717c73edd68703.camel@redhat.com>
Message-ID: <7f1db2dd-6c91-8813-b5ba-1fce6d60eeb8@linux.intel.com>
References: <356dce030d0adf2bf6b45888876e2c3f9f553a3a.1623691387.git.pabeni@redhat.com>  <1dbd7296-c31f-dce9-69fc-595df927a456@linux.intel.com> <de101616524d72d1bd83addd6a717c73edd68703.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 15 Jun 2021, Paolo Abeni wrote:

> On Mon, 2021-06-14 at 18:27 -0700, Mat Martineau wrote:
>> On Mon, 14 Jun 2021, Paolo Abeni wrote:
>>
>>> When receiving 32 bits DSS ack from the peer, the MPTCP need
>>> to expand them to 64 bits value. The current code is buggy
>>> WRT detectiong 32 bits ack wrap-around: usaging the 'before()'

A couple of typo fixes: detecting, using...

>>> helper is just meaningless: when the wrap-around happes the

...happens. And "of" in the subject line.

>>> current 32 bit ack value is lower than the previous one, need
>>> plain direct comparison.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
>>> Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/options.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index a05270996613..7db1e219f24f 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -952,7 +952,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
>>> 	old_ack32 = (u32)old_ack;
>>> 	cur_ack32 = (u32)cur_ack;
>>> 	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
>>> -	if (unlikely(before(cur_ack32, old_ack32)))
>>> +	if (unlikely(cur_ack32 < old_ack32))
>>> 		return cur_ack + (1LL << 32);
>>> 	return cur_ack;
>>> }
>>
>> I think you're right, but I haven't had a chance to test myself (since
>> this is tagged as closing #204 it sounds like your tests are good!).
>>
>> While it's a good thing that mptcp_trunk helped us find this problem,
>> maybe this also shows that mptcp_trunk should be more aggressive about
>> switching to 64-bit ACKs? Or is this less about speed and only a
>> wraparound bug?
>
> Without this patch single subflows transfer from net-next to mptcp.org
> stalls after a few GB - after the wrap-around. That happens because
> net-next misinterpret the ack for the wrapped seq as a very old one.
> This patch fixes the issue in my test.
>
> Not sure if the above answer your question.

That is helpful, thanks.

Like we discussed on IRC, the new comparison could result in an old (but 
recent) ACK getting wrongly interpreted as a "future" 64-bit ACK, but one 
that is unlikely to be in the correct window - so it gets ignored. Would 
be good to have a comment explaining this.


--
Mat Martineau
Intel
