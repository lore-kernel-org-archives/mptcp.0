Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A041D22C;
	Mon, 14 Sep 2026 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380408; cv=none; b=GHLUlf4IPIhW4Tj3Zuh1FJIyBgU9vlO5sFX6HHvR+Cr/I8CJh3rdM0Spl1qrS3wQnqVyOeiX6XwG57YdTlp99V8O9h6S0p75vNniXG8DNIpSBF+8DpSgYr7Ko6/II+4kcAY+EHMydvAg2uMO1BnBIcPXOId9iuoTdwA5SqcGmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380408; c=relaxed/simple;
	bh=Sbe+vc+aVmleVZcpQVtskvA2EDy/QtkUtj4dZJ+rO2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4ofuDHx6r+kM9B3kCMtFnHnz8ekJ6Eui5nGohf6F7xZ6aUPl34gdkDZyqmNPjwREqvkjSbJCubtnS4kIqe7P/gGpf+TXHfpUJpUlLIcEdEb1jDraff8FTgG7MWsqe8OBqnxzo+osiqp3gYgr4CiEDCINFRREME0uC6veL2K5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkf7PEf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkf7PEf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE811F00893;
	Mon, 14 Sep 2026 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789380406;
	bh=6U66J0vgegkdBYEEUGB5I7wbrHnMwmHGP29FOANs9S0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lkf7PEf6aiWH2jIeNt/fM8hnpg+mwi5Vemp0FenyA51saZsnLz37Y6tqWEanoouZf
	 ydlEtXoGu0VvcLM6Sehy1cjPaLFvWKH5MRybWBN1AQaOp4aJtt6b0bO1d04sxeRgDM
	 ZC1Mxvf7PBoTuUMXpFpaEGaIyGIWcGWXrGMCZO5XP5iPqnZ79EiMc5Md2qyhrr6+zB
	 9I9Bt2f4OM6sFdvqrDre/RLALqCjnOOuCa6kZW1qG3CIy0joKYRfUZf0CPfPoucf5e
	 XvYnzSvBSuMEs7EJ7QTGDhHYATwpjaIB5v0wSqgodcJQos2kBaUwByWj5uLhyj3ExF
	 bzFTyN+vkYSzA==
Message-ID: <095b530aa856a81d8576d235d28dcbc3e25841b2.camel@kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
From: Geliang Tang <geliang@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Eric
 Dumazet	 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima	 <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, David Howells	 <dhowells@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau	 <martineau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
Date: Mon, 14 Sep 2026 18:06:38 +0800
In-Reply-To: <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
	 <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
	 <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

On Mon, 2026-09-14 at 16:24 +0800, Jiayuan Chen wrote:
> 
> On 9/14/26 3:14 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When the sendpage->MSG_SPLICE_PAGES migration series replaced
> > do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers
> > that
> > had used do_tcp_sendpages() kept an explicit
> > tcp_rate_check_app_limited(sk)
> > that was originally needed to cover do_tcp_sendpages() (which did
> > not call
> > tcp_rate_check_app_limited()). After the inlining,
> > tcp_sendmsg_locked()
> > always provides the check, and the outer call became redundant.
> > 
> > The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop
> > that
> > holds the socket lock and only iterates when size > 0;
> > tcp_sendmsg_locked()
> > is invoked on every iteration with state identical to what the
> > outer call
> > sees, so dropping the outer call is safe and behavior-preserving.
> > 
> > A potential benefit of this change is that it facilitates future
> > reuse of
> > tcp_bpf_push() for sockmap support in protocols beyond TCP, such as
> > MPTCP.
> > Since tcp_rate_check_app_limited() is TCP-specific while
> > sendmsg_locked()
> > is a generic interface in struct proto_ops, this change allows us
> > to switch
> > to different protocols via sk->sk_socket->ops->sendmsg_locked()
> > without
> > carrying protocol-specific assumptions.
> > 
> > Fixes: ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now
> > a wrapper around tcp_sendmsg")
> 
> 
> Same as the tls one: this looks like a cleanup to me. Is there a real
> regression that affects kernel or user behavior?
> 
> Do we really need a Fixes tag?

Thanks for the review. I fully agree - I'll drop the "Fixes" tags and
update the commit logs in v2.

Thanks,
-Geliang

> 
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >   net/ipv4/tcp_bpf.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index 2e234d155b5e..d5fcf3ce4861 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -108,7 +108,6 @@ static int tcp_bpf_push(struct sock *sk, struct
> > sk_msg *msg, u32 apply_bytes,
> >   		off  = sge->offset;
> >   		page = sg_page(sge);
> >   
> > -		tcp_rate_check_app_limited(sk);
> >   retry:
> >   		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
> >   		has_tx_ulp = tls_sw_has_ctx_tx(sk);
