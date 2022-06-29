Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C886AA2
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656535870; x=1688071870;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Nlope8rRkzc/34zkeye+vIzm/90uLzDu9Mu1Deyb88=;
  b=j/lwLngD43cFgdGrcVxHAxtIxjgab829VexQFr/sSv1m86RaMxnLHhTz
   BHGPxAonKrhgJu0tmu7e/JlyOqHujPod2OtpiJu0qt+321SQAEGBP64Cx
   EKp1MO6g4ErSVrzmI6FZSVCTJkkYAoN8i5rCaeEl/qgd6/OqTfUHpeck+
   IJF/rYqlEmQlOfIsx38+J1SqXjJ8kUe0VcVOp2f715cKwb+d11Os/DpfJ
   xyTBqijwEW/kF04op0qJhLcxTdGfaNJrWVpOYHhmzGodsuVIV3vEYuu0F
   B3ZqMGDyvytOdt7Os7eUmT8tAIrIvL0AVMlCocSRT19u0XJINSYGGdJaA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346147131"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="346147131"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 13:51:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="717973823"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 13:51:10 -0700
Date: Wed, 29 Jun 2022 13:51:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 3/3] mptcp: Acquire the subflow socket lock
 before modifying MP_PRIO flags
In-Reply-To: <0a3f73ff8a19509737147af305cc521abb1bca9b.camel@redhat.com>
Message-ID: <ad679bdc-b668-9be-5eaa-4b708b6caa3c@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>  <20220628190356.326233-4-mathew.j.martineau@linux.intel.com> <0a3f73ff8a19509737147af305cc521abb1bca9b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Jun 2022, Paolo Abeni wrote:

> On Tue, 2022-06-28 at 12:03 -0700, Mat Martineau wrote:
>> When setting up a subflow's flags for sending MP_PRIO MPTCP options, the
>> subflow socket lock was not held while reading and modifying several
>> struct members that are also read and modified in mptcp_write_options().
>>
>> Acquire the subflow socket lock earlier and send the MP_PRIO ACK with
>> that lock already acquired.
>>
>> Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index d04b34fc9a8e..05c6a95e9c28 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -729,11 +729,13 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>  		struct sock *sk = (struct sock *)msk;
>>  		struct mptcp_addr_info local;
>> +		bool slow;
>>
>>  		local_address((struct sock_common *)ssk, &local);
>>  		if (!mptcp_addresses_equal(&local, addr, addr->port))
>>  			continue;
>>
>> +		slow = lock_sock_fast(ssk);
>>  		if (subflow->backup != bkup)
>>  			msk->last_snd = NULL;
>>  		subflow->backup = bkup;
>> @@ -742,7 +744,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>  		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
>>
>>  		pr_debug("send ack for mp_prio");
>> -		mptcp_subflow_send_ack(ssk);
>> +		__mptcp_subflow_send_ack(ssk);
>> +		unlock_sock_fast(ssk, slow);
>
> After this chunk, we can remove mptcp_subflow_send_ack() from
> protocol.h and make it static. I think it's easier squashing this patch
> into the previous one.
>

There's still a call to mptcp_subflow_send_ack() in pm_netlink.c, so I'll 
leave both in protocol.h for now. Will squash patches 2 & 3 though.

--
Mat Martineau
Intel
