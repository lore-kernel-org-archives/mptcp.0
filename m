Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75C29CA
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642122819; x=1673658819;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=npkNF3pWbgW7hwLVfSgH7zX1CMCaTj0ygoGQnUBo8a4=;
  b=RKdeDp46T2XCJQ0yZuTFnFMwGckUmoyKVfZCVETXf+cFgFDDYLRWZYgR
   5Npiuem74+HV1raoX70m4DMOqdcehJi3sxytnrWoR8GzBISUxR6D1HmDw
   1rJUnchusmI7IZMwlSsNkgNiKwL4xM9HH/sIQdBdmaF05Hg9zNdnI9Vh/
   hUgwft3q0dPm8pbRgRiymDIo1M29Tmu+tIC9ZDBRAEpTluSitkFgac8H+
   lQPh2zhjVaZ4OoBaBB0soAxbeQ5XG8dtyT9sPJfNs133SK8Z26HvWVe5U
   dmmtPMD+7q3MrZaSE5UMhpg1/uFQfqDanb/4rE5HdZC7gsWZDf/DIAo6B
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268517448"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="268517448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:13:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491327134"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:13:31 -0800
Date: Thu, 13 Jan 2022 17:13:30 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/3] selftests: mptcp: add backup with port
 testcase
In-Reply-To: <7472cf13c155c5d37e6faba42d00dfa8ea4fe08b.1642085750.git.geliang.tang@suse.com>
Message-ID: <d764977-66a3-7a8-ab81-81b8994641ea@linux.intel.com>
References: <cover.1642085750.git.geliang.tang@suse.com> <7472cf13c155c5d37e6faba42d00dfa8ea4fe08b.1642085750.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 13 Jan 2022, Geliang Tang wrote:

> This patch added the backup testcase using an address with a port number.
>
> The original backup tests only work for the output of 'pm_nl_ctl dump'
> without the port number. It chooses the last item in the dump to parse
> the address in it, and in this case, the address is showed at the end
> of the item.
>
> But it dosen't work for the dump with the port number, in this case, the
> port number is showed at the end of the item, not the address.
>
> This patch implemented a more flexible approach to get the address and
> the port number from the dump to fit for the port number case.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++--
> 1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 25725be98342..39dffde68ae2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -239,6 +239,16 @@ is_v6()
> 	[ -z "${1##*:*}" ]
> }
>
> +is_addr()
> +{
> +	[ -z "${1##*[.:]*}" ]
> +}
> +
> +is_number()
> +{
> +	[[ $1 == ?(-)+([0-9]) ]]
> +}
> +
> # $1: ns, $2: port
> wait_local_port_listen()
> {
> @@ -464,11 +474,27 @@ do_transfer()
> 	if [ ! -z $sflags ]; then
> 		sleep 1
> 		for netns in "$ns1" "$ns2"; do
> -			dump=(`ip netns exec $netns ./pm_nl_ctl dump`)
> -			if [ ${#dump[@]} -gt 0 ]; then
> -				addr=${dump[${#dump[@]} - 1]}
> -				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
> -			fi
> +			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
> +				local arr=($line)
> +				local addr
> +				local port=0
> +				local _port=""
> +
> +				for i in ${arr[@]}; do
> +					if is_addr $i; then
> +						addr=$i
> +					fi
> +					if is_number $i; then
> +						if [ $i -gt 10000 ]; then

Why this check for > 10000? I assume it's because the expected port 
numbers are assumed to be 10000+$TEST_COUNT but it would help to explain 
in a comment.

-Mat

> +							port=$i
> +						fi
> +					fi
> +				done
> +				if [ $port -gt 0 ]; then
> +					_port="port $port"
> +				fi
> +				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
> +			done
> 		done
> 	fi
>
> @@ -1651,6 +1677,16 @@ backup_tests()
> 	chk_add_nr 1 1
> 	chk_prio_nr 1 0
> 	chk_rm_nr 0 0
> +
> +	# single address with port, backup
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +	chk_join_nr "single address with port, backup" 1 1 1
> +	chk_add_nr 1 1
> +	chk_prio_nr 1 0
> }
>
> add_addr_ports_tests()
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
