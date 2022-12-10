Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678C7E0
	for <mptcp@lists.linux.dev>; Sat, 10 Dec 2022 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670631451; x=1702167451;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7qc8FaseLiVd6A82N+6ss2tJgIp2ktIim/vR/BMNH8M=;
  b=ItsTA/Bknj/w2jPEx3OY62gWhk014YjO0INpUeVaB69B9H/JAk62tXGO
   rPbaIO0C+44bllIxyYO7i/cmehVafX8vYn+xlk2RkA7o+LwsSLMMKc4FR
   2Mx2o+atQc5Bn65eSqH5VuE9V3LzcIIbZVNl3yfWdWJZ+9aVnyeRDVMFC
   U8DmKdOYMrbd1MqIvYFv8U3YZDMyBNlFlLBrgYH2eeil1Vi/KFM36l6VR
   VDAgzYiPM7Fgs3V5BbRRYC7AtD7IaCIZJ+AB3HzFQr8K+PspEmxLeXpCa
   f9iaXgvTxvcCvPVJ3T4x9rsDhQkNfjeD0yi8rshHYWe7Ze/884Ru2X2D3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="381878072"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="381878072"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:17:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647568103"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647568103"
Received: from blionber-mobl.amr.corp.intel.com ([10.209.9.207])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:17:31 -0800
Date: Fri, 9 Dec 2022 16:17:31 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, 
    Ossama Othman <ossama.othman@intel.com>, 
    Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>, 
    Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
    Dmytro Shytyi <dmytro@shytyi.net>, Christoph Paasch <cpaasch@apple.com>, 
    Geliang Tang <geliang.tang@suse.com>
Subject: Re: [Weekly meetings] Change day/hour?
In-Reply-To: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Message-ID: <f33c7852-bffd-5dd7-12b2-efbc6ce7ba37@linux.intel.com>
References: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 8 Dec 2022, Matthieu Baerts wrote:

> Hello,
>
> At the last meeting, we discussed the idea of re-scheduling the weekly
> meetings we have because some people might not be able to join or prefer
> another moment.
>
> But because we were exceptionally only 3 today because of the feast of
> the Immaculate Conception, we didn't take any decision. Instead, we
> would then like to hear from people who want to participate to know what
> they think about eventually:
>
> - Changing the day to Tuesday?
>  - It might be better to avoid Monday (morning) and Friday (evening).
>  - Wednesday was not OK for today's participants
>
> - Changing the time to have it one hour later?
>  - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
>  - This is late for people in China but midnight is late anyway
>  - Maybe we can also schedule less frequent meetings at a different
> time (or on request), e.g. morning in Europe, afternoon in China?
>  - (the BPF weekly meetings are on Thursdays at 17:00 UTC)
>
> What would be OK or not OK for you? Tuesday or Thursday, same time or
> one hour later?
>

Any of these times work for me.

Thanks,

--
Mat Martineau
Intel
