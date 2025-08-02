Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EE22069A
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127492; cv=none; b=bNzDn4dp97trohIa5fNTnc7Hml3dT5nAAcxjvxc2aN1j/JDj3SRmBtV1wZ1qN+z8XvBDO3KFm1g/bcp5fm+GnnqBuvbo3ok98S+hlbKcNwM7J9TzuBexn9Yt16wCWU/xSmbeN2aSk+KALeCz1h6CUTpIaCpWmLjJpDhM5oYtZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127492; c=relaxed/simple;
	bh=sMiFkFoOf2d7QDvVgHKIArOQyy1GWOSYHxoJlFGdf/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWbxI4M1IWt4TGxTVpqFVEtnz4AoAokrJ3J5iJh0dIM+8+gFZTgsuTQocH/k8DUDj8M1cfgyyO1UnO79/JHOFnH0fASrkZP+DRKZZ+To3lNr50qCr4tnZ9XCPBV2b71FCHXTKjIviTN7y0mGAMyGMtQ9NW9UfBjGt9zuJeK1Fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbchF8i7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbchF8i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9C7C4CEEF;
	Sat,  2 Aug 2025 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754127491;
	bh=sMiFkFoOf2d7QDvVgHKIArOQyy1GWOSYHxoJlFGdf/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbchF8i7LjwMrqqGRv4zBOTjZTHq8Z+jwakZy9eJIDsZied7C7LXEhcxrrrTHbcqX
	 DLVH8CGZjmV3RAYho7dQR3nysnkvZkSDCWkhLgssq48y2BsIFCNmWbAw0QuJ3suLWM
	 LcXtdm8E+Rg1s3JhtDVCVHjgN/e/y+K1mD7sPvmW+99sEyknBGAE62jXpHxsNz2V0V
	 /7+sYmzIwHvB9BhdLRxHQ72rYD18+fuLE7q7hmI4xAqlMBb9jk2T/mTVMSTKghyQZ3
	 reD2mrTwlPud7CLbOMKpGhEpPt7rNXHP5i6wCtCHEz2RzJjJNHxEX1U3DqtfwxKini
	 Rz/Is96qx6IaQ==
Message-ID: <34cc29ec-8e1b-4b82-9b82-1f645d455842@kernel.org>
Date: Sat, 2 Aug 2025 11:38:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: setsockopt support for
 TCP_MD5SIG
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754091681.git.tanggeliang@kylinos.cn>
 <8bba29599d026ff96f5b4d5aaf90f087137fc578.1754091681.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8bba29599d026ff96f5b4d5aaf90f087137fc578.1754091681.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 02/08/2025 01:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Supporting TCP_MD5 socket option is required when MPTCP is used by
> default when creating a socket, to keep the same behaviour as with
> TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
> fallback to TCP at the connection request, if MPTCP was requested.
> This then fixes a "regression" compared to TCP.
> 
> This patch adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT
> options. The implementation:
>  - Allow setting these options (getsockopt remains unsupported)
>  - Apply them only to the first subflow
>  - Trigger fallback to TCP to maintain MD5 compatibility
> 
> Note that getsockopt for these options remains unsupported, consistent
> with TCP.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 006849741813..4dec3c372772 100644
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
> @@ -596,11 +597,12 @@ static bool mptcp_supported_sockopt(int level, int optname)
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
> @@ -865,6 +867,19 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  	case TCP_FASTOPEN_NO_COOKIE:
>  		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
>  						      optval, optlen);
> +#ifdef CONFIG_TCP_MD5SIG

Do we need this? mptcp_setsockopt_first_sf_only() should return an error
coming from tcp_setsockopt() if TCP_MD5SIG(_EXT) is not supported, no?

> +	case TCP_MD5SIG:
> +	case TCP_MD5SIG_EXT:
> +		if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> +			return -EINVAL;

If I'm not mistaken, this check is not needed, because the same check
will be done in mptcp_setsockopt_first_sf_only(): it should only change
something on the first sufblow, before the connection, no?

> +		ret = mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
> +						     optval, optlen);
> +		if (ret)
> +			return ret;
> +		if (!__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
> +			return -EINVAL;

If the fallback is done before the connection, it should not fail. Maybe
use WARN_ON_ONCE(!__mptcp_try_fallback(msk, <MIB>)) instead?

  if (ret == 0)
      WARN_ON_ONCE(!__mptcp_try_fallback(msk, <MIB>))

  return ret;


> +		return 0;
> +#endif
>  	}
>  
>  	ret = mptcp_get_int_option(msk, optval, optlen, &val);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

