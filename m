Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB54221714
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758341705; cv=none; b=AmYu/Eo7dr80Fybq39hWhpsCKouh17zpCVtC/W3UR769kbGkET6m/l3Ccmf/iZewBG1znUoP7GvYY2L8LcueOcp1B82w3Gz/m70qwXRf2NiaQBaggqyqwbbffLb9NoYjRWhelFSTYFvhzhNr6wn1z0UTv5Tera+9VMuQwVzA4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758341705; c=relaxed/simple;
	bh=jwxZxNy9PO9ObZ6vquvHxAroktode5FMPncxdEC+WSk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q5iE8cmTYXnnPUdtY/HKt0LX5P4BL2f7+XJ/U+sd9Et7Ugtq+r13/cc4A+GgvRPoRkonaqrs1lInZU47+3gKia2WKFSNiEZWjXcjBoKU6w55oIx6h3Q/3ix7NEmd/ZGv+RSOn5WG5JQeks21sJWwRJdXRXlEFXSeE721s8jLJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzNZIFcx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzNZIFcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45E0C4CEEB;
	Sat, 20 Sep 2025 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758341704;
	bh=jwxZxNy9PO9ObZ6vquvHxAroktode5FMPncxdEC+WSk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FzNZIFcxNkBK/mlKhHGg0S62tAxRgigl3MsqgNcvSyDAOsqapk+VY6ZQmyS5CtRYL
	 zluQmimnvqKrq1n0Yn7uJaKuzRg1P+sEayoJvrX2LGMIXLnWUmmFaY5E3d0YmhT29b
	 3SB4WodQO9psll3Vz/0K7q5BzdTtwOkFv9U1PiAYYhaMvTR+JkzMzX3aVonib386aa
	 4+fXx06pq3vWp1uqQK7S066D+KwMUKsYlcXeoNxm6i4p2NE0tekMUy3KuPFXBf8ZW+
	 mMT2yFIHHNQCT2vXptF2EhLl6qXhBR7j8ceBeRifEp7MhSfNGMe5npPpjETqRPYlut
	 +lz3+C3Xu2sQg==
Message-ID: <e2d28fecf8ec5db0324a1b0dd4291f03f65d5d19.camel@kernel.org>
Subject: Re: [MPTCP next v3 00/12] mptcp: receive path improvement
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Date: Sat, 20 Sep 2025 12:15:02 +0800
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
