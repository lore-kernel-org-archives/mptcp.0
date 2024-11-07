Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95231E1A25
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974777; cv=none; b=qARTBnSyj/6tP5h1z+2VfjD9teNW7qDZK0jbk3nyVm/VhBSIuculu+pYph69C3OVUGK5B+ndgHuzhuTgyEk8zREbNNgAuk1OHEwheZi4UJ+R2ZNcGKubSV4Hf615e98DXstuJyxiwh4XkObdOoKcI9BFILSaILOR4KX//WQBH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974777; c=relaxed/simple;
	bh=J4TkgrcK1u779IcewVroUR3NEpirvt7tmc+XGbmTujE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugxRvwD2IlRXiTPS4NNPX0O4keqR5Ztp+pfEXQqH8C1yITiPUYQGTxZXWOvg5QMUVveD7zMBt1uaI78/zANwItn9AarHdkMTukHhAz8lLdFoM+UK96frdyEd7XPoUnGlhE11ZRC/t9et4raxZyMWbTDIU/VyrE5DBHJvDZXQIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sig9BMWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sig9BMWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D05C4CED0;
	Thu,  7 Nov 2024 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730974776;
	bh=J4TkgrcK1u779IcewVroUR3NEpirvt7tmc+XGbmTujE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sig9BMWfD9QLnp8slwCuq7ZrJy1pCh2IKV3aQvYnoty5GhFx+2iQ7n0SxoMG3QXDV
	 3OPz8W4uqTz+csM9BjeloR1V6K4XZ62ZuPBPnYb0Fn/DYMYrM7mk5lfoIJ4K70H5sS
	 RBzdDdKS4azZH9V/72nvoX5088n1ZrLFc39KLSsnO9SNsevZM6beDCAWzcM851i3lI
	 iZ4WSxPtT42Jy3zc7HxZqAP/oNjuyPKj9EovWRLQz34T3UN9SSXwzws3pqyiWU4PcZ
	 86gnpGaA/DDkJ6WGacQtIN1QVYzjE5PNdYIGRCp41spvZllptcv7yARTB1e+0Dp1Z6
	 P93YtvyF9fIXw==
Message-ID: <2a8bb3262f35643316090550ecba249da42d1e5e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 23/36] mptcp: drop struct mptcp_pm_local
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 07 Nov 2024 18:19:31 +0800
In-Reply-To: <f1e9d825-189f-4a86-91be-59492ef80ce0@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn>
	 <4661b240-9a9c-47c2-9dc0-362d22baad83@kernel.org>
	 <a77c02db831525e2e1ec5371aaea4b9869441c0b.camel@kernel.org>
	 <f1e9d825-189f-4a86-91be-59492ef80ce0@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-11-07 at 11:00 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/11/2024 08:29, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Mon, 2024-11-04 at 20:08 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 22/10/2024 11:14, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > The following code in mptcp_pm_nl_subflow_create_doit() that
> > > > assigns struct
> > > > mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local
> > > > variable
> > > > "local" is not allowed in BPF if we use the same code to
> > > > implement
> > > > the
> > > > subflow_create() interface of a BFP path manager:
> > > > 
> > > > 	struct mptcp_pm_local local;
> > > > 
> > > > 	local.addr = entry.addr;
> > > > 	local.flags = entry.flags;
> > > > 	local.ifindex = entry.ifindex;
> > > 
> > > Here as well, I'm not sure to understand the issue. Is it because
> > > you
> > > cannot allocate this structure locally with BPF? No alternatives?
> > 
> > Here "struct mptcp_pm_local local" is a "scalar", when passing it
> > to
> > __mptcp_subflow_connect(), this error occurs:
> > 
> > # ; err = __mptcp_subflow_connect(sk, &local, remote); @
> > mptcp_bpf_userspace_pm.c:242
> > # 53: (bf) r1 = r6                      ;
> > R1_w=trusted_ptr_mptcp_sock()
> > R6=trusted_ptr_mptcp_sock()
> > # 54: (bf) r3 = r8                      ;
> > R3_w=trusted_ptr_mptcp_addr_info() R8=trusted_ptr_mptcp_addr_info()
> > # 55: (85) call __mptcp_subflow_connect#34404
> > # max struct nesting depth exceeded
> > # arg#1 pointer type STRUCT mptcp_pm_local must point to scalar, or
> > struct with scalar
> > 
> > Also, assigning an address to an address like this is not allowed
> > in
> > BPF:
> > 
> > 	local.addr = entry.addr;
> 
> OK, thank you, that's a bit clearer (even if it is not clear what BPF
> code was causing that). For this kind of issue, would it work to add
> a
> BPF-specific kfunc, eventually with additional annotations or
> arguments,
> or taking a "struct mptcp_pm_addr_entry" in argument, and "simply"
> calling __mptcp_subflow_connect() with a "struct mptcp_pm_local"?

It works indeed. But I prefer the version in v3, "mptcp: use
mptcp_pm_local in pm_netlink only". It makes more sense to move
mptcp_pm_local in pm_netlink.c.

WDYT?

Thanks,
-Geliang

> 
> So something specific to BPF, without impacting the rest?
> 
> Cheers,
> Matt

