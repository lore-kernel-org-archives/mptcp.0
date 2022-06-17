Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B76AA6
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 00:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655424109; x=1686960109;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dF9LiZdEMraigu6o/NSGRToQ4AeVBh51MRE4MLCOZwA=;
  b=UCSeO3OgNI7XMYAeb9+wtr88tbifdVvwaE6Qj4/eWK4e5teeKbq35ZGj
   NUTRrMUY0BAJBt9rHws43U+CDNARTNg0MG5gXuF6QmhQxSUd6pTecY1zL
   9dWRpQGtNFrkT2QxNDSMeGEykLd75iZr6b1JznDQipprB/aQsYD2EehXu
   22HYWlNymb898UdPohUKwI76Bq6vWOAIRB7wqLeSFEJIBLVuGnXUNg1F8
   NbTnRKK3jE4fiXei32MOENA/AmxYxt+GzS8yeriRUxoszadLtA39s5zbv
   PAeh2xPRT/0LKsGLMPxn2J5pz20d53SsqFoSUH0Pyyb1RLzQcEuSJdrKU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278178414"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278178414"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 17:01:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="589875774"
Received: from lhossain-mobl.amr.corp.intel.com ([10.255.231.225])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 17:01:48 -0700
Date: Thu, 16 Jun 2022 17:01:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: more stable diag tests
In-Reply-To: <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
Message-ID: <2aa056e8-f51-e367-5bf0-1a9371cc88c4@linux.intel.com>
References: <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 16 Jun 2022, Paolo Abeni wrote:

> The mentioned test-case still use an hard-coded-len sleep to
> wait for a relative large number of connection to be established.
>
> On very slow VM and with debug build such timeout could be exceeded,
> causing failures in our CI.
>
> Address the issue polling for the expected condition several times,
> up to an unreasonable high amount of time. On reasonably fast system
> the self-tests will be faster then before, on very slow one we will
> still catch the correct condition.
>
> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good to me, thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> tools/testing/selftests/net/mptcp/diag.sh | 40 ++++++++++++++++++++---
> 1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 9dd43d7d957b..ee2f238255ec 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -61,6 +61,39 @@ chk_msk_nr()
> 	__chk_nr "grep -c token:" $*
> }
>
> +wait_msk_nr()
> +{
> +	local condition="grep -c token:"
> +	local expected=$1
> +	local timeout=20
> +	local msg nr
> +	local max=0
> +	local i=0
> +
> +	shift 1
> +	msg=$*
> +
> +	while [ $i -lt $timeout ]; do
> +		nr=$(ss -inmHMN $ns | $condition)
> +		[ $nr == $expected ] && break;
> +		[ $nr -gt $max ] && max=$nr
> +		i=$((i + 1))
> +		sleep 1
> +	done
> +
> +	printf "%-50s" "$msg"
> +	if [ $i -ge $timeout ]; then
> +		echo "[ fail ] timeout while expecting $expected max $max last $nr"
> +		ret=$test_cnt
> +	elif [ $nr != $expected ]; then
> +		echo "[ fail ] expected $expected found $nr"
> +		ret=$test_cnt
> +	else
> +		echo "[  ok  ]"
> +	fi
> +	test_cnt=$((test_cnt+1))
> +}
> +
> chk_msk_fallback_nr()
> {
> 		__chk_nr "grep -c fallback" $*
> @@ -184,7 +217,7 @@ for I in `seq 1 $NR_CLIENTS`; do
> 	echo "a" | \
> 		timeout ${timeout_test} \
> 			ip netns exec $ns \
> -				./mptcp_connect -p $((I+10001)) -l -w 10 \
> +				./mptcp_connect -p $((I+10001)) -l -w 20 \
> 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
> done
> wait_local_port_listen $ns $((NR_CLIENTS + 10001))
> @@ -193,12 +226,11 @@ for I in `seq 1 $NR_CLIENTS`; do
> 	echo "b" | \
> 		timeout ${timeout_test} \
> 			ip netns exec $ns \
> -				./mptcp_connect -p $((I+10001)) -w 10 \
> +				./mptcp_connect -p $((I+10001)) -w 20 \
> 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
> done
> -sleep 1.5
>
> -chk_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
> +wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
> flush_pids
>
> exit $ret
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
