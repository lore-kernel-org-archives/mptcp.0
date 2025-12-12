Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C472E6CAF
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528168; cv=none; b=parjY3g/zYfKrh2o9A7iCgN0y5qE5X6W9QN1+Dx0ubWRbYjGlU24+wzvIRbu4YdKep4JoZaXruI54JwnlxeEJekryMnrSVW16c+YofCpS2T3HnzeCkubeOmd5KgncupZrfrF6jGCJZAB5BjBKiKcvQVw//5OefgMjqO5ds1M1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528168; c=relaxed/simple;
	bh=lVWOhZC6lMrPgd6hCOQy74ensHW/XeZwgp9Zti9lw7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKjM2Z8yfLxuHye3EsXSB4JeLNCr9okP5CPFat74MPzMN2ExW2izSnPOXrd8LaW+HxLIKD6U3OLTOkBk2XiZY9CRmBmS2gbw2yoeA/brxpLNddOKJ2np2e2gAzHJ3VE7hvLprMoWqVBnRK7F5hwLK+l3PMj8Ax7GvYdHnSf7pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7diFUPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7diFUPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1577AC4CEF1;
	Fri, 12 Dec 2025 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765528167;
	bh=lVWOhZC6lMrPgd6hCOQy74ensHW/XeZwgp9Zti9lw7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k7diFUPegsBlonw1zYL3jtBx1XdgubeG+siN+5Fe1g3UM0ReYUtY9FK0p4UkYFIQO
	 QHEuJC+2PnypRprpYcb01KW/vCcKxfydBom7g0PTXNHXNVmAKWYeMYj4Sb2oqn26oR
	 eD9jTNNOZ3SMd4U3t0iioUR5uIY+I7yUZRYBYxfNa3n3TdOEvp7F8Jd9U7ZZPqkZFI
	 WxX5FKYvgEkxS6H45G6qnhzLGmFhUE9MaQ/eV/9v0floaB3zBVRMJLs5THmMaACDgC
	 Pww3JGBlyIyTBv0xV6KK7Z3dlmeqxsSppOBn+vQYroASWU+8moXzX9GJGFoH8e7MOw
	 7XeqoIl+FLVDg==
Message-ID: <0bfb29e59a823e7ac1ed15056be20f8b9c8e0e1b.camel@kernel.org>
Subject: Re: [RFC mptcp-next v4 08/10] mptcp: enable TLS setsockopt
From: Geliang Tang <geliang@kernel.org>
To: GangYan <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan
	 <yangang@kylinos.cn>
Date: Fri, 12 Dec 2025 16:29:21 +0800
In-Reply-To: <aTvDDz10WD9VJ48i@thinkbook16p>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
	 <03bbe5c5fa031651f0796c30f3c64a74083d8a7f.1765505775.git.tanggeliang@kylinos.cn>
	 <aTvDDz10WD9VJ48i@thinkbook16p>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-12-12 at 15:23 +0800, GangYan wrote:
> Hi, Geliang:
> > On Fri, Dec 12, 2025 at 10:27:18AM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds MPTCP TLS setsockopt support. It allows setting the
> > TCP_ULP
> > option to 'tls' exclusively, and enables configuration of the
> > TLS_TX and
> > TLS_RX options at the SOL_TLS level.
> > 
> > This option cannot be set when the socket is in CLOSE or LISTEN
> > state.
> > 
> > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/sockopt.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index f3db4f2e8f81..52ff75702404 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -12,6 +12,7 @@
> >  #include <net/protocol.h>
> >  #include <net/tcp.h>
> >  #include <net/mptcp.h>
> > +#include <net/tls.h>
> >  #include "protocol.h"
> >  
> >  #define MIN_INFO_OPTLEN_SIZE		16
> > @@ -567,6 +568,7 @@ static bool mptcp_supported_sockopt(int level,
> > int optname)
> >  		case TCP_FASTOPEN_CONNECT:
> >  		case TCP_FASTOPEN_KEY:
> >  		case TCP_FASTOPEN_NO_COOKIE:
> > +		case TCP_ULP:
> >  			return true;
> >  		}
> >  
> > @@ -576,6 +578,13 @@ static bool mptcp_supported_sockopt(int level,
> > int optname)
> >  		 * TCP_REPAIR_WINDOW are not supported, better
> > avoid this mess
> >  		 */
> >  	}
> > +	if (level == SOL_TLS) {
> > +		switch (optname) {
> > +		case TLS_TX:
> > +		case TLS_RX:
> > +			return true;
> > +		}
> > +	}
> >  	return false;
> >  }
> >  
> > @@ -819,11 +828,18 @@ static int mptcp_setsockopt_sol_tcp(struct
> > mptcp_sock *msk, int optname,
> >  				    sockptr_t optval, unsigned int
> > optlen)
> >  {
> >  	struct sock *sk = (void *)msk;
> > +	char ulp[4] = "";
> >  	int ret, val;
> >  
> >  	switch (optname) {
> >  	case TCP_ULP:
> > -		return -EOPNOTSUPP;
> > +		if (copy_from_user(ulp, optval.user, 4))
> > +			return -EFAULT;
> > +		if (strcmp(ulp, "tls\0"))
> > +			return -EOPNOTSUPP;
> > +		if ((1 << sk->sk_state) & (TCPF_CLOSE |
> > TCPF_LISTEN))
> > +			return -EINVAL;
> Here should return -ENOTCONN

Yes, you're right. I'll update it in v5.

Thanks,
-Geliang

> 
> I'm running the tls selftest(tools/testing/selftest/net/tls.c), and
> the
> '-EINVAL' will cause an error in 'non_established' test, it checks
> the
> errno should be 'ENOTCONN'.
> 
> If we don't return here is also OK, because the
> 'tcp_setsockopt' can return too, but I think a state validation at
> the
> MPTCP layer is necessary, and 'ENOTCONN' is more accurate for
> 'TCPF_CLOSE | TCPF_LISTEN'.
> 
> WDYT
> 
> Thanks
> Gang
> > +		return tcp_setsockopt(sk, SOL_TCP, optname,
> > optval, optlen);
> >  	case TCP_CONGESTION:
> >  		return mptcp_setsockopt_sol_tcp_congestion(msk,
> > optval, optlen);
> >  	case TCP_DEFER_ACCEPT:
> > -- 
> > 2.51.0
> > 
> > 
