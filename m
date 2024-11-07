Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A4198831
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964549; cv=none; b=JO+pDhHEwfdZ9vFw7gtxQybBj2PGgk81J+7eAT4x0fRZSJklKXCVDWx+wI7O4cZcn9A6Md79Flfi+xOutbEiADKUNiL2+TaWbn16dLj/2u5run46vPm1yhml8QmNRTcGthJJYmun+CJbLyje7myC/Wz46S+Gbpx4wNTvE9zn/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964549; c=relaxed/simple;
	bh=gehH2gz2V9/kUvPT1jtOES2WSsWhOfoWHOeTy4vBns4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BDoW7ki7q/INM6scsIoVf3cFjmPKfy5WRWHwjZFWXuhwDQ40+pF4euQn44LxDvj7x4PgH5kZ2ju4YgrR6zakmqQRC76iVchinfkg+eG1a2FhP/ULQiRDXYJxI4VFBESXmucuLUG1uVvrfRkV6c2jUZqyDLPurJ+S+t36YMjFeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjOSCQrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjOSCQrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECB6C4CECC;
	Thu,  7 Nov 2024 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730964549;
	bh=gehH2gz2V9/kUvPT1jtOES2WSsWhOfoWHOeTy4vBns4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rjOSCQrOjBL8q1L/tzAYidFYPbDwWuFnkPXrcaxFXbqsIruFQ3hgcYZMhbzCk8rBn
	 kcVFRYkLxZHU2a/CALX52ubDLM11dtujdQbAu0lm9nTpgNyT033jgg1oeJk0qKLOGK
	 fy7sg21IUiRcDzIX9rp4Bhg3KyBcTJrvTU5n01y/lc/XdOfGc6SFVO27Ber2V8lCNk
	 Hxp8oLXqlvJGzy9qfE/lPesY4YGp1SFQnHHibf5jc5a7UGguZT7ilFCq/dB8eMljzs
	 ou6HNGUcUsWZ5VM7tDGwmOTIJD1WWXw1CSVjqn9cE/tDt2rQklQgLvvVYpdgRHBPa7
	 VBO8/hndKBufA==
Message-ID: <a77c02db831525e2e1ec5371aaea4b9869441c0b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 23/36] mptcp: drop struct mptcp_pm_local
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 07 Nov 2024 15:29:05 +0800
In-Reply-To: <4661b240-9a9c-47c2-9dc0-362d22baad83@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn>
	 <4661b240-9a9c-47c2-9dc0-362d22baad83@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2024-11-04 at 20:08 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The following code in mptcp_pm_nl_subflow_create_doit() that
> > assigns struct
> > mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local
> > variable
> > "local" is not allowed in BPF if we use the same code to implement
> > the
> > subflow_create() interface of a BFP path manager:
> > 
> > 	struct mptcp_pm_local local;
> > 
> > 	local.addr = entry.addr;
> > 	local.flags = entry.flags;
> > 	local.ifindex = entry.ifindex;
> 
> Here as well, I'm not sure to understand the issue. Is it because you
> cannot allocate this structure locally with BPF? No alternatives?

Here "struct mptcp_pm_local local" is a "scalar", when passing it to
__mptcp_subflow_connect(), this error occurs:

# ; err = __mptcp_subflow_connect(sk, &local, remote); @
mptcp_bpf_userspace_pm.c:242
# 53: (bf) r1 = r6                      ; R1_w=trusted_ptr_mptcp_sock()
R6=trusted_ptr_mptcp_sock()
# 54: (bf) r3 = r8                      ;
R3_w=trusted_ptr_mptcp_addr_info() R8=trusted_ptr_mptcp_addr_info()
# 55: (85) call __mptcp_subflow_connect#34404
# max struct nesting depth exceeded
# arg#1 pointer type STRUCT mptcp_pm_local must point to scalar, or
struct with scalar

Also, assigning an address to an address like this is not allowed in
BPF:

	local.addr = entry.addr;

> 
> > We should avoid this type of assignment from struct
> > mptcp_pm_addr_entry to
> > struct mptcp_pm_local.
> > 
> > In fact, there is no need to add a dedicated address entry type for
> > local
> > address entry. All its fields are the same as struct
> > mptcp_pm_addr_entry,
> > except that it lacks a "lsk" for the listening socket. So we can
> > use struct
> > mptcp_pm_addr_entry directly. This makes the path manager code
> > simpler.
> 
> There was a need for this structure, see this discussion:
> 
> 
> https://lore.kernel.org/mptcp/587e096f-0e76-40fd-9220-6d8dd2930838@redhat.com/
> 
> and the changelog in v5:
> 
> 
> https://lore.kernel.org/mptcp/20240726-mptcp-pm-avail-v5-13-fb1117ddeef6@kernel.org/
> 
> In short ...
> 
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_netlink.c   | 22 ++++++++--------------
> >  net/mptcp/pm_userspace.c |  7 +------
> >  net/mptcp/protocol.h     |  8 +-------
> >  net/mptcp/subflow.c      |  2 +-
> >  4 files changed, 11 insertions(+), 28 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 287e715bcf68..15f97e7af182 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> 
> (...)
> 
> > @@ -721,7 +715,7 @@ static unsigned int
> > fill_local_addresses_vec(struct mptcp_sock *msk,
> >  
> >  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> >  {
> > -	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
> > +	struct mptcp_pm_addr_entry locals[MPTCP_PM_ADDR_MAX];
> 
> ... we don't want that: that's reserving too much memory, and we
> don't
> need half of it.

Thanks for your information.

> 
> *If* it is really needed to change it for BPF (I'm surprised there
> are
> no alternatives), then maybe we can change the signature of
> __mptcp_subflow_connect(), but not change the code here.
> 
> In this case, only one "struct mptcp_pm_addr_entry" will be needed,
> and
> the "struct mptcp_pm_local" can be defined in this pm_netlink.c file
> if
> it is only used here.
> 
> But please mention that in the commit message.

I updated it in v3 as you suggested.

Thanks,
-Geliang

> 
> >  	struct sock *sk = (struct sock *)msk;
> >  	unsigned int add_addr_accept_max;
> >  	struct mptcp_addr_info remote;
> (...)
> 
> Cheers,
> Matt

