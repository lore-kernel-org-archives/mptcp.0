Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDC18C038
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962366; cv=none; b=Jv/7S41/V+vU7jArdzNEKLXdaXqyxWl2empgZ131OCKmy4vg93rlBj7KrIJnpbxbQXFmE3IWNAGkTmo7tl0RSsax/ZLxY5URz7996VEor16kSWlSv8Ddb4XY5PAMWd3tsurZ/BBL6Dab//qOozi5j7+JYCD2TheLsEdU2YyC3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962366; c=relaxed/simple;
	bh=fCDvh7m+Cm8K13TGN+YC2vo0UpFx88a9GY/S61U2hVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4tSPQSh3qK1J4xtGtuVgSrhsXB+l79sBEL92jz5SCyOilchj3pqjoC2fWxjGnIMKOAWkV6Ch7O5kte6idFHlBbfzYBl3YEAc3x8WK7TVfhJ10EWF3CLA86gSF/BCVBZhCKpQbGYO/koxH8TYFCh0mzHxHXDptShoDe8JNtNVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ5SkQIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ5SkQIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B75C4CECF;
	Tue, 10 Sep 2024 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725962365;
	bh=fCDvh7m+Cm8K13TGN+YC2vo0UpFx88a9GY/S61U2hVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OJ5SkQIL+/eii6maalu+CyO9gG8h909e9+aqJ7oz8E6kGBJPEfnh+IscyGfIIKjyJ
	 80OmEF+mOw0VJwHBHb6KW8tz9V0Zh6LliFFp/rsgvRGyAh0E10XURNclt058FKwYiW
	 hwkYUhQsHCT8fFbPqSXCS7kp+VjX+TZAF+iR+FE8QASvdDOFyog2Ms1sRQHJcA1itL
	 HW6clnUenrN4ipRwQ8lGa5J4ij01uwlOKZa75SaoSXxYNgVDHCl+sq5aDd0nmrxVJp
	 Laxv4+WfLbHFMtolLd3TMKzQvcHll3cNJDIL2m8GUw7umCW9liMkuC0bYdP0e3cnQu
	 GibtzFvr69cUw==
Message-ID: <c5a9005e8fd225c5015244b1079f7d61e5820867.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 10 Sep 2024 17:59:20 +0800
In-Reply-To: <e4fd09ab-b88b-4d90-a452-affb151772b6@kernel.org>
References: <cover.1725958296.git.tanggeliang@kylinos.cn>
	 <cb7ca604cdc487d1f9a2f03a3a14904b003227fd.1725958296.git.tanggeliang@kylinos.cn>
	 <a1822c37-3c2d-4865-848c-e6d92fa439aa@kernel.org>
	 <72458d8097fa7ee4f8b783c51ec70376fc1234e2.camel@kernel.org>
	 <7040e6bd-2257-48dc-99a1-3dacbdb1993f@kernel.org>
	 <7e2736756b3e900189873023a20ab84fb242c220.camel@kernel.org>
	 <e4fd09ab-b88b-4d90-a452-affb151772b6@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-10 at 11:44 +0200, Matthieu Baerts wrote:
> On 10/09/2024 11:41, Geliang Tang wrote:
> > On Tue, 2024-09-10 at 11:33 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 10/09/2024 11:27, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Tue, 2024-09-10 at 11:12 +0200, Matthieu Baerts wrote:
> > > > > Hi Geliang,
> > > > > 
> > > > > On 10/09/2024 10:53, Geliang Tang wrote:
> > > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > 
> > > > > > Register mptcp_subflow bpf_iter helpers in common_btf_ids
> > > > > > in
> > > > > > kernel/bpf/helpers.c, then they can be used on a larger
> > > > > > scale,
> > > > > > not only in types BPF_PROG_TYPE_TRACING and
> > > > > > BPF_PROG_TYPE_STRUCT_OPS.
> > > > > 
> > > > > Why could they not be used in these types? I find it good to
> > > > > have
> > > > > them
> > > > > defined in net/mptcp, from a maintenance point of view.
> > > > > 
> > > > > Also, the different bpf_iter_xxx helpers defined there look
> > > > > generic.
> > > > > While here, it is specific to MPTCP, I'm not even sure that
> > > > > would
> > > > > be
> > > > > OK
> > > > > to add them there. Is it not OK to define them only in
> > > > > net/mptcp/bpf.c?
> > > > 
> > > > Yes, a new test for #484 (BPF: setsockopt on an MPTCP socket:
> > > > check
> > > > support) will use these helpers in "cgroup/setsockopt", that is
> > > > the
> > > > BPF_PROG_TYPE_CGROUP_SOCKOPT type.
> > > > 
> > > > register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
> > > > 		&bpf_mptcp_sched_kfunc_set);
> > > > 
> > > > will fail, since BPF_PROG_TYPE_CGROUP_SOCKOPT is not allow to
> > > > register
> > > > more kfuncs (see bpf_prog_type_to_kfunc_hook() in
> > > > kernel/bpf/btf.c).
> > > > 
> > > > So I have to move them into common_btf_ids in
> > > > kernel/bpf/helpers.c
> > > > to
> > > > allow them can be used in almost every BPF program type.
> > > 
> > > OK, but then I guess these helpers can be upstreamed before the
> > > packet
> > > schedulers, right?
> > 
> > Yes, indeed. I hope them can be upstreamed after the "new MPTCP
> > subflow
> > subtest" set under reviewing on BPF list.
> 
> OK good!
> 
> > So this set should be applied in this order:
> > 
> > selftests/bpf: Add mptcp subflow example
> > selftests/bpf: Add getsockopt to inspect mptcp subflow
> > selftests/bpf: Add mptcp subflow subtest
> 
> I will first send these 3, before focusing on the other ones if
> that's OK.

Thanks.

> 
> > bpf: Add mptcp_subflow bpf_iter
> > bpf: Register mptcp tracing kfunc set
> > selftests/bpf: Add mptcp_subflow bpf_iter test prog
> > selftests/bpf: Add mptcp_subflow bpf_iter subtest

The next set is to use this mptcp_subflow bpf_iter to update all the
BPF scheduler examples, which is almost ready. I will post them in the
next few days.

Regards,
-Geliang

> > selftests/bpf: Add bpf scheduler test
> > selftests/bpf: Add bpf_first scheduler & test
> Cheers,
> Matt

