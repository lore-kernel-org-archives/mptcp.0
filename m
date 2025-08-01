Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D334CF9
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017299; cv=none; b=tzhMDa9cY5hPfKU9szEOsWJNtTlIwcm9vSGZKDXPcUzU/mpk7p3q72/usgtlpBxK4FHm7x+MzHw0NAkC1IbM+Npq2uHSqtOkb0sWDtYOavrC3VfG7RPrqpqDESZIB/E79iJo984ehDLy32QeQNroAsraHCDn3nuq0Nz42q4ab1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017299; c=relaxed/simple;
	bh=4AJKkBqzWe6JllOs4Webj7ZpOoT8Mdc4syvqYhPC7Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3ZPY14T97fjeFjTvk8zf9tbN9gsROoUZeanLBPD1+u1Eq9fOmoG2mtQVw5inqzCLLTirJLjSfHmBQ9aKMbvdx5a2mnXKqqk0bZVFcmMr6dGnA52xc8Qz9uDqkUWuxc+DCwVLSYPiClkPi+MLcafSWc/h7M7ZWCE24N1bH/NZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIdAWCyf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIdAWCyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704A6C4CEEF;
	Fri,  1 Aug 2025 03:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754017298;
	bh=4AJKkBqzWe6JllOs4Webj7ZpOoT8Mdc4syvqYhPC7Cs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FIdAWCyfMYf97SDuU0Gm4kwaoMmnADN4Kf8YBi4uV+drhZh3bX2F7/WWB4v4Dwp+Q
	 rGRs1GqyHdeTdwpjQPrj0WCvCshHr7hkps9LoxoNCEUnrH/EKjSQG4bKkyocFWtZIi
	 oY12xVaiHpTCeyquDROU6mNRERwZ2EBqxUHW44NzbSMjIGkSHQNjBHsj9X9Ovrto7P
	 tAiL7Zax65JGcO6Xx1JF6k/DNv2Hfqou/0ld/US1Z7sC1TkIBw4iiGGGLMuKKIN1i/
	 +C67WjbbLeElfIOiGQHu1FeCW7/kFHV1ugGuRV5s4IlRSRNnlczwDc0mjo/mc426vO
	 KnpUYYYNZGMjw==
Message-ID: <bcf2fe86d9fd4a8c4300db90ec4a8af32b074bdd.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: setsockopt support for
 TCP_MD5SIG
From: Geliang Tang <geliang@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 01 Aug 2025 11:01:35 +0800
In-Reply-To: <CADg4-L8S1bqK6f6YUWuoEJOziYL-Q0DZY5p2DFStKA4mFi02mg@mail.gmail.com>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
	 <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
	 <CADg4-L8S1bqK6f6YUWuoEJOziYL-Q0DZY5p2DFStKA4mFi02mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

On Thu, 2025-07-31 at 12:18 -0700, Christoph Paasch wrote:
> On Thu, Jul 31, 2025 at 12:28 AM Geliang Tang <geliang@kernel.org>
> wrote:
> > 
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
> 
> Just wondering : What does the above line mean ? "unsupported for TCP
> too" ?

It should be:

TCP_MD5SIG and TCP_MD5SIG_EXT getsockopts are unsupported for TCP too.

Thanks,
-Geliang

> 
> 
> Christoph
> 
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
> >  #define MIN_INFO_OPTLEN_SIZE           16
> >  #define MIN_FULL_INFO_OPTLEN_SIZE      40
> > @@ -567,11 +568,12 @@ static bool mptcp_supported_sockopt(int
> > level, int optname)
> >                 case TCP_FASTOPEN_CONNECT:
> >                 case TCP_FASTOPEN_KEY:
> >                 case TCP_FASTOPEN_NO_COOKIE:
> > +               /* MD5 will force a fallback to TCP: OK to set
> > while not connected */
> > +               case TCP_MD5SIG:
> > +               case TCP_MD5SIG_EXT:
> >                         return true;
> >                 }
> > 
> > -               /* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported,
> > MD5 is not compatible with MPTCP */
> > -
> >                 /* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ,
> > TCP_REPAIR_OPTIONS,
> >                  * TCP_REPAIR_WINDOW are not supported, better
> > avoid this mess
> >                  */
> > @@ -830,6 +832,12 @@ static int mptcp_setsockopt_sol_tcp(struct
> > mptcp_sock *msk, int optname,
> >                 /* See tcp.c: TCP_DEFER_ACCEPT does not fail */
> >                 mptcp_setsockopt_first_sf_only(msk, SOL_TCP,
> > optname, optval, optlen);
> >                 return 0;
> > +#ifdef CONFIG_TCP_MD5SIG
> > +       case TCP_MD5SIG:
> > +       case TCP_MD5SIG_EXT:
> > +               __mptcp_try_fallback(msk,
> > MPTCP_MIB_MD5SIGFALLBACK);
> > +               fallthrough;
> > +#endif
> >         case TCP_FASTOPEN:
> >         case TCP_FASTOPEN_CONNECT:
> >         case TCP_FASTOPEN_KEY:
> > --
> > 2.48.1
> > 
> > 
