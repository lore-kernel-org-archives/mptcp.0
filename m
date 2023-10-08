Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300315C3
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5tg4i+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7728BC433C8;
	Sun,  8 Oct 2023 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696762759;
	bh=5Vtl+Oj94p5EBjQiuWmdPH6LJGazHrRnFKUQhKmt3zo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=f5tg4i+HJ0xgaN0RjYkjBqjZiEfAApYTaOoA4beccQicQf4b//Xc1yWIfo+5skAOF
	 T7VetLrMs0HpdpkE9BxIj3GfXxPXaYvv2f1U6eXMwbJG/SDk95Gmtcma2UYslm48XA
	 EMS7kmPAcKldi8LSRyMf8A9QVY4Lmh3piNMZfylvt/6gy5jn6y8+Mn6E4/a7Wdw80w
	 QijrC8J5vUqcyZFZOJbLYbPj+POUIqiigQ4RRMtZO4YLDlKDojOnETGGFhDc+VqhWG
	 cfFSW2ckEEzpzeYoZTnI7azNTpuq7Ugam6QKHLEr2ke26HH4vddnaI6ieE16T5KOEU
	 BUtxRsXs17SJQ==
Message-ID: <35b82aab-2048-40d4-bafd-d26566be0f63@kernel.org>
Date: Sun, 8 Oct 2023 12:59:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 28/29] selftests: mptcp: add
 mptcp_lib_check_transfer
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <a37ed95ef83e996c98a4f3e7376dc708cbffccbd.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <a37ed95ef83e996c98a4f3e7376dc708cbffccbd.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:42, Geliang Tang wrote:
> check_transfer() helper is defined both in mptcp_connect.sh and
> mptcp_sockopt.sh, export it into mptcp_lib.sh and rename it with
> mptcp_lib_ prefix. Use this new helper in both scripts.

Good idea!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 7b0d03c40f89..fba62cdef2cd 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -353,3 +353,27 @@ mptcp_lib_make_file() {
>  	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
>  	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
>  }
> +
> +print_file_err()

Please prefix it with "mptcp_lib_" + add a comment:

  # $1: file

> +{
> +	ls -l "$1" 1>&2

Please use {} around variables: "${1}"

(like in the rest of the file)

> +	echo "Trailing bytes are: "
> +	tail -c 27 "$1"
> +}
> +
> +mptcp_lib_check_transfer() {

Please add a comment:

  # $1: input file ; $2: output file ; $3: what kind of file

> +	local in=$1

Please use {} and quotes around variables: "${1}". Same below.

> +	local out=$2
> +	local what=$3
> +
> +	cmp "$in" "$out" > /dev/null 2>&1
> +	if [ $? -ne 0 ] ;then

Small detail: probably better to do this (I guess Shellcheck would
complain if it is not done like that)

  if ! cmp "$in" "$out" > /dev/null 2>&1; then

> +		echo "[ FAIL ] $what does not match (in, out):"
> +		print_file_err "$in"
> +		print_file_err "$out"
> +
> +		return 1
> +	fi
> +
> +	return 0
> +}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 39128fca99dd..aa4b9a4e6a56 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -135,32 +135,6 @@ check_mark()
>  	return 0
>  }
>  
> -print_file_err()
> -{
> -	ls -l "$1" 1>&2
> -	echo "Trailing bytes are: "
> -	tail -c 27 "$1"
> -}
> -
> -check_transfer()
> -{
> -	local in=$1
> -	local out=$2
> -	local what=$3
> -
> -	cmp "$in" "$out" > /dev/null 2>&1
> -	if [ $? -ne 0 ] ;then
> -		echo "[ FAIL ] $what does not match (in, out):"
> -		print_file_err "$in"
> -		print_file_err "$out"
> -		ret=1

Could you add a comment in the commit message: here it is OK to drop
'ret=1' because it will be set in run_tests() anyway (if I'm not mistaken).

Otherwise a reviewer could think the test is no longer marked as failed
in case of error and he might ask the question or take time to find the
answer and we want to avoid that ;)

> -
> -		return 1
> -	fi
> -
> -	return 0
> -}
> -
>  do_transfer()
>  {
>  	local listener_ns="$1"
> @@ -232,7 +206,7 @@ do_transfer()
>  		check_mark $connector_ns 4 || retc=1
>  	fi
>  
> -	check_transfer $cin $sout "file received by server"
> +	mptcp_lib_check_transfer $cin $sout "file received by server"
>  	rets=$?
>  
>  	mptcp_lib_result_code "${retc}" "mark ${ip}"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
