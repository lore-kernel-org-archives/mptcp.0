Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917807F
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644624665; x=1676160665;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ywZvn4aOY7mTM0fwrSYLLZp8Hv9k1R9hViZSQuSOrwc=;
  b=VcmJhjAVXRzVHzawlPRl312Cn3H5rKOWbfHOv2KKrTG8VyKgOe8+oCTx
   w4QtmlyxgTHSEmg0yUas+u1792u5lztZ8Kynv4IKyqHRbNYQyfPf5E9kc
   QxigK0VQcmf4cjzNX/o+yaw4Z+ZKRpch2KTFG1OoAY3N9DVOjiMSn0cz1
   AXiHJS737hF5ztvKjYerT3P6//MC5g5jOFBX8E0TfyqspTtwFkI4v2hkT
   Kdqp2gpjt2SDeisu43bA8HujqD39m0Pw+cJsstUzxUlOL/TpxmYIp1CkE
   lOSC22V2tinxekgBYCG5cnL4OgXKsrbH6tZ2EitSvQ2IF3oAsCU1x4cfy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="233386404"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="233386404"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:11:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="679656163"
Received: from kpdespai-mobl.amr.corp.intel.com ([10.212.245.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:11:04 -0800
Date: Fri, 11 Feb 2022 16:11:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v7 5/7] selftests: mptcp: add more
 arguments for chk_join_nr
In-Reply-To: <e49e65fd1f2b77ce3e0a16725d4780e54f6bf970.1644618926.git.geliang.tang@suse.com>
Message-ID: <4259152c-7243-7afb-6c8b-afccd379527d@linux.intel.com>
References: <cover.1644618926.git.geliang.tang@suse.com> <e49e65fd1f2b77ce3e0a16725d4780e54f6bf970.1644618926.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 12 Feb 2022, Geliang Tang wrote:

> This patch added three more arguments for the function chk_join_nr,
> named fail_nr, rst_nr and infi_nr, for the input numbers of MP_FAIL,
> MP_RST and the infinite map, which are needed to check. The default
> values of them are all zero.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 35 +++++++++++--------
> 1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7537f4fe8078..f0d0d540ee0c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -719,6 +719,8 @@ dump_stats()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -730,8 +732,8 @@ chk_csum_nr()
> 	printf " %-36s %s" "$msg" "sum"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns1 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns1"

I ran the 'mptcp_join.sh -F' tests a few times, and on the second attempt 
I saw:

001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          sum[fail] got 2 data checksum error[s] expected 1 - csum  [ ok ]

(followed by "2 MP_FAIL[s]" and "2 MP_RST[s]")

That seems to match the output you posted from the one failure in 500 
runs. Given the way the packets are corrupted for the test, should it 
allow multiple checksum errors but report the failures for multiple 
MP_FAIL/MP_RST?

I think the "2 data checksum errors" may be the only issue to fix in the 
test itself, and the 2 MP_FAIL / 2 MP_RST problem is something to fix in 
the kernel. What do you think?

-Mat



> 		ret=1
> 		dump_stats=1
> 	else
> @@ -740,8 +742,8 @@ chk_csum_nr()
> 	echo -n " - csum  "
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns2 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -752,27 +754,27 @@ chk_csum_nr()
>
> chk_fail_nr()
> {
> -	local mp_fail_nr_tx=$1
> -	local mp_fail_nr_rx=$2
> +	local fail_tx=$1
> +	local fail_rx=$2
> 	local count
> 	local dump_stats
>
> 	printf "%-${nr_blank}s %s" " " "ftx"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_fail_nr_tx" ]; then
> -		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
> +	if [ "$count" != "$fail_tx" ]; then
> +		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
> 		ret=1
> 		dump_stats=1
> 	else
> 		echo -n "[ ok ]"
> 	fi
>
> -	echo -n " - frx   "
> +	echo -n " - failrx"
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_fail_nr_rx" ]; then
> -		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
> +	if [ "$count" != "$fail_rx" ]; then
> +		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -852,6 +854,9 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local rst_nr=${6:-0}
> +	local infi_nr=${7:-0}
> 	local count
> 	local dump_stats
> 	local with_cookie
> @@ -898,10 +903,10 @@ chk_join_nr()
> 	fi
> 	[ "${dump_stats}" = 1 ] && dump_stats
> 	if [ $checksum -eq 1 ]; then
> -		chk_csum_nr
> -		chk_fail_nr 0 0
> -		chk_rst_nr 0 0
> -		chk_infi_nr 0 0
> +		chk_csum_nr "" $fail_nr
> +		chk_fail_nr $fail_nr $fail_nr
> +		chk_rst_nr $rst_nr $rst_nr
> +		chk_infi_nr $infi_nr $infi_nr
> 	fi
> }
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
