Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594E173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642625041; x=1674161041;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RHsODDjYDW/kL7lyu7EApSPIrlxn0lJZ+mwCZR7+95c=;
  b=JN+Dmi0Z8u9oXTB4/WGjqkB0EvdBy8nPa9Ns/o1M4B0KdO3qCmfnOTKp
   nUw91wB+YRwSlQrRqx2vSc/bINhNzewdsDYx3UOS4ij8/Kd/mtX7g7IUK
   4lX/q/9+fYIlHgvdWazWPDZnyWvFDa+/gcacj4IFDG3JKM12gAcEMvYRv
   vNWO3KkzZHyZePiDDyIV5qpRThJUbdISLr2qVAZk081ic9RSNNtinrDQJ
   ZdE3fv2WmKYSg8AplouwqmZxxGiv5JUSTTsqXQcXRIUCESVJTxGEfEsfe
   2J1heTtoKdvrmdQikktXUadnP5YIb6GX3SAsRThP9ZhpldBpI3HZS92QU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305920772"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="305920772"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:44:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="578960887"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:44:00 -0800
Date: Wed, 19 Jan 2022 12:44:00 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced
 by userspace PMs
In-Reply-To: <c2a1c4e2-2c3f-8f16-7643-5b7d2857cc43@intel.com>
Message-ID: <bad0c4ad-69fc-2e1e-35a-43178343704f@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com> <20220112221523.1829397-11-kishen.maloor@intel.com> <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com> <d399a1cd-39f5-244a-b88b-54c1f17b9437@intel.com> <7830588b-99bd-d5aa-5018-7f559fa39bda@linux.intel.com>
 <c2a1c4e2-2c3f-8f16-7643-5b7d2857cc43@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Jan 2022, Kishen Maloor wrote:

> On 1/19/22 11:20 AM, Mat Martineau wrote:
>> On Tue, 18 Jan 2022, Kishen Maloor wrote:
>>
>>> On 1/14/22 9:11 AM, Paolo Abeni wrote:
>>>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>>>> This change adds a new internal function to store/retrieve local
>>>>> addrs announced by userspace PM implementations from the kernel
>>>>> context. The function does not stipulate any limitation on the #
>>>>> of addrs, and handles the requirements of three scenarios:
>>>>> 1) ADD_ADDR announcements (which require that a local id be
>>>>> provided), 2) retrieving the local id associated with an address,
>>>>> also where one may need to be assigned, and 3) reissuance of
>>>>> ADD_ADDRs when there's a successful match of addr/id.
>>>>>
>>>>> The list of all stored local addr entries is held under the
>>>>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>>>>> flow is freed while the sock is destructed.
>>>>
>>>> It feels strange to me that we need to maintain an additional addresses
>>>> list inside the kernel for the user-space PM - which should take care
>>>> of all the status information.
>>>
>>> The PM daemon will have the complete picture, but the protocol needs to know the
>>> local ids assigned to addresses so as such the kernel has to store addresses
>>> (with their ids) regardless of PM.
>>>
>>>>
>>>> Why anno_list is not enough? Why isn't cheapest to extend it?
>>>
>>> The anno_list is the list of addresses that were announced via the ADD_ADDR command, to
>>> be used specifically for doing re-transmissions.
>>>
>>> However, the implementation can also accept connections at local addresses that were not
>>> explicitly announced (hence not in anno_list), and in this case the kernel records the address
>>> and assigns it a local id unique in the scope of its connection.
>>>
>>> So basically msk->local_addr_list is the list of all known local addresses, both announced
>>> and not so their ids can be later retrieved.
>>>
>>> To give you more context, in my last iteration of the code before I posted the series, I was storing local addrs
>>> in pernet->local_addr_list just as its done for the kernel PM, but later moved it to
>>> a per-msk list to eliminate contention (in accessing that list) with other userspace or kernel
>>> PM managed connections.
>>>
>>>>
>>>> Being the list unlimited a malicius (or buggy) user-space could consume
>>>> all the kernel memory. I think we need some limits, or at least some
>>>> accounting.
>>>
>>> At this point we're taking the PM daemon as a trusted entity which can issue these
>>> netlink commands for path management. So there is currently no configurable ceiling
>>> in the kernel on the size of the PM's kernel stored context.
>>>
>>
>> I think it's still worthwhile to have some limits/accounting as Paolo suggests - part of the point of pushing PM code to userspace is so bugs or other vulnerabilities don't take down the whole machine.
>>
>
> Agreed, but do we put circuit breakers inside the kernel or the PM daemon? (for e.g.,
> if a PM plug-in can see limitations imposed by the daemon?)
>

Kernel, I'd say.

> If we consider userspace path management as providing "more flexibility",
> then conceivably the kernel would expose hooks to the PM daemon to bump up any
> kernel enforced limits when necessary. So a malicious or buggy PM could also raise
> those limits.
>

True, an admin (or bad actor) can get themselves into trouble by setting 
nonsensical limits. But the limits remain useful for stability and 
managing resources.

> Since interactions over the netlink interface are to be carried out by a privileged
> entity, I've been assuming that the PM daemon is to be trusted.
>

We're trusting the PM daemon with certain (granular) 
privileges/capabilities using CAP_NET_ADMIN, not the old 
"root-controls-all" model.

> On the other hand, if we're talking about having fixed upper bounds in the kernel wrt
> # of addrs/subflows (which cannot be changed by the PM daemon), then that could make sense.
>

That's pretty much what I'm talking about, maybe tunable (within a range) 
by a sysctl.

--
Mat Martineau
Intel
