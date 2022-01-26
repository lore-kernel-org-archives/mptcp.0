Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDD173
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643161538; x=1674697538;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9YSGDd4FYMZTb3zcOGiZJ/ZCrcmiFF7E26ISWhrd0rI=;
  b=Lp85fxHIbPRksiXP1GTHG2tOZ08VdcIgz2CoCdjG/wgbFhPqnwWWXmv+
   OVdIpaAvErthLKh57qwUuvo5NC0Mq1LNEP6V53msaLUYyFMyiqClrqCvC
   lsrkyPveS0RsjNKRVVYaQg374QfXdPV0mwc177/x354XuIV1pr150bNrL
   WKKG2JCU8SMpAcjV6hyW6vO6vT1H08WdH1NUwx41zYFD0ZtWPUQ2GCJCv
   jDLKcfzmfk8khgBFCmaKnWRQ5f/rnggetSex0AHhXTMXjWWIqs6TQiIvs
   OQPDam5S9tSiwaFP/HlD4MhVTm2D1JYTU/uJryhJS8NRjEZdgayqJT08O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309775231"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="309775231"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:45:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="769235192"
Received: from vsanjeep-mobl.amr.corp.intel.com ([10.212.157.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:45:37 -0800
Date: Tue, 25 Jan 2022 17:45:36 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: add set_flags tests
 in pm_netlink.sh
In-Reply-To: <8115efcc945fc08172f8454947d12b4434375f43.1643076075.git.geliang.tang@suse.com>
Message-ID: <7a745b37-7780-4418-e272-96e9a82299a6@linux.intel.com>
References: <cover.1643076075.git.geliang.tang@suse.com> <8115efcc945fc08172f8454947d12b4434375f43.1643076075.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 25 Jan 2022, Geliang Tang wrote:

> This patch added the setting flags test cases, using both addr-based and
> id-based lookups for the setting address.
>

Thanks for adding the checks!

> The output looks like this:
> set flags                                          [ OK ]
>                                                    [ OK ]
>                                                    [ OK ]
>                                                    [ OK ]
>                                                    [ OK ]

One more small thing to ask: These empty lines could make it harder to see 
what failed, especially in reports from CI that might not show the full 
output of the script.

How about:

set flags (backup)                                 [ OK ]
set flags (nobackup)                               [ OK ]
set flags (fullmesh)                               [ OK ]
set flags (nofullmesh)                             [ OK ]
set flags (backup,fullmesh)                        [ OK ]

?

-Mat


>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/pm_netlink.sh  | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index cbacf9f6538b..ae735a380123 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -164,4 +164,22 @@ id 253 flags  10.0.0.5
> id 254 flags  10.0.0.2
> id 255 flags  10.0.0.3" "wrap-around ids"
>
> +ip netns exec $ns1 ./pm_nl_ctl flush
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
> +ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow,backup 10.0.1.1" "set flags"
> +ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow 10.0.1.1" ""
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow,fullmesh 10.0.1.1" ""
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow 10.0.1.1" ""
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow,backup,fullmesh 10.0.1.1" ""
> +
> exit $ret
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
