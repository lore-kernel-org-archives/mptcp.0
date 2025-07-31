Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA02AE6C
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956000; cv=none; b=QGC63ZWrgqh6FT+3gRoXq5FEJGb8JKmqtZlLtBmg12gL1GYvQA6LGeostRbcnl5jjwPwpCnVKBJ2qIM1s11NSMuDudfBcz6T+lWyjsorY0232L9eCi+CtgjM7Mzs6wniQm2rWtiZVm+Vy9rHDQpqXGunJnL8H6oZ0U7we0YvU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956000; c=relaxed/simple;
	bh=QeKUVb4lpwhFP4ae4SyPkUvf9Mi0i/yZg/Q0hULVNwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX6NTdq1GJtZeuWO2fuHY7m/eLcyzsLRm1fDPI7tWSR2Bz41i8Azu0rOZZct3K/eQDvlq3dknhLA5oPiUGpKgF9UAhs0nYNdEqEmdXb0Yq5jnJSnNGUTqzWtVLQQl8/7Bf0rQwjRwhZ3FdD+YzSJR9MtOLqvdGW6AzRbtW1wKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/8mOZ5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/8mOZ5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668D0C4CEEF;
	Thu, 31 Jul 2025 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753956000;
	bh=QeKUVb4lpwhFP4ae4SyPkUvf9Mi0i/yZg/Q0hULVNwU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/8mOZ5Nc1eHzOjxtb5DigqrW7/E6IRbys1c9PjeRLyzFIwNdgPV6VYcukowXNvog
	 0hbp0PKTJGlqi/WvQUHNElFXdvBH/wa6PC/uh/ItTAszy/0CqsLTuWkQE/tVfeK2rm
	 Tl57fej+K45bS3EcChjLBnSNfkVXU8eMwNZyOg85kw2zEKJn6oRIbNp5QF9WfA1KqQ
	 +wvxVmNaQWm7JYxl36sWm2bijjw396uvS4g8tVNk0khk89Do/l7/96YV2dY1MLg2vL
	 pOsIS1/BRifSaHyvT+4vYQKrJs0Z5aScRvw3ME2sXLcLgf5v7LjaclzggXlYdAjA3F
	 FhIGSpwfmDXdw==
Message-ID: <9f6237d3-a8eb-4dce-bea1-baefbd6ef59c@kernel.org>
Date: Thu, 31 Jul 2025 11:59:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: setsockopt support for
 TCP_MD5SIG
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
 <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version.

On 31/07/2025 09:27, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
> The implementation:
> - Allows setting these options (getsockopt remains unsupported)
> - Applies them only to the first subflow
> - Forces fallback to TCP (since MD5 isn't compatible with MPTCP)
> 
> Setting these options triggers fallback to TCP to maintain MD5
> compatibility.
> 
> Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index b264185b810d..3ffdeca694be 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -13,6 +13,7 @@
>  #include <net/tcp.h>
>  #include <net/mptcp.h>
>  #include "protocol.h"
> +#include "mib.h"
>  
>  #define MIN_INFO_OPTLEN_SIZE		16
>  #define MIN_FULL_INFO_OPTLEN_SIZE	40
> @@ -567,11 +568,12 @@ static bool mptcp_supported_sockopt(int level, int optname)
>  		case TCP_FASTOPEN_CONNECT:
>  		case TCP_FASTOPEN_KEY:
>  		case TCP_FASTOPEN_NO_COOKIE:
> +		/* MD5 will force a fallback to TCP: OK to set while not connected */
> +		case TCP_MD5SIG:
> +		case TCP_MD5SIG_EXT:
>  			return true;
>  		}
>  
> -		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
> -
>  		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
>  		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
>  		 */
> @@ -830,6 +832,12 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
>  		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
>  		return 0;
> +#ifdef CONFIG_TCP_MD5SIG
> +	case TCP_MD5SIG:
> +	case TCP_MD5SIG_EXT:
> +		__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK);

I don't think that's a good idea to do just that: here, you will do a
fallback even if the options are not correct. Please this helper can
return false if a fallback is not possible, and a reset will be needed.

I think it would be easier to simply limit the use of this option for
listened and closed state: a fallback will be done in mptcp_connect()
and subflow_check_req().

If I'm not mistaken, mptcp_setsockopt_first_sf_only() will limit to the
first subflow, before the establishment of the connection
(__mptcp_nmpc_sk() is explicitly checking the state), no?

Then all you require is to add the two 'case', no? If yes, please add a
Fixes tag:

Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")

And add something like this in the commit message:

  Supporting TCP_MD5 socket option is required when MPTCP is used by
  default when creating a socket, to keep the same behaviour as with
  TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
  fallback to TCP at the connection request, if MPTCP was requested.
  This then fixes a "regression" compared to TCP.


One last thing, please also send the new packetdrill test on GitHub when
sending a next version.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

