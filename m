Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808371
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:28:28 +0000 (UTC)
IronPort-SDR: CWL6MfZ+tZz8lheYrZRqG+Dl5weZkaRvDnvAIHtETLU9yDG3j4+r2yAybr8EIp2ZLdSShMqh1z
 r2a8nhA0/W3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180375229"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180375229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:28:28 -0700
IronPort-SDR: kQn16RAyCS5sGXd29r7bdxUmPSpbSsL8qmi6tCz6U29gfMh1XbL5hofZ5TnaEokcvcUi5FrSk6
 yqGUYDrGjnJQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439201321"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:28:28 -0700
Date: Tue, 18 May 2021 10:28:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: do not reset MP_CAPABLE subflow
 on mapping errors
In-Reply-To: <d816c5c2b4bcb0d69effdb3b8fc4fd09fa2a9003.camel@redhat.com>
Message-ID: <7b2f1ab8-68e-adb8-aaff-8a8cd080529@linux.intel.com>
References: <18ddcf2f53d732eb9b41a485ce7da23329aaa81e.1621270518.git.pabeni@redhat.com>  <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>  <2651afa0-d371-8730-a685-def56669d6e@linux.intel.com>
 <d816c5c2b4bcb0d69effdb3b8fc4fd09fa2a9003.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Paolo Abeni wrote:

> On Mon, 2021-05-17 at 17:16 -0700, Mat Martineau wrote:
>> On Mon, 17 May 2021, Paolo Abeni wrote:
>>
>>> When some mapping related errors occours we close the main
>>> MPC subflow with a RST. We should instead fallback gracefully
>>> to TCP, and do the reset only for MPJ subflows.
>>>
>>> Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/subflow.c | 39 +++++++++++++++++++--------------------
>>> 1 file changed, 19 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 278986585088..9befe9fe7bca 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1110,10 +1110,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>
>>> 		status = get_mapping_status(ssk, msk);
>>> 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
>>> -		if (unlikely(status == MAPPING_INVALID)) {
>>> -			ssk->sk_err = EBADMSG;
>>> -			goto fatal;
>>> -		}
>>> +		if (unlikely(status == MAPPING_INVALID))
>>> +			goto fallback;
>>> +
>>
>> There are a bunch of other ways to get MAPPING_INVALID during the life of
>> a connection, including when there are multiple subflows active and
>> fallback is not a valid option. Can the new fallback condition be more
>> targeted to this "out of order / packet loss at connection time" issue so
>> truly fatal MAPPING_INVALID cases still reset the connection?
>
> What we should do if we get a MAPPING_INVALID and we have a single
> (MPC) subflow? I could not find any specific reference in the RFC. I
> think it's roughly the same as 'no mapping' at all: if we can fallback
> we do fallback, otherwise we reset.

Looking at section 3.7, there aren't many cases where fallback is an 
option during operation (after the initial data has been successfully 
acked in each direction).

"If a subflow breaks during operation ... then once this is detected ...
the subflow SHOULD be treated as broken and closed with a RST, since no 
data can be delivered to the application layer and no fallback signal
can be reliably sent."

In general, it looks like a bad mapping should reset the *subflow* (rather 
than the whole MPTCP connection) - what I said above was unclear about 
what exactly should be reset.

It seems like the only way to fall back the whole connection later in its 
life involves checksum failure. In that case the RFC describes the 
conditions where an "infinite mapping" can be used for fallback - but 
that's different from the beginning-of-connection fallback code we have 
today.

>
> Note that with this patch, under the 'fallback' label, checks if a
> reset is needed or not. The current patch does a reset only if the
> subflow is an MP_JOIN one, but that condition could be additionally
> extended to 'msk has multiple subflows' - even if the latter looks like
> a net-next patch.
>
> WDYT?

As long as the subflow is reset when the mapping failed, that's fine. It 
doesn't seem like there are conditions during operation (long after 
connection time) where it's correct to do fallback without an infinite 
mapping.

--
Mat Martineau
Intel
