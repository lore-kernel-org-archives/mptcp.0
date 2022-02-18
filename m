Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19B48A4
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645208944; x=1676744944;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iR+z1o6DC1GB99vbFr4wYXMe6Dx0N9ZelsrlYyk5lts=;
  b=ffGBrrm6y00+PoSfIcy/VWXjDQuu36V4pe1zOBD6+rgom7l7gjYVwUTt
   WcvzYKCwUQ5vWW4pv8nTjXJD5zQcF4BjYq4FD3nJKghjM/J1mRnoNoW+P
   e/Kp+REayw1oTs4RiDEUozp+Koac7206oHEJ7oafnGAgL9tzrjBWi//YM
   2ujG53RKr7HJyd0AT6Z5PtFUL0k463QyI/+U5Sqyl60gx8JyB52hibU/r
   FZVThKIukwE7EHel5BmnbBmXyht5sceaQpmizNlTMaX3GB0FFas/gs8Ef
   uqOeC8AsmIa9WMG3dpNFgSXq+5+ByTs/6jUG8tlMyFELlogj1YzkdckvV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="311926808"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="311926808"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:29:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="590288078"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:29:03 -0800
Date: Fri, 18 Feb 2022 10:29:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 5/9] selftests: mptcp: join: alt. to exec
 specific tests
In-Reply-To: <1bd2f732-a158-ebc9-3360-61a2ff115e00@tessares.net>
Message-ID: <1ebba12a-45a7-a1c-ef78-27ac9f850d3@linux.intel.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net> <20220217174329.826430-6-matthieu.baerts@tessares.net> <5a7dabe8-c4bf-99d0-4b8e-96c6823ba8f7@linux.intel.com> <1bd2f732-a158-ebc9-3360-61a2ff115e00@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Feb 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/02/2022 01:35, Mat Martineau wrote:
>> On Thu, 17 Feb 2022, Matthieu Baerts wrote:
>>
>>> Running a specific test by giving the ID is often what we want: the CI
>>> reports an issue with the Nth test, it is reproduceable with
>
> (should be "reproducible")
>
>>> ./mptcp_join.sh N
>>>
>>> But this doesn't work when a test is unstable and it is needed to find
>>> since when it is unstable because the ID is a counter and new tests can
>>> be added before changing the ID of a specific test.
>>>
>>
>> Could you rephrase or split up this sentence to make it easier to parse?
>
> Wow, I was really tired when I wrote and even reviewed that :)
>
> I hope the following text is better:
>
> But this might not work when there is a need to find which commit has
> introduced a regression making a test unstable: failing from time to
> time. Indeed, a specific test is not attached to one ID: the ID is in
> fact a counter. It means the same test can have a different ID if other
> tests have been added/removed before this unstable one.
>

Yes, that works!

--
Mat Martineau
Intel
