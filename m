Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC872
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 20:39:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210055270"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="210055270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 13:39:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="412573980"
Received: from tpierc1x-mobl1.amr.corp.intel.com ([10.209.110.90])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 13:39:09 -0700
Date: Tue, 13 Jul 2021 13:39:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
In-Reply-To: <CA+WQbwtGmfH7JtZUAUN7deZwVwJ=9o_7dZCk=7gC7h63sQMMZA@mail.gmail.com>
Message-ID: <656b5aa6-f697-a35-2aa6-53ec2aec2cfc@linux.intel.com>
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com> <f0920ba1126ff81aa1acbff47e805e5573c64abc.1626158123.git.geliangtang@gmail.com> <CA+WQbwtGmfH7JtZUAUN7deZwVwJ=9o_7dZCk=7gC7h63sQMMZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 13 Jul 2021, Geliang Tang wrote:

> This squash-to patch will conflict with "mptcp: remove
> MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT":
>
> Auto-merging net/mptcp/protocol.h
> CONFLICT (content): Merge conflict in net/mptcp/protocol.h
> Auto-merging net/mptcp/pm.c
> error: could not apply bf1fec79a2bf... mptcp: remove
> MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
>
> Please fix it like this:
>
> <<<<<<< HEAD
> static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
> {
>         return (mptcp_pm_should_add_signal_addr(msk) &&
> msk->pm.local.family == AF_INET6) ||
>                 (mptcp_pm_should_add_signal_echo(msk) &&
> msk->pm.remote.family == AF_INET6);
> }
>
> static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
> {
>         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.port) ||
>                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.port);
> }
>
> =======
> >>>>>>> bf1fec79a2bf (mptcp: remove MPTCP_ADD_ADDR_IPV6 and
> MPTCP_ADD_ADDR_PORT)
> static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> {
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
> }
>
> ->
>
> static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
> {
>         return (mptcp_pm_should_add_signal_addr(msk) &&
> msk->pm.local.family == AF_INET6) ||
>                 (mptcp_pm_should_add_signal_echo(msk) &&
> msk->pm.remote.family == AF_INET6);
> }
>
> static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
> {
>         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.port) ||
>                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.port);
> }
>
> static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> {
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
> }
>
>

Well, it looks like I gave my Reviewed-by tag too soon. I think it would 
be easier to get the correct results by posting more revisions of the 
patch set - don't want to introduce mistakes when trying to resolve these 
conflicts when applying to mptcp_net-next repo!

Geliang and Yonglong, what do you think about posting v9, possibly with 
co-developed-by tags?


--
Mat Martineau
Intel
