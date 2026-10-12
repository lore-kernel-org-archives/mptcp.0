Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98813472790
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826480; cv=none; b=r1VYTfZqXdeumiyer6728L1gMMX/ZrEvWdO6DnygjC/jQcrqsuejbbuOlXyU8abJmUGqC3Uk6yiAMlvIhhsNWls/2epVJjC+Q5PpJuF0pC+dCcm+QRV190Vcdg5ywLObTALaVr5RmAusZzUE9fH33NBwwH+3hNkzWQGJU73w2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826480; c=relaxed/simple;
	bh=uhBQec5Ln20QXlTmXLCOhU/LA9BlaKff0RXe+caQiiI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e/QNii3kIItD3XRTe+LfJ2bLIDrGN8bCnCSxN62s5rb180d/LCqUgGo/saiWLMjXAX8CGJsY9efwVjHFCMlInf3gO6tt54esXSRdPQdCc0PDCpfTQxtKl5bwdHHWJCb26CfPKm+Wro6NYwtBbwi5BC82m7FaJ9IGCrCo6aWUmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsB52L8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsB52L8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FEA1F0089B;
	Mon, 12 Oct 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826479;
	bh=PRxeBLU7gbIzvJTCUKUCN0GC0eTKfNLrlVlXsocINyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LsB52L8GQr0KseSxllI9BA4/cz+5mAJ76ur588zNgpD1M/jPvgh8xRjZahs7gHPKK
	 IcHmnwnqfr81YdlO4sEv8hQToc/SZOsPbnb3tl4y7G/lSJPwUpVgLvHufgQ7bi2E14
	 hgofy3kpGtc35jDJIMu9AU4Bn1Cs2SSVGtVuW6FQjpj2cX2d2WJnmiZ9Ocqn4nyYKk
	 nnPTiMw8NjzFfbDwq9Vprt9bfukerrv3nVdESWGA0eFrRaAzL7N6Da9D7cifCS2Zp9
	 +m0aEa9d7kgO+dpnAjhpVRDukPkD5eC/gkM3XmdeCAae9Hsi3VMyATwsfyy6ZTSBCX
	 bdqlYIkZCA0sg==
Message-ID: <sashiko-outbox-168464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mptcp-next 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261012171740.464517-3-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
 <20261012171740.464517-3-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:34:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: pm: infinite loop when net.mptcp.subflow_retry_timeout is 0
- [Medium] mptcp: pm: retry list slot exhaustion due to uncollected disable=
d entries
--

commit d5d7b6b49191fe292c451a4a994147ebff6534b3
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: kernel: retry subflows closed after an error

This commit introduces a mechanism to retry creating subflows that were
closed due to an error, using the in-kernel path manager. It adds a sysctl
to configure the exponential backoff retry interval, up to a defined maximum
delay.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..2683e359695cd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
[ ... ]
> @@ -493,6 +509,250 @@ static void mptcp_pm_free_announced_list(struct mpt=
cp_sock *msk)
>  	}
>  }
> =20
> +/* Subflows closed after an error can be re-created later on, see the
> + * 'subflow_retry_timeout' sysctl. Entries are kept until the msk is des=
troyed
> + * to track the exponential backoff, and are disabled when the correspon=
ding
> + * local endpoint or remote address is removed.
> + */
> +static void mptcp_pm_retry_timer(struct timer_list *timer)
[ ... ]
> +/* To be called while pm->lock is held */
> +static void mptcp_pm_retry_arm(struct mptcp_sock *msk,
> +			       struct mptcp_pm_retry *entry)
> +{
> +	unsigned long max =3D mptcp_subflow_retry_timeout(sock_net((struct sock=
 *)msk));
> +	unsigned long timeout =3D TCP_TIMEOUT_INIT << min_t(u8, entry->attempts=
, 16);
> +
> +	entry->pending =3D false;
> +	entry->timer_done =3D false;
> +	if (entry->attempts < U8_MAX)
> +		entry->attempts++;
> +
> +	sk_reset_timer((struct sock *)msk, &entry->timer,
> +		       jiffies + min(timeout, max));

[Severity: High]
What happens if the sysctl is dynamically changed to 0 while there are acti=
ve
entries in the retry list?

It appears mptcp_pm_retry_arm() calculates max as 0, which results in arming
the timer with jiffies + 0. The timer would then fire immediately and sched=
ule
the PM worker mptcp_pm_retry_subflows(). If the connection fails again, the
worker immediately calls mptcp_pm_retry_arm() again.

Could this create an infinite, zero-delay loop between the timer softirq and
the PM worker queue that monopolizes a CPU core? Perhaps the code should
explicitly check if the sysctl is 0 and halt retries for existing entries,
rather than clamping the timer delay to 0.

> +}
> +
> +static bool mptcp_pm_retry_path_error(int err)
[ ... ]
> +static void mptcp_pm_retry_add(struct mptcp_sock *msk,
> +			       const struct mptcp_subflow_context *subflow)
> +{
[ ... ]
> +	spin_lock_bh(&msk->pm.lock);
> +	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
> +		goto unlock;
> +
> +	list_for_each_entry(entry, &msk->pm.retry_list, list) {
> +		if (mptcp_addresses_equal(&entry->local.addr, &local, false) &&
> +		    mptcp_addresses_equal(&entry->remote, &remote, true))
> +			goto found;
> +		nr++;
> +	}
> +
> +	if (nr >=3D MPTCP_PM_RETRY_MAX)
> +		goto unlock;

[Severity: Medium]
When mptcp_pm_retry_disable() marks retry list entries as disabled, they are
not removed from the retry_list.

During mptcp_pm_retry_add(), the list iteration counts all entries via nr++,
including disabled ones. If normal network events accumulate 8 disabled
entries over the lifetime of a connection, it looks like this limit will be
reached and no new subflows can ever be retried.

Can this lead to permanent slot exhaustion on this connection? Should disab=
led
entries be evicted or skipped in the count to avoid this?

> +
> +	entry =3D kzalloc_obj(*entry, GFP_ATOMIC);
> +	if (!entry)
> +		goto unlock;
> +
> +	entry->sock =3D msk;
> +	timer_setup(&entry->timer, mptcp_pm_retry_timer, 0);
> +	list_add_tail(&entry->list, &msk->pm.retry_list);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012171740.4645=
17-1-anilkaushikwireless@gmail.com?part=3D2
