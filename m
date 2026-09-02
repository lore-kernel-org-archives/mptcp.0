Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5794A8FD8
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368219; cv=none; b=jpEgGuJgwwhGqaPIzjURkqH+WQhaP5fG/isteFeqlcDvIBxjSZRmI12Jw2ooy7qeLdS5PbaH3YYLdB8PPN/NuvJbuzpFA4i5h2HB/FhvShzZj9LHaDf8VFspX8Zg39PwW0Ahe+GQywtL1WPVgePxxSzFtYEbbvkcIk/P5qiC7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368219; c=relaxed/simple;
	bh=DN5KbZePw6JBSf5gJ1Gk6voIvhyzmKFHWMkFaN49J3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezPiETFT/PftGZQkON3A1rh4AYNQjcCqL9t67LY+agti2ENVShS7MtspdU+zXUeYuhBZdclc+39/TPjnwGqpIXd6ymfCqtI/cQ1SWj+7Z+McT/0w9ogXkSsMPmJHqg5KL/7YzTB08l8005rbsBsZamfoxE/z6SHg2LAZIdMHQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhpPI8PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhpPI8PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991E71F000E9;
	Wed,  2 Sep 2026 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788368217;
	bh=u/9WYOn6nTCmf3XSaymTZiiNfVKKnWjGVtkZgKPcY+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZhpPI8PLSQz/EoAgsByj1e5RL/+/fpdYN9l3BSlcLvS/j2OjRyy8ZxTePdstKvqtu
	 A9EkqxPWHwclJGvlsPTZE+0a3iKVseF9b1/HebPXdqEbVJfLKAXvZcEq/5X+B2sI47
	 clswgi2/svh30zKzY+d3slzErRMD/8XfugBM6VWtPbVhrStkdZdDhCMeF3jz0RTwO1
	 jwNfDI+ROi2e5dMVSHwqDrXOYZmb7j4nXS5aP9uPy268aaIVt9IgMoNNqZfGfuXcB/
	 MP8cuddAM+QWhOdMb1t51QruLSKt12LeGQAoCTjMfIe2zPkxZKpvJXqHIPKrsSh1oM
	 9t4Lq6CccdDZQ==
Message-ID: <ce1ad12f-1da7-457f-b5a7-187ee174c63e@kernel.org>
Date: Wed, 2 Sep 2026 18:56:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: skip extra_subflows accounting
 on disconnected msk
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>, mptcp@lists.linux.dev
Cc: geliang@kernel.org, cuitao@kylinos.cn
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-3-cui.tao@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260831093206.689827-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao Cui,

On 31/08/2026 11:32, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The WARN_ON_ONCE() guards added to the extra_subflows decrement sites
> turn out to be reachable:
> 
> mptcp_pm_data_reset() zeroes the counter with only the msk socket lock
> held, while an MP_JOIN subflow can still sit in msk->join_list, its
> reference already accounted by mptcp_pm_allow_new_subflow() under
> pm->lock. If the socket gets disconnected(AF_UNSPEC) in that window,
> mptcp_pm_data_reset() zeroes the counter, and the join list is flushed
> later at release_sock() time: the leftover subflow then reaches
> mptcp_pm_subflow_check_next() (or __mptcp_pm_close_subflow() for
> kernel PM sockets) with the counter already at 0, firing the warning.
> On panic_on_warn kernels this is a remotely triggerable panic, which
> is worse than the silent wrap the guards replaced.
> 
> Skip the PM accounting when the msk is already in TCP_CLOSE: in the
> scenario above the state is set before the counters are cleared, and
> once the msk is closed the accounting is not relevant anymore. Keep a
> clamp and a rate-limited pr_warn() on the decrement sites instead,
> to leave a trace of any imbalance we would still not know about.
> 
> Fixes: e99c1ca89071 ("mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

This patch looks good to me, but could you please use the "Closes" tag
for the last patch of the series closing this ticket, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

