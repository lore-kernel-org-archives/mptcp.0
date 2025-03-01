Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168B257D
	for <mptcp@lists.linux.dev>; Sat,  1 Mar 2025 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788364; cv=none; b=HVRFEpMBT2GcbJe4qcPGV+jwgfPuhmJk3aZemhLEfNjPS7E99Zl50Zh7LhiCMT51eYRVqrSta1z53y8j42Ileasstye9shP3t+LSdjwKGBrxXW0gcS++1mjIiV4LIaRZdxsyKgYrvtNsNAo+xpAeK2Y/DMF3O2tB69Wm+COK5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788364; c=relaxed/simple;
	bh=aPlA0aSXgOXtFaLbsA840r0zdZaT9DbF0xgmFP+9flY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=az6OPaMXZ8trjtMcfK0RT/tAtAJhZMVU3hkkdrh7ZLFuc7hSYbIngGvCF1HFmASOH1ni4i0usuxo0835jke/r2idKYVw0Ku18XaRVl68HJfTtd4nng1GCrOzKtrJjMGZVpUY6L3aF5Rnppndvu7LR1y4a07TnAGBWVii/3BwcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjoEknV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjoEknV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93525C4CED6;
	Sat,  1 Mar 2025 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788364;
	bh=aPlA0aSXgOXtFaLbsA840r0zdZaT9DbF0xgmFP+9flY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=NjoEknV+muySl+cWavZvWNUFGZ4/0XZqLrW6fiZ2fnxExfQcwb9wCEqTLGxUqgob1
	 Q5X/kuYyTD0MaB/pRqo6f2n2I9hY5uejs9C8KQ3shCU7DFMYKPYFbQQ4/Ok33EwW5X
	 s8GDANemTVWWyDF/hyO/tpneaKysssApnDeLULZ7KHXQ3+g4xlYKgzUBAoUjHpiahD
	 3VIa/feQW4om4uyMj5WvVR1VpZFVAAQMVrLaUVvCkDq31rAvyHFsN/cWT3vP2TNwKq
	 mdXggERcrAmW7WXR/eMLCh2apYzihfxEL7Fpk0Nk/lAb8fcgf7Ji4NsGwN9uEUDz43
	 QhgnM1hVXIDjQ==
Message-ID: <1b900c7fc0fcaca5ebc0de615cfc45b2cc9ca222.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 01 Mar 2025 08:19:21 +0800
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-02-28 at 14:31 +0100, Matthieu Baerts (NGI0) wrote:
> I have been thinking about that during the past couple of months, but
> now, with the recent modifications done by Geliang, and the
> associated
> reviews, I really think it is time to reorganise the code around the
> path-managers to avoid confusions, and a mix of code used in
> different
> conditions.
> 
> I hope this will not cause too many issues with the in-progress
> patches.
> I tried only to move the code around, and minimise the functions
> renaming. Then, to switch to the new code, it might be easier to
> simply
> copy your modified code from the old place to the new one. In other
> words, duplicate the net/mptcp directory, then do a rebase, resolve
> the
> conflicts with 'git restore --ours', then reapply the modifications
> by
> copying your old code to the new place. If it is too difficult,
> please
> let me know.
> 
> Before this series, the PM code was dispersed in different places:
> 
> - pm.c had common code for all PMs
> 
> - pm_netlink.c was supposed to be about the in-kernel PM, but also
> had
>   exported common helpers, callbacks used by the different PMs, NL
>   events for PM userspace daemon, etc. quite confusing.
> 
> - pm_userspace.c had userspace PM only code, but using specific
>   in-kernel PM helpers
> 
> To clarify the code, a reorganisation is suggested here, only by
> moving
> code around, and small helper renaming to avoid confusions:
> 
> - pm_netlink.c now only contains common PM Netlink code:
>   - PM events: this code was already there
>   - shared helpers around Netlink code that were already there as
> well
>   - shared Netlink commands code from pm.c
> 
> - pm_kernel.c now contains only code that is specific to the in-
> kernel
>   PM. Now all functions are either called from:
>   - pm.c: events coming from the core, when this PM is being used
>   - pm_netlink.c: for shared Netlink commands
>   - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
>   - sockopt.c: for the exported counters per netns
> 
> - pm.c got many code from pm_netlink.c:
>   - helpers used from both PMs and not linked to Netlink
>   - callbacks used by different PMs, e.g. ADD_ADDR management
>   - some helpers have been renamed to remove the '_nl' prefix, and
> they
>     have been marked as 'static'.
> 
> - protocol.h has been updated accordingly:
>   - some helpers no longer need to be exported
>   - new ones needed to be exported: they have been prefixed if
> needed.
> 
> The code around the PM is now less confusing, which should help for
> the
> maintenance in the long term.
> 
> This will certainly impact future backports, but because other
> cleanups
> have already done recently, and more are coming to ease the addition
> of
> a new path-manager controlled with BPF (struct_ops), doing that now
> seems to be a good time. Also, many issues around the PM have been
> fixed
> a few months ago while increasing the code coverage in the selftests,
> so
> such big reorganisation can be done with more confidence now.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Addressing Geliang's comments
> - The renaming of common helpers have been done in dedicated patches
> - Some helpers have been kept where they were in pm.c, except one now
> in
>   a dedicated patch.
> - The last patch has been split in smaller chunks, only moving code
> from
>   one file to another to help with the reviews.

