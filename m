Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285C7F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 22:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659478263; x=1691014263;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7xXkpzVNuPeQWv3xP0Vya/cMot0kX82VQ1/PS252PjU=;
  b=iulIdZYASCBtedSZPV7uante+89aHjQoOcLYq3B1bsai/5qWjXbv25hB
   3iNnkRENYuXYT2FjoNLdNcqrc+1wYPeMBcqjmXY8SSg7Oht7dXksBnXpL
   3nRRRgtwGGanZM74ad/qYc7ql1Y4/k+jM+GI/bKgOIamQC3fGGNHwBOmK
   CPUHen3oFtCBd/gLQMVzY+lL3Gxv0FVTN3GERrR9Mm4PDGW3+spwiMets
   i/fJLP+6w7t2F/n/X6cEgsNUFjPlxgjcvc9A5a78m6wul3pLxmCdVfC+A
   gAfjTn6RZoLkNMwMitzUDU/SpZZpfXVRwwApCsgrnrENZLSTmZZIDTkDd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269300412"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269300412"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:11:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="930147224"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:11:02 -0700
Date: Tue, 2 Aug 2022 15:11:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 0/4] mptcp: just another receive path
 refactor
In-Reply-To: <9f161078dfd130882b9d9bfea2a76b3d89fdc42e.camel@redhat.com>
Message-ID: <ba2ec96f-aee3-8c96-e18b-75a666d14488@linux.intel.com>
References: <cover.1659165378.git.pabeni@redhat.com> <9f161078dfd130882b9d9bfea2a76b3d89fdc42e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 1 Aug 2022, Paolo Abeni wrote:

> On Sat, 2022-07-30 at 10:04 +0200, Paolo Abeni wrote:
>> This is a refresh and rebase of an already shared work:
>>
>> https://lore.kernel.org/mptcp/cover.1621963632.git.pabeni@redhat.com/
>> [1]
>>
>> The motiviation for refreshing this is:
>>
>> https://lore.kernel.org/mptcp/YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020/
>>
>> specifically it looks like that properly attaching mem_cg to the
>> msk socket would be (much?) easier if the RX path and the fwd memory
>> allocation would be under msk socket lock protection.
>>
>> The first 2 patches are proably worthy even without the refactor,
>> but specifically the 2nd one is required to get a good mptcp-level
>> acking behavior when we move the rx under the socket lock.
>>
>> The 3rd patch does the real work, and the 4th is a follow-up cleanup.
>>
>> Back at [1], I measured relevant performance regressions in some
>> specific cases. I've done the same test here and I now see little to
>> noise changes. I guess that is mostly due to the better acking
>> strategy already introduce with commit 949dfdcf343c ("Merge branch
>> 'mptcp-improve-mptcp-level-window-tracking'") and refined here.
>>
>> v2 -> v3:
>>  - dropped obsoleted comment in patch 2/4
>>  - fixed compile warning in patch 3/4
>>
>> v1 -> v2:
>>  - fix build issue in patch 3/4 due to PEBKAC
>>  - added missing commit messages(!!!) in patch 3/4 & 4/4
>>
>> Paolo Abeni (4):
>>   mptcp: move RCVPRUNE event later
>>   mptcp: more accurate receive buffer updates
>>   mptcp: move msk input path under full msk socket lock
>>   mptcp: use common helper for rmem memory accounting
>>
>>  include/net/mptcp.h  |   2 +
>>  net/ipv4/tcp.c       |   3 +
>>  net/mptcp/options.c  |   1 -
>>  net/mptcp/protocol.c | 219 +++++++++++--------------------------------
>>  net/mptcp/protocol.h |  12 ++-
>>  5 files changed, 68 insertions(+), 169 deletions(-)
>
> I *think* there is a litte more self-tests instability with series
> applied, specifically on simult_flows, and mptcp_join 32 && 99.
>
> Behind the CI report I also observed a few sporadid failures there.
>
> I'm wild guessing that the mpj failures are caused by the subflow
> socket lock being acquired/relased more often under the msk socket lock
> , possibly changing the timing for some events.
>
> I still have to investigate the above.
>
> I think we could still consider merging this on the export branch, and
> later try to hammer the issue on the branch (to get more coverage from
> the bots).
>
> WDYT?
>

I think that's a good plan. Tests are running ok on my test VM and the 
code looks ok, and I agree your wild guess is plausible.

It's also a good time to let it bake a bit in the export branch, with 
net-next being newly closed.

For the series:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
