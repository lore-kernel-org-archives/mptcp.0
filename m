Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA33D6C
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518635; x=1688054635;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v9MAFGw+D+q8fA+Ns6zzRoGuUsqeS7sHEgJGDYMRdgs=;
  b=asWW8uwVuKLh3oAhtp6L+DpAK3sDaqKUhYWNCninaHcJbiMyxZFYVYSo
   zrPhZKMgO30Tfpf9qWjHFid4SuvX+S0t8s1OBDtXdpPb15QphdFYsm+as
   DMScWZBUZ+WsphZXg8SN/X8MpzXf4wHVPFhRhJNahUFkJtM287GaWXpdI
   rhu9cO5Lg9UZyV9cmPFCDD6f/+QE1pjNdCB+cVDXsIeu2qy9yn6Rl/15F
   L5q7lsMJgSd8vQOXwhMNkmf3ez889wy/oxXL2nPXI61sdd+72IkLBhxRr
   XfLlabUktkvCO4Qy5T71E4OFzvpgmBEeD1EpWpTue735vC2NKzR+UbBii
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346060678"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="346060678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:03:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595289152"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:03:54 -0700
Date: Wed, 29 Jun 2022 09:03:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <9bfd377923a2c200ff8be000dcbe6b378504f8bd.camel@redhat.com>
Message-ID: <7f39b3d3-3681-48cf-d656-a778c7a367eb@linux.intel.com>
References: <20220629012702.425574-1-kishen.maloor@intel.com>  <144ee4af-c481-ffd3-1eae-151557d28e9c@linux.intel.com> <9bfd377923a2c200ff8be000dcbe6b378504f8bd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Jun 2022, Paolo Abeni wrote:

> On Tue, 2022-06-28 at 20:37 -0700, Mat Martineau wrote:
>> On Tue, 28 Jun 2022, Kishen Maloor wrote:
>>
>>> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
>>> to issue MP_PRIO signals over a selected (by local and remote address+port)
>>> subflow in a MPTCP connection. It also adds self tests for this
>>> change.
>>>
>>> This patch series has been rebased to the series (in review) titled
>>> "Locking fixes for subflow flag changes".
>>>
>>> v2:
>>> -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.
>>>
>>> v3:
>>> -use local and remote address+port (instead of address ID) alongwith the
>>> connection token to select a subflow.
>>>
>>> v4:
>>> -fixed bug during rebase in v3.
>>
>> Thanks Kishen. v4 looks good to me, and the builds look good (I pushed
>> equivalent commits to github to trigger a build):
>>
>> https://cirrus-ci.com/build/6289402744799232
>> https://github.com/multipath-tcp/mptcp_net-next/runs/7103422638
>>
>> Looks like the github action got a little confused by the exact version of
>> the patches not being in patchwork.
>>
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>> At the meeting last week Paolo said he was planning to take a look as
>> well.
>
> LGTM, too.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

Thanks for the ack.

As Kishen noted above, this series depends on "Locking fixes for subflow 
flag changes" - have you had a chance to look at that one? Like I 
mentioned in the other thread, it's almost a match for your locking 
changes in the RFC MPC MP_PRIO series.

--
Mat Martineau
Intel