Thanks for this v2, I have some comments for it:

Patches 1, 2, 5 can be merged into one.
Patch 3 can be merged into patch 9.
Patch 4, change mptcp_pm_rm_addr_recv() as non-static here, instead of
changing it in patch 9. How about renaming it as
__mptcp_pm_nl_rm_addr_received?
Patch 7, how about renaming mptcp_pm_nl_set_flags_all as
__mptcp_pm_nl_set_flags too?
Patch 11, how about dropping this patch, keep
mptcp_pm_addr_families_match() unmoved, but add a new section like "/*
generic PM helpers */" to import the helpers there?
Patch 12
 - in mptcp_remove_anno_list_by_saddr() behavioural is changed, a
separate patch is needed.
 - mptcp_lookup_subflow_by_saddr should be after mptcp_remote_address
 - mptcp_pm_sport_in_anno_list should be after
mptcp_lookup_anno_list_by_saddr and befor mptcp_pm_add_timer.
 - split "move all struct mptcp_pm_add_entry related code into pm.c"
from patch 12 as a separate one.
 - split "move all send_ack related code into pm.c" from patch 12 as a
separate one.
 - make mptcp_pm_is_init_remote_addr() static shoud be merged into
patch 6.
Split "move all pm_nl_pernet related code into pm_kernel.c" from patch
13 as a separate one.
Can the action of deleting three headers in patch 14 be advanced to the
previous patch?

Thanks,
-Geliang

> - Link to v1:
> https://lore.kernel.org/r/20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (14):
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_work
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
>       mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
>       mptcp: pm: avoid calling PM specific code from core
>       mptcp: pm: worker: split in-kernel and common tasks
>       mptcp: pm: export mptcp_remote_address
>       mptcp: pm: move generic helper at the top
>       mptcp: pm: move generic PM helpers to pm.c
>       mptcp: pm: split in-kernel PM specific code
>       mptcp: pm: move Netlink PM helpers to pm_netlink.c
> 
>  net/mptcp/Makefile       |    2 +-
>  net/mptcp/pm.c           |  644 +++++++++++----
>  net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
>  net/mptcp/pm_netlink.c   | 1934 ++----------------------------------
> ----------
>  net/mptcp/pm_userspace.c |   11 +-
>  net/mptcp/protocol.c     |    5 +-
>  net/mptcp/protocol.h     |   36 +-
>  7 files changed, 2029 insertions(+), 2013 deletions(-)
> ---
> base-commit: 6b32949274eb9e32fe867ba9a8f8cb98587ecf36
> change-id: 20250227-mptcp-pm-reorg-code-13227530bd05
> 
> Best regards,

