Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2C72
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 16:45:31 +0000 (UTC)
IronPort-SDR: E5nri983ZhNVcclN+8eUxOW8ipzGCfPt4lPa3AsLR6UjfZFCaFgceFf+Z+TeXA/E+AcVmchEVJ
 kqVXFI3Xemqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="219670599"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="219670599"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 09:45:30 -0700
IronPort-SDR: zLKZPAAbn21LV1euiUgZ5IYrw3mbDPdVgIhBzZZuMtaOOMrJaGYQGcqWzTZyJ33QKAyE3yGuY1
 4elsqU0ZX/zA==
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="622933676"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 09:45:30 -0700
Date: Fri, 7 May 2021 09:45:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
In-Reply-To: <a73a8ce9-bf15-a94d-e936-444632eaa7dc@tessares.net>
Message-ID: <985e6bfb-c31b-47f8-b94-3eef631578e0@linux.intel.com>
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com> <a73a8ce9-bf15-a94d-e936-444632eaa7dc@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 7 May 2021, Matthieu Baerts wrote:

> Hi Paolo, Florian, Mat,
>
> On 06/05/2021 19:24, Paolo Abeni wrote:
>> We can't use tcp_set_congestion_control() on an mptcp socket, as
>> such function can end-up accessing a tcp-specific field -
>> prior_ssthresh - causing an OOB access.
>>
>> To allow propagating the correct ca algo on subflow, cache the ca
>> name at initialization time.
>>
>> Additionally avoid overriding the user-selected CA (if any) at
>> clone time.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/182
>> Fixes: aa1fbd94e5c7 ("mptcp: sockopt: add TCP_CONGESTION and TCP_INFO")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Thank you for the patch and the review!
>
> I just applied the patch with Florian's Ack, a fix for the typo spot by
> Mat but not RvB tag for Mat (@Mat: I guess you are OK with the patch but
> it is unclear :) )
>
> - 20744dcd6f36: mptcp: avoid OOB access in setsockopt()
> - c69b45723290: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
> - Results: 37818f5e301f..837dc82fa10b
>
> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210507T154124
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210507T154124
>

Hi Matthieu -

I ran syzkaller for a while and didn't see this crash (but without a 
reproducer I don't know how definitive that is.)

You can add my tag:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
