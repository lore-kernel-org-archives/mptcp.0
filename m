Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109E29A0
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652283156; x=1683819156;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q9XJSrCgzXBFy1Z2lk0YIj+PaaHQmuAKIY/oeBJoB2U=;
  b=KykgEKpAyEY0SbEFZ4nq4arhtOpKfY7llLfDOi38UKiz0FZVV1ogeOwS
   MrX4LlmYHOjvMsK4NsAWyGqjdwrTE0863/UVpD5ZlDTGDbj81OZjh8LPj
   89hjsmd6pDUTo5sXZNjQDvP/98cAd0o/crKLU1lrOFwOf6VSY/MauXAUA
   BUsfifi0UdCcUSHQ144UHf72RmZ6eNVgSbbyppqgo739XTpHuIcakArLB
   TZ/iaHnNahDXLbJ7itBT8i28VHjMfJWSBVOj04KIAXeMzlGH53t++pXuN
   nUnY/RUarL+6Tue2Bf4Oq2xIE9aWb3bwyvPkIZEs/vSyZD2ioPChbI10V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269862955"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269862955"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:32:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="572134138"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:32:24 -0700
Date: Wed, 11 May 2022 08:32:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: problems with MP_FAIL timer
In-Reply-To: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
Message-ID: <88834512-46aa-604e-9e25-a17c13a6986@linux.intel.com>
References: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1758220211-1652283144=:12238"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1758220211-1652283144=:12238
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 May 2022, Paolo Abeni wrote:

> Hello,
>
> re-reviewing again the commit:
>
> mptcp: reset subflow when MP_FAIL doesn't respond
>
> There are a few issue with sk_timer handling, specifically:
> - no additional mptcp_data_lock is needed to stop/reset it
> - I think overlapping infinite mapping reception and close may lead to
> some inconsistent timer usage
>

I'm working on a patch for this.

The issues you describe are what I was trying to comment on in
https://lore.kernel.org/mptcp/bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com/, 
but my proposed solution (deferred events for coordinating with 
msk->sk_state) isn't the way to fix it.

I think checking the subflows for SOCK_DEAD before changing the timer 
should prevent bad interaction with msk close, since the subflows are 
always orphaned before the msk resets sk_timer.

> More importantly I could not find the RFC reference for such
> timer?!? @Geliang, @Mat could you please point that out?!?
>

The RFC doesn't specify what to do if the peer ignores the MP_FAIL. 
Resending seemed to be hard to resolve correctly (what if it turned out to 
be a duplicate?), so the choice was to revert to the reset behavior after 
a timeout.

--
Mat Martineau
Intel
--0-1758220211-1652283144=:12238--
