Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B937156
	for <mptcp@lists.linux.dev>; Mon,  4 Mar 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555525; cv=none; b=EdDl2ebccRimK/UcadO3IeFsuua985NmrFLUgL2+QydmV9rpXHACqB32O/ShUwFHxxWxlX6henJ6iQB9iD1SCQSFBE3PBASsVdVpF38EURoZkHnWwtbM5e61PBMdQ80JZGGjG3Zwal8siTgDzbtT3Fv7TVLSXySh30g7N1aHa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555525; c=relaxed/simple;
	bh=hGZ8Z058VrQpEjSzF9fphfQeng7EKIpT1ky0noNN40k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JShGMXhqb/bNmDMFRNvqJgGFlFKUPf25MQ1T4glpJapbmhA4p7PdeH6PVX/6O2gRvigv+RLXZ4ftDFbnwOE0HEbRrTc+pnVEtjhotS2fdR+XmkLof+xcz9WK3cgsjfGF//CywB/Gpma3S3zZ1Mfhhn4ekNUh3z0+XXdNoV6HrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMh3FUnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMh3FUnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F08C433F1;
	Mon,  4 Mar 2024 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709555524;
	bh=hGZ8Z058VrQpEjSzF9fphfQeng7EKIpT1ky0noNN40k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HMh3FUncilIlm2LROEX5mOdkyAzsW/BD4NmfMDa9q+RgiENUOx+JVmmhhq8uPhKlt
	 KQVUIWl0f5rWgpfnnHkXY9J4ny/leRmLLyh02m0/W3/Nh1n35QKLjMjIHebllghtKK
	 v7CE/fbTuwJpGDTO7UMzTeMbiKp/Eaw0HZJPjVWNUmVnwd6ODU6DQS9q82vSR1aLCj
	 d5liuVo70KgOpoKbDLwvkMFBRkc585rxWPxsicdn9SKyRVjQny/rM6Vn3r1dR/5oDy
	 o2Jfv1fFXUmIwociCTiF9luUNd9C1IEikbFTX0T10oGtDBBD4mKxUkpP6wSQTL+JeV
	 DZjV7McwG3C8Q==
Message-ID: <73670b3c-91fd-40fe-8d1a-293a59f3cc79@kernel.org>
Date: Mon, 4 Mar 2024 13:32:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v11 4/8] selftests: mptcp: sockopt: print every
 test result
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709466624.git.tanggeliang@kylinos.cn>
 <d5d8963bae6555f4ebd9b51f9269cc7b64dedc94.1709466624.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d5d8963bae6555f4ebd9b51f9269cc7b64dedc94.1709466624.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/03/2024 12:52, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Only total test results are printed out in mptcp_sockopt.sh:
> 
> PASS: all packets had packet mark set
> PASS: SOL_MPTCP getsockopt has expected information
> PASS: TCP_INQ cmsg/ioctl -t tcp
> PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> PASS: TCP_INQ cmsg/ioctl -r tcp
> PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp
> 
> They mismatch with the test results:
> 
> ok 1 - mptcp_sockopt: mark ipv4
> ok 2 - mptcp_sockopt: transfer ipv4
> ok 3 - mptcp_sockopt: mark ipv6
> ok 4 - mptcp_sockopt: transfer ipv6
> ok 5 - mptcp_sockopt: sockopt v4
> ok 6 - mptcp_sockopt: sockopt v6
> ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
> ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
> ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
> ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
> ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp
> 
> 'mptcp_sockopt.sh' now display more detailed results + why (what you had
> in a former patch from v6, merged here). It no longer displays 'PASS:',
> because it is duplicated info now that the detailed are displayed:
> 
> Transfer v4                                       [ OK ]
> Mark v4                                           [ OK ]
> Transfer v6                                       [ OK ]
> Mark v6                                           [ OK ]

Small detail: I see above, in the TAP output, that we first have 'mark',
then 'transfer', while here, it is the opposite: 'Transfer', then 'Mark'.

While at it, can you invert the two please to keep the same order for
both please? Especially when later we add the test number.

I guess the TAP output is wrong (not logical) → so we should move:

  mptcp_lib_result_code "${rets}" "transfer ${ip}"

before checking the mark.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index bf22174c022c..f7f643779992 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -113,6 +113,11 @@ check_mark()
>  	return 0
>  }
>  
> +print_title()
> +{
> +	printf "%-50s" "${@}"
> +}
> +
>  do_transfer()
>  {
>  	local listener_ns="$1"
> @@ -162,6 +167,7 @@ do_transfer()
>  	wait $spid
>  	local rets=$?
>  
> +	print_title "Transfer ${ip:2}"
>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		echo " client exit code $retc, server $rets" 1>&2
>  		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
> @@ -175,7 +181,9 @@ do_transfer()
>  		ret=1
>  		return 1

Here, in case of error, you will not print '[FAIL]', right?

>  	fi
> +	echo "[ OK ]"

Mmh, be careful that the transfer can be marked as failed later, please
check where we call "mptcp_lib_check_transfer".

In fact, I think we should move ...

  mptcp_lib_check_transfer $cin $sout "file received by server"
  rets=$?
  mptcp_lib_result_code "${rets}" "transfer ${ip}"

... before this "echo "[ OK ]", no?


So having something like:

  print_title "Transfer ${ip:2}"
  if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
      echo "[FAIL]"
      (...)
      return 1
  elif ! mptcp_lib_check_transfer $cin $sout "(...)"; then
      rets=1
      mptcp_lib_result_fail "transfer ${ip}"
  else
      echo "[ OK ]"
      mptcp_lib_result_pass "transfer ${ip}"
  fi


By doing that, we fix the TAP order, and we correctly print "OK" even if
there was an issue during the transfer

>  
> +	print_title "Mark ${ip:2}"
>  	if [ $local_addr = "::" ];then
>  		check_mark $listener_ns 6 || retc=1
>  		check_mark $connector_ns 6 || retc=1
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
