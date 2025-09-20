Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC71BDCF
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758341635; cv=none; b=k3jW7mXwvoRthAa4mzsBqN7/I8dwdGyFr/2QfcI1a4lcSPcevoB5zl7qU0FVUq/6GPRIZ9+VI747qF4elSNYO6Lv6Xqz7WVGdSBSUJdBDV5OHNkFNXZXemUpUpdR4/7+a8GKPJ8/Fsztn7v8YS42GShBa+qnvbTyMKuNA87DBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758341635; c=relaxed/simple;
	bh=jwxZxNy9PO9ObZ6vquvHxAroktode5FMPncxdEC+WSk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6AdAQll8mNy+HLPEW9IHBRkwFv87OIT/xE7xYVr2heWivrkZu30LimuUPGH84SjhW4tBiIRtaTwmUpeqADoQ5N/zYd6emS+WX6zNuYsFs66VAT2vvIW2E/CeAX+XgVzd9zWmNPyS6UdKrA5Dzi20aZhN5rmkMfQcLSJd5vGV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckbd7tOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckbd7tOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88381C4CEEB;
	Sat, 20 Sep 2025 04:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758341634;
	bh=jwxZxNy9PO9ObZ6vquvHxAroktode5FMPncxdEC+WSk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ckbd7tOhrBypu//nh5Nz2dMeWnJVlqxrd9GjhcYTaHIgRo13wgpaC8tVH9W1l8cuD
	 qjOwe6zwYbvpUmiXsis6kcT7FUoaXhCDUUzzVeLsp5UYySP2FRE2DlgfZQkSOnVbcv
	 eXB8g9+5ElXB8N1NZHiTIrYwr/kdfo+A3tp5JDXrmI10BygJWyHJ57qw89j2ZeOxlh
	 lh9e8LdXS5ucewPdv2rrbndOyW+cYpPMbdonurnFcbpaJW0P6r31dAEn6eKHlP3amU
	 4vzEjM4cRpOurbJN5lxl+NpTDV9i1tiIqVdP+zIVxveTziPQyt486SsK6e1tguh5Bu
	 ga2yfn6z3lMLQ==
Message-ID: <28bd4af1fd143f34cc38c769953bd0d72a021ce1.camel@kernel.org>
Subject: Re: [MPTCP next v3 00/12] mptcp: receive path improvement
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Date: Sat, 20 Sep 2025 12:13:51 +0800
In-Reply-To: <4e5d00ca-1317-4f98-952b-e7ac058c52b7@kernel.org>
References: <cover.1758296923.git.pabeni@redhat.com>
	 <4e5d00ca-1317-4f98-952b-e7ac058c52b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo, Matt,

On Fri, 2025-09-19 at 23:13 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 19/09/2025 17:53, Paolo Abeni wrote:
> > This series includes several changes to the MPTCP RX path.
> > 
> > The main goals are improving the RX performances _and_ increase the
> > long term maintainability.
> > 
> > Some changes reflects recent (or not so) improvements introduced in
> > the
> > TCP stack: patch 1, 2 and 3 are the MPTCP counter part of skb
> > deferral
> > free and auto-tuning improvements.
> > 
> > Note that patch 3 could possibly fix issues/574, and overall such
> > patch
> > should protect from similar issues to arise in the future.
> > 
> > All the others patches are aimed at introducing the socket backlog
> > usage
> > to process the packets received by the subflows while the msk
> > socket is
> > owned. That (almost completely) replace the processing currently
> > happening in the mptcp_release_cb().
> > 
> > The actual job is done in patch 10, while the others are cleanups
> > needed
> > to make the change tidy and more follow-up cleanups.
> > 
> > Sharing earlier with known issues (at least on fallback socket) to
> > raise
> > awareness about this upcoming work.
> > ---
> > v2 -> v3:
> >   - (hopefully) addressed CI failures
> 
> Sadly, the CI doesn't seem that happy, but only in debug mode:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17863851247

I just sent two fixes for these CI failures to our mail list. It works
on my end. Still waiting for the CI results - hope everything goes
well.

Thanks,
-Geliang

> 
> If it is easier for you, I can already apply (and send to netdev?)
> some
> of these patches? e.g. 1-7/12?
> 
> Cheers,
> Matt
