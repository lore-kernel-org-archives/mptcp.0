Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19541C72
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551507; cv=none; b=iIwDIdadsX6QU+BFOL3FuGlqJTXlOJWJ7MNOauSjn6+WWoVOx5rOjawy2c/RCR9943F0GpKTLiiVq7tL2PAK5iuzX2ItYmELZ8seT3LwHsrwnhCuQCSvJscwuwO6VZnhRlUiFEpgaEgumiWetn17hZ6ht8g8kat3WIZfNhZC1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551507; c=relaxed/simple;
	bh=UtS+qCiuw+9gIkMgLsIePD/q6mjs1F2KS03nF2j1ytg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mw2HpADWBXM7ukI7k0MNushIPz2HDtjn01yvLziR5xi++bFehwS5AQLjVop2x0NPg3xNcCrUV3YZVpDHpzyLBoMqEN6U9hT4l89hKodGZgH/3cVaddN+uT82BjwJuoQXyndIa4dyj6EV4xs8ija9myChIVU+qHhGZVk0uyVeaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBN46QZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBN46QZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A125C4CEE3;
	Fri, 21 Mar 2025 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742551506;
	bh=UtS+qCiuw+9gIkMgLsIePD/q6mjs1F2KS03nF2j1ytg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EBN46QZmlGs3PZelbhqg3uRQveaP8vu1ZvZCl75Qghbss3tcW856LjzxUw9yk2KBk
	 +dfKWo43G+cm0owYNOzwMYSvXqjDcf1AE00m2OuGCOvHfLxii1phR3Ru5kD0jgZrdV
	 T3lw+iPLx15r3TtCxRvZg9NtK8tqRHtpsb1oL9NuQX+Ud1mnYUQjgFCJ8MNZ3U5xWg
	 rPvKuH99nxKQxxTqCRhywPxaojeG1IFQtj4i1dA4uYnoIzZ2FFa5qLQR7zUymFNT01
	 4u+O/xHfs6TFswW1waxNEFiiDlqDRAoYT+EyT3MoRrd/LRexHDMuQ3yaLbSjx/WUzM
	 ERmXjOf8xf1gQ==
Message-ID: <45ade20cc4eadcb81fa022aabac69f25d32fc16f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for
 mptcp_sock
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Fri, 21 Mar 2025 18:05:02 +0800
In-Reply-To: <fac4638e-9e00-4762-99d9-90826187fcf6@kernel.org>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
	 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
	 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
	 <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
	 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
	 <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
	 <05be0df71bcac1bf0f24a7637ba1652aebb8a312.camel@kernel.org>
	 <bf2ad4ed-bf4a-47c7-a7d5-eb23c0825198@kernel.org>
	 <e26c30144a91e8452ae2bf6dc1c0cea91becdf58.camel@kernel.org>
	 <fac4638e-9e00-4762-99d9-90826187fcf6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Fri, 2025-03-21 at 10:19 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 21/03/2025 05:14, Geliang Tang wrote:
> > On Tue, 2025-03-18 at 12:26 +0100, Matthieu Baerts wrote:
> 
> (...)
> 
> > > Mmh, all 8 callbacks from add_addr to here seem to be linked to
> > > Netlink
> > > commands, right? If yes, they should not be here: they don't make
> > > sense
> > > for a BPF PM, no? BPF PMs should be configured with BPF, and not
> > > via
> > 
> > Do you have any idea how we can pass commands like ADD_ADDR and
> > addresses from user space to BPF?
> 
> The userspace can inject any kind of BPF program. Additional
> addresses
> can then be hardcoded in this program, or it can load them from eBPF
> maps, or read skel->bss->(...), etc.
> 
> Netlink is then not needed.
> 
> > What I can think of is passing through sockopt, the user space
> > passes
> > the command and the address through setsockopt, and the BPF program
> > handles it through the custom "cgroup/setsockopt". I would like to
> > hear
> > your opinions. If you also agree to use sockopt to implement it, I
> > can
> > write a test program for this.

I just tested it and found it difficult to use setsockopt.

"cgroup/setsockopt" program doesn't work. We need to invoke sleepable
kfuncs in BPF PM:

BTF_ID_FLAGS(func, mptcp_pm_remove_addr_entry, KF_SLEEPABLE)
BTF_ID_FLAGS(func, mptcp_pm_addr_send_ack, KF_SLEEPABLE)
BTF_ID_FLAGS(func, mptcp_pm_mp_prio_send_ack, KF_SLEEPABLE)
BTF_ID_FLAGS(func, bpf_mptcp_subflow_connect, KF_SLEEPABLE)
BTF_ID_FLAGS(func, mptcp_subflow_shutdown, KF_SLEEPABLE)
BTF_ID_FLAGS(func, mptcp_close_ssk, KF_SLEEPABLE)

They can't be invoked in "cgroup/setsockopt" program. And
"cgroup/setsockopt" program can't be set with BPF_F_SLEEPABLE flag:

        err = err ?: bpf_program__set_flags(skel->progs.pm_setsockopt,
                                            BPF_F_SLEEPABLE);

With this error occurs:

test_bpf_hashmap_pm:PASS:set sleepable flags 0 nsec
libbpf: prog 'pm_setsockopt': BPF program load failed: -EINVAL
libbpf: prog 'pm_setsockopt': -- BEGIN PROG LOAD LOG --
Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs
can be sleepable
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

It seems that we can only choose one of fentry/fexit/fmod_ret, lsm,
iter, uprobe, or struct_ops type to implement BPF PM.

Thanks,
-Geliang

> That's a good idea for userspace apps which want to control how the
> MPTCP PM is acting. I guess MPTCP BPF PM will generally not be linked
> to
> network apps: a separate application dedicated to inject and
> configure
> the BPF PM, no?
> 
> Cheers,
> Matt

