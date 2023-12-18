Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F936AEA
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7EFClwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845A7C433C8;
	Mon, 18 Dec 2023 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916526;
	bh=mt+2AIleIzwqepJwUoPGcQ+bh62074XGg43fdk7hg7o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=e7EFClwST7qAyJ79Z7yUOhwVI30X9Megs2X3jTbzwjfrcnaCW/KdOhoLfSeEjpE46
	 By/XzZW5R8sKFCDdmBiY0S3s5pu4uAoE/3CbhAI9i2LT4LfSwu/9y/fw0SgcMcwSaZ
	 J6pArfor5oq0PXfz9ESPSHALc7CL5zsihauz6rq6698IZipWJpWKXNwA/Lghegk9D9
	 6DiNYuiS73/+z2kv5CAP0zc/FL6NjKH+MFfkLh0BhwayPMG5s75bDMsm+yE9scua0R
	 SjHxi8MxKt55RCLhqpSWPWrlrpNiEhxk5vlwEwEiQWGQKwvt7huYQ+t47nf8VCNtrB
	 dHP5djqYbASgg==
Message-ID: <0809cd74-cbef-4bee-b0f8-9893b6a8c413@kernel.org>
Date: Mon, 18 Dec 2023 17:22:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 5/5] selftests: mptcp: diag: check CURRESTAB
 counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
References: <cover.1702889134.git.geliang.tang@linux.dev>
 <573a8f55b47fb4aa35dfdfc49f1984ab7d232781.1702889134.git.geliang.tang@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <573a8f55b47fb4aa35dfdfc49f1984ab7d232781.1702889134.git.geliang.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/12/2023 09:47, Geliang Tang wrote:
> This patch adds a new helper chk_msk_cestab() to check the current
> established connections counter MIB_CURRESTAB in diag.sh. Invoke it
> to check the counter during the connection after every chk_msk_inuse().

Thank you for this new test!

> ---
> Note: chk_msk_cestab() and chk_cestab_nr() will be replaced by
> mptcp_lib_chk_cestab_nr() in subsequent patches after the commit
> "selftests: mptcp: diag: print colored output"

Thank you for the note!

(a note should be after the last Signed-off-by or added with 'git notes'
+ 'git format-patch --notes')

> ---
> 
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 95b498efacd1..aa341f40363c 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -182,6 +182,30 @@ chk_msk_inuse()
>  	__chk_nr get_msk_inuse $expected "$msg" 0
>  }
>  
> +# $1: ns, $2: cestab nr
> +chk_msk_cestab()> +{
> +	local ns=$1
> +	local cestab=$2
> +	local count
> +	local msg="....chk $2 cestab"
> +	test_cnt=$((test_cnt+1))

Not sure if it is useful, but usually we increment it at the end, and we
return it in case of failure.

> +
> +	printf "%-50s" "$msg"
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
> +	if [ -z "$count" ]; then
> +		echo "[ skip ]"
> +		mptcp_lib_result_skip "${msg}"
> +	elif [ "$count" != "$cestab" ]; then
> +		echo "[ fail ] got $count current establish[s] expected $cestab"
> +		ret=${KSFT_FAIL}
> +	else
> +		echo "[  ok  ]"
> +		mptcp_lib_result_pass "$msg"
> +	fi

Can you not use __chk_nr() instead?

> chk_msk_cestab()
> {
>     local ns=$1
>     local cestab=$2
> 
>     __chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" "${cestab}" "....chk ${cestab} cestab" ""
> }

I didn't check but I guess you will have to replace this line in
__chk_nr(), from:

  local skip="${4:-SKIP}"

to:

  local skip="${4-SKIP}"

(so it will only replace $4 by "SKIP" if it is not defined, even if it
is empty)

> +}
> +
>  wait_connected()
>  {
>  	local listener_ns="${1}"
> @@ -219,9 +243,11 @@ chk_msk_nr 2 "after MPC handshake "
>  chk_msk_remote_key_nr 2 "....chk remote_key"
>  chk_msk_fallback_nr 0 "....chk no fallback"
>  chk_msk_inuse 2 "....chk 2 msk in use"
> +chk_msk_cestab $ns 2
>  flush_pids
>  
>  chk_msk_inuse 0 "....chk 0 msk in use after flush"
> +chk_msk_cestab $ns 0
>  
>  echo "a" | \
>  	timeout ${timeout_test} \
> @@ -237,9 +263,11 @@ echo "b" | \
>  wait_connected $ns 10001
>  chk_msk_fallback_nr 1 "check fallback"
>  chk_msk_inuse 1 "....chk 1 msk in use"
> +chk_msk_cestab $ns 1
>  flush_pids
>  
>  chk_msk_inuse 0 "....chk 0 msk in use after flush"
> +chk_msk_cestab $ns 0
>  
>  NR_CLIENTS=100
>  for I in `seq 1 $NR_CLIENTS`; do
> @@ -261,9 +289,11 @@ done
>  
>  wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
>  chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
> +chk_msk_cestab $ns 200

The CI complained about this test:

https://api.cirrus-ci.com/v1/artifact/task/4992211134185472/summary/summary.txt

But the previous test also failed:

>   ....chk many msk in use        [ fail ] expected 252 found 239
>   ....chk 200 cestab             [ fail ] got 176 current establish[s] expected 200

Maybe just unlucky this time?

>  flush_pids
>  
>  chk_msk_inuse 0 "....chk 0 msk in use after flush"
> +chk_msk_cestab $ns 0
>  
>  mptcp_lib_result_print_all_tap
>  exit $ret

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
