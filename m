Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344C2E3705
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017221; cv=none; b=GZ+4pFcsM8RbQLJLRcIsH5wp4GfeC2sGcK//sf5a4zptW3VorYZhK4TLczs4MobnbLHT+W5T+Bodpq8GsuDuH7f47E0YmW23U42Hfe2kbnKJ1IPxT0wkkqwLH9i/QR+szNdev6gfudCpNl7ShLMANuVzFok7Qx8s0PpyFrniEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017221; c=relaxed/simple;
	bh=PFSbTKaN1kSzsuJOi16NyvnAD3TOdyM3kK2VodoG9bc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2P9ddhDh9GtYq/RKw4RgHJNoasbMEPgTFFQBr/FQJpkNvmb2U3n3IKfA5/r2Mbe2Rw3U3bVqZxnUQinn2giMxupoggDcVi41QrOl2BYT54m8ERFY1L5cRbQDxvp/KrtKaaGI1EpkEcI3cJee72pQW5pl8S0ykGY9BJ5R6QsYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8Gky0qt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8Gky0qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492A6C4CEEF;
	Fri,  1 Aug 2025 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754017220;
	bh=PFSbTKaN1kSzsuJOi16NyvnAD3TOdyM3kK2VodoG9bc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P8Gky0qt+ULi6IsoK8SLgUWQG2o09k31hWdTV8gIS1QNCJ/B74LlWV0MDgdlYf4+y
	 j5MeuqZbhEEBmcfTkOtUZJgydxZZX2S5tUU/g1UexMArxLV+enO+++s6tUnpLm2djE
	 WYyWXvtAjiPAsd4vUMHo7UociSkAyAZS9YaV3c8Zg96G0fUim6WQHs7fbbXNIwf0mg
	 HRUWHYZWKQRN1NI5NfG1VtADx8EiZ8RlD1qogwV/CsoSxTtO2hQyaA5Z2m64qlcyaQ
	 wglAFpWgg56SiQAz05z3anUZ5KmHRLwU476NGe6qT1ZR9k1IIbBIkooqmkbqYmeK2T
	 hewZa/8SmFOjw==
Message-ID: <34edc365d26db1b51671f34d85e9ca2d7bd72dde.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: setsockopt support for
 TCP_MD5SIG
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 01 Aug 2025 11:00:14 +0800
In-Reply-To: <9f6237d3-a8eb-4dce-bea1-baefbd6ef59c@kernel.org>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
	 <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
	 <9f6237d3-a8eb-4dce-bea1-baefbd6ef59c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-07-31 at 11:59 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the new version.
> 
> On 31/07/2025 09:27, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT
> > options.
> > The implementation:
> > - Allows setting these options (getsockopt remains unsupported)
> > - Applies them only to the first subflow
> > - Forces fallback to TCP (since MD5 isn't compatible with MPTCP)
> > 
> > Setting these options triggers fallback to TCP to maintain MD5
> > compatibility.
> > 
> > Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP
> > too.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/sockopt.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index b264185b810d..3ffdeca694be 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -13,6 +13,7 @@
> >  #include <net/tcp.h>
> >  #include <net/mptcp.h>
> >  #include "protocol.h"
> > +#include "mib.h"
> >  
> >  #define MIN_INFO_OPTLEN_SIZE		16
> >  #define MIN_FULL_INFO_OPTLEN_SIZE	40
> > @@ -567,11 +568,12 @@ static bool mptcp_supported_sockopt(int
> > level, int optname)
> >  		case TCP_FASTOPEN_CONNECT:
> >  		case TCP_FASTOPEN_KEY:
> >  		case TCP_FASTOPEN_NO_COOKIE:
> > +		/* MD5 will force a fallback to TCP: OK to set
> > while not connected */
> > +		case TCP_MD5SIG:
> > +		case TCP_MD5SIG_EXT:
> >  			return true;
> >  		}
> >  
> > -		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported,
> > MD5 is not compatible with MPTCP */
> > -
> >  		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ,
> > TCP_REPAIR_OPTIONS,
> >  		 * TCP_REPAIR_WINDOW are not supported, better
> > avoid this mess
> >  		 */
> > @@ -830,6 +832,12 @@ static int mptcp_setsockopt_sol_tcp(struct
> > mptcp_sock *msk, int optname,
> >  		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
> >  		mptcp_setsockopt_first_sf_only(msk, SOL_TCP,
> > optname, optval, optlen);
> >  		return 0;
> > +#ifdef CONFIG_TCP_MD5SIG
> > +	case TCP_MD5SIG:
> > +	case TCP_MD5SIG_EXT:
> > +		__mptcp_try_fallback(msk,
> > MPTCP_MIB_MD5SIGFALLBACK);
> 
> I don't think that's a good idea to do just that: here, you will do a
> fallback even if the options are not correct. Please this helper can
> return false if a fallback is not possible, and a reset will be
> needed.

Yes, here the return value of __mptcp_try_fallback() needs to be
checked:

 if (!__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
	 return 0;

> 
> I think it would be easier to simply limit the use of this option for
> listened and closed state: 

Yes, the state of sk needs to be checked too:

 if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
     !__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
 	return 0;

Do you think this will work?

> a fallback will be done in mptcp_connect()
> and subflow_check_req().

When running the selftests of patch 3 in v1, no fallback is done in
mptcp_connect() and subflow_check_req(). Since both
rcu_access_pointer(tcp_sk(ssk)->md5sig_info) and
rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info) are NULL. So we do
need to fallback in mptcp_setsockopt_sol_tcp().

Thanks,
-Geliang

> 
> If I'm not mistaken, mptcp_setsockopt_first_sf_only() will limit to
> the
> first subflow, before the establishment of the connection
> (__mptcp_nmpc_sk() is explicitly checking the state), no?
> 
> Then all you require is to add the two 'case', no? If yes, please add
> a
> Fixes tag:
> 
> Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported
> sockopt")
> 
> And add something like this in the commit message:
> 
>   Supporting TCP_MD5 socket option is required when MPTCP is used by
>   default when creating a socket, to keep the same behaviour as with
>   TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
>   fallback to TCP at the connection request, if MPTCP was requested.
>   This then fixes a "regression" compared to TCP.
> 
> 
> One last thing, please also send the new packetdrill test on GitHub
> when
> sending a next version.
> 
> Cheers,
> Matt
