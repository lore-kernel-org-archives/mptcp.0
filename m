Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088E190685
	for <mptcp@lists.linux.dev>; Fri, 17 Oct 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682256; cv=none; b=XowyoZTPfS6y7aqUS1GeRiQ589E5WaBCCi1miuzum7+mcCr5/coDuc5pVp7BpWdjXWkSGZin0WU3kJSwprKNxiLRk/M746WM5X8ZmbIqgqZqU3mVZk2DGFqcSSPAhDaxexpso5JeMnTptnz/lXp+pt+a+U+lwISW7BdNp/h6sFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682256; c=relaxed/simple;
	bh=99A0zainrToKlaH+ZzbIp1JT5jQTpNYrZIMQRFax718=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pE0MvNqTpXJhCKpz8sLJVxEJprpdBkmSMg3d/p7gO6k55K43S/+kEW/r9uukMuFead1d3dgOvi0kt2Q5MxT5iEWPzDGU0Ts/m+qEvvI9VyAMC/eusfmKVaOPLEwsABMCint/qIEOgbwIKaPHCTu8eC3Zcw1zrCiCkoC1pLUduwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N87CUMd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N87CUMd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35693C4CEE7;
	Fri, 17 Oct 2025 06:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760682256;
	bh=99A0zainrToKlaH+ZzbIp1JT5jQTpNYrZIMQRFax718=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N87CUMd2hzI53oMoexiQNcguQH/FJYHh5PQtUwkhzUCt699Pg7XGjabt+fBLUImli
	 Was6f6HozHpO65CgPn+Hbg76t5rTt6otN7IB5UbveSR4sVELjUbX0oFh3Lax0xK5n4
	 Om0PYUUu4kEryCXivmktGUOxuN1nKRaU9IP8E+y/dbhY+Ink3oXS97Mp/sRv414hYQ
	 gkkSDkQSTDeUlir6md1AxI2T39RKC0oA6Q98I6JDBjrJkfB1IwNHDP+XBbGvRB/io6
	 OMfSOTfgMvgbFxgYCFEzfLcvcNjln8FKnyQiAR7N57amNPn0BHB6QXZIrFEGdQlMGb
	 rGyO3R6WutRAA==
Message-ID: <81c30fd90b5166b91de49b59f93c12e22429afa8.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 1/7] mptcp: pm: in-kernel: C-flag: handle late
 ADD_ADDR
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Fri, 17 Oct 2025 14:24:12 +0800
In-Reply-To: <bfbf803d-1431-4a16-9514-724000f3ffb1@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-1-c624eb3bf10d@kernel.org>
	 <96221a4b1a5e83a82d6c2293f4536aece7ff755e.camel@kernel.org>
	 <bfbf803d-1431-4a16-9514-724000f3ffb1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-10-17 at 08:21 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> 17 Oct 2025 08:11:37 Geliang Tang <geliang@kernel.org>:
> 
> > Hi Matt,
> > 
> > On Wed, 2025-10-08 at 15:59 +0200, Matthieu Baerts (NGI0) wrote:
> > > The special C-flag case expects the ADD_ADDR to be received when
> > > switching to 'fully-established'. But for various reasons, the
> > > ADD_ADDR
> > > could be sent after the "4th ACK", and the special case doesn't
> > > work.
> > > 
> > > On NIPA, the new test validating this special case for the C-flag
> > > failed
> > > a few times, e.g.
> > > 
> > >   102 default limits, server deny join id 0
> > >         syn rx                 [FAIL] got 0 JOIN[s] syn rx
> > > expected 2
> > > 
> > >   Server ns stats
> > >   (...)
> > >   MPTcpExtAddAddrTx  1
> > >   MPTcpExtEchoAdd    1
> > > 
> > >   Client ns stats
> > >   (...)
> > >   MPTcpExtAddAddr    1
> > >   MPTcpExtEchoAddTx  1
> > > 
> > >         synack rx              [FAIL] got 0 JOIN[s] synack rx
> > > expected 2
> > >         ack rx                 [FAIL] got 0 JOIN[s] ack rx
> > > expected 2
> > >         join Rx                [FAIL] see above
> > >         syn tx                 [FAIL] got 0 JOIN[s] syn tx
> > > expected 2
> > >         join Tx                [FAIL] see above
> > > 
> > > I had a suspicion about what the issue could be: the ADD_ADDR
> > > might
> > > have
> > > been received after the switch to the 'fully-established' state.
> > > The
> > > issue was not easy to reproduce. The packet capture shown that
> > > the
> > 
> > It was indeed not easy to reproduce, but after spending a lot of
> > time,
> > I finally managed to reproduce it and also verified that this patch
> > indeed works.
> 
> Thanks!
> 
> > > ADD_ADDR can indeed be sent with a delay, and the client would
> > > not
> > > try
> > > to establish subflows to it as expected.
> > > 
> > > A simple fix is not to mark the endpoints as 'used' in the C-flag
> > > case,
> > > when looking at creating subflows to the remote initial IP
> > > address
> > > and
> > > port. In this case, there is no need to try.
> > > 
> > > Note: newly added fullmesh endpoints will still continue to be
> > > used
> > > as
> > > expected, thanks to the conditions behind
> > > mptcp_pm_add_addr_c_flag_case.
> > > 
> > > Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side
> > > with
> > > C-flag")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  net/mptcp/pm_kernel.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > > index da431da16ae0..df2bc36593d0 100644
> > > --- a/net/mptcp/pm_kernel.c
> > > +++ b/net/mptcp/pm_kernel.c
> > > @@ -370,6 +370,10 @@ static void
> > > mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> > >     }
> > >  
> > >  subflow:
> > > +   /* No need to try establishing subflows to remote id0 if not
> > > allowed */
> > > +   if (mptcp_pm_add_addr_c_flag_case(msk))
> > > +       goto exit;
> > > +
> > 
> > I think it would be better to place this c_flag check inside the
> > while
> > loop below.
> > 
> > >     /* check if should create a new subflow */
> > >     while (msk->pm.local_addr_used < endp_subflow_max &&
> > >            msk->pm.extra_subflows < limit_extra_subflows) {
> > > @@ -401,6 +405,8 @@ static void
> > > mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> > >             __mptcp_subflow_connect(sk, &local,
> > > &addrs[i]);
> > >         spin_lock_bh(&msk->pm.lock);
> > >     }
> > > +
> > > +exit:
> > 
> > This way, we won't need to add an exit label and can simply use a
> > break. Something like this:
> > 
> > subflow:
> >         /* check if should create a new subflow */
> >         while (msk->pm.local_addr_used < endp_subflow_max &&
> >                msk->pm.extra_subflows < limit_extra_subflows) {
> >                 struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
> >                 bool fullmesh;
> >                 int i, nr;
> > 
> >                 /* No need to try establishing subflows to remote
> >                    id0 if not allowed */
> >                 if (mptcp_pm_add_addr_c_flag_case(msk))
> >                         break;
> 
> I'm not convinced: that means these conditions will be checked for
> each
> local address, for each iteration here, while the result will be
> always the
> same.
> 
> Here it sounds better to me to skip the selection before starting, if
> there
> is no need to do that.

If so, please add my reviewed-by tag and apply this set. Sorry for the
delay.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 
> > 
> >                 if (signal_and_subflow)
> >                         signal_and_subflow = false;
> >                 else if (!select_local_address(pernet, msk,
> > &local))
> >                         break;
> > 
> > WDYT?
> > 
> > Thanks,
> > -Geliang
> > 
> > >     mptcp_pm_nl_check_work_pending(msk);
> > >  }
> > >  
> > > 
> 

