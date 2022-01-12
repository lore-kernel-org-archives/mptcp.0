Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1912C9C
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641950337; x=1673486337;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cJh0vyD5x21yAK6XNx3/JnzSNtfrWJsQeqGe4ABo1/g=;
  b=Qpbs5q2vDvO8RGwuEQsOMoRdy0UJawbkzmILfMIgEf0OsW8lkLv1K/4q
   q14asDyfUo87DMl87FhNFvE8GHlpQkapjj2SUY4cKuBZQJRxdQPIdC7fJ
   2mshINfbx3bI5gVfYyv0cCGQF96sim3hcwW/m5ZAhtfiH0S3/rnbnygbi
   V/I0T0LrBKnKhKedwL5FMqthcEbkP3v5eKbBrSheel1aVh3ef5JBHshn/
   CJ0xWSrjzvde2mTfGD7We9EsAof+mZ/5bCJj+TL8BEfY+z6uOVqHyA1Nh
   t9JFXHh4+KRwrDhHGIWlC0R2itKbkclDaZdI709IIqKGmmaHA0MN4D9VC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="242450396"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="242450396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:18:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="669999091"
Received: from tcastee-mobl.amr.corp.intel.com ([10.209.73.84])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:18:56 -0800
Date: Tue, 11 Jan 2022 17:18:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH] Squash to "selftests: mptcp: implement
 pm_nl_set_endpoint"
In-Reply-To: <432145d02a7fa2c0de7ca2a1074d2a009d71380e.1641789957.git.geliang.tang@suse.com>
Message-ID: <973ce67f-3a22-be44-442d-6e4b8297a944@linux.intel.com>
References: <432145d02a7fa2c0de7ca2a1074d2a009d71380e.1641789957.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 10 Jan 2022, Geliang Tang wrote:

> I just noticed Davide had added support for changing the backup flag in
> iproute2-next, so my patch "[PATCH iproute2-next 3/3] mptcp: add the
> backup flag setting" needs to be dropped.
>
> Furthermore, Davide's patch used 'change id $id backup' instead of 'set
> $addr backup'. So this squash-to patch is needed.
>
> pm_nl_set_endpoint is renamed to pm_nl_change_endpoint in this patch, so
> please rename the subject too:
>
> Subject: selftests: mptcp: implement pm_nl_change_endpoint
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

I did include this patch when reviewing the "use 'ip mptcp' in selftests" 
series. It's good to squash, waiting on discussion of one question in 
patch 7/9

- Mat

> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7ceb8ec11f79..46f7adab802b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -374,14 +374,15 @@ pm_nl_show_endpoint()
> 	fi
> }
>
> -pm_nl_set_endpoint()
> +pm_nl_change_endpoint()
> {
> 	local ns=$1
> 	local addr=$2
> -	local bkup=$3
> +	local id=$3
> +	local bkup=$4
>
> 	if [ $ip_mptcp -eq 1 ]; then
> -		ip -n $ns mptcp endpoint set $addr $bkup
> +		ip -n $ns mptcp endpoint change id $id $bkup
> 	else
> 		ip netns exec $ns ./pm_nl_ctl set $addr flags $bkup
> 	fi
> @@ -586,6 +587,10 @@ do_transfer()
> 		for netns in "$ns1" "$ns2"; do
> 			pm_nl_show_endpoint $netns | while read line; do
> 				local arr=($line)
> +				local nr=0
> +				local addr
> +				local id
> +
> 				# 'pm_nl_ctl' shows the address at the end
> 				let pos=${#arr[@]}-1
>
> @@ -594,7 +599,14 @@ do_transfer()
> 					pos=0
> 				fi
> 				addr=${arr[$pos]}
> -				pm_nl_set_endpoint $netns $addr $bkup
> +
> +				for i in ${arr[@]}; do
> +					if [ $i = "id" ]; then
> +						id=${arr[$nr+1]}
> +					fi
> +					let nr+=1
> +				done
> +				pm_nl_change_endpoint $netns $addr $id $bkup
> 			done
> 		done
> 	fi
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
