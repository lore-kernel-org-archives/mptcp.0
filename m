Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FA2F24
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644454547; x=1675990547;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fMaY/Df4uqsPcQEwIQHhDqyRrjvF4MHS9xWGIZDIFUQ=;
  b=OI98kfWyyqHOa90fmo136gDS5sy8BmGu1v1N6ctZMyZSEfFHYn5+MPZn
   jHMNNoNRDapUWRJBxG1xOKrWEBwARWKQnD04t80VxMGE5UvF4xUId6MC2
   6kXICajU7+TCF+Ksh8g1+gTkwmiqflRt4kBQgd5oSXeWaa8e3QnzbORIS
   /Z0zeFLOXO8rkUFbnQzRr1EddYktG5C+puHX7+UZPZq+ylZ+2Fdn2Q+P+
   Sre7Jv1SDCfrQeoMpU8oFl2UA3hPIO90bKg0974llS2w6cG4y8n/If8PH
   h0hjwKILQrbTK3n8HBJ0N7ry6cD8FB1WXTWO34zgkgP9zKN93FB1+J8pU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312667951"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="312667951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:55:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678968667"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:55:46 -0800
Date: Wed, 9 Feb 2022 16:55:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: improve 'fair usage on
 close' stability
In-Reply-To: <d938eba9-0bbd-8cea-9148-a36afadbb31a@tessares.net>
Message-ID: <1fa1f387-d647-de45-83ee-34182e67de5d@linux.intel.com>
References: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com> <d938eba9-0bbd-8cea-9148-a36afadbb31a@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 5 Feb 2022, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 04/02/2022 19:33, Paolo Abeni wrote:
>> The mentioned tests has to wait for a subflow creation failure. The
>> current code looks for TCP sockets in TW state and sometimes misses
>> the relevant event. Switch to a more stable check, looking for the
>> associated mib counter.
>
> Thank you for the patch and the review!
>
> It has been running all night on my side, more than 2000 attempts,
> without issues!
>
> Now in our tree (fixes for -net) with Fixes, my R&Tb and Mat's

Hi Matthieu -

I noticed both this patch and "selftests: mptcp: fix diag instability" 
were listed as mptcp-next, but queued in the export branch in the "fixes 
net" section. Is this accidental or did I miss some discussion?

Thanks,

Mat

> RvB tags:
>
> - c43e2e4ed88d: selftests: mptcp: improve 'fair usage on close' stability
> - Results: 3150c57070f7..1baae8d646d8
>
> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220205T103656
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
>
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
>

--
Mat Martineau
Intel
