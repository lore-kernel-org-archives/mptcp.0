Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66A2F32
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645148222; x=1676684222;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2eoLmtL72900oQkEd+t7d0Q+0qJ3KM12d6bjvRaqYmo=;
  b=Ie77MKym0a+coeRBncLJHmuggEQ0AaBtX7ExuXS/kdB4fA8KjR9XiOte
   FHYADobvAv/5KAsWyJoAebQRzyuXD/SuzRSm2Pti9bWjB44Ty7ifYh+Df
   emaBmKNqf1E1h0UKeIuU13Vd4O8Tbr4RX2OLTDfH0rgAZ8/VsJjx0p6nV
   9fTj+SI+qVJ1p8EcM0YVB6T6l1YHpj6xs0ZYtFNQNaM35XNfEnKQfkdvs
   L4yMjFHnQLoD6SdCVaKN2s0vOcWE60nxNLKi3qs9ezDbADHfD8MTWmdQd
   4yJpaVEL7unJXRZ7rB2Z0tiLJj1FJyM4gKLVyZqkbo2iI5FuPiXpRpSVe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238429709"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="238429709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 17:37:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="775081090"
Received: from pjayapal-mobl1.amr.corp.intel.com ([10.212.185.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 17:37:01 -0800
Date: Thu, 17 Feb 2022 17:37:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4] Squash to "selftests: mptcp: add the MP_RST
 mibs check v3"
In-Reply-To: <963f2f26574e15433cd3f50087c30599474250cb.1645136543.git.geliang.tang@suse.com>
Message-ID: <61801574-c624-8dd3-f849-11167407bbf@linux.intel.com>
References: <963f2f26574e15433cd3f50087c30599474250cb.1645136543.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 18 Feb 2022, Geliang Tang wrote:

> Reflect the ns_invert.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v4:
> - show extra_msg after dump_stats
>

Looks ok to squash, thanks Geliang.

-Mat

> v3:
> - add extra_msg
>
> v2:
> - update the output message from
>                                         rtx[ ok ] - rstrx [ ok ] - invert
> to
>                                         rtx[ ok ] - rstrx [ ok ]   invert
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++------------
> 1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 3252865352f3..644db851a56c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -809,13 +809,14 @@ chk_rst_nr()
> 	local ns_invert=${3:-""}
> 	local count
> 	local dump_stats
> +	local ns_tx=$ns1
> +	local ns_rx=$ns2
> +	local extra_msg=""
>
> -	if [ -z $ns_invert ]; then
> -		ns_tx=$ns1
> -		ns_rx=$ns2
> -	elif [ $ns_invert = "invert" ]; then
> +	if [[ $ns_invert = "invert" ]]; then
> 		ns_tx=$ns2
> 		ns_rx=$ns1
> +		extra_msg="   invert"
> 	fi
>
> 	printf "%-${nr_blank}s %s" " " "rtx"
> @@ -837,18 +838,12 @@ chk_rst_nr()
> 		ret=1
> 		dump_stats=1
> 	else
> -		if [ -z $ns_invert ]; then
> -			echo "[ ok ]"
> -		elif [ $ns_invert = "invert" ]; then
> -			echo -n "[ ok ]"
> -		fi
> -	fi
> -
> -	if [ ! -z $ns_invert ] && [ $ns_invert = "invert" ]; then
> -		echo " - invert"
> +		echo -n "[ ok ]"
> 	fi
>
> 	[ "${dump_stats}" = 1 ] && dump_stats
> +
> +	echo "$extra_msg"
> }
>
> chk_infi_nr()
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
