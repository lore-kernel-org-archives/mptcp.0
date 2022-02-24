Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7687B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 01:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645666063; x=1677202063;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k4X3fPGOl0aih4FVEyELS22nptyF/zzJAKdNm6WupRY=;
  b=M6GRyN7ixHqdnSU9Jy3Lsx3UUeVSJsKLWYDLVIDGPCmDgZ34fmiJL9xR
   xjrVuIXZ9X2B5067mBKpZcbGak/AYNIybeXCIS5qk2ewNkj1FsdPJUz8R
   kZriR4bj3CSmA5vEYJQkOM1uqXMHGsNKYDDGdBKZ7AkkNoFR9B4/LBiSI
   2+c2ENnVYY/Hp+M7e0BUlTClDTT3LWVbH4uJerK8gn3rlqb0jq/HRy06S
   Bq2pd+JJQjrjopu7YxUSNxOy/HdEiG8Qm8OLugGdETpzBjac/UuFuSdLo
   0m4AsNTFOl4V07gekMu5ordiDGWbOiKQfpGYhBHMOH8XrfyZzEEUUll1z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252316520"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="252316520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:27:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508673360"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:27:42 -0800
Date: Wed, 23 Feb 2022 17:27:42 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add the MP_FASTCLOSE
 mibs check"
In-Reply-To: <981a7ec4e8d14bffba4d4251d491ff70fb2eeba3.1645658270.git.geliang.tang@suse.com>
Message-ID: <fc9dd352-2779-eea4-88e6-3acce2fe1f8c@linux.intel.com>
References: <981a7ec4e8d14bffba4d4251d491ff70fb2eeba3.1645658270.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 24 Feb 2022, Geliang Tang wrote:

> This following code appeared in another commit "selftests: mptcp: add infinite map
> mibs check":
>
>        echo -n " - fclzrx"
> -       count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}'`
> +       count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
>        [ -z "$count" ] && count=0
>        if [ "$count" != "$fclose_rx" ]; then
>                echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
>
> It's better to squash it here. With this patch, it will be dropped from the commit
> "selftests: mptcp: add infinite map mibs check" automatically.
>

Hi Geliang,

I agree, looks good to squash.


-Mat

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7d414cff02a0..10339a796325 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -800,7 +800,7 @@ chk_fclose_nr()
> 	local dump_stats
>
> 	printf "%-${nr_blank}s %s" " " "ctx"
> -	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}'`
> +	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$fclose_tx" ]; then
> 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
> @@ -811,7 +811,7 @@ chk_fclose_nr()
> 	fi
>
> 	echo -n " - fclzrx"
> -	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}'`
> +	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$fclose_rx" ]; then
> 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
