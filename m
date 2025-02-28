Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F217256C80
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738723; cv=none; b=jHilpmPfnrd9NL0nufjqeIVwNwcQjjInO/JQndmelAaau+c9bvEhb/gFF8EPmB7B8I9ajkJXB9jdq0V0luiLwgOjrgJRit0pS0q9uoOYnBTb2ZmC+xpZ4rNSyQ5wO33Ws7Muu3XLlAtqt+ellXJo1m+gi8IxYyHArWQcsG4gk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738723; c=relaxed/simple;
	bh=ga2zoVbSZhLP+q4y4iyl6XJpmRDu5vlTjZ4fgej4ehY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0YnC/3OljKkwUaZ0mqx0uSA7y1+CEg3PQntiu2+m6jr2LO3FL4gyNrqCcBXpt1vt9ZkgyNDwMd7BcXl99k16PAJJhtINwx2xVD4ayfJpygKQe0VzRK5TALhDj4LST2K0ozjDL2Fo7G3X9jPKpdg4mbB2mbX4HZeNhcBNwFIQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK+xcLty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK+xcLty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB93C4AF09;
	Fri, 28 Feb 2025 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740738722;
	bh=ga2zoVbSZhLP+q4y4iyl6XJpmRDu5vlTjZ4fgej4ehY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=aK+xcLtyX4mt6MJcXt1wZHX3mwr1KscqZhEq569pvMZ8bn4/fG7wGqIciKCgq7Qwf
	 THEnNqSKzrxx3FKFhb/fMxNTg7cb5wR9t3lMMad1inPYqpqMge0BcGgil7CxDBCd7x
	 1rDKuu0MGaKhcF5DUbQT4LgqPCjWx6PT0xZozCbWX7Mz3YbiLGl8npwjXuaK+fmPkV
	 r0ShmodoqVzHzJm6i+ECZlHPigyKLyegrWNfQ5/UoO9ppYDMtQ0NUFRX848WNpmZT6
	 EQsEh98cUsxO/4i7k/YzaCE8BTiqbFHYD4QzwKiwE1qf2v5X+TBNRrIt3X9IQ4IyYK
	 F5xseC21nshOQ==
Message-ID: <0499c678a6bc8973d616f95561867eb292f2d538.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 28 Feb 2025 18:31:59 +0800
In-Reply-To: <ebd83ca4-2068-41a6-a2b8-56bcb4ba1156@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
	 <ec9413f7d72c88231a72e3aebcda847ad15a16d2.camel@kernel.org>
	 <ebd83ca4-2068-41a6-a2b8-56bcb4ba1156@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-02-28 at 11:09 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/02/2025 04:27, Geliang Tang wrote:
> > On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:
> > > I have been thinking about that during the past couple of months,
> > > but
> > > now, with the recent modifications done by Geliang, and the
> > > associated
> > > reviews, I really think it is time to reorganise the code around
> > > the
> > > path-managers to avoid confusions, and a mix of code used in
> > > different
> > > conditions.
> > > 
> > > Here is a first proposition, feel free to comment! :)
> > > 
> > > Please look at the last patch for more details about the why and
> > > why
> > > now.
> > > 
> > > I hope this will not cause too many issues with the in-progress
> > > patches.
> > > I tried only to move the code around, and minimise the functions
> > > renaming. Then, to switch to the new code, it might be easier to
> > > simply
> > > copy your modified code from the old place to the new one. In
> > > other
> > > words, duplicate the net/mptcp directory, then do a rebase,
> > > resolve
> > > the
> > > conflicts with 'git restore --ours', then reapply the
> > > modifications
> > > by
> > > copying your old code to the new place. If it is too difficult,
> > > please
> > > let me know.

I have successfully rebased all of my in-progress patches on this set
today.

> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > Cc: Geliang Tang <geliang@kernel.org>
> > > 
> > > ---
> > > Matthieu Baerts (NGI0) (7):
> > >       mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
> > >       mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
> > >       mptcp: pm: remove '_nl' from mptcp_pm_nl_work
> > >       mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_or_subflow
> > >       mptcp: pm: avoid calling PM specific code from core
> > >       mptcp: pm: worker: split in-kernel and common tasks
> > >       mptcp: pm: code reorganisation
> > > 
> > >  net/mptcp/Makefile       |    2 +-
> > >  net/mptcp/pm.c           |  685 ++++++++++++----
> > >  net/mptcp/pm_kernel.c    | 1410
> > > +++++++++++++++++++++++++++++++++
> > >  net/mptcp/pm_netlink.c   | 1934 ++------------------------------
> > > ----
> > > ----------
> > 
> > Patch 7 has too many changes to review, so I suggest splitting it
> > into
> > multiple small patches for review, and then merging them into a
> > large
> > patch after review.
> 
> Thank you for looking at that. If we split, maybe no need to merge
> them
> later.
> 
> > I think it is possible to make "move the code from pm_netlink.c to
> > pm.c" as a separate patch, and "move the code from pm_netlink.c to
> > pm_kernel.c" as another separate patch. Moreover, these two patches
> > only involve the movement of code, without any renaming or
> > relocation
> > of functions, and these changes should be done by separate patches.
> 
> OK, I will try to do that.
> 
> > In addition, we can try to keep the original positions of the
> > functions
> > that were originally in pm.c, such as mptcp_pm_addr_families_match,
> > mptcp_pm_schedule_work, and mptcp_pm_add_addr_send_ack.
> 
> I moved mptcp_pm_addr_families_match() to be with all the new "addr
> helpers" coming from pm_netlink.c. It looks better there. Maybe I can
> do
> the move in a separated patch.
> 
> For the two other helpers, that's because
> mptcp_pm_add_addr_send_ack()

It's better not to change mptcp_pm_add_addr_send_ack() to static.
There's such code in mptcp_pm_add_addr_received():

        if (mptcp_pm_is_userspace(msk)) {
                if (mptcp_userspace_pm_active(msk)) {
                        mptcp_pm_announce_addr(msk, addr, true);
                        mptcp_pm_add_addr_send_ack(msk);
                } else {

This part will be moved into pm_userspace.c later, then it will invoke
mptcp_pm_add_addr_send_ack() from outside. So it's better to keep
mptcp_pm_add_addr_send_ack() as it.

Thanks,
-Geliang

> is now static, but called by code imported from pm_netlink.c. Maybe I
> can add a signature above to ease the review here. Would that be OK?
> 
> Cheers,
> Matt

