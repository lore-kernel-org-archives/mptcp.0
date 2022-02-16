Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D103674
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645055339; x=1676591339;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DmRIldEdmUX1n7odtzQf8a4FS0s64BldbXYs7nwugc4=;
  b=Iu+DGgW4BeL5PNjfA/m9SkFsdwhMWF5w6CXEye9VSx8R+rP6peb7MqAO
   olK8Al7LVZMBT04Wwbq2N3yTDfYCCOWWQjDYE+Bks7vjRR1RloSIePbU0
   g1wxs1lGyqZxDHXoclgKEytLjBfqkJriTaZi4LV73cS6FHv/A92YHZU2O
   f65Tb1U9bupWFD5aSnssZYGgV893UsHcAm87pwp2pNdHMO3hb+iKoEenp
   G7XLjop2CM0c4ItAm0aG+SZNw8jV4hMe6M+Qi2fn7Nm0HyYSMajiCfNZz
   SHHZqzl6oxHXMWhxwRyuIaAKLkmqAmXVRWkeT8iet2qe1x326KNNrgeXp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="337193059"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="337193059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 15:48:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="540462596"
Received: from hasaeed-mobl.amr.corp.intel.com ([10.209.58.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 15:48:58 -0800
Date: Wed, 16 Feb 2022 15:48:58 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR
 generation
In-Reply-To: <965a43a6d37214f16db59a035ea2969bfa8a6bd3.camel@redhat.com>
Message-ID: <323250b1-a8c2-479d-2c55-71fb0e612ca@linux.intel.com>
References: <cover.1644852970.git.pabeni@redhat.com>    <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>   <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>   <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com> 
 <1db883cd0e1c8849a64ab2c0acb0204c9e82469f.camel@redhat.com>  <79c7eb81-a894-a5cf-433-7bffade2b215@linux.intel.com> <965a43a6d37214f16db59a035ea2969bfa8a6bd3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Feb 2022, Paolo Abeni wrote:

> On Tue, 2022-02-15 at 11:15 -0800, Mat Martineau wrote:
>> On Tue, 15 Feb 2022, Paolo Abeni wrote:
>>
>>> On Mon, 2022-02-14 at 17:19 -0800, Mat Martineau wrote:
>>>> On Mon, 14 Feb 2022, Paolo Abeni wrote:
>>>>
>>>>> On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
>>>>>> In some edge scenarios, an MPTCP subflows can use a local address
>>>>>> mapped by a "implicit" endpoint created by the in-kernel path manager.
>>>>>>
>>>>>> When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
>>>>>> suboption. That is somewhat unexpected, as an MPTCP listener will keep
>>>>>> accepting incoming subflows targeting such address and the unexpected
>>>>>> options can confuse some self-tests.
>>>>>>
>>>>>> Be more conservative about RM_ADDR generation: explicitly track the
>>>>>> implicit endpoint with an appropriate flag and exclude them from the
>>>>>> RM_ADDR generation.
>>>>>>
>>>>>> Additionally allow the user-space to replace implicit endpoint with
>>>>>> user-provided data at endpoint creation time.
>>>>>>
>>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>>
>>>>> The CI still reports an issue on top of this patch:
>>>>>
>>>>> https://cirrus-ci.com/task/5380046008352768?logs=test#L7283
>>>>>
>>>>> Even if the symtom is the same, the root cause is different. I think
>>>>> such failure is caused by the flush operation deleting both all
>>>>> existing endpoints and all the existing subflows for each MPTCP socket.
>>>>>
>>>>> Even when the subflow is not attached to any known, non implicit,
>>>>> endpoint.
>>>>>
>>>>> When we have simult flush on both sides, deleting the subflow (with no
>>>>> endpoint) on one end can make disappear the subflow on the other end
>>>>> (tied to a local endpoint) before the PM could generate the relevant
>>>>> RM_ADDR.
>>>>>
>>>>
>>>> If we aren't closing all subflows during the flush, shouldn't there be at
>>>> least one subflow where the RM_ADDR can be sent?
>>>>
>>>> Maybe mptcp_pm_nl_addr_send_ack() needs to pick a better subflow for
>>>> sending the RM_ADDR. Do you think it would help to make
>>>> mptcp_subflow_send_ack() return a bool, and only return true if the ack
>>>> was sent? Then it could retry the ack on other subflows in the conn_list,
>>>> until it finds one that works or they all fail.
>>>
>>> I'm sorry it looks like I was unclear.
>>>
>>> What I mean is that in the following scenario:
>>>
>>> Client					Server
>>> [endpoint1] ------- MPTCP-subflow ----> [addr0/no endpoint]
>>> [endpoint2] ------- subflow 1  -------> [addr0/no endpoint]
>>> [endpoint3] ------- subflow 2  -------> [addr0/no endpoint]
>>>
>>> if we flush simultaneusly the endpoints on both the server and the
>>> client (which is what the failing selftest is currently doing), the
>>> number of RM_ADDR generated by the client is unpredictable.
>>>
>>> On endpoint flush the server will try to delete all the subflows,
>>> regardless of no endpoints attached there. The server can delete the
>>> subflow 1 and/or the subflow 2 before the client processes the relevant
>>> endpoint on the other side. If that happens, the client will not
>>> generate (correctly) the related RM_ADDR.
>>
>> I'm not sure that's correct, though. Even if subflows 1 and/or 2 have been
>> closed, if the client has sent an ADD_ADDR to advertise endpoints 2 and 3,
>> it should send RM_ADDR to "unadvertise" them on the remaining open
>> subflow.
>
> If the peer sent ADD_ADDR for a given address, it will generate the
> RM_ADDR, regardless of the related subflow being already closed. We
> don't have bugs - al least not shown by the current self-tests failures
> - in that situation.
>
> The criticial scenario is a bit different: the client created the
> subflows, but it did not avertize any address with ADD_ADDR (the client
> endpoints have the 'SUBFLOW' flag, not the 'SIGNAL' one).
>

Ok, that's the part I had missed.

> If I read correctly the discussion about ADD_ADDR handling, a correct
> and simple solution would be sending RM_ADDR only for 'SIGNAL'
> endpoints, and update the test-cases accordingly.
>

Yeah, I think that would work.

> It's not clear to me if in case of 'endpoint flush', we should keep
> deleting all the subflows - including the ones not tied to 'SIGNAL'
> endpoints on any end.
>

I like the idea of separating the "unadvertising" from subflow deletion. 
MPTCP_PM_CMD_FLUSH_ADDRS should continue to act the same as "foreach 
endpoint ID call MPTCP_PM_CMD_DEL_ADDR". Could add a flag to optionally 
delete/keep subflows?

--
Mat Martineau
Intel
