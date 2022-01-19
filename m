Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807A2CA5
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642551608; x=1674087608;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kFO/uu2Eq92HX0eT8VkIZNgtCS+3qT6vqUHZbGC1igM=;
  b=IOXeJfp8w5HClBLaCq4wBSWBojPdTPOXm/evfnuul01Q9ML7uY0pTbju
   zYDN3rBh1ORU4006A7k1V+3TE0T0ix5iYbKzoh1sRFexSITgboW3LbTOh
   qQn79oeD17c93YKQLf+530tr6qaRISO96HZK8lc4pwoRa5y/5RE0odG5A
   Gvsxuwv8VY1nLh16SF/F+wx6Jwum4LBGOEqfb/AYhF44XiId77ZpHAAXr
   OkTDevkZkQ788MVZl4nBT0SCYAk8Em2sDtgV7y0+KF/lOClOTNiKYWgFo
   HDiQkkEC12NmeWq4k6qfI5rCQz0y/xwTt5V5iEPKM7BYKYll+wfMUZaqj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232309206"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="232309206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 16:20:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="672008133"
Received: from sesloan-mobl1.amr.corp.intel.com ([10.212.237.254])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 16:20:07 -0800
Date: Tue, 18 Jan 2022 16:20:05 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add invert check in
 check_transfer
In-Reply-To: <43bc1675461051df68f3ffc09d4f309b7c0ba4b6.1642317523.git.geliang.tang@suse.com>
Message-ID: <2deb992b-3fe5-3da1-4281-6fd08c5ddcc8@linux.intel.com>
References: <43bc1675461051df68f3ffc09d4f309b7c0ba4b6.1642317523.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 16 Jan 2022, Geliang Tang wrote:

> This patch added the invert bytes check for the output data in
> check_transfer().
>
> Instead of the file mismatch error:
>
>  [ FAIL ] file received by server does not match (in, out):
>  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
>  Trailing bytes are:
>  MPTCP_TEST_FILE_END_MARKER
>  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
>  Trailing bytes are:
>  MPTCP_TEST_FILE_END_MARKER
>
> Print out the inverted bytes like this:
>
>  file received by server has inverted bytes at 7454789 (in, out)
>  file received by server has inverted bytes at 7454790 (in, out)
>  file received by server has inverted bytes at 7454791 (in, out)
>  file received by server has inverted bytes at 7454792 (in, out)
>

Thanks Geliang! This is really close to what I was looking for. Can you 
also make sure the bit flips are only allowed in the few tests where they 
are expected?

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - instead of adding a new function is_invert, add the invert bytes
>   check in check_transfer().
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++-------
> 1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2be3cad4b52b..de6589d1c541 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -193,15 +193,22 @@ check_transfer()
> 	out=$2
> 	what=$3
>
> -	cmp "$in" "$out" > /dev/null 2>&1
> -	if [ $? -ne 0 ] ;then
> -		echo "[ FAIL ] $what does not match (in, out):"
> -		print_file_err "$in"
> -		print_file_err "$out"
> -		ret=1
> +	cmp -l "$in" "$out" | while read line; do
> +		local arr=($line)
> +
> +		let sum=${arr[1]}+${arr[2]}

bash is interpreting the values as decimal here, would be best to 
interpret them as octal by adding a leading '0' to each value:

let sum=0${arr[1]}+0${arr[2]}

> +		# Octal 377 is 0xFF
> +		if [ $sum -ne 377 ]; then

Can also change this to use hexadecimal directly:

if [ $sum -ne $((0xff)) ]; then


> +			echo "[ FAIL ] $what does not match (in, out):"
> +			print_file_err "$in"
> +			print_file_err "$out"
> +			ret=1
>
> -		return 1
> -	fi
> +			return 1
> +		else
> +			echo "$what has inverted bytes at ${arr[0]} (in, out)"

What's the meaning of "(in, out)" here?


-Mat

> +		fi
> +	done
>
> 	return 0
> }
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
