Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0615C3
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTK3PvIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09D7C433C7;
	Sun,  8 Oct 2023 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696762705;
	bh=xqLJW33m0v36jeUQVMAv5c+WI1MJUNdCjfyuzDZUeqc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RTK3PvInwaVdiihgRMwETEAVtneMh+Q/pcwCRCuwpolT9nUMpzUhTrmVID7W8f0Rl
	 cemRLorWaRWJlRoMrCMrgNkI0HkdA25P58AVSxAKtuLwYqXY14MvQS+JokYGkou/zs
	 0si0BA0YVzinR+2hs6VP9BMapKk21jBr+JsOJui2LYKJaKss91WIFw/+Wh9lbtqLhW
	 Mdiyilr40pqBXm5mUTPvHWSq2meIJKKj6EYRXnK7cQ46zmCVwoJUzgewx+Qq2QaaFs
	 OjlaB4O4EGJFEaBniqzO1D3eguYUjTJvemk5Lcktx8nUNw0c8xz1c8q0vPGFZLmgkF
	 nb0Wx2bCFmsnQ==
Message-ID: <f6b636ee-a790-415a-b582-393bb0bdffa0@kernel.org>
Date: Sun, 8 Oct 2023 12:58:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 27/29] selftests: mptcp: add
 mptcp_lib_make_file
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <5b20fc53613f849a9e9ef3ebb132e7494476762e.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <5b20fc53613f849a9e9ef3ebb132e7494476762e.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:42, Geliang Tang wrote:
> make_file() helper in mptcp_sockopt.sh and userspace_pm.sh are the same.
> Export it into mptcp_lib.sh and rename it as mptcp_lib_kill_wait(). Use
> it in both mptcp_connect.sh and mptcp_join.sh.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 3b971d1617d8..dc4a1dd3566d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -592,9 +592,8 @@ make_file()
>  	ksize=$((SIZE / 1024))
>  	rem=$((SIZE - (ksize * 1024)))
>  
> -	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
> +	mptcp_lib_make_file $name 1024 $ksize
>  	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null

Mmh, why were we doing that?

I guess we are missing something like "oflag=append" because this will
write "${rem}" bytes at the beginning of the file where there is already
some random bytes. It should write that at the end. Do you mind adding a
commit adding "oflag=append" please?

Then it means this should be done in the version of the "lib" as well
(an optional behaviour). That may increase a bit the complexity.

(Or we remove this second dd line (+ ${rem}) in a dedicated commit
because we were not using it correctly from the beginning and we are
fine like that (if I'm not mistaken)?)

> -	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
>  
>  	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
>  }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 26ea0919810f..f88168d66fdc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1155,8 +1155,7 @@ make_file()
>  	local who=$2
>  	local size=$3
>  
> -	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
> -	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
> +	mptcp_lib_make_file $name 1024 $size
>  
>  	print_info "Test file (size $size KB) for $who"
>  }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 0f5e34c76bb4..7b0d03c40f89 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -344,3 +344,12 @@ mptcp_lib_get_counter() {
>  
>  	echo "${count}"
>  }
> +
> +mptcp_lib_make_file() {
> +	local name=$1
> +	local bs=$2
> +	local size=$3
> +
> +	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
> +	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
> +}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index bfa744e350ef..39128fca99dd 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -245,18 +245,6 @@ do_transfer()
>  	return 1
>  }
>  
> -make_file()
> -{
> -	local name=$1
> -	local who=$2
> -	local size=$3
> -
> -	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
> -	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
> -
> -	echo "Created $name (size $size KB) containing data sent by $who"
> -}
> -
>  do_mptcp_sockopt_tests()
>  {
>  	local lret=0
> @@ -357,8 +345,10 @@ sout=$(mktemp)
>  cin=$(mktemp)
>  cout=$(mktemp)
>  init
> -make_file "$cin" "client" 1
> -make_file "$sin" "server" 1
> +mptcp_lib_make_file "$cin" 1024 1
> +echo "Created $cin (size 1 KB) containing data sent by client"
> +mptcp_lib_make_file "$sin" 1024 1
> +echo "Created $sin (size 1 KB) containing data sent by server"

Maybe easier to keep 'make_file()' helper to call mptcp_lib_make_file()
and print the message?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
