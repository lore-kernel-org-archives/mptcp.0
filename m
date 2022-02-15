Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C31164
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 01:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644889452; x=1676425452;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q8PgSROLjlQiFmW6EfwLqstf+P2WVDeW+ZCoHsSzStk=;
  b=gAbv4NFnyQRrUT/KfBPHR0CWMEjjPHC+Vtg4zPSS9foH1UvOJ/9MNhbQ
   AyL9ZjDDunyOdGXF+ToE/oM+IgmwwAiUPR783VWlxwFVufVUfxKvxpjAk
   G98kN/fC5Jbar5tddeNZ3ipM/eI7V3ajhKsOuOhW5TPcBd7AK7VBkhn3V
   uBdpgn8QqFPGTQ5ZaYqkmPtDVcFymOy35FyAPcOZ41LLwxFA888GgN4LY
   oO9SxlIWH95QW57pXygRpbPZh7U+0BuA7T++m+OIFgFodO3UubYBSHAwr
   S5VguJLtdSzptRYR/xpBKqyaDIWy/9/Xitu7YD5flp26BJIYXjR2lUSsx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249057332"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="249057332"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:44:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="528548541"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:44:07 -0800
Date: Mon, 14 Feb 2022 17:44:07 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] dump infinite_map in trace event
In-Reply-To: <cover.1644819421.git.geliang.tang@suse.com>
Message-ID: <9c9def71-95f6-f6d0-262a-f7d9de0579@linux.intel.com>
References: <cover.1644819421.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 14 Feb 2022, Geliang Tang wrote:

> Small patches for dumping newly added infinite_map in trace event.
>
> Geliang Tang (2):
>  mptcp: dump infinite_map field in mptcp_dump_mpext
>  mptcp: add tracepoint in mptcp_sendmsg_frag
>
> include/trace/events/mptcp.h | 10 ++++++++--
> net/mptcp/protocol.c         |  1 +
> 2 files changed, 9 insertions(+), 2 deletions(-)
>

Thanks Geliang, I tried out the trace events and all worked as expected 
for both mptcp_sendmsg_frag and get_mapping_status events with 
infinite_map output.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
