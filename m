Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C2535D6
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419444; cv=none; b=alh4txC/JkzoCwGfpKJT6i5WBpP4ksSxpu/T6kS0orRzXfvLRDetxuJr/STriwi88ZzCBnDhgoSBBcoHXzSnXKU+ritQzD5LNLT6Px/qwfGYEW/+754bP23R9LdfcJOziOjHHBEQdgA0XF7XPXpeJuttm3P8gOU91odolB3quqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419444; c=relaxed/simple;
	bh=zeQRmx9RtBwkrIVzZ8UZWD3Wiekn/lB/LUfktrOzKgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fp7YOtpeyGiT0QUdlB+KKyoyLq8cnYHkWtZtyUlyy/48j9OTPp4yJ3snPVVlErQOECyzDxjq013FccjIZNQ8/PgXZz+bDDAiBelb+T/o/y37LcFYNv42Urb5XEo7F4vOr8Pf0qtQOchR1SZOkl2qG50pAAm2YCNdJZNjvIPJpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHDvgmXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHDvgmXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB9BC2BD10;
	Sat, 11 May 2024 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715419443;
	bh=zeQRmx9RtBwkrIVzZ8UZWD3Wiekn/lB/LUfktrOzKgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sHDvgmXaivb8STt2WXfka3kJrvjWI4h2a9C5TDZW7TW5YWU6EnAqga0MLwF2kDXjI
	 VTOxqx87QdATohRIQd3N7BGCnENi+pe7sRVmVX6uC5A3QD7PVLjQG2ryKpnbt47sZW
	 TpKiNEMSJ24oQprtUoCInlVcV6U2yfwkgtqFAiyWvM8YIqmjmrT3aCA4iqoe3mryMp
	 O/37Lt/nNPSKiTWwiBpPYTQ8oV7nTLx5QO5UpaNxVvfsj0pf1vEVFEMYDKossEJ7f2
	 sk/GgCqjvtIcriBAvXYm+qRIDWhMA0bN7Swy5xOWvxIPoYGCT98XxQ9SMPiNUfg069
	 SsUq/Ae47NJAw==
Message-ID: <34a6fe1439ef8b6915391bb75b593a4e2805fe5a.camel@kernel.org>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: new MPTCP subflow subtest &
 improvements
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Sat, 11 May 2024 17:23:58 +0800
In-Reply-To: <89dc0020-6bd8-4cce-8b8c-8b73c22c386e@kernel.org>
References: 
	<20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
	 <89dc0020-6bd8-4cce-8b8c-8b73c22c386e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-09 at 16:39 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (only with MPTCP ML in cc)
> 
> On 07/05/2024 12:53, Matthieu Baerts (NGI0) wrote:
> > In this series from Geliang, modifying MPTCP BPF selftests, we
> > have:
> > 
> > - SIGINT support
> > 
> > - A new macro to reduce duplicated code
> > 
> > - A new MPTCP subflow BPF program setting socket options per
> > subflow: it
> >   looks better to have this old test program in the BPF selftests
> > to
> >   track regressions and to serve as example.
> > 
> >   Note: Nicolas is no longer working for Tessares, but he did this
> > work
> >   while working for them, and his email address is no longer
> > available.
> > 
> > - A new MPTCP BPF subtest validating the new BPF program.
> > 
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Geliang Tang (3):
> >       selftests/bpf: Handle SIGINT when creating netns
> 
> Regarding this patch, do you mind looking for a new version that is
> generic as requested by Alexei, please?

Sure. I'll send them to BPF ML directly and cc MPTCP ML when I finish.

Thanks,
-Geliang

> 
> I guess he meant adding a new helper in network_helpers.c doing "ip
> netns add" + "signal(SIGINT)" + "open_netns()", and using it
> everywhere
> "ip netns add" + "open_netns()" are used. (I guess you will need
> another
> helper to "close_netns()" + "ip netns del" + remove the signal
> handler
> or the netns name.)
> Be careful that sometimes, more than one netns is used.
> 
> >       selftests/bpf: Add RUN_MPTCP_TEST macro
> >       selftests/bpf: Add mptcp subflow subtest
> > 
> > Nicolas Rybowski (1):
> >       selftests/bpf: Add mptcp subflow example
> 
> For your information, I modified our tree to apply comments from
> Alexei:
> 
> New patches for t/upstream:
> - 12609b68c8d9: tg:msg: clarify the commit message
> - a4ad7c6dee6a: Revert "selftests/bpf: Add RUN_MPTCP_TEST macro"
> - f457d8911a38: conflict in t/selftests-bpf-Add-mptcp-subflow-subtest
> - 5072ff915f8d: Revert "selftests/bpf: Handle SIGINT when creating
> netns"
> - 9df135860724: conflict in t/selftests-bpf-Add-bpf-scheduler-test
> - 8ef1339edc8a: conflict in t/selftests-bpf-add-bpf_first-scheduler
> - 2f5ced304cc1: conflict in t/selftests-bpf-Add-bpf_bkup-scheduler
> - e9bafe786620: conflict in t/selftests-bpf-Add-bpf_rr-scheduler
> - dca93e3c7e9a: conflict in t/selftests-bpf-Add-bpf_red-scheduler
> - 5349d85a8c73: conflict in t/selftests-bpf-Add-bpf_burst-scheduler
> - Results: 304693999ba6..b74adae98e0d (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/715c505a46ae8394e40fdeb54e0ecea27f95dc5d/checks
> 
> I will also modify the tree not to remove MPTCP_SCHED_TEST() macro as
> asked by Alexei.
> 
> Cheers,
> Matt

