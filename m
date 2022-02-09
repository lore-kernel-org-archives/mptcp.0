Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36982F39
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644447644; x=1675983644;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9+lanD1BrObRydqjJUZ054LA5iSTijJ8JSER8KTV/Ds=;
  b=YDs1pzK46jY4ZT1r8jSNzsU4RJBS55LIrAa/JYCBJDkcQXINgSWH9VbA
   03q0ZvDbunHzuAfGAIkEKnr3+DauqQml8ZsD5i8u7uGX15wgzlFQTIxds
   sDKT00XzZAFUtMssTn9F4KN3pWSeL4AvNrry4sqVaB7owKRauQnNYsTrS
   NfCoSlN7fIGwogMvjey0GReGTG6uiStBWtv7B2Q1AgOzs33HkJSNX1s1P
   oya5Wwfu6elNge7P00Ht3kDhIx4xR7Nb2gjBF+NeMEW8zQ9CI3Y9tJLra
   Y6Spu7LYz+sjMYbjpL475LoBPuY/sv6ESikm6PD0jhpZtviQi+/eNCrQ9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312653882"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312653882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:00:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701448192"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:00:43 -0800
Date: Wed, 9 Feb 2022 15:00:34 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: be more conservative with
 cookie MPJ limits
In-Reply-To: <d3aaf62f955697daa23859487bfaa5f1a777b29d.1644426852.git.pabeni@redhat.com>
Message-ID: <1afa995-966c-c694-f33a-adfea5a65df4@linux.intel.com>
References: <d3aaf62f955697daa23859487bfaa5f1a777b29d.1644426852.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Paolo Abeni wrote:

> Since commit 2843ff6f36db ("mptcp: remote addresses fullmesh"), an
> MPTCP client can attempt creating multiple MPJ subflow simultaneusly.
>
> In such scenario the server, when syncookies are enabled, could end-up
> accepting incoming MPJ syn even above the configured subflow limit, as
> the such limit can be enforced in a reliable way only after the subflow
> creation. In case of syncookie, only after the 3rd ack reception.
>
> As a consequence the related self-tests case sporadically fails, as it
> verify that the server always accept the expected number of MPJ syn.
>
> Address the issues relaxing the MPJ syn number constrain. Note that the
> check on the accepted number of MPJ 3rd ack still remains intact.
>
> Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this fixes for me some rare failure I observe in debug build:
>
> 072 subflows limited by server w cookies syn[ ok ] - synack[fail] got 2 JOIN[s] synack expected 1

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 66ac990415e6..9bcb3653f78b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -822,6 +822,7 @@ chk_join_nr()
> 	local ack_nr=$4
> 	local count
> 	local dump_stats
> +	local with_cookie
>
> 	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
> @@ -835,12 +836,20 @@ chk_join_nr()
> 	fi
>
> 	echo -n " - synack"
> +	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$syn_ack_nr" ]; then
> -		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
> -		ret=1
> -		dump_stats=1
> +		# simult connections exeeding the limit with cookie enabled could go up to
> +		# synack validation as the conn limit can be enforced reliably only after
> +		# the subflow creation
> +		if [ "$with_cookie" = 2 -a "$count" -gt "$syn_ack_nr" -a "$count" -le "$syn_nr" ]; then
> +			echo -n "[ ok ]"
> +		else
> +			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
> +			ret=1
> +			dump_stats=1
> +		fi
> 	else
> 		echo -n "[ ok ]"
> 	fi
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
