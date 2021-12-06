Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4B2C80
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 22:34:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217447399"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="217447399"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:34:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="611413166"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.10])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:34:45 -0800
Date: Mon, 6 Dec 2021 14:34:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/6] mptcp: Bypass kernel PM when userspace
 PM is enabled
In-Reply-To: <7d2c19aa4a4753fa1c7d88db9a89527aead958d5.camel@redhat.com>
Message-ID: <1022e3c7-adcb-a3de-597a-229dfb8d2f3b@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>  <20211202005216.154787-4-mathew.j.martineau@linux.intel.com> <7d2c19aa4a4753fa1c7d88db9a89527aead958d5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Paolo Abeni wrote:

> On Wed, 2021-12-01 at 16:52 -0800, Mat Martineau wrote:
>> When a MPTCP connection is managed by a userspace PM, bypass the kernel
>> PM for incoming advertisements and subflow events. Netlink events are
>> still sent to userspace.
>>
>> v2: Remove unneeded check in mptcp_pm_add_addr_received() (Kishen Maloor)
>
> I guess the above should be 'mptcp_pm_rm_addr_received'.
>

Thanks for noticing that, mptcp_pm_rm_addr_received is the function that 
was modified from v1.

--
Mat Martineau
Intel
