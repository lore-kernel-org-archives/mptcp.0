Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CD2F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 15:01:41 +0000 (UTC)
IronPort-SDR: CS8bTNvW3ep7GE6irzcbjeXyQlmQfAQ9Ld4EFpvjfjmRMcdXvXzvgj0X3ZSM/zIVaDGVEPRqqw
 TIt98nhslStw==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216353457"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="216353457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:01:40 -0700
IronPort-SDR: KnLqswg4bfnSOF/W2/5PmXygQqfXRFp3siKkABufyv2EQOtgYrQqF8j5XLV2gJTBIZ7XoO9XsM
 FWIqI9TDdo9w==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="427546839"
Received: from bjones3-mobl.amr.corp.intel.com ([10.212.214.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:01:39 -0700
Date: Wed, 21 Apr 2021 08:01:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: Retransmit DATA_FIN
In-Reply-To: <e6ebf2625a8d8e383e5cb1c62d078c49a879aa88.camel@redhat.com>
Message-ID: <a3685615-f9d7-933-fd5a-6d253acf42@linux.intel.com>
References: <20210419213836.59887-1-mathew.j.martineau@linux.intel.com> <e6ebf2625a8d8e383e5cb1c62d078c49a879aa88.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 21 Apr 2021, Paolo Abeni wrote:

> Hello,
>
> On Mon, 2021-04-19 at 14:38 -0700, Mat Martineau wrote:
>> With this change, the MPTCP-level retransmission timer is used to resend
>> DATA_FIN. The retranmit timer is not stopped while waiting for a
>> MPTCP-level ACK of DATA_FIN, and retransmitted DATA_FINs are sent on all
>> subflows. The retry interval starts with a couple of attempts at
>> TCP_RTO_MIN and then doubles on each attempt, up to TCP_RTO_MAX.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/146
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index a8180a917649..1fddaeeb8051 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/atomic.h>
>> +#include <linux/log2.h>
>>  #include <net/sock.h>
>>  #include <net/inet_common.h>
>>  #include <net/inet_hashtables.h>
>> @@ -402,6 +403,15 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
>>  	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
>>  }
>>
>> +static void mptcp_set_datafin_timeout(const struct sock *sk)
>> +{
>> +	struct inet_connection_sock *icsk = inet_csk(sk);
>> +	int retransmits = clamp_val(icsk->icsk_retransmits, 1,
>> +				    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
>> +
>> +	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
>
> The patch LGTM! I have only a couple of minor comment WRT to the above.
> To me something alike:
>
> 	mptcp_sk(sk)->timer_ival = min(TCP_RTO_MAX,
> 				       TCP_RTO_MIN << icsk->icsk_retransmits);
>
> would be more readable.

Yeah, good point. I didn't want to start overflowing the result of 
TCP_RTO_MIN << x, but that would take an hour or two without any subflow 
catching up to the DATA_FIN sequence number. Probably too paranoid there.

>
> Also I'm wondering if we could use  max subflows 'icsk->icsk_rto'
> instead of TCP_RTO_MIN - so that e.g. we are not too "aggressive" on
> slow links
>
> The latter could be really a follow-up, if needed at all.

By "max subflows icsk_rto", you mean look through all the subflows and use 
the max icsk_rto?

Follow-up sounds right to me. Thanks!

--
Mat Martineau
Intel
