Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C5320B
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655507133; x=1687043133;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mi0aOz1VUUzpvZqn68mqxvDvC9T1FUGOsv5vtHGErSI=;
  b=ZswymTVZ0xgHvhkozUyfBTn2nnBwd4+UUpI634HfYYosqdHhSnvOmKUQ
   i+tLBjmM7mVgjq8LACBoc2O3o7aX/BxUvChUNQT6Hbjt7LRIH2KR6uupM
   6dCp9gcmp/Gn96GeoSCKQkkNKlUmSBTQ8NHqtdK/ia/Xz/6aeGg00mnDN
   xdkagGNeAe234daj3LL+7TCPwZNllBlv/740QhzJMd6IcFftVfdwSNVnL
   psdXGqda+85AXFC5Y2rxQBRmwYMJmZDWO8Scz4CeV651judNt2vdpt0qL
   nxfBWO8Wx5iOS4FL42oEwzjWBRgF0BgZvk9Da8Vmu/+IrL0kCC5W5hQAT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268319752"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268319752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642223335"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:05:27 -0700
Date: Fri, 17 Jun 2022 16:05:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 0/6] mptcp: mp_fail related fixes
In-Reply-To: <cover.1655460262.git.pabeni@redhat.com>
Message-ID: <8bbe5bd3-5b56-1fbc-899f-2663a186633@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jun 2022, Paolo Abeni wrote:

> While cooking a follow-up for "mptcp: invoke MP_FAIL response when
> needed" I stumbled upon a few other MP_FAIL related issues hit my
> the self-tests while mangling the above.
>
> All the patches for for the -net tree, and should be applied in-order
> around to the squashed-to patch.
>
> v2 -> v3:
> - do not schedule mp_fail timeout on closed socket in patch 3/6 (mat)
>

Thanks for the v3 Paolo. I have a (non-blocking) question for patch 2 and 
a locking concern for patch 6. But for patches 1-5:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> v1 -> v2:
> - take care of UaF in mptcp_worker with new patch 6/6
>
> Paolo Abeni (6):
>  mptcp: fix error mibs accounting
>  mptcp: introduce MAPPING_BAD_CSUM
>  Squash-to: "mptcp: invoke MP_FAIL response when needed"
>  mptcp: fix shutdown vs fallback race
>  mptcp: consistent map handling on failure
>  mptcp: fix race on unaccepted mptcp sockets
>
> net/mptcp/options.c  |   8 +--
> net/mptcp/pm.c       |   5 +-
> net/mptcp/protocol.c |  57 +++++++++++++++++----
> net/mptcp/protocol.h |  25 +++++++--
> net/mptcp/subflow.c  | 119 ++++++++++++++++++++++++++++++++++---------
> 5 files changed, 170 insertions(+), 44 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
