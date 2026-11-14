Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661764;
	b=WV6c0DzTTXo99GyWn7t/jPLxQUl6n4x9xDkeC2vwBpcihWIpq9uJYzrlfjHdIxg5cBvx
	 j6C7nZyldG9mdoUNb67a85/0FoXs1V57Rwf4CDck51lk3cwfJeU61KHRVbnM4v6X3watT
	 wUubYEf9VcEvPO6FOsj7L2xGC+ltnHSnASOsngOtO1nTkrpFvVh2XueL2UQhfvDQvd/cz
	 earZhKFiGXKDbfo8jOgwSZPFxWD1mudIX9u6OInhsC74wRgJPO9h4+6Mf+Hnu8ZR9ryqu
	 ZpZ8nE72j/zKkATJjRMYV2JqG41IsBkGrFcdcG6uWn65AGtM1TJ0CUQ7iw6rC/r6cpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661764;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=9QHmD6CbC3B8E4Fu+2pBtpNfJsF3diLcnyMXeoB/6ZA=;
	b=5gLeZcDFWzTYdgIw+trL/gRi3Pj1XFkf9tGjSBDaEvRGrruPUCP45SGE+c9P9LzkHCKL
	 LvObIhGJNXZ/p/e/DbLC4R7+RsVuKNLLEImnf4MmAh/Q1jlzm2TU0lAHo7ij/Sjmo8XcQ
	 EXqIZiynQSFPm0WDPW685mLdG813ldPKVjn0/e3ZSK2QLkbDREVaiC4QZWwXiJlZWBHTA
	 AsDkRLnaiA+tN6C9U6l/8WxIopLUlH+0XOH9eHdg6UXBx0zU0itqKUWo98LNJY6Z2pKAg
	 dJDitFuEXZG+Of5DtNO+UAIyqJqwZqpi0nF11IHaJRDDZ0oEBd82CsrQUDVnqw6bPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hBpyChmy;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8896075C62
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 13:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE8896075C62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hBpyChmy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794661760; bh=9QHmD6CbC3B8E4Fu+2pBtpNfJsF3diLcnyMXeoB/6ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBpyChmybMm5aVI4drzPni8AuleG5XZwrboiosTTwWexsaIoAt1WJPEuLLepvv0gT
	 mA8XCSWpadDMHCFT3ncTLtUCUdH/X5/Bp4cu4iErjNZJvPNVnasN5rPTAVsSlY9/Vt
	 UBJBAik6tU4UJIbdq1NXLUGgaqsO+5S/f+CbK61o=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:7443:873c:1230:8af8])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 24F86472; Sat, 14 Nov 2026 21:09:15 +0800
X-QQ-mid: xmsmtpt1794661755twccmgsz6
Message-ID: <tencent_D60B0B7B6362D7A729A4FEAFFDF4D8328107@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uL2TWbxEEsFke5p/dO2hZuv9UzZTpEyVpZFZr0fMQ5/Be7DDHSE
	 iwge78Q/cUM0f/Pn4F+DbXY1UOlESf2fEjA2ol1RUMZo7wUZCjtP2M126E2J48m5aY05T/BUmyfc
	 DVxnfO8x5TUxaJPAyf6M9W1vXtIFmh44hS9uadpYPBK/DZ8g00UTQAPeUd5qcT7uSyAQANeB9v/K
	 72dP75mtuKAWrjldn/zSw8NXOE4spmXwd1CQ9Sw2kcW11jWSNfYGrYg6D0kjw82JUMD28dq1Lip7
	 589nLyX9Mi8jXl2QfR0UlxNyKyRWixafkXMhGOlvnu+aA2gMRidu0lLV9WQ7i7D9UaibLRUNRHKj
	 xMimR7b6JpTXNDRD8/8o8sIabsxzj/nyBQT/YvVGzXPngIA078MgXxJNRD/5QdhUdwjcHJl3YcBF
	 r/BW/9RNjssm48e0joFoylp6PNcG6MscJQ+mEE6Rhom+qWAkSM4KPXaPipU8vdEEIZVvUhmgnO7o
	 MrlYaufuhn4sE19G8dDp1ovwxc9SVZRGzOVsBj211HaDpuVV+DCg9TDLzxTEyjU8mSFTGyfyJm/s
	 GI/nS4S5qTPJpd3XMNDZOfwYDpluQHIcnP4erEjAxbOyoMLBtAf2+M0h02nAo+c2xR0rXFerXz6T
	 dyh8giwUKeCoMepmVNVmYwIfbo4iFL1vK7vhD+pED9zMmIey/qbclE40szrW22JBkXkWr8VtrJMx
	 knT5iTSRCG1e8VXLXHFkgNqKMZykF7+9tDhDrJNhJMXdq20W3O5mSwZiaifWPsvEn7hy5XiuiL/r
	 JQ3LFtfR84K3ysaI90xnSAeJkKs+zWdM/eP+i9xyO/LDcxxEnR02gWgBLy4PqYxR06qg0AivJ808
	 dSH/hW62P/S/f2i4csTZ5YyOnIt+mPxKjBLkOOxa+d3rdkzVDrKdOCbsMYD5l38vdwWsBUT4Fqkg
	 26rZFHEEq/I0o6dnVGZtYATCUX7lYKq5yz3vcimP/xqMPzUxJeevm4NJN+XKXxkk/KMK9qp2m+23
	 /WZkOGYFqMj1TG1eHntzU4Je1uCrh21gIP/FQMtsA2bf3q0tZU2z4k1AZs3gfFfR5bIRPMHw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: sashiko-bot@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net 1/2] net: mptcp: take token lookup references with
 acquire ordering
