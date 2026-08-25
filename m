Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD243E072
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676561; cv=none; b=Fv4m6UxkCZDJcO9Dl95r78AAgXKjBB/zEx2bgqNru5Wlb8JyC2AYqEoFOtqLgjiAopa2g/jr5vRpuAMnMnr1b1xEB0r1YfF9vJ6DKSeoDsy4IVQcZRZ/VNowSMJ3gnp5aae++MyGYCbN0hooE5wSPhBFrvd1t4DV+bVpgWq9Wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676561; c=relaxed/simple;
	bh=ccG570NFUHVXxcbZScMhECeILHrFYI7UJQhM71AVrxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kaIXL6gJ+IvyDvrgpmA2px9qHqf5nNQCKcLFk4aD+ZRD1tTLN7dO74n8hSij2fgPSJXsfcpEKAPB3XsgIrdi3G3ebXGzOflybtUjgatG1pWezlxi8xfAJ3Kht9KFLpDqw1Qq/ZnOq+mV/giqqBzDyvlVwvQoLrH8Xq79olnTJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnXBC91S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnXBC91S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6240E1F00A3D;
	Tue, 25 Aug 2026 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787676559;
	bh=U9Fwi41gI+Yf4KDvyUzmN2//p3Bg6QCXvW8ZaczwQNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnXBC91S7dRoR7QWyA3Bn9+Gkxhh0nFGLxcA4Cn4MJies+yLGteZU+JrC1xuE5AdT
	 dIqqQ5+PSbGpsO8LPKLcJPsfMK0nWlk0jlvtSYWER80Pe/2xZefX5OiOTAQ3dCiAzV
	 8EAHzW67LnMhULzVlA+bNVn6AxpXwgpeBo1fz14Lt/dTmKGwsqk0UmXaecZzHiHmfZ
	 wG/SrJBaJYMkyvBaNXABHSG3SSKv7FGrDIsKmdbyF5j36C/Sx43PSZYu6o69kfmfio
	 eVNfKoCXNK648jD8v8ytjwvVf2l87mz6oeNUE9MM70ybI9aKasXK+5in+9nljuo6wY
	 0fVzgqq0FUzGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 04/14] mptcp: pm: kernel: drop pending ADD_ADDR when
 removing ID0
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-4-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
 <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-4-a92309d121ca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 16:49:18 +0000
Message-Id: <20260825164919.6240E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Hardcoded `anno_addr.port =3D 0` fails to cancel the pending `ADD_=
ADDR` if the ID 0 endpoint was configured with a specific port.

Pre-existing issues:
- [High] Canceling an `ADD_ADDR` fails to clear `MPTCP_ADD_ADDR_SIGNAL`, si=
lently dropping `RM_ADDR` and erroneously transmitting a canceled `ADD_ADDR=
`.
- [High] Calling `sk_stop_timer_sync()` while holding `rcu_read_lock()` tri=
ggers a sleep-in-atomic bug on PREEMPT_RT kernels.
--

--- Patch [4]: [PATCH net 04/14] mptcp: pm: kernel: drop pending ADD_ADDR w=
hen removing ID0 ---
commit 8ec4a41a6bf3f96bdf00a1088430d4fcabb37f97
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint. This happens because the id 0
removal path does not tear down pending announcements, unlike the non-zero
id path.

Cc: stable@vger.kernel.org
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 424f1a7f92482..1a77508132354 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct =
net *net,
>  			goto next;
> =20
>  		lock_sock(sk);
> +		/* Drop a possibly pending ADD_ADDR for this address. */
> +		anno_addr =3D msk_local;
> +		anno_addr.port =3D 0;

[Severity: High]
Does hardcoding the port to 0 here prevent mptcp_pm_announced_remove() from
finding the pending announcement if the ID 0 endpoint was configured with a
specific port?

If a signal endpoint matches the initial subflow's IP but has a non-zero
port, the PM maps it to ID 0 and stores it in anno_list with the non-zero
port. Because mptcp_pm_announced_remove() enforces strict port matching,
it seems it would fail to find the announcement, leaving a stale ADD_ADDR
timer that could trigger a WARN_ON_ONCE.

> +		announced =3D mptcp_pm_announced_remove(msk, &anno_addr);

[Severity: High]
This is a pre-existing issue, but does calling mptcp_pm_announced_remove()
trigger a sleep-in-atomic bug on PREEMPT_RT kernels?

In net/mptcp/pm.c:mptcp_pm_announced_del_timer(), which is called by
mptcp_pm_announced_remove(), there is a call to sk_stop_timer_sync()
inside an RCU read-side critical section:

mptcp_pm_announced_del_timer()
    rcu_read_lock();
    ...
    sk_stop_timer_sync(sk, &entry->timer);

On PREEMPT_RT, timer_delete_sync() can sleep, which is not allowed inside
an RCU critical section.

>  		spin_lock_bh(&msk->pm.lock);
> +		if (announced)
> +			msk->pm.add_addr_signaled--;
>  		mptcp_pm_remove_addr(msk, &list);

[Severity: High]
This is also a pre-existing issue, but does canceling an ADD_ADDR fail to
clear the signal bit, causing the RM_ADDR to be dropped here?

When mptcp_pm_announced_del_timer() deletes the timer and removes the entry,
it does not clear the corresponding BIT(MPTCP_ADD_ADDR_SIGNAL) in
msk->pm.addr_signal.=20

Then, when mptcp_pm_remove_addr() is called, it checks if rm_addr is
non-zero (which it is, because the signal bit is still set):

mptcp_pm_remove_addr()
    if (rm_addr) {
        MPTCP_ADD_STATS(...);
        return -EINVAL;
    }

Would this cause the RM_ADDR request to be silently dropped, while
erroneously transmitting the canceled ADD_ADDR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-net-mptcp-=
misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org?part=3D4
