Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B7620
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668129790; x=1699665790;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=osqnhMjuW24IlTlNtt+IKwJF0sbsAaMpG6RUJxSf8vo=;
  b=AC7vsOsktP7YmC9Wzc2ph034KaP7QYFTfnF+sYNTn7VeM+pxA6c09o9+
   MO0XB/ENXDtjAQMpvS2ktn7kqI4CyHBwcnvqlmqjWHPpbPKjMvsC/Q0cH
   a2Iqi1/Dq59xba17yIxMRinoJJflYl9tEBc9d2ea4/btNMU4rJn1P/sBQ
   3MQOK5SVsvoXFZYSwiZDC7DG0283+UwrowlwhDfY+ScxOzWJOpeshZMM5
   TDY2VPTB1rujZ4m82InbNPefGaIRTW2KPKdvEALzlVZMe1uzbjfreHVIa
   BWmMOpZaaeLg0tE6/8B0tHVMgQYXlhfBvcO0XfAxF4+hp8dnz2AtL5hro
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291214877"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="291214877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:23:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="670573564"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="670573564"
Received: from ssamaraj-mobl1.amr.corp.intel.com ([10.209.53.250])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:23:08 -0800
Date: Thu, 10 Nov 2022 17:23:07 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: more cleanup in mptcp_sockopt.sh
In-Reply-To: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
Message-ID: <384e3619-ec0f-b826-c7d2-122b547f6020@linux.intel.com>
References: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Nov 2022, Matthieu Baerts wrote:

> The first patch was suggested by Geliang in [1].
>
> While at it, I also added more 'local' keywords as we do in other selftests.
> Nothing complex or fancy ;-)
>
> [1] https://lore.kernel.org/all/CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com/
>
> Matthieu Baerts (2):
>  selftests: mptcp: clearly declare global ns vars
>  selftests: mptcp: declare var as local
>
> .../selftests/net/mptcp/mptcp_sockopt.sh      | 65 ++++++++++---------
> 1 file changed, 35 insertions(+), 30 deletions(-)
>
>
> base-commit: 5f9e0bf4aacf217cf06e89defe06867e2b4c6e7d
> -- 
> 2.37.2

Series looks good to me. The CI failure appears to be an intermittent 
issue - I see the same failure on October 14.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