Date: Sat, 14 Nov 2026 21:09:14 +0800
X-OQ-MSGID: <179466175477.91732.2161918558371491672@qq.com>
In-Reply-To: <179448794830.196117.14284634941387773647@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
 <179448794830.196117.14284634941387773647@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thanks.  All four points are correct; respun as v3 with two additional
patches.  Details below.

[High] token 0 accepted by mptcp_token_get_sock()

Agreed, and it is a real defect rather than a consequence of the missing
ordering.  Both validations compare the socket's token with the requested
one, and for a requested token of 0 that comparison is satisfied by
exactly the states a socket must not be accepted in: the value
mptcp_token_destroy() stores, and the zeroed state of a newly allocated
msk.  The ordering change does not help there, because the comparison
itself is vacuous.

What I verified statically before sending v3:

  - mptcp_parse_option() copies the MP_JOIN SYN token with
    get_unaligned_be32() and does not reject 0;
  - subflow_token_join_request() passes the result straight to
    mptcp_pm_get_local_id(), and for a subflow with a different source
    port to mptcp_pm_announced_has_ssk(), which walks
    msk->pm.anno_list under msk->pm.lock;
  - that list is initialised from mptcp_pm_data_init(), i.e. well after
    a socket can be found on a chain.

Patch 3 now rejects token 0 before walking the chain.  I did not manage
to reproduce the resulting crash, so I am not claiming to have observed
it: the description in the patch is a static argument, and the Fixes: tag
points at the commit that introduced the lookup, not at an observed
failure.

[High] mptcp_token_iter_next() re-checks only net_eq()

Agreed.  Patch 4 re-reads the token after the acquisition and drops the
socket unless it is non-zero and still hashes to the slot being walked.
A socket on a chain always hashes to that slot, so the check only rejects
objects whose memory has been reused in the meantime.  I kept the
severity assessment lower than the one above because both consumers
(mptcp_diag, the userspace path manager) are netlink paths that require
privileges in the target network namespace, so the bad state is reached
locally rather than from the wire.

[Medium] the commit message gives the wrong reason

Agreed, and the correction is in patch 1.  The acquire does not pair with
anything in mptcp_token_destroy(): that function does not touch
sk_refcnt.  What it pairs with is the publication in
sock_init_data_uid(), smp_wmb() followed by refcount_set(&sk->sk_refcnt,
1), in the SLAB_TYPESAFE_BY_RCU reuse window, which is the case
refcount.h documents.  The message now says that, and keeps the teardown
comment only as background for what the re-check is looking at.

[Low] Fixes: trailer

Agreed, and corrected in v2 (now v3): 2c5ebd001d4f and 96d890daad05 for
the two mptcp sites, and 1cd62c21572c for the reuseport patch, whose site
also postdates the consolidation.

On testing: the ordering change itself has no runtime observable on
x86-64 (both variants compile to lock cmpxchg) and we have no way to
observe the reordering on the hardware at hand, so patches 1 and 2 carry
an instruction-level argument only (on arm64 the CAS becomes CASA; I can
include the disassembly if useful).  Patches 3 and 4 are plain
functional checks and both objects build; I have not run a KUnit case
for token 0 yet.

pw-bot: cr

