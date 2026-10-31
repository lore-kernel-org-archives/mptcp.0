Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446233;
	b=ikWNgLMIsHIN+nfhOnKH8ugMpoLw8BEDhkazB1j4hGPOiuNrOwnrO1siqxYSzAKb6DNk
	 +1HcFcvuHdmLUGo0mHSpPZ7l5JXzX1vivu8+41czBKWGL3n7VjQv6sk2nCyILbJPCB3Rx
	 +Uu4ACOm1bh3w/ZdONJ2fZtWQq7qT38u8Vvy1Gr/WIHx+3b4xIg0I6Zff5fUJEm1mBlYo
	 Q8iQT6i5xEjcsShfXjx8W4Rsu9rP1gUVuq2heD+zA4Ym4tixB94mjQu7r+cTO/3MD8LoQ
	 FjZqzcMPyf+i9ukkvI3SkTTlFHvv7TGoklPWOhnY5YoCCTWUuMZEu4FF0n+HWvPByeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446233;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P3no9wCO56ewSWdNb1TD1GksMzkMxCzdt1G3Ha/IcFM=;
	b=KiZIEn6lkRPcsrReg573JXInHstt1jVeBHC2fGHAW8OuCv8M1uloXCX5/8BecnjauBjW
	 t523cCCb5+SuNWDl/eBPZDg62T4gtKasynOZcKrT5TKkm7O9a3fckl2V/PMny+jTp3+G7
	 t1bB0BUdOExQFWg48gymz2veHBf3UCHXk+uQjnhVQ2OKSoS0TAX24vxYclNEDYqXs5Vtp
	 5bMuiFVPw4LgaDB6yrJnLdH5fqfT1Mx1Nsm5zHQ09sICZb8hoQ1O8/bUQGE6t9+IjqEK7
	 +cSMpLTiwMin0w8GBlFJ6nndmx/8roQHgWaOv22PiF+ZE/r7H7odQImBi6vH4RZFwhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pkq6/CBt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8E606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pkq6/CBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6714D1F0093A;
	Sat, 31 Oct 2026 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446232;
	bh=P3no9wCO56ewSWdNb1TD1GksMzkMxCzdt1G3Ha/IcFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pkq6/CBtBsaRlaxfz8BPp5NE7oRlJuds4DaHUm1g7XG3qL3JaIs59JXVWuYoRQ2lw
	 CFi97c3H5O5Tg/D5O74Ov9xr6gyOWBoqQoLPAeeIc4tncHuMbayk5iirLnlvcaaIsn
	 Qj9K/pf9cZ/ikEe9GGz5KvOEo4kaumjDGc86m7nBwaZHffZUNlsBHqP2ztVyB2ewEC
	 oTfGt02TAtb1bOoWbLXE7UF+OhgHxdyJTvuatY9Obfb2mSdJt9DJH4cDDRsnm+yHRc
	 64ij+4cbMuV0bA8nEXdDXumalxfc/AVgHLz69AynpyKe0VP2xepMJUQw8mYCPiBUQO
	 anFkNP1hwt8tQ==
