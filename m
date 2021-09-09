Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636472
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 00:18:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="218774892"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="218774892"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:18:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="469829838"
Received: from rdbrim-mobl3.amr.corp.intel.com ([10.209.14.139])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:18:10 -0700
Date: Wed, 8 Sep 2021 17:18:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, 
    Christoph Paasch <cpaasch@apple.com>, 
    Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH RFC mptcp-next 3/4] mptcp: round-robin packet scheduler
 support
In-Reply-To: <bf211816c921732874fcc66cade7a86c2eaecfa8.camel@redhat.com>
Message-ID: <5397f14c-a48-c4b6-ddb8-80ab97e5dc44@linux.intel.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>  <95d450f9694cf9d95081a77db529db2181d0d3b3.1631011068.git.geliangtang@xiaomi.com> <bf211816c921732874fcc66cade7a86c2eaecfa8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Tue, 7 Sep 2021, Paolo Abeni wrote:

> There is an import side question, already asked by Christoph, why the
> round robin? perhpas we should consider instead some different
> scheduler, known to perform well. @Christoph: which is the 'best'
> mptcp.org scheduler out there? blest?
>

This is the main question I have!

We've also discussed the idea of eBPF-based schedulers, so I've been 
thinking we would have one built-in scheduler and then allow alternatives 
(like round robin) via eBPF.

If there's a good use case for round robin maybe there's a solution here 
similar to what we did with the fullmesh path manager: could there be a 
configuration knob for the existing scheduler that makes it try to *not* 
use the last-used subflow, instead of favoring the last-used subflow?

--
Mat Martineau
Intel
