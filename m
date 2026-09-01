Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBD2E1EFC
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222031; cv=none; b=eBcvriDDnnNzfqwsbV0ldBB11LZSNPPBcdfs5/sDwPpGdM5MfEorswvO2nAxhG3PsDjwOmOD51jB1t9ZJjU9df6sbGZAo1sf8JjtLwBS9LJWlEF1REsRSfwq1WxosyW85xZB12Be4bAsDa0ON7oyJBN3crHWhY21SMHhiN5AKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222031; c=relaxed/simple;
	bh=IyCPJEfDuB1dWzo732Tp1QuxbD7/VpmlkCAJFu1Sn6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQT4lKw5n0x2QGgLZRvFrwf2PSW83m3y/cwRvLWsYe13bYN22fcEwCY/37Se9BO1VyHHCF7gbCALhK7q5TzpsN2wZVQFvy9q4EwMs+II1kcJQGSS7fce8JVUR78IGPngUBsNEioHw+bN/D0iwP5Vp3x5rcSl0cwQ8nVJ0TlBHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ckqRmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ckqRmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845491F000E9;
	Tue,  1 Sep 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222030;
	bh=Xax6oTeu3mgailVP9mqKzs++jD7qnsvG68JP6cG2oVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h2ckqRmLuFi3/qkRClAItuESubMIRkEqKeivbfspO9yD8NF9SXs+dPyF7JrwzQQ76
	 lemnMBwSnWiXS2arBDKlThcGTCZcGW06HzDlAblrZCdBpRVAOVToG4rgxj3I5JHuQx
	 nbwUwsm/QxNzYtcpyCaOT/wLBh2Fw85jP4sIztoGIv7JLKXaApAjou33R7E8VFJ7iX
	 0QfbaAJlVbYZv+zgY2ue5GkOgpkSj76gLEFdKLaCZIFqO+DoSBsDSknI/CY72KCaIa
	 xxuv2k50F/Ok72ZZ5B/MmyJuC47p1doa134my9BvSwcLOZHANIL7PhWNpsxrccfRHj
	 3ArEIQa4i6oPA==
Message-ID: <a6b33dd8-140f-4ae9-8d3a-7a5da5c9e34e@kernel.org>
Date: Tue, 1 Sep 2026 02:20:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v11 00/10] Reduce the differences between TCP
 and MPTCP for TLS usage
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
 <fa191475-a2bf-db16-2281-9b7ceed624a8@gmail.com>
 <69010109b91ce875a5e037e03faa26ad574e2443.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69010109b91ce875a5e037e03faa26ad574e2443.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 31/08/2026 10:50, Geliang Tang wrote:
> Hi Matt,
> 
> On Sun, 2026-08-30 at 15:33 +0000, MPTCP CI wrote:
>> Hi Geliang,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1
>> failed test(s): packetdrill_dss ⚠️ 
>> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
>> - KVM Validation: debug (except selftest_mptcp_join): Notice: Call
>> Traces at boot time, rebooted and continued ⚠️ 
>> - KVM Validation: debug (only selftest_mptcp_join): Notice: Call
>> Traces at boot time, rebooted and continued ⚠️ 
>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>> - KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces
>> at boot time, rebooted and continued - Notice: Call Traces at
>> shutdown time, ignored and continued ⚠️ 
>> - Task:
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/33317921888
> 
> The latest code triggers a crash when running virtme:
> 
> BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:322
> 
> [    4.595485][    T1] virtme-ng-init: mount devtmpfs -> /dev: EBUSY:
> Device or resource busy
> Waiting for the virtme-ng-init to finish
> [    4.598085][    T1] virtme-ng-init: Setting hostname to mptcpdev...
> [    4.630121][    T1] virtme-ng-init: running systemd-tmpfiles
> [    5.434499][   T70] systemd-tmpfile (70) used greatest stack depth:
> 24904 bytes left
> [    5.434526][   T70] BUG: sleeping function called from invalid
> context at include/linux/sched/mm.h:322
> [    5.434529][   T70] in_atomic(): 1, irqs_disabled(): 1, non_block:
> 0, pid: 70, name: systemd-tmpfile
> [    5.434532][   T70] preempt_count: 2, expected: 0
> [    5.434534][   T70] RCU nest depth: 0, expected: 0
> [    5.434536][   T70] locks held by systemd-tmpfile/70: 5, last CPU#1:
> [    5.434539][   T70]  #0: ffffffff84a3d078 (low_water_lock){+.+.}-
> {3:3}, at: do_exit (include/linux/spinlock.h:347)
> [    5.434558][   T70]  #1: ffffffff84badda0 (console_lock){+.+.}-
> {0:0}, at: vprintk_emit (kernel/printk/printk.c:2478)
> [    5.434569][   T70]  #2: ffffffff84bade18 (console_srcu){....}-
> {0:0}, at: console_flush_one_record (include/linux/rcupdate.h:314
> (discriminator 1))
> [    5.434578][   T70]  #3: ffffffff84acd740 (console_owner){....}-
> {0:0}, at: console_lock_spinning_enable (kernel/printk/printk.c:1902
> (discriminator 1))
> [    5.434587][   T70]  #4: ffffffff84acd640 (printk_legacy_map-wait-
> type-override){....}-{3:3}, at: console_emit_next_record
> (kernel/printk/printk.c:3095 (discriminator 1))
> [    5.434596][   T70] irq event stamp: 273968
> [    5.434598][   T70] hardirqs last  enabled at (273967):
> __down_trylock_console_sem (kernel/printk/printk.c:330 (discriminator
> 5))
> [    5.434604][   T70] hardirqs last disabled at (273968):
> console_emit_next_record (kernel/printk/printk.c:3176 (discriminator
> 7))
> [    5.434609][   T70] softirqs last  enabled at (273890):
> handle_softirqs (kernel/softirq.c:491)
> [    5.434614][   T70] softirqs last disabled at (273865):
> __irq_exit_rcu (kernel/softirq.c:679)
> [    5.434619][   T70] Preemption disabled at:
> 
> I have already fixed this over the weekend and sent the patch to the
> virtualization mailing list:
> 
> https://lore.kernel.org/virtualization/e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn/T/#u
> 
> Please consider applying this patch first to avoid CI failures.
Thank you for this message and for the fix. It looks like the same patch
has already been sent before on the virtualisation ML. I took the oldest
one because I guess that's the one which will be applied:

https://lore.kernel.org/20260810-serial-v1-1-abbe51602c13@debian.org

New patches for t/upstream-net and t/upstream:
- 37d601ecd030: virtio_console: allocate the port_buffer with the
caller's gfp
- Results: 55dc409a2258..f53fe5e25d9e (export-net)
- Results: b301d9e1afdc..edf6a01ba9f7 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/0c164b6dd50adfb4bb924b9030ab3e529a1b48cc/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/52ef5e042a881a7753cad4d5e3c3f5c15676da17/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

