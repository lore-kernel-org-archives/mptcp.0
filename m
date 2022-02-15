Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B87C
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644952531; x=1676488531;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DcPtV0k3P/IgjMOsU3mq9EdQTClSLQH5GxMQ2HLWTlU=;
  b=Zw3zJyQjU7iwxnvfONxwVH+WZKPXH/JQrO4EtEmu7AqUFEeG8iL6YQbO
   mjwrjgcXBKQrWJ9Xyfkt5lfI4e58MOLwJB0+O32RJLhPpg0/lQzsMfkbD
   2OQO2uRpElfTIZ8CvQtrpIhH4YRKPBjkzQMEv0Q4W6ctT92STtZWR3BCN
   xl+zKUxxzit8LLvllTBsyOgyw3gkOuLOiT6e4RPm7dmAGS1IYPVfkKec/
   2JJ5b/CPPiiCZkcXN9ry6eBCwd3uqoDu8nzw5MRGodubjagFotuQmaDx6
   z15/WsHpqLRIo2N+aHmZKW2nJdC0R9KhzDoLIvtzI8b/2Q+1YMtFCbCTY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230396057"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230396057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:15:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681165969"
Received: from skling-mobl1.amr.corp.intel.com ([10.212.200.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:15:31 -0800
Date: Tue, 15 Feb 2022 11:15:30 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR
 generation
In-Reply-To: <1db883cd0e1c8849a64ab2c0acb0204c9e82469f.camel@redhat.com>
Message-ID: <79c7eb81-a894-a5cf-433-7bffade2b215@linux.intel.com>
References: <cover.1644852970.git.pabeni@redhat.com>   <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>  <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>  <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com>
 <1db883cd0e1c8849a64ab2c0acb0204c9e82469f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 15 Feb 2022, Paolo Abeni wrote:

> On Mon, 2022-02-14 at 17:19 -0800, Mat Martineau wrote:
>> On Mon, 14 Feb 2022, Paolo Abeni wrote:
>>
>>> On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
>>>> In some edge scenarios, an MPTCP subflows can use a local address
>>>> mapped by a "implicit" endpoint created by the in-kernel path manager.
>>>>
>>>> When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
>>>> suboption. That is somewhat unexpected, as an MPTCP listener will keep
>>>> accepting incoming subflows targeting such address and the unexpected
>>>> options can confuse some self-tests.
>>>>
>>>> Be more conservative about RM_ADDR generation: explicitly track the
>>>> implicit endpoint with an appropriate flag and exclude them from the
>>>> RM_ADDR generation.
>>>>
>>>> Additionally allow the user-space to replace implicit endpoint with
>>>> user-provided data at endpoint creation time.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>> The CI still reports an issue on top of this patch:
>>>
>>> https://cirrus-ci.com/task/5380046008352768?logs=test#L7283
>>>
>>> Even if the symtom is the same, the root cause is different. I think
>>> such failure is caused by the flush operation deleting both all
>>> existing endpoints and all the existing subflows for each MPTCP socket.
>>>
>>> Even when the subflow is not attached to any known, non implicit,
>>> endpoint.
>>>
>>> When we have simult flush on both sides, deleting the subflow (with no
>>> endpoint) on one end can make disappear the subflow on the other end
>>> (tied to a local endpoint) before the PM could generate the relevant
>>> RM_ADDR.
>>>
>>
>> If we aren't closing all subflows during the flush, shouldn't there be at
>> least one subflow where the RM_ADDR can be sent?
>>
>> Maybe mptcp_pm_nl_addr_send_ack() needs to pick a better subflow for
>> sending the RM_ADDR. Do you think it would help to make
>> mptcp_subflow_send_ack() return a bool, and only return true if the ack
>> was sent? Then it could retry the ack on other subflows in the conn_list,
>> until it finds one that works or they all fail.
>
> I'm sorry it looks like I was unclear.
>
> What I mean is that in the following scenario:
>
> Client					Server
> [endpoint1] ------- MPTCP-subflow ----> [addr0/no endpoint]
> [endpoint2] ------- subflow 1  -------> [addr0/no endpoint]
> [endpoint3] ------- subflow 2  -------> [addr0/no endpoint]
>
> if we flush simultaneusly the endpoints on both the server and the
> client (which is what the failing selftest is currently doing), the
> number of RM_ADDR generated by the client is unpredictable.
>
> On endpoint flush the server will try to delete all the subflows,
> regardless of no endpoints attached there. The server can delete the
> subflow 1 and/or the subflow 2 before the client processes the relevant
> endpoint on the other side. If that happens, the client will not
> generate (correctly) the related RM_ADDR.

I'm not sure that's correct, though. Even if subflows 1 and/or 2 have been 
closed, if the client has sent an ADD_ADDR to advertise endpoints 2 and 3, 
it should send RM_ADDR to "unadvertise" them on the remaining open 
subflow. While RM_ADDR does in some cases trigger disconnects, its primary 
role is to inform the peer that previous advertisements have been revoked.

>
> The testcase is currently expectiong exactly 2 RM_ADDR in the above
> scenario (well actually 3, because the testcase uses 3 MPJ subflows)
>
> Picking a different subflow to send the RM_ADDR will not change the
> results.
>
> Not sure if the above is somewhat more clear.
>

I think your explanation is clear, but we are each trying to explain a 
different model of how things should work :)


In our in-kernel PM implementation, ADD_ADDR ends up being treated as a 
"request to connect" event and RM_ADDR is a "request to disconnect" event. 
That's doesn't completely capture what the RFC intends: ADD_ADDR is an 
advertisement that an endpoint is available for a peer PM to potentially 
connect to (at that moment or any later time before RM_ADDR or connection 
close). RM_ADDR revokes that advertisement. From the RFC (note middle 
sentence, especially):

3.4.2.  Remove Address

    If, during the lifetime of an MPTCP connection, a previously
    announced address becomes invalid (e.g., if the interface disappears
    or an IPv6 address is no longer preferred), the affected host SHOULD
    announce this situation so that the peer can remove subflows related
    to this address.  Even if an address is not in use by an MPTCP
    connection, if it has been previously announced, an implementation
    SHOULD announce its removal.  A host MAY also choose to announce that
    a valid IP address should not be used any longer -- for example, for
    make-before-break session continuity.


Those SHOULDs do say that maybe our self test is more strict than the RFC, 
but if we fix our in-kernel PM to send a predictable number of RM_ADDRs 
then the existing tests can be satisified.


--
Mat Martineau
Intel
