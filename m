Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A284C94
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645221659; x=1676757659;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yoj2cJ+h3eeZ10PdWp2Vuwnyy8wgTnEnKiC0cVg/P/k=;
  b=cYvGH/yt9SgvlqK/7vnxIEf2TbvPVPHJA24hhbcXH3W7hTtf7VRMIm4H
   1t8xjVwnRXW4ki4EWRS62wHdOEeQ2zE/pK8PkzqOSQ8SoqU//oq00V+1U
   i4PjGlpnKFBAJbcDPcfodDzKIb0HCFRMZZY5YwCCAEHZz+uFYz2ahIsm+
   utVkPeEUEJlwMAWAO5iyvE9QWNU+oucwJaMzpCPtiUB+9XlRnnRZI2Rwd
   fbbLVXC50by5Qi9T5kiuzRS6A04LvdgMVJs3Zbx7gGC2EpiJVadCH+oPs
   glZPMds7SzTNOGZv7UDakg4MAnLVldqcxSFwuDecrHro7OrPGMATw2Ogr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231203940"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231203940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:00:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="489799830"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:00:54 -0800
Date: Fri, 18 Feb 2022 14:00:54 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
    matthieu.baerts@tessares.net, geliang.tang@suse.com, mptcp@lists.linux.dev
Subject: Re: [PATCH net 6/7] selftests: mptcp: more robust signal race test
In-Reply-To: <20220218213544.70285-7-mathew.j.martineau@linux.intel.com>
Message-ID: <b536d171-11c-407b-4236-39fb592b571a@linux.intel.com>
References: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com> <20220218213544.70285-7-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Feb 2022, Mat Martineau wrote:

> From: Paolo Abeni <pabeni@redhat.com>
>
> The in kernel MPTCP PM implementation can process a single
> incoming add address option at any given time. In the
> mentioned test the server can surpass such limit. Let the
> setup cope with that allowing a faster add_addr retransmission.
>

Jakub / David -

A heads-up, this patch will give a trivial merge conflict in the hunk 
below when merging net/master to net-next/master. It's only due to changes 
in the preceeding context (those "ip netns exec" lines), so conflict 
resolution will be obvious.


> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 10b3bd805ac6..0d6a71e7bb59 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

...

> @@ -1158,7 +1164,10 @@ signal_address_tests()
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> +
> +	# the peer could possibly miss some addr notification, allow retransmission
> +	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> 	chk_join_nr "signal addresses race test" 3 3 3
>
> 	# the server will not signal the address terminating
> -- 
> 2.35.1
>
>

--
Mat Martineau
Intel
