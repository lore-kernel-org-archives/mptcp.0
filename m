Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610CAD24
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524255; cv=none; b=suxEaSZob8bEB+qwcZDIlwJsEglcC4ku1zAO6v7KQ6k0Qx/rp7QPy1dA5OmzqFKKYn4c0YDUCutt4YylzWUepTp5DjTXnMqBPPRzcdKqN3DwDqbCXITXTHalnSLvJjjnOzX4inzDKKPl7x4B21QuC/oGni0hLHOB0w5/xNr6nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524255; c=relaxed/simple;
	bh=jzhIlNwjM0qDlE0F+Qz4lwd7KFxC4bTfQvbtnCy+d+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyRDWuWYK41AHFqkHiZ0/ylCYA/ZcSLkIJPNVo0gv5Nfqbpl7/7X7mVQ2lErvTYHMrP1dBJi4eSYc7HHqrwaWpyOD5XBPHFJDM+ZYVR2m3d4jjh/pRdgEnntQWW3o3/fHJwWpljH0a6vBb3sgDUJWFEO7tC/cPV0n46AvzxgCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rjYs2/qM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rjYs2/qM"
Date: Fri, 12 Dec 2025 15:23:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765524250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6/5K9STTvaXNWyhhWlwoU0TmY/BVsuhPYujKi7C0EA=;
	b=rjYs2/qMI/hQ6EP2BKUBU+bWoCwttiiS8BgrFhhX1tFTKDdsQhvjfiaiL2kQKJYiqYhiu8
	a/4kIhjuMw8x9qU7hhktYhA34qP7n5PPg8eTWjDTMtMkfmBPRYQDLqQt0YIU6U5EhCRqu+
	SrCsb4Y27KRhZaUheGSKjlPpUiFTSn0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: Re: [RFC mptcp-next v4 08/10] mptcp: enable TLS setsockopt
Message-ID: <aTvDDz10WD9VJ48i@thinkbook16p>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
 <03bbe5c5fa031651f0796c30f3c64a74083d8a7f.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03bbe5c5fa031651f0796c30f3c64a74083d8a7f.1765505775.git.tanggeliang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

Hi, Geliang:
> On Fri, Dec 12, 2025 at 10:27:18AM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds MPTCP TLS setsockopt support. It allows setting the TCP_ULP
> option to 'tls' exclusively, and enables configuration of the TLS_TX and
> TLS_RX options at the SOL_TLS level.
> 
> This option cannot be set when the socket is in CLOSE or LISTEN state.
> 
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index f3db4f2e8f81..52ff75702404 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -12,6 +12,7 @@
>  #include <net/protocol.h>
>  #include <net/tcp.h>
>  #include <net/mptcp.h>
> +#include <net/tls.h>
>  #include "protocol.h"
>  
>  #define MIN_INFO_OPTLEN_SIZE		16
> @@ -567,6 +568,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
>  		case TCP_FASTOPEN_CONNECT:
>  		case TCP_FASTOPEN_KEY:
>  		case TCP_FASTOPEN_NO_COOKIE:
> +		case TCP_ULP:
>  			return true;
>  		}
>  
> @@ -576,6 +578,13 @@ static bool mptcp_supported_sockopt(int level, int optname)
>  		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
>  		 */
>  	}
> +	if (level == SOL_TLS) {
> +		switch (optname) {
> +		case TLS_TX:
> +		case TLS_RX:
> +			return true;
> +		}
> +	}
>  	return false;
>  }
>  
> @@ -819,11 +828,18 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    sockptr_t optval, unsigned int optlen)
>  {
>  	struct sock *sk = (void *)msk;
> +	char ulp[4] = "";
>  	int ret, val;
>  
>  	switch (optname) {
>  	case TCP_ULP:
> -		return -EOPNOTSUPP;
> +		if (copy_from_user(ulp, optval.user, 4))
> +			return -EFAULT;
> +		if (strcmp(ulp, "tls\0"))
> +			return -EOPNOTSUPP;
> +		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> +			return -EINVAL;
Here should return -ENOTCONN

I'm running the tls selftest(tools/testing/selftest/net/tls.c), and the
'-EINVAL' will cause an error in 'non_established' test, it checks the
errno should be 'ENOTCONN'.

If we don't return here is also OK, because the
'tcp_setsockopt' can return too, but I think a state validation at the
MPTCP layer is necessary, and 'ENOTCONN' is more accurate for
'TCPF_CLOSE | TCPF_LISTEN'.

WDYT

Thanks
Gang
> +		return tcp_setsockopt(sk, SOL_TCP, optname, optval, optlen);
>  	case TCP_CONGESTION:
>  		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
>  	case TCP_DEFER_ACCEPT:
> -- 
> 2.51.0
> 
> 
