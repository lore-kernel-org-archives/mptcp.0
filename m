Received: from mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533D18E025
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906062; cv=none; b=uoZjTySrHjNk01/oAay1T4InAWteaK9B+rlqgbfyZ+83WvatHt+sYS+Im8sNfGBx3aUWp2DDDLHm7DS6rRLPMWyJnNAfwLe94BP1KzUkiTHiyUGgfLjkDHdLDt5LLrvolHAEY/5Yz7twpvplM7+2l2ry8FZJrc5fVZNNU6aBJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906062; c=relaxed/simple;
	bh=9hMdHeIR+IN8aJLQLUXcpLYHqx8scuYNCQoEyPUlL4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZxHwYzW2mScpMdIbwB/T8nqO3W36QK9/itUAeIFWQp/+HbeRP50tc8wCZBEAb/BWPDVY5HxkSwXzgQvbuHsmBjD3SMMOwiNpjjwqIOZgt4PQsf+0Z7MTnTtNN7M+g0dA1OOvmsAZRvVFiaSV17yTNWONkD6Kpan8yzqPpJFJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C2mPAMFf; arc=none smtp.client-ip=91.218.175.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C2mPAMFf"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=9hMdHeIR+IN8aJLQLUXcpLYHqx8scuYNCQoEyPUlL4g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787906057; v=1; x=1788510857;
 b=C2mPAMFfqG+R62hNS32hQro+SaNtLrrpQy3YMMbd16MeP5J4jmh7PtUUwug2avd9lbGF3zOr
 QNqWYV0a7lCXk2oXWJNTbxa9GZKklMaeN40uEYo/rRlh/tweyirw0V8g42CkSSaGjqvn5jVTxDA
 z74bGm0nYARwn7CRfIVljEdI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 3fca9118684d59aa;
	Fri, 28 Aug 2026 08:34:17 +0000
X-Mizu-Trace-ID: 3fca9118684d59aa
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: matttbe@kernel.org
Cc: cuitao@kylinos.cn,
	geliang@kernel.org,
	mptcp@lists.linux.dev,
	cui.tao@linux.dev
Subject: Re: [PATCH net-next 01/11] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow
Date: Fri, 28 Aug 2026 16:33:52 +0800
Message-ID: <20260828083352.292492-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5eeb6f1e-3444-4737-a310-dfc0b6b644cd@kernel.org>
References: <5eeb6f1e-3444-4737-a310-dfc0b6b644cd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hi Matt,

> On 22/05/2026 10:50, Tao Cui wrote:
>> extra_subflows is a u8 counter that can underflow if a decrement races
>> with or precedes an increment. While the recently fixed userspace PM
>> subflow creation path eliminated the primary cause, add defensive
>> WARN_ON_ONCE guards at both decrement sites to catch any remaining edge
>> cases rather than silently wrapping to 255.
> 
> FYI, Clashiko found some existing issues linked to this patch:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/629
> 
> I don't know if it impacts your case, but just to avoid having multiple
> people looking at it, do you plan to address Clashiko's comments?

Thanks for the pointer, I had missed that issue.

I had another look and yes, I'll take care of it. Both findings look
real to me:

The disconnect() race is the nasty one. The MP_JOIN softirq bumps the
counter under pm->lock and defers the subflow to the join list, then
mptcp_pm_data_reset() zeroes it with only the socket lock held, and
the subflow gets closed later at release_sock() time when the join
list is flushed. So we hit the new warn with the counter already at 0.
With panic_on_warn that's a remotely triggerable panic, which is
arguably worse than the silent wrap we had before.

The unbounded increment on the userspace PM side is pre-existing, but
now the wrap also lands on the warn instead of just corrupting
mptcpi_subflows_total.

I don't think we want to keep WARN_ON_ONCE() on paths we know are
reachable. My plan for a fix series:

- refuse new MP_JOINs on the userspace PM once extra_subflows is at
  U8_MAX, so the counter can't wrap anymore
- sort out the accounting across disconnect (reset vs join list
  drain) and downgrade the warn to a clamp, maybe with a
  pr_warn_ratelimited() to keep some trace of it

I'll follow up in the issue once I have patches. No strong opinion
between clamping and refusing admission at the limit, happy to go
with whatever you prefer.

Thanks,
Tao

https://github.com/multipath-tcp/mptcp_net-next/issues/629
