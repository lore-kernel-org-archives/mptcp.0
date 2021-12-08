Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C7173
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 23:19:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237915253"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="237915253"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 15:19:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="680105845"
Received: from mnepal-mobl2.amr.corp.intel.com ([10.209.68.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 15:19:19 -0800
Date: Wed, 8 Dec 2021 15:19:19 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next] mptcp: add support for changing the backup
 flag
In-Reply-To: <c7c976ee-2510-858e-c075-25add945bc3b@tessares.net>
Message-ID: <3482aa7d-c838-f3c-e2cd-5cd64bc4d8b6@linux.intel.com>
References: <cb2ddffb2211d6fdde7a8bf81879a3a83c620f00.1638542999.git.dcaratti@redhat.com> <8a517-d825-f27c-1fe4-4dceae4fd2d7@linux.intel.com> <c7c976ee-2510-858e-c075-25add945bc3b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 8 Dec 2021, Matthieu Baerts wrote:

> Hi Mat, Davide
>
> On 08/12/2021 02:59, Mat Martineau wrote:
>> On Fri, 3 Dec 2021, Davide Caratti wrote:
>>
>>> Linux supports 'MPTCP_PM_CMD_SET_FLAGS' since v5.12, and this control has
>>> recently been extended to allow setting flags for a given endpoint id.
>>> Although there is no use for changing 'signal' or 'subflow' flags, it can
>>> be helpful to set/clear the backup bit on existing endpoints: add the 'ip
>>> mptcp endpoint change <...>' command for this purpose.
>>>
>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
>>> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Matthieu -
>>
>> Since you already Acked, what should be the status of this in patchwork?
>
> I just set the status as "Awaiting Upstream". Is it OK for you for
> patches for other trees?
>

Sure, that status makes sense.


--
Mat Martineau
Intel
