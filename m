Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DE2BB17
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847381; cv=none; b=Tw2tiqkssnm2k3psLxTWR8Rvge/WW+2gIpAr6rvRogRyc0N68AUWS/HgX9LjfPed54NqaUSW0iCZCLsjqBcerwc7pNgxFRxFrIvaVZvKt3f9I2r8G2Q+VcN0dKY5GPaBOjrsdEbvDE255e7nOpMh44dApu749hF2YtqBAYVeTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847381; c=relaxed/simple;
	bh=XzA+chTj95Cs15VeR00NRmLHk3+b9Sm3qihKsw9SSpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3BpXmyajFziawL2BBov+D3jNdwQaLBq7F8ShqQ5wZr9keDg6crKPFmB+xEpGukQRomCFT1JLWHjpp3mKrrwJHDocGycFPSBA6ZlPbzCKxS7mqm0UC9BOhKzYB02zKXjOSjkTvI/0NHwDmWHFAoPTW1fkFk1tDmcWNv5+nT7U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSstJyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSstJyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977B5C116B1;
	Tue, 11 Nov 2025 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847381;
	bh=XzA+chTj95Cs15VeR00NRmLHk3+b9Sm3qihKsw9SSpk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YfSstJyh3IgX1GUPFskxjrFMXcfwWm4LZlYPQ+S5XegsHmbqcb7KJT9YFHqqgjbgA
	 9pSQjEg78aMZur29LGtcWm8d25uX0fUdjxOH62GTIqWWpDlkJAWlPyYcpEWstmBN51
	 Zl6MHXnjwjvGmbkHqKTBAFUr7cUTnVkT/h70dM9qXm/ZaKFz5pBnyy6ojpATIGc9Oj
	 TACXHdGyEGh3j6LQGlwKASLORejLqzEK3kn06bgMa62q5ZAjEjDhqPqyMvp17P+fEi
	 uFIMcliqGBq2kxTYh1mpQ8FgjE4U8384ZdsAANBntfUEEro2fxHPXJSMh5KGpc/N/+
	 GY1MdGuWRevZw==
Message-ID: <3377639ffc4e70891038a3b24b18c387a27bf775.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 15:49:36 +0800
In-Reply-To: <e2ee6526-a092-4034-8977-1104ccee1fea@redhat.com>
References: <cover.1762500073.git.pabeni@redhat.com>
	 <32586f43554a4837f39d534676c5ad957dc10dd5.1762500073.git.pabeni@redhat.com>
	 <5a0c227a3a2b660492af391af65eaae8afe31ad0.camel@kernel.org>
	 <be209b04-d721-4f75-a05c-56899eb2942f@kernel.org>
	 <e2ee6526-a092-4034-8977-1104ccee1fea@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-11-11 at 08:27 +0100, Paolo Abeni wrote:
> On 11/11/25 7:14 AM, Matthieu Baerts wrote:
> > 11 Nov 2025 02:59:28 Geliang Tang <geliang@kernel.org>:
> > > On Fri, 2025-11-07 at 08:23 +0100, Paolo Abeni wrote:
> > > > @@ -2448,7 +2447,7 @@ static void
> > > > __mptcp_subflow_disconnect(struct
> > > > sock *ssk,
> > > >                        unsigned int flags)
> > > 
> > > nit:
> > > 
> > > The 3rd argument "flags" of __mptcp_subflow_disconnect is useless
> > > now.
> > > We can drop it.
> > 
> > I don't think it is useless: __mptcp_close_ssk() is still called
> > with either
> > the push flag or no flag (0).
> > 
> > Because this patch is for net, we should avoid unnecessary
> > modifications:
> > we should not change the type or the name of the function argument
> > for
> > "cosmetic" reasons.
> 
> FWIW, I agree with Mat.

I agree too. Let's apply it as is.

Thanks,
-Geliang

> 
> > > > @@ -2511,20 +2510,13 @@ static void __mptcp_close_ssk(struct
> > > > sock
> > > > *sk, struct sock *ssk,
> > > >     if (dispose_it)
> > > >         list_del(&subflow->node);
> > > >  
> > > > -   if ((flags & MPTCP_CF_FASTCLOSE) &&
> > > > !__mptcp_check_fallback(msk)) {
> > > > -       /* be sure to force the tcp_close path
> > > > -        * to generate the egress reset
> > > > -        */
> > > > -       ssk->sk_lingertime = 0;
> > > > -       sock_set_flag(ssk, SOCK_LINGER);
> > > > -       subflow->send_fastclose = 1;
> > > > -   }
> > > > +   if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
> > > > +       tcp_set_state(ssk, TCP_CLOSE);
> > > >  
> > > >     need_push = (flags & MPTCP_CF_PUSH) &&
> > > > __mptcp_retransmit_pending_data(sk);
> > > >     if (!dispose_it) {
> > > >         __mptcp_subflow_disconnect(ssk, subflow, flags);
> > > >         release_sock(ssk);
> > > > -
> > 
> > (This line should not be removed but this can be fixed when
> > applying the patch.)
> 
> Thanks!
> 
> /P
> 

