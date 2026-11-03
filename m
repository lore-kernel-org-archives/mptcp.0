Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677476;
	b=C+Z1gzAE+mus+lXnSnwyZTYMbgcVIRC3UmAnmxyxo9IRQKDWGZ4T7XlJl8lIhcZ1L+zx
	 xuIHZOFX8yyu0P2GYxPacJ4sLCgru+AIz1O9wmYN813u6nE1nMjRi65g0lc0svkOrCVCu
	 3qagctkPj+mYPo/Lt+rjrioe7NVl44HMK9NrG5Y0QZqHdmFbm93+CalLLrsIMtEWiyllj
	 nroRS08QpNiXW77+jiST8f2uL/MVbbG8NcEAs0PuJS2RWBy5Ohs9BEzfkrMZpbTld21q/
	 c5217e8/XSBLX+uDwzKyGCuOpx1EIpOPas83g+oISPi78P6sV80/dTtxkl1CGtkdg4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677476;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iKeakN6DDHiDdyA5AttBwZ2kI2tYOtobNd8R6DiDfj8=;
	b=YE+8LUIQjIkBdH/5h1gUrCwhTeBYgphbczbR64A73h2AlyJ0aTEYfenmTKG+oSppDHKm
	 XCFTgQuQoRmCMOcFalj3R/pDtQEL7d0FLMqnUwxRXCV3h81wt3xUg5nuh5+nOGc6kBPwx
	 HI0QjjJRyZMKOjaPQSHgpTvL1xSM6X36JFL5yymPTdKHf6PO+7GgfgLllQLyl+DMJ3fL6
	 kSLIsnq1aS4/pnt0D3l5yqQYpa0Q9rwBFrOYDJ7W/Adg62SCU/NHcF0fhGZ2yOMCQOxoY
	 42CnyNqESG5PZ9ee4Y2l0gojFPSXchtatpk8cMk7mrBaoKBAX26H3awgdi8YfAR3apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI5VT6+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01E606A32F
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI5VT6+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D21F0093A;
	Tue,  3 Nov 2026 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793677475;
	bh=iKeakN6DDHiDdyA5AttBwZ2kI2tYOtobNd8R6DiDfj8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=iI5VT6+X19TvpEV1PRGZ6dceb7ttyxuwIAuV8GdP7NFCR7QciiE2rR0g8QjKXkTrE
	 gMdBR0uy8gJ2V5CqhBEGlP18HwB8FUFIdsfutVyJZAhzfiOpvNwbGctltvzfNAlFDl
	 N2c1gzPCjz95qRqiJ9SrFKKrH1np/POiIPoUEjqDJojwXhc0QBvyN3+5NXtXmxorbM
	 nQ7IhVPQnNi+TTx19Q+RAleidOo8cupbCSa6jc2w+OMXMNPeKRjXhHl7J2t5u5LJTH
	 ili2aqbZtBu56rGKKFFHwmOkDOcDaIoweO/A39QI2AsKOzSOApg+YCNgsqW541IVO7
	 l6OxaH3mxKD7w==
Message-ID: <0466fe04a8987c271e81f739d8e6eaf24f3309d6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 0/6] mptcp: avoid data-races around the
 sysctls
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Date: Tue, 03 Nov 2026 11:44:33 +0800
In-Reply-To: <cover.1790147728.git.yangang@kylinos.cn>
References: <cover.1790147728.git.yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

On Wed, 2026-09-23 at 17:49 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Changlog:
> v7:
> Patch 5:
>  - Rephrase the commit message accoding to sashiko's comments.[1]

Sashiko is still reporting some issues. Please fix them first. I've set
this series to "Changes Requested".

Thanks,
-Geliang

> 
> Patch 6:
>  - Fix the use-after-free reported by sashiko [2]: the module
> reference is
>    now taken inside the same RCU read section as the pointer fetch in
>    mptcp_pm_data_reset(), so the ops cannot be freed between the
>    rcu_read_unlock() and the bpf_try_module_get() that previously
>    lived in mptcp_pm_ops_init(). The fallback to mptcp_pm_kernel now
>    takes a reference as well, fixing a pre-existing refcount
>    underflow when MPTCP is built as a module.
>  - Fix the reported use-after-free in [2]: take the module reference
> inside
>    the same RCU read section as the pointer fetch.
>  - The remaining of [2] are not actual issues, along with the
>    "scheduling while atomic" one which does not apply: lock_sock()
>    has mutex semantics, no spinlock is held across synchronize_rcu().
>  - Clear the pm.ops inherited by cloned sockets before re-selecting
>    it: the clone entered the swap logic with a reference it never
>    took, and the grace period wait could run in RX softirq.
>  - Wait for a grace period before releasing the retired ops in all
>    cases (same-ops reuse and final destruction included).
> v6:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260904093531.20023-1-gang.yan@linux.dev/
> v5:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260828060643.14397-1-gang.yan@linux.dev/
> 
> v4:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260824073625.57471-1-gang.yan@linux.dev/
> 
> v3:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260819125629.49823-1-gang.yan@linux.dev/
> 
> v2:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260818094825.48446-1-gang.yan@linux.dev/
> 
> v2:
>  Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/
> 
> [1]
> https://sashiko.dev/#/patchset/20260904093531.20023-1-gang.yan@linux.dev?part=5
> [2]
> https://sashiko.dev/#/patchset/20260904093531.20023-1-gang.yan@linux.dev?part=6
> 
> Gang Yan (5):
>   mptcp: sched: change scheduler sysctl atomically
>   mptcp: pm: change path_manager sysctl atomically
>   mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
>   Squash-to "mptcp: pm: init and release mptcp_pm_ops"
>   Squash to previous one
> 
> Matthieu Baerts (NGI0) (1):
>   mptcp: use READ_ONCE() over sysctls
> 
>  net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++---------
> --
>  net/mptcp/pm.c       |  64 ++++++++++++++------
>  net/mptcp/protocol.c |   7 ++-
>  net/mptcp/protocol.h |   9 +--
>  net/mptcp/sched.c    |   2 +-
>  net/mptcp/subflow.c  |   9 ++-
>  6 files changed, 171 insertions(+), 61 deletions(-)
