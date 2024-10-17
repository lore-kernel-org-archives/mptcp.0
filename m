Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05F12E7F
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128584; cv=none; b=feKVoBRutLBBnlaiTeGjeIxXxAOLFxAsKd6N/5Uv7GVOVEWfNCo5vgP0MWAx7s1dgKxTyJxjYdwOg6W1VfKZun+Dlb44JFY5lRpWyRyRaAX8NixmYfFiqqZCs8Zine1tfZHtlxfjW9+MsBxfiXivAsil9p7OEXjbPeRYTvTdfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128584; c=relaxed/simple;
	bh=TtlNlGS0iyXQ2NOnnSVCwLPb/cwTo1cvzX8/zA+aMFI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wxj60Ny9iI4fCQVGb3CZaIgqzQCJfS424492P0G0IgSv1JsuQP0or0hSIaCHFOKF3Et4GoTb6hrPF/G/MxlzXXOaJGt29RS3Jp6orNwH1XczENW1cxZG0kdOD3VOskZ6J7/Nv6xznh5p8Ckf2bfWFrLo9HhI9Wm6/vlTgqQHVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2ATCb3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2ATCb3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FD9C4CEC5;
	Thu, 17 Oct 2024 01:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729128583;
	bh=TtlNlGS0iyXQ2NOnnSVCwLPb/cwTo1cvzX8/zA+aMFI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=r2ATCb3bbmfU4azTYlngxqcpHelWwlFqZM+x+drBbqvheV5IurnijGtW/W/r+g/ZM
	 pYro3EnrFK9awAKr6V8Ud3F5os2r/q73l40g1dhfa2bEEIrpPliHWxRdHTDS0iUvUM
	 qNOQOxBOaiBoeXHqlSdCEKvURqAI0mGtEYgzYh5uy5J8XN87oYNWGc674aFLPyl6EE
	 aJIKy1hfwjXzCihP/oziXPtrdcAE3VwOJoIjyqq+EX0AdTKbzz/AEXtRwa4R87BOiP
	 va8VMXj6bOHJnLQUd1Zaw13k9k2XzsqETSngcWLl51Z46aHUkkUnKA+pRoIfs5Gcke
	 5j2Bg0SjTKGbQ==
Message-ID: <3aa7ba9211ce89a31eb61def9a0c51ce2cdb1c5d.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/2] Squash to "bpf: Add bpf_mptcp_sched_ops"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 17 Oct 2024 09:29:37 +0800
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-2-5e9af4fbce11@kernel.org>
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
	 <20241016-mptcp-sched-find-rcu-v1-2-5e9af4fbce11@kernel.org>
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
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-10-16 at 21:05 +0200, Matthieu Baerts (NGI0) wrote:
> Similar to the previous commit, this splat can be seen:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.12.0-rc2+ #1 Tainted: G           OE
>   -----------------------------
>   net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   1 lock held by test_progs/323:
>   ffff888007e16a40 (&st_map->lock){+.+.}-{3:3}, at:
> bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:632)
> 
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 323 Comm: test_progs Tainted: G          
> OE      6.12.0-rc2+ #1
>   Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>   Call Trace:
>    <TASK>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>    mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
>    bpf_mptcp_sched_init_member (net/mptcp/bpf.c:128
> net/mptcp/bpf.c:109)
>    ? btf_type_resolve_ptr (include/linux/btf.h:252
> kernel/bpf/btf.c:637)
>    bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:658)
>    ? __might_fault (mm/memory.c:6700 (discriminator 5)
> mm/memory.c:6693 (discriminator 5))
>    ? __pfx_bpf_struct_ops_map_update_elem
> (kernel/bpf/bpf_struct_ops.c:591)
>    ? __pfx___might_resched (kernel/sched/core.c:8593)
>    ? kasan_save_track (arch/x86/include/asm/current.h:49
> (discriminator 1) mm/kasan/common.c:60 (discriminator 1)
> mm/kasan/common.c:69 (discriminator 1))
>    bpf_map_update_value (kernel/bpf/syscall.c:169)
>    map_update_elem (kernel/bpf/syscall.c:1627)
>    ? __pfx_map_update_elem (kernel/bpf/syscall.c:1586)
>    __sys_bpf (kernel/bpf/syscall.c:5622)
>    ? __pfx___sys_bpf (kernel/bpf/syscall.c:5596)
>    __x64_sys_bpf (kernel/bpf/syscall.c:5739)
>    ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347
> kernel/locking/lockdep.c:4406)
>    do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1)
> arch/x86/entry/common.c:83 (discriminator 1))
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Also similar to the previous commit, this can be fixed by adding the
> missing rcu_read_lock().
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/bpf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index
> 6414824402e6449ba01efb9093b2293232a67915..a9d6b5b939a2631f17a468ee6ba
> 4867dc33dda63 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -113,6 +113,7 @@ static int bpf_mptcp_sched_init_member(const
> struct btf_type *t,
>  	const struct mptcp_sched_ops *usched;
>  	struct mptcp_sched_ops *sched;
>  	u32 moff;
> +	int ret;
>  
>  	usched = (const struct mptcp_sched_ops *)udata;
>  	sched = (struct mptcp_sched_ops *)kdata;
> @@ -123,9 +124,12 @@ static int bpf_mptcp_sched_init_member(const
> struct btf_type *t,
>  		if (bpf_obj_name_cpy(sched->name, usched->name,
>  				     sizeof(sched->name)) <= 0)
>  			return -EINVAL;
> -		if (mptcp_sched_find(usched->name))
> -			return -EEXIST;

This part of mptcp_sched_find() code comes from bpf_tcp_ca_init_member,
but it was recently deleted by commit 68b04864ca42 ("bpf: Create links
for BPF struct_ops maps.").

--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct
btf_type *t,
                if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
                                     sizeof(tcp_ca->name)) <= 0)
                        return -EINVAL;
-               if (tcp_ca_find(utcp_ca->name))
-                       return -EEXIST;
                return 1;
        }

So we should also delete this part directly instead of adding
rcu_read_lock.

.validate interface is added in bpf_struct_ops by commit 68b04864ca42,
I'll implement it in both mptcp_sched_ops and mptcp_pm_ops too.

Thanks,
-Geliang

> -		return 1;
> +
> +		rcu_read_lock();
> +		ret = mptcp_sched_find(usched->name) ? -EEXIST : 1;
> +		rcu_read_unlock();
> +
> +		return ret;
>  	}
>  
>  	return 0;
> 

