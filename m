Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE71F3BB3
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051366; cv=none; b=cq4PQuwGoJp/VMujurQZi8Cg/CA0loiAyuf90tTT0xNptZBHBn1QTIG9XRxwGD+ESkoQenuB1rl6YzDUTn2o6+3Wp5lFr96THSZ8mrpiueoubLY657vic1uBfVjiu0atQv+VDOKhyygdfxMndnV9HAYpWq+4moKhedPh/Bz7Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051366; c=relaxed/simple;
	bh=QzMPzlcem3StEaaz2VbQB4+BxCwDH+aIC6XUDgtf1QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VvHIPefNK3S7rM3R1iyvyqMQK3brFmEj8SZzaenwTX/a2epsBs1Gd81k4elrhCbl+ezPr60spS0XhXJ+CVZe+4u3m4VY4Z312cJQGPcTnJDC2Kahqu1MvYxyMbMEhogs7hCANNDWv2Uxa7BVjgnzmjvYMJJedkFDPdj436L5E2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYMv1SNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYMv1SNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBECC4CED6;
	Thu, 20 Feb 2025 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740051365;
	bh=QzMPzlcem3StEaaz2VbQB4+BxCwDH+aIC6XUDgtf1QM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XYMv1SNY8f3BDG6SYlIuDkvKMazmkFBM/q7AsG9PPx27N6org2hwsboOUBN9puKBH
	 ck4jtC5w64RUIgB9Q0B14LZm55jaAPsXAHSiV8/wta8ftyDFDeADVXcen+RPO/MA0D
	 5UHYkcTrgw14t2O0p4E0dx6tDEZfIF9Rb2n0AMd57xYJJhQsxahdAjQ5yVJm3gUcCb
	 DDrxRJP3JT5M1zKmPujiaZFlU8q/2cjQ7xT33XJeiZ3tSSyXS43bbqkffZhYtYJDUv
	 g0KRWeDoEcsH7yV/RIhCMbXfMFvEm2MU4FBXDYUG3kZsEKMDPAUgFDXOpuVoT56v04
	 RJYX3tYOD+htA==
Message-ID: <4b699e29-6b98-4735-ad5a-e122639c2d6c@kernel.org>
Date: Thu, 20 Feb 2025 12:36:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 2/2] selftests: mptcp: add a test for
 mptcp_diag_dump_one
Content-Language: en-GB
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1740035000.git.yangang@kylinos.cn>
 <bf32d17ddef19059b2806a041a9ea322ecd1977a.1740035000.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bf32d17ddef19059b2806a041a9ea322ecd1977a.1740035000.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 20/02/2025 08:11, Gang Yan wrote:
> This patch introduces a new 'chk_diag' test in diag.sh. It retrieves
> the token for a specified MPTCP socket (msk) using the 'ss' command and
> then accesses the 'mptcp_diag_dump_one' in kernel via ./mptcp_diag
> to verify if the correct token is returned.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 2bd0c1eb70c5..9a57c27b14b9 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -200,6 +200,28 @@ chk_msk_cestab()
>  		 "${expected}" "${msg}" ""
>  }
>  
> +chk_dumpone()
> +{
> +	local ss_token="$(ss -inmHMN $ns | grep 'token:' |\
> +			  head -n 1 |\
> +			  sed 's/.*token:\([0-9a-f]*\).*/\1/')"
> +	local token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
> +		       grep 'token:' |\
> +		       sed 's/.*token:\([0-9a-f]*\).*/\1/')"

(Or use "grep 'token:' | cut -d: -f2")

BTW, mptcp_diag should probably print all the different fields from
mptcp_info, and add a space after ':'

  token: (...)
  bytes_sent: (...)

And then we could do this:

  ./mptcp_diag -t (...) | awk '/^token: / { print $2 }'

> +	local msg="...chk dumpone"
There should be one more '.'. See the tests logs:

  # 13 ....chk 2 cestab                                  [ OK ]
  # 14 ...chk dumpone                                    [ OK ]
  # 15 ....chk 2->0 msk in use after flush               [ OK ]


Also, probably better with 'dump_one'.

> +
> +	mptcp_lib_print_title "$msg"
> +        if [ "$ss_token" != "$token" ]; then

Please use tabs for the indentation.

> +		mptcp_lib_pr_fail "expected $ss_token found $token"
> +		mptcp_lib_result_fail "${msg}"
> +		ret=${KSFT_FAIL}
> +	else
> +                mptcp_lib_pr_ok
> +                mptcp_lib_result_pass "${msg}"

Please use tabs for the indentation.

> +	fi
> +
> +}
> +
>  msk_info_get_value()
>  {
>  	local port="${1}"
> @@ -290,6 +312,7 @@ chk_msk_remote_key_nr 2 "....chk remote_key"
>  chk_msk_fallback_nr 0 "....chk no fallback"
>  chk_msk_inuse 2
>  chk_msk_cestab 2
> +chk_dumpone
>  flush_pids
>  
>  chk_msk_inuse 0 "2->0"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

