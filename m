Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADC72
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 00:40:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192149400"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="192149400"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:40:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="475471617"
Received: from navarrof-mobl.amr.corp.intel.com ([10.252.140.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:40:31 -0700
Date: Tue, 27 Jul 2021 17:40:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH v3 mptcp-next 0/3] mptcp: minor out optimization
In-Reply-To: <cover.1627296764.git.pabeni@redhat.com>
Message-ID: <d454c33f-e885-548b-3920-0a8f37b9e31@linux.intel.com>
References: <cover.1627296764.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mon, 26 Jul 2021, Paolo Abeni wrote:

> This series implements a few ideas discussed in the past mtg,
> specifcally:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/15
> https://github.com/multipath-tcp/mptcp_net-next/issues/42
>
> The final goal is shrink the mptcp_out_options struct, which is
> always zeroed by the plain TCP protocol in the output path.
>
> This iteration covers the feedback provided by Geliang (many thanks!)
> on v1:
> - some code moved to new squash-to patch 1/3
> - some cleanup in 2/3
>
> please see the individual patch changelog for the details
>
> Paolo Abeni (3):
>  Squash-to: "mptcp: move drop_other_suboptions check under pm lock"
>  mptcp: optimize out option generation
>  mptcp: shrink mptcp_out_options struct
>
> include/net/mptcp.h  |  26 +++--
> net/mptcp/options.c  | 227 +++++++++++++++++++++++--------------------
> net/mptcp/pm.c       |   9 +-
> net/mptcp/protocol.h |   1 +
> 4 files changed, 142 insertions(+), 121 deletions(-)
>
> -- 
> 2.26.3

Hi Paolo -

This refactoring looks good to me, and the tests pass on my system. Thanks 
for shrinking mptcp_out_options!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