Subject: Re: [PATCH mptcp-net v4 8/8] mptcp: pm: restrict in-kernel worker
 actions to this PM
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:32 +0000
Message-ID: <179344623200.3128.14617930354055063041@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-8-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-8-555066fa4292@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit has a `Fixes:` tag (a49eb8ae95b8, "mptcp: pm: worker:
  split in-kernel and common tasks") but fixes no reachable bug.
- [Low] The new check in `mptcp_pm_worker()` (net/mptcp/pm.c:1158) uses
  `msk->pm.pm_type` to decide whether the kernel-only status bits get…

--

mptcp: pm: restrict in-kernel worker actions to this PM

This commit gates the call to __mptcp_pm_kernel_worker() in
mptcp_pm_worker() so it only runs when the socket is not using the
userspace PM.

> Fixes: a49eb8ae95b8 ("mptcp: pm: worker: split in-kernel and common tasks")

[Severity: Low]
Is this Fixes: tag needed? When pm_type and pm.ops both point to the
userspace PM, __mptcp_pm_kernel_worker() seems to do nothing already,
because none of the three bits it handles can be set.

MPTCP_PM_ADD_ADDR_RECEIVED is only scheduled from the in-kernel branch of
mptcp_pm_add_addr_received(). The userspace branch calls
mptcp_pm_announce_addr() and mptcp_pm_add_addr_send_ack() instead.

MPTCP_PM_ESTABLISHED and MPTCP_PM_SUBFLOW_ESTABLISHED are only scheduled
when pm->work_pending is true. mptcp_pm_data_reset() zeroes work_pending
via the reset struct_group, and only mptcp_pm_kernel_init() sets it to
true. mptcp_pm_subflow_check_next() also returns early for the userspace
PM.

Also, a49eb8ae95b8 only moved code around. The old mptcp_pm_worker() in
pm_netlink.c already tested these bits for every PM type.

The commit message says:

    No need to check them for the userspace PM.

That reads like a cleanup. Could the tag be dropped and the patch sent to
net-next instead? If there is a real failure behind it, could the commit
message describe it?

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e9a538296200a..e38fe835abc0b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1154,7 +1154,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
>  		mptcp_pm_rm_addr_recv(msk);
>  	}
> -	__mptcp_pm_kernel_worker(msk);
> +
> +	if (!mptcp_pm_is_userspace(msk))
> +		__mptcp_pm_kernel_worker(msk);

[Severity: Low]
This check uses msk->pm.pm_type. The code that sets MPTCP_PM_ESTABLISHED
and MPTCP_PM_SUBFLOW_ESTABLISHED uses pm->work_pending instead, and that
flag follows msk->pm.ops. Can these two disagree?

mptcp_pm_data_reset() reads pm_type and the path_manager string
separately, without a lock:

net/mptcp/pm.c:mptcp_pm_data_reset() {
	const char *pm_name = mptcp_get_path_manager(net);
	u8 pm_type = mptcp_get_pm_type(net);
    ...
	WRITE_ONCE(pm->pm_type, pm_type);

	rcu_read_lock();
	mptcp_pm_ops_init(msk, pm_name);
    ...
}

The string is only read later, in mptcp_pm_ops_init()->mptcp_pm_find().
The sysctl handlers in net/mptcp/ctrl.c also update the two pernet fields
with separate stores. proc_pm_type() stores pm_type through
proc_dou8vec_minmax() and then calls mptcp_set_path_manager().
proc_path_manager() does the same in the opposite order.

Suppose a write of net.mptcp.pm_type=1 lands between those two reads. The
socket then ends up with pm_type == MPTCP_PM_TYPE_USERSPACE and ops ==
&mptcp_pm_kernel. mptcp_pm_kernel_init() sets work_pending without
checking pm_type, even though its comment says:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_init() {
	/* pm->work_pending must be only be set to 'true' when
	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
	 */
	WRITE_ONCE(pm->work_pending,
    ...
}

mptcp_pm_fully_established(), mptcp_pm_subflow_established() and
mptcp_pm_add_addr_echoed() can then schedule MPTCP_PM_ESTABLISHED or
MPTCP_PM_SUBFLOW_ESTABLISHED.

Before this patch, mptcp_pm_worker() always cleared and handled those
bits. With the new check, won't they stay set for the rest of the
connection?

If so, mptcp_pm_schedule_work() would return false for them from then on,
and the kernel PM would never act on that socket. Every later
mptcp_pm_worker() call would also pass the MPTCP_PM_WORK_MASK test and
take pm.lock for nothing.

The pm_type/ops mismatch itself is older than this patch. Would checking
msk->pm.ops == &mptcp_pm_kernel here, or setting pm_type from the ops
that actually get selected, keep both sides consistent?

>  
>  	spin_unlock_bh(&msk->pm.lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
