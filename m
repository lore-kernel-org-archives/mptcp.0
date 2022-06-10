Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210577A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654891176; x=1686427176;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yUqjYbg9XEfuol0E9AvETNcK/5MwJ8Do8WYSgi731to=;
  b=WGFCYvfhMu3xq075pOZwNnFU10JxNPYp1kepN5Hkfv3mBiezJm2E8BrQ
   msyf1tNF5CeObXQwjFCLOBC9K9ksDWPs3MJb7YxePFf/O+8SehIQiRF6G
   l07LxErYq2vy6imHYVgi7q6UcyLxSUSMJ+loxqUMFdPbo12wq5Dyq/T6w
   LxY2AHI/pmGRYzDPIbpwkXp8CfdLEoKIituW61aUj7BHOcoGBNVzTPJ8G
   sUrRJCXvA5gkg9qiw41nssxRcVBmV2USay5wAZMyA2X1QABhmOHoyroM3
   6cDWIYwQHLJa46p2S3wN5ibs3CXJL5Y/XG1lTuho8E3SM7FqvYhlDhEff
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278531318"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="278531318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 12:59:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="909088282"
Received: from efbarbud-mobl1.amr.corp.intel.com (HELO csouzax-mobl2.amr.corp.intel.com) ([10.212.104.59])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 12:59:27 -0700
Date: Fri, 10 Jun 2022 12:59:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, Ossama Othman <ossama.othman@intel.com>, 
    davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
    matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] mptcp: fix conflict with <netinet/in.h>
In-Reply-To: <20220610111607.38b003e1@kernel.org>
Message-ID: <a74a82cf-130-9eef-d128-2c88e081ba31@linux.intel.com>
References: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com> <20220608191919.327705-2-mathew.j.martineau@linux.intel.com> <20220609225936.4cba4860@kernel.org> <d4c74484-da9-8af3-e25b-93de29443840@linux.intel.com>
 <20220610111607.38b003e1@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Jakub Kicinski wrote:

> On Fri, 10 Jun 2022 11:00:28 -0700 (PDT) Mat Martineau wrote:
>> This is a minor "fix" to be sure, which I thought did not meet the bar for
>> net and therefore submitted for net-next. It's not prep for another
>> change, it's something Ossama and I noticed when doing code review for a
>> userspace program that included the header. There's no problem with kernel
>> compilation, and there's also no issue if the userspace program happens to
>> include netinet/in.h before linux/mptcp.h
>>
>>
>> If my threshold for the net branch is too high, I have no objection to
>> having this patch applied there and will recalibrate :)
>>
>> Do you prefer to have no Fixes: tags in net-next, or did that just seem
>> ambiguous in this case?
>
> The important point is that the middle ground of marking things as fixes
> and at the same time putting them in -next, to still get them
> backported but with an extended settling time -- that middle ground
> does not exist.
>
> If we look at the patch from the "do we want it backported or not"
> perspective I think the answer is yes, hence I'd lean towards net.
> If you think it doesn't matter enough for backport - we can drop the
> fixes tag and go with net-next. Unfortunately I don't have enough
> direct experience to tell how annoying this will be to the user space.
> netinet/in.h vs linux/in.h is a mess :(
>

By that criteria, I lean towards net too. Thanks Jakub.

--
Mat Martineau
Intel
