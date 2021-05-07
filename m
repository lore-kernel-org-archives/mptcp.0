Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6871
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 19:01:14 +0000 (UTC)
IronPort-SDR: qh6Dv+nD60EzqUmAeXdjhukLRx7o9d1Zi8T+0HYHwj0AkLa2Eb983ekfD/TIQW6c00OidXtv95
 P9Fp14Nd8UsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186245621"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="186245621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 12:00:43 -0700
IronPort-SDR: 9zTv6gMLRLj0SAuBBogkDZ1GPd1lE8KAiBjcBuviFX9qvojHPCYSWHW5vOAM4Tx7dienXzhO/S
 P2E9xdU+c8YQ==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431496548"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 12:00:43 -0700
Date: Fri, 7 May 2021 12:00:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
In-Reply-To: <fde1191e-9e7b-a83a-d968-a24fe5467cc7@tessares.net>
Message-ID: <2b569f67-97d4-9733-51d9-7721a41ecb3c@linux.intel.com>
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com> <a73a8ce9-bf15-a94d-e936-444632eaa7dc@tessares.net> <985e6bfb-c31b-47f8-b94-3eef631578e0@linux.intel.com> <fde1191e-9e7b-a83a-d968-a24fe5467cc7@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 May 2021, Matthieu Baerts wrote:

> Hi Mat,
>
> On 07/05/2021 18:45, Mat Martineau wrote:
>> I ran syzkaller for a while and didn't see this crash (but without a
>> reproducer I don't know how definitive that is.)
>
> Thank you for having started the tests!
>
> I think Christoph said he quickly got the warning after having
> re-started syzkaller yesterday at the beginning of the meeting.
>
> Do you see the same issue without the patch?
>

I don't see the issue even without the patch. Code I'm running for that is 
net/master with the "use kmalloc on kasan build" patch from our export 
branch.

> But I guess we can be quite confident here that the bug is fixed :)
>
>> You can add my tag:
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> Done!
>
> - 983511e46a4f: tg:msg: add Mat's RvB tag
> - Results: d76b60f54174..860b49961672
>
> Now available in the export branch and export/20210507T174457 tag
>

--
Mat Martineau
Intel
