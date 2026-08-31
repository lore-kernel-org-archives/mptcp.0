Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECC3C13E9
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166241; cv=none; b=fa6R3ftg/EuMbkV4OCci3vMV431kWayIgNppsuyYKLoqMHAYd/I0LoPAgz1DHLZeiDHFEzf7+O3FWyfW0Uh+E479Z4LyGoWsVdffpyZ2c3DhODBaNJ0DJZlKfQEXwJP5LssfXAhXIo0r+q630fs7e3LslmaBgoeaLtYbS5VAM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166241; c=relaxed/simple;
	bh=CIibuvva4Y/7QFctWJHPzV5bNm+RC59NX4ZlfScHueM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+J01FAZvdDQ7BwvLd7TLKeYVaoKJXoJNgRYS9IFwLE9B7sLwsXcg8WzPzUj8VqkCTtL6yV7QFQFqRD32ctPtj99aTK0TC/0Tx6QBNZ+HP0kGHw6wdhHiJNZd/oOq1iJtilg9GkUIqQrFbbPQ1BuTWBT6zyKinJm8PDMtdN7t2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTcyQOV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTcyQOV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A6B1F000E9;
	Mon, 31 Aug 2026 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788166240;
	bh=s4It3d5yDmKJDUyHPjJ3Xd41d+wB5HidKpMdCoWhXiM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HTcyQOV/ZG395Pldy6xYGeGMX9gF283pImylV1G/D4GbsZVfM3aaDwrN0ELMFqiq3
	 5ki9sQjDiVe5Kstewj/bKKCAzUpYX56/vaNxjdpj4bqD0MIyIMQXa/RwGo5QtQBiGC
	 uKKoUY/6WJtxyNqMkVmY85583W/jp7SiIbZVQ5smhuDGAwKY/d32GCLKXlsOpf1wDK
	 RA2mr/8ZmYLe3Dj7FRxMI9tofmgjT2ZUND4xYt+F/kJV8DjWvcG0+AcvE1gIDzSnPy
	 +OxTCyd+eS3S4OSPGV7/yFG4BPRSaRNKU6mhYW+1xpbZXa3O4F1Re6Ii6f7XkrNQE+
	 ltWFhs4cp2TkA==
Message-ID: <69010109b91ce875a5e037e03faa26ad574e2443.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v11 00/10] Reduce the differences between TCP
 and MPTCP for TLS usage
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 31 Aug 2026 16:50:31 +0800
In-Reply-To: <fa191475-a2bf-db16-2281-9b7ceed624a8@gmail.com>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
	 <fa191475-a2bf-db16-2281-9b7ceed624a8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2026-08-30 at 15:33 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1
> failed test(s): packetdrill_dss ⚠️ 
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Notice: Call
> Traces at boot time, rebooted and continued ⚠️ 
> - KVM Validation: debug (only selftest_mptcp_join): Notice: Call
> Traces at boot time, rebooted and continued ⚠️ 
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces
> at boot time, rebooted and continued - Notice: Call Traces at
> shutdown time, ignored and continued ⚠️ 
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/33317921888

The latest code triggers a crash when running virtme:

BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:322

[    4.595485][    T1] virtme-ng-init: mount devtmpfs -> /dev: EBUSY:
Device or resource busy
Waiting for the virtme-ng-init to finish
[    4.598085][    T1] virtme-ng-init: Setting hostname to mptcpdev...
[    4.630121][    T1] virtme-ng-init: running systemd-tmpfiles
[    5.434499][   T70] systemd-tmpfile (70) used greatest stack depth:
24904 bytes left
[    5.434526][   T70] BUG: sleeping function called from invalid
context at include/linux/sched/mm.h:322
[    5.434529][   T70] in_atomic(): 1, irqs_disabled(): 1, non_block:
0, pid: 70, name: systemd-tmpfile
[    5.434532][   T70] preempt_count: 2, expected: 0
[    5.434534][   T70] RCU nest depth: 0, expected: 0
[    5.434536][   T70] locks held by systemd-tmpfile/70: 5, last CPU#1:
[    5.434539][   T70]  #0: ffffffff84a3d078 (low_water_lock){+.+.}-
{3:3}, at: do_exit (include/linux/spinlock.h:347)
[    5.434558][   T70]  #1: ffffffff84badda0 (console_lock){+.+.}-
{0:0}, at: vprintk_emit (kernel/printk/printk.c:2478)
[    5.434569][   T70]  #2: ffffffff84bade18 (console_srcu){....}-
{0:0}, at: console_flush_one_record (include/linux/rcupdate.h:314
(discriminator 1))
[    5.434578][   T70]  #3: ffffffff84acd740 (console_owner){....}-
{0:0}, at: console_lock_spinning_enable (kernel/printk/printk.c:1902
(discriminator 1))
[    5.434587][   T70]  #4: ffffffff84acd640 (printk_legacy_map-wait-
type-override){....}-{3:3}, at: console_emit_next_record
(kernel/printk/printk.c:3095 (discriminator 1))
[    5.434596][   T70] irq event stamp: 273968
[    5.434598][   T70] hardirqs last  enabled at (273967):
__down_trylock_console_sem (kernel/printk/printk.c:330 (discriminator
5))
[    5.434604][   T70] hardirqs last disabled at (273968):
console_emit_next_record (kernel/printk/printk.c:3176 (discriminator
7))
[    5.434609][   T70] softirqs last  enabled at (273890):
handle_softirqs (kernel/softirq.c:491)
[    5.434614][   T70] softirqs last disabled at (273865):
__irq_exit_rcu (kernel/softirq.c:679)
[    5.434619][   T70] Preemption disabled at:

I have already fixed this over the weekend and sent the patch to the
virtualization mailing list:

https://lore.kernel.org/virtualization/e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn/T/#u

Please consider applying this patch first to avoid CI failures.

Thanks,
-Geliang

> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/3e4dc4f936bd
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1153916
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
