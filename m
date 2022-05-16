Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F732577
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652741788; x=1684277788;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qeBWt9sFz0qhBj6THXmPyx42/x9n80C4nO36vfGOiRk=;
  b=BP45YHnyk4Ov1Wlb2EoJr2CX+j3QgjymZIrgb1NJ9N3DmGB7Jk/OVHWj
   tJSASaqXU9MtqIwk0dVDMQDxt7K9qFZwQDOyvVTogcnb8sZHorg5RhoU3
   bZV5mSSQjL2JJ2LBaTLIuAMQXZGiJd6ZfYm12MCQQcjA3K8fdWCTGzk4S
   Rx/BRKQZ/58D6bRB6mwCFkTS7pKU93rrvhzlHKC46I5Bw4JEWkCf1UwQA
   IrvV44lDYvOLm0w6uGYFBLk0e+qO1Ti9EDvGP3OEXHXzhBdz7mCqxxQ8w
   ajNQMbbZULYN3O1G6xwYKphiXu0oylmE/aB8WP+xByzrj4StYkurljBbB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="250885552"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="250885552"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 15:56:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="626172172"
Received: from scrowley-mobl1.amr.corp.intel.com ([10.212.97.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 15:56:27 -0700
Date: Mon, 16 May 2022 15:56:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: test
 bpf_skc_to_mptcp_sock"
In-Reply-To: <896634ab-bb72-bbc0-19c8-4e14b6ead723@tessares.net>
Message-ID: <763216a-c627-c4ae-ccae-4042575246c3@linux.intel.com>
References: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com> <45f492b2-1b41-9681-2fac-9cd59dd0f6b@linux.intel.com> <896634ab-bb72-bbc0-19c8-4e14b6ead723@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 14 May 2022, Matthieu Baerts wrote:

> Hi Mat, Geliang,
>
> On 11/05/2022 01:03, Mat Martineau wrote:
>> On Tue, 10 May 2022, Geliang Tang wrote:
>>
>>> Drop bpf_mptcp_helpers.h, squash into bpf_tcp_helpers.h (Andrii)
>
> Thank you for the patch!
>
>> Hi Geliang -
>>
>> Since there are 6 different commits touching bpf_mptcp_helpers.h, maybe
>> it would be easier for Matthieu if you posted the full patches for
>> "selftests/bpf: test bpf_skc_to_mptcp_sock" and all the bpf patches
>> after that, instead of squash changes / instructions?
>>
>> I'm not sure the instructions below translate well to topgit.
>
> Sorry for the late reply. In fact, I prefer to get squash-to patches
> instead of reworded patches where I need to find differences :-)
>

Noted, I should have spoken for myself :)

I was hoping you would not need to find any differences if the old patches 
were dropped in favor of a fresh import of the new ones, but I was 
making a lot of assumptions there.

> If there are conflicts, I'm usually fine with some explanations in the
> commit message. Here, the conflicts are easy to resolve: just move the
> content of one file to another one. For these conflicts, I don't even
> need the detailed instructions but that's always useful, just in case.
>
> If the conflicts are harder to resolve, sharing a Git branch on a public
> repo is an easy way for me to compare the resolution I did with the
> expected one.

I do agree this is the best thing to do in general.


--
Mat Martineau
Intel
