Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EF168
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 00:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642637188; x=1674173188;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HzAtL0GGZJa4oc0Iqlt3OwZGrjpH6qoKHvtFd6YfTFk=;
  b=XcbjyhoJIYJABZQgP8bTtDWwOByEgoKllh1AhucK76fwHnzdvOPdJRrP
   dWHP0bKnfQDryB8pb5Dz48sQlHwwsOAN+YCyK8/M2b+9T4QWXi1zLHMje
   8imkpiKsDbfZ9+7QSx4wjQ+8zu606pMdc85Tfdn1dQkoNcMibKnBwlUv1
   nQ/3aCkbUiU0vjilm9juO1DSSKjNC0Kr0CHPx1+4uUhKtiCQbptuuMh99
   sD9Bjd9fJCaZPcLPC52VJIRPTAbpa1Vgnwv+Cltp8zlVrMDVImzP69wjO
   zf+Kpf7xsD7cjv0NGWbA8kx5Slv8wbJnyNCL7vEPoiXpY9K4Zp08Re4Us
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305962841"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="305962841"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 16:06:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="672361553"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 16:06:26 -0800
Date: Wed, 19 Jan 2022 16:06:26 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add invert check in
 check_transfer
In-Reply-To: <ed191af941837d4c63ea37a9a863dc39904571d2.1642570570.git.geliang.tang@suse.com>
Message-ID: <d6e12420-bc8e-9369-8acf-702539b2fe87@linux.intel.com>
References: <ed191af941837d4c63ea37a9a863dc39904571d2.1642570570.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 19 Jan 2022, Geliang Tang wrote:

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
>  file received by server has inverted byte at 7454789
>  file received by server has inverted byte at 7454790
>  file received by server has inverted byte at 7454791
>  file received by server has inverted byte at 7454792
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v3:
> - add the check_invert flag, do the invert bytes check only when this flag
> is set.
> - use 0xff directly.
> - update the output log.

Hi Geliang -

Looks good to me, thanks for the updates! Please update "selftests: mptcp: 
add mp_fail testcases" for the inversion check.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> v2:
> - instead of adding a new function is_invert, add the invert bytes
>   check in check_transfer().
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++------
> 1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2be3cad4b52b..4f8ee8a9a8f2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -15,6 +15,7 @@ timeout_test=$((timeout_poll * 2 + 1))
> mptcp_connect=""
> capture=0
> checksum=0
> +check_invert=0
> do_all_tests=1
>
> TEST_COUNT=0
> @@ -58,6 +59,8 @@ init()
> 		fi
> 	done
>
> +	check_invert=0
> +
> 	#  ns1              ns2
> 	# ns1eth1    ns2eth1
> 	# ns1eth2    ns2eth2
> @@ -193,15 +196,21 @@ check_transfer()
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
>
> -		return 1
> -	fi
> +		let sum=0${arr[1]}+0${arr[2]}
> +		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
> +			echo "[ FAIL ] $what does not match (in, out):"
> +			print_file_err "$in"
> +			print_file_err "$out"
> +			ret=1
> +
> +			return 1
> +		else
> +			echo "$what has inverted byte at ${arr[0]}"
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
