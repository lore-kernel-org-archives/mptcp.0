Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269715A0
	for <mptcp@lists.linux.dev>; Tue,  9 Aug 2022 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660004119; x=1691540119;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fdtAtv2JPMsbcix1AFVf1WX9kLPKYrE0I+SQabnNTsI=;
  b=UYk5Ih5HLbCiZOly1TyYpo3FYotjJhf//B4WSQNGtGmAKO55+mLh5O2r
   oobWBcQdVicrcByzYLulUt2ONchv1EOz/HXmDcXC/XBUMpE7d2RKPESw5
   vig46oLHt0WIJ39HBk5r3Wi/A9l4PKXoPUKzfp6cxzQyKQ2f/EAk2cAVW
   SwsFUV/CfOr6+S80P9v5kjz04coNnwdhtZxgNkKjsVqQGW9ovZv7MmrXp
   HEIeTIVSqaSP5zlfsQnpfHLpcwabn1A/696cGnZq5AKX4DS+uaL+NUkdo
   mZ2LkkCmxIYxR+zZwCQPcE+oEPeL/0s7j4RP4B9tyQsa7VI4WxJZgtMwO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277653609"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="277653609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 17:15:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="780678409"
Received: from srinathm-mobl.amr.corp.intel.com ([10.212.202.204])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 17:15:18 -0700
Date: Mon, 8 Aug 2022 17:15:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: move prefix tests of
 addr_nr_ns2 together
In-Reply-To: <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
Message-ID: <b69ddfa-7e77-2c1d-1e76-84527d297228@linux.intel.com>
References: <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Aug 2022, Geliang Tang wrote:

> Move the fullmesh prefix test of addr_nr_ns2 together with its other
> prefix tests.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to me, thanks Geliang:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ff83ef426df5..2957fe414639 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -706,6 +706,7 @@ do_transfer()
> 		addr_nr_ns1=${addr_nr_ns1:10}
> 	fi
>
> +	local flags="subflow"
> 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> 		# disconnect
> 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
> @@ -713,6 +714,9 @@ do_transfer()
> 	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> 		userspace_pm=1
> 		addr_nr_ns2=${addr_nr_ns2:10}
> +	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> +		flags="${flags},fullmesh"
> +		addr_nr_ns2=${addr_nr_ns2:9}
> 	fi
>
> 	if [ $userspace_pm -eq 1 ]; then
> @@ -832,12 +836,6 @@ do_transfer()
> 		fi
> 	fi
>
> -	local flags="subflow"
> -	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> -		flags="${flags},fullmesh"
> -		addr_nr_ns2=${addr_nr_ns2:9}
> -	fi
> -
> 	# if newly added endpoints must be deleted, give the background msk
> 	# some time to created them
> 	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
