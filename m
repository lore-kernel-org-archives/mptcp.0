Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1500C7B
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664409735; x=1695945735;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RJESctRceHiWbOFdWGoWHsgUtlEAtLh17BS17mHB4Ek=;
  b=XhSUDaZDi6KUqP0LITBCoEySBLALB66LapzzyLuomVIFbJo0OPsLARal
   i+2J2tscDduup9VBbXScn1RefpqhDYAm61cBLk37xWp1dvykMSNfcPu4M
   C33K3bfWodC5497GkOXqzmnT7pQkbZb2BsONVR+qoMxgeIizgPfra3i4k
   GvHnwSMlRnZRvckjyheDCqSw7RB3FQHTYEt7Y9mr1+HicMwtP/RcLEru/
   nDJqwDw4/OJJkg2LgPVvzr4mNdsP4dgN64WVd2JKstYLOofHr+HLCasYT
   tv+afTlgl74pdu8JWzqj6Q7G5LJ5WGl4tSDz33wToiNVMVikQ64LDdXdB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299349180"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="299349180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 17:02:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="726159527"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="726159527"
Received: from iban-mobl1.amr.corp.intel.com (HELO ncucuk-mobl2.amr.corp.intel.com) ([10.209.77.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 17:02:13 -0700
Date: Wed, 28 Sep 2022 17:02:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/4] mptcp: update __mptcp_push_pending
In-Reply-To: <20220928125251.GA4575@bogon>
Message-ID: <9c2baa9d-db31-3bd7-d1ec-bc3860d68a80@linux.intel.com>
References: <cover.1664358100.git.geliang.tang@suse.com> <0b90e9ec304d919c833863e056f8e6c7b62d0dc2.1664358100.git.geliang.tang@suse.com> <5b186defb2217a8de5ef73c4a8f0809dac920d07.camel@redhat.com> <20220928125251.GA4575@bogon>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Sep 2022, Geliang Tang wrote:

> On Wed, Sep 28, 2022 at 01:02:07PM +0200, Paolo Abeni wrote:
>> On Wed, 2022-09-28 at 17:48 +0800, Geliang Tang wrote:
>>> To support redundant package schedulers more easily, this patch moves the
>>> packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
>>> mptcp_sched_get_send() only once.
>>
>> I fear the above will make cause hitting HoL blocking [more]
>> frequently/easily. I'm not sure if the simult_flows.sh self test will
>> catch that, but you should see a measurably worse running time for such
>> test - in non debug build, as the average of multiple runs.
>
> Yes, simult_flows.sh self test failed in my tests. I guess this problem
> also exists in "BPF redundant scheduler" v12, because it also uses the
> same logic in __mptcp_push_pending(), move the packet scheduler out of
> the dfrags loop.
>

Hi Geliang -


Thanks for posting the __mptcp_push_pending() changes as a separate 
series, that's the main area of complexity in the BPF redundant scheduler 
series. I was trying to come up with some more detailed proposals for this 
part of the code, but it will be easier to discuss it in this 4-patch 
series.


We had talked about the need to change the __mptcp_push_pending() loops to 
support the redundant scheduler, since the existing structure and locking 
optimizations don't fit well with trying to send the same dfrags across 
multiple subflows. A simplified view of the existing code is this:

/* [1] Existing send loops */
For each dfrag:
 	While sends succeed:
 		Call the scheduler (selects subflow and msk->snd_burst)
 		Update subflow locks (push/release/acquire as needed)
 		Send the dfrag data with mptcp_sendmsg_frag()
 		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
 	Update msk->first_pending
Push/release on final subflow


With the redundant scheduler, it's necessary to send each dfrag on 
multiple subflows. If the top-level loop is "For each dfrag", then 
redundant sends have to lock/unlock every subflow on every iteration of 
the inner loop.

Because of that, I proposed changing the outer loop to be based on the 
scheduler:


/* [2] Proposed send loops */
While the scheduler selects one or more subflows:
 	For each subflow:
 		Lock the subflow
 		For each pending dfrag:
 			Send the dfrag data with mptcp_sendmsg_frag()
 			Break if required by msk->snd_burst / etc
 		Push and release the subflow
 	Update dfrag metadata and msk->first_pending

>>
>> I'm sorry, I can't see a feasible way out here :(
>>

I'm still optimistic here :)

Whatever the outer loop is, I think we can still make basically the same 
sequence of calls to the subflow locks, mptcp_sendmsg_frag(), and 
tcp_push(). And fewer scheduler calls too! That would maintain the 
blest-like behavior Paolo implemented.

It seems to me that this v1 iteration of the patches is missing one 
important detail compared to the proposed pseudocode [2]: There's no outer 
loop to call the scheduler again after msk->snd_burst is exhausted. If 
this block of code is moved out of mptcp_subflow_get_send():

 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
 	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
 		mptcp_set_timeout(sk);
 		return msk->last_snd;
 	}

and those conditions are instead checked in the inner "For each pending 
dfrag" loop of my proposed pseudocode above, I think the single subflow 
case is feasible. Once that is working then redundant subflow support can 
be added in later patches.


--
Mat Martineau
Intel
