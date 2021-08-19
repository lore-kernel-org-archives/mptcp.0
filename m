Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F42F80
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 23:20:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238795038"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="238795038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 16:20:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="532694394"
Received: from seedmund-mobl.amr.corp.intel.com ([10.212.221.18])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 16:20:01 -0700
Date: Thu, 19 Aug 2021 16:20:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp
 getsockopt test cases"
In-Reply-To: <20210819134026.1155338-1-matthieu.baerts@tessares.net>
Message-ID: <bddda8b-1340-1554-c41e-236956bcac@linux.intel.com>
References: <20210819134026.1155338-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 19 Aug 2021, Matthieu Baerts wrote:

> selftests: mptcp: ignore mptcp_sockopt
>
> Similar to what was done for mptcp_connect and pm_nl_ctl.
>
> (No need to add "Co-Dev" tag of course)
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: add mptcp getsockopt test cases"

Looks good, please squash!


>
> tools/testing/selftests/net/mptcp/.gitignore | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
> index 260336d5f0b1..7569d892967a 100644
> --- a/tools/testing/selftests/net/mptcp/.gitignore
> +++ b/tools/testing/selftests/net/mptcp/.gitignore
> @@ -1,4 +1,5 @@
> # SPDX-License-Identifier: GPL-2.0-only
> mptcp_connect
> +mptcp_sockopt
> pm_nl_ctl
> *.pcap
> -- 
> 2.32.0

--
Mat Martineau
Intel
