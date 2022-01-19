Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550102CA8
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642620929; x=1674156929;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j0gWi+B72yUO2MynJj+VLUGJse7OdKNQZokv/AQzTJo=;
  b=LVBYSCNN91XcIXzHgSRfrVxQN/18ujeekXzvTEjgEEWJPm5FX+OSbOWb
   PKc+dhvahb12GUhy737iWuiADNqzMcOQGNmlbEXfCCmn60cWrf6qwKpWT
   NgGIXlkqb3aQH3TB++pO/vlSg6UwWNYXNimcjVhExBAW4PkSz24L2L0jY
   zgaKCUKemp3ujJsL97PUjooHT0MYIkvWlmGpK+xW6yJcBG3fQp6Fv9Ob2
   QPAgpsGeHiPyKeKd7IdRRpdKFT9c7krVZqcVvJOiqVX5dxvN6JpA3SopI
   U+ldXBDhmL6HQIjU+WE9igWUfIG8U8jkldgbaIJi/5SqFqBaCAuW2vnLb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225844385"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="225844385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:20:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="493149880"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:20:43 -0800
Date: Wed, 19 Jan 2022 11:20:43 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced
 by userspace PMs
In-Reply-To: <d399a1cd-39f5-244a-b88b-54c1f17b9437@intel.com>
Message-ID: <7830588b-99bd-d5aa-5018-7f559fa39bda@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com> <20220112221523.1829397-11-kishen.maloor@intel.com> <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com> <d399a1cd-39f5-244a-b88b-54c1f17b9437@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 Jan 2022, Kishen Maloor wrote:

> On 1/14/22 9:11 AM, Paolo Abeni wrote:
>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>> This change adds a new internal function to store/retrieve local
>>> addrs announced by userspace PM implementations from the kernel
>>> context. The function does not stipulate any limitation on the #
>>> of addrs, and handles the requirements of three scenarios:
>>> 1) ADD_ADDR announcements (which require that a local id be
>>> provided), 2) retrieving the local id associated with an address,
>>> also where one may need to be assigned, and 3) reissuance of
>>> ADD_ADDRs when there's a successful match of addr/id.
>>>
>>> The list of all stored local addr entries is held under the
>>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>>> flow is freed while the sock is destructed.
>>
>> It feels strange to me that we need to maintain an additional addresses
>> list inside the kernel for the user-space PM - which should take care
>> of all the status information.
>
> The PM daemon will have the complete picture, but the protocol needs to know the
> local ids assigned to addresses so as such the kernel has to store addresses
> (with their ids) regardless of PM.
>
>>
>> Why anno_list is not enough? Why isn't cheapest to extend it?
>
> The anno_list is the list of addresses that were announced via the ADD_ADDR command, to
> be used specifically for doing re-transmissions.
>
> However, the implementation can also accept connections at local addresses that were not
> explicitly announced (hence not in anno_list), and in this case the kernel records the address
> and assigns it a local id unique in the scope of its connection.
>
> So basically msk->local_addr_list is the list of all known local addresses, both announced
> and not so their ids can be later retrieved.
>
> To give you more context, in my last iteration of the code before I posted the series, I was storing local addrs
> in pernet->local_addr_list just as its done for the kernel PM, but later moved it to
> a per-msk list to eliminate contention (in accessing that list) with other userspace or kernel
> PM managed connections.
>
>>
>> Being the list unlimited a malicius (or buggy) user-space could consume
>> all the kernel memory. I think we need some limits, or at least some
>> accounting.
>
> At this point we're taking the PM daemon as a trusted entity which can issue these
> netlink commands for path management. So there is currently no configurable ceiling
> in the kernel on the size of the PM's kernel stored context.
>

I think it's still worthwhile to have some limits/accounting as Paolo 
suggests - part of the point of pushing PM code to userspace is so bugs or 
other vulnerabilities don't take down the whole machine.

--
Mat Martineau
Intel
