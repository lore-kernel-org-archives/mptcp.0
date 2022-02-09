Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295342F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644368059; x=1675904059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BMN6mZkhYQl/Z1Grx+ZylV06PC9MlzRdCWphcC24tgI=;
  b=W/mJqRjapCpI88s6eDmc0aV1k9UZxew2slZ+5XavHk6dnt5XxJEWHKo9
   GHKOsnS/gIlVF+f+ui+4VJTM/gKXjYb4v52kSy4JgAUoVpzSCvo8CUV7X
   U0HCu35eyynNHQzhcYYs5qAfMxsPV/n9CFRGQ/4HCwpfXYbpYpgnHyWna
   z6B9usLxlr2tS2267txJhLg+3OTQNUKc5BehI5jiXiqzVcKjuTobjSxSI
   g2j0Laj+VsTXd+NakF8VoLZiNPo8Y/p1p9Khkw4XRfudPjj4vqtkamb2d
   LLnMyRSZZJ7AbzBszEeIOLnPF3a5aL4RDSMadyUbi4W7dQhcLsx4GhBat
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="247922756"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="247922756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:54:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="678294347"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:54:07 -0800
Date: Tue, 8 Feb 2022 16:54:06 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 1/4] mptcp: fix race in overlapping signal
 events
In-Reply-To: <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644346664.git.pabeni@redhat.com>
Message-ID: <5b78d02e-c47c-7ecb-f0d0-8464f71ed49b@linux.intel.com>
References: <cover.1644346664.git.pabeni@redhat.com> <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644346664.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Feb 2022, Paolo Abeni wrote:

> After commit a88c9e496937 ("mptcp: do not block subflows
> creation on errors"), if a signal address races with a failing
> subflow creation, the subflow creation failure control path
> can trigger the selection of the next address to be announced
> while the current announced is still pending.
>
> The above will cause the unintended suppression of the ADD_ADDR
> announce.
>
> Fix the issue skipping the to-be-suppressed announce before it
> will mark an endpoint as already used. The relevant announce
> will be triggered again when the current one will complete.
>
> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 93800f32fcb6..fb8d4bfcfbd6 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -546,6 +546,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
> 		local = select_signal_address(pernet, msk);
>
> +		/* due to racing events on both ends we can reach here while
> +		 * previous add address is still running: if we invoke now
> +		 * mptcp_pm_announce_addr(), that will fail and the
> +		 * corresponding id will be marked as used.
> +		 * Instead let the PM machinery reschedule us when the
> +		 * current address announce will be completed.
> +		 */
> +		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))

There is a helper for this: mptcp_pm_should_add_signal_addr()
(which also uses READ_ONCE())


> +			return;
> +
> 		if (local) {
> 			if (mptcp_pm_alloc_anno_list(msk, local)) {
> 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> -- 
> 2.34.1

--
Mat Martineau
Intel
