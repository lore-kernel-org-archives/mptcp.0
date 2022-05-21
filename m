Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CE7E
	for <mptcp@lists.linux.dev>; Sat, 21 May 2022 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653092320; x=1684628320;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=176zx5fBs0ogsyZSc6kCZQHDskY6rmR/x9XN3xJtc44=;
  b=OtxRMgg5LQty9vkdYYLP3b2BhyYePx4bbc0WYczzQUmhOZkfFIhXlA4l
   2U/t0xluXop8NhQeX3WsFMr/CCNKH0BgepCx6vF1TN4N9DzL92283njfE
   yF/j33pUSK7iu7L6gkcLMOCCJdirk0vT8/ja2+kzo+SKPrwH6Be3toDiK
   D8e/kWnLpe3t6NHbuHAkGC9WfSE+o7Eo5/D9aK0xujFbyeDsCxSK1cDN+
   ofug3Babnn4YQ+gYHXQ8KoYzG5jiKcRVH8JyZb2j9/73r19blxeyirrvH
   WBWSgGvXqbI+nv3veV8KjIaU15d3motAYvKhhmUTROs3FIU6MF84mU6jl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="260362133"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="260362133"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:18:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="524887982"
Received: from ofirfata-mobl1.amr.corp.intel.com ([10.209.118.159])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:18:39 -0700
Date: Fri, 20 May 2022 17:18:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Ossama Othman <ossama.othman@gmail.com>, mptcp@lists.linux.dev, 
    Ossama Othman <ossama.othman@intel.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix conflict with <netinet/in.h>
In-Reply-To: <e5d644c4-b190-412f-967a-8a79bfaf0f9b@tessares.net>
Message-ID: <bd93114f-b693-cf60-9f42-f83543354499@linux.intel.com>
References: <20220519153929.214331-1-ossama.othman@intel.com> <f4baa4-81e6-21df-80a5-13eb15317559@linux.intel.com> <e5d644c4-b190-412f-967a-8a79bfaf0f9b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 20 May 2022, Matthieu Baerts wrote:

> Hi Ossama, Mat,
>
> On 20/05/2022 02:05, Mat Martineau wrote:
>> On Thu, 19 May 2022, Ossama Othman wrote:
>>
>>> Including <linux/mptcp.h> before the C library <netinet/in.h> header
>>> causes symbol redefinition errors at compile-time due to duplicate
>>> declarations and definitions in the <linux/in.h> header included by
>>> <linux/mptcp.h>.
>>>
>>> Explicitly include <netinet/in.h> before <linux/in.h> in
>>> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
>>> compatibility logic in <linux/libc-compat.h> is enabled when including
>>> <linux/mptcp.h> in user space code.
>>>
>>> Signed-off-by: Ossama Othman <ossama.othman@intel.com>
>>
>> Looks good to me, I think this makes things easier for userspace.
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> Thank you for the patch and the review!
>
> Do you mind if I add this Fixes tag?
>
> Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
>
> Or do you prefer without it not to have it backported?
>

Fixes tag is good, thanks! I will probably cc: stable on this one.

--
Mat Martineau
Intel
