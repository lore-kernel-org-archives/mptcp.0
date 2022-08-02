Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8B7F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659473251; x=1691009251;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Mu0Hh6ClNDyQsJ5JiYre0VlvPUdzVDpoNkM4g5UfoHA=;
  b=bSybWWIvG/oKrM5hOFs2IkDqBikmshwiG1loY/aI2a837Kz0D5/CfCY6
   /E1vqA0qhYftzIz6cln3oBh0Cyfae7ByMENV1GgAX2kb2B7vPJisp/FSc
   y8L6jid51h4WULzVvFKYgIcpklhpdltR2ut34qThwiB2vNYTPjHUX2QrP
   dtorJxs5t3AIVfDOLnurEXSJIWQ6pmcdGlXZJPHb7VV98nfct7CoMORUB
   Z2qwgicbEk5OLf73iKGWRvZt8FVbTRveMUPLoGA/UhGIOGYtN+075ji4h
   B3kwQVqVcuqIj+V9R4tkzNweZSOkCp6zygkBUkrLxkr0ugml3aT5zJeEe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290731968"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290731968"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:47:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="778755424"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:47:30 -0700
Date: Tue, 2 Aug 2022 13:47:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Patch "mptcp: don't send RST for single subflow" has been added
 to the 5.18-stable tree
In-Reply-To: <9beff9f6-b06d-a879-c2df-542375a2def7@tessares.net>
Message-ID: <c6f067e4-37a4-a8a7-5bdf-45c461c2462@linux.intel.com>
References: <20220731024320.3360515-1-sashal@kernel.org> <9beff9f6-b06d-a879-c2df-542375a2def7@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 1 Aug 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> (cc: MPTCP ML)
>
> On 31/07/2022 04:43, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     mptcp: don't send RST for single subflow
>>
>> to the 5.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mptcp-don-t-send-rst-for-single-subflow.patch
>> and it can be found in the queue-5.18 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
> I just noticed the patch below is being backported to v5.18 while it
> doesn't have any "Fixes" tag.
>
> It slightly changes the behaviour on v5.18 but I don't think that's an
> issue, it could even be seen as a bug-fix for me.
>
> I just double-checked and the selftests are still OK with this patch.
>
> Also OK for you to have it in v5.18?
>

I noticed this too - I'm going to ask Greg to drop it. Without the 
infinite mapping support that follows in the series I think it's better to 
keep the RST behavior.

- Mat

>
>> commit 0a782d12ad419f820fbaf1d637a788097014b5b1
>> Author: Geliang Tang <geliang.tang@suse.com>
>> Date:   Fri Apr 22 14:55:36 2022 -0700
>>
>>     mptcp: don't send RST for single subflow
>>
>>     [ Upstream commit 1761fed2567807f26fbd53032ff622f55978c7a9 ]
>>
>>     When a bad checksum is detected and a single subflow is in use, don't
>>     send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>>
>>     So invoke tcp_send_active_reset() only when mptcp_has_another_subflow()
>>     is true.
>>
>>     Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>     Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>     Signed-off-by: David S. Miller <davem@davemloft.net>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 7919e259175d..ccae50eba664 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1221,14 +1221,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>  	/* RFC 8684 section 3.7. */
>>  	if (subflow->send_mp_fail) {
>>  		if (mptcp_has_another_subflow(ssk)) {
>> +			ssk->sk_err = EBADMSG;
>> +			tcp_set_state(ssk, TCP_CLOSE);
>> +			subflow->reset_transient = 0;
>> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
>>  			while ((skb = skb_peek(&ssk->sk_receive_queue)))
>>  				sk_eat_skb(ssk, skb);
>>  		}
>> -		ssk->sk_err = EBADMSG;
>> -		tcp_set_state(ssk, TCP_CLOSE);
>> -		subflow->reset_transient = 0;
>> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
>>  		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
>>  		return true;
>>  	}
>
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--
Mat Martineau
Intel
