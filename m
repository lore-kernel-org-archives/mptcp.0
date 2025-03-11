Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26E1E832E
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667097; cv=none; b=JodgIS7Au9GxWBg12PL/cEC/sljunrwwngLjOyerft0SQVVpHt+fSbxKMp4/0nlCf8nf3/9KRDU+U1afYJgApJO3mYMAXFU1xtehYW8kAhDh5Y3YTIrEAYceMAXZ8r+gyXNW6U0h2/xklPhRpRFb/tsJ1MtVXQl8SlgGPnpIEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667097; c=relaxed/simple;
	bh=5LpIL/EujMPvhVCqAA7q9JsPd3uF70adob8qwJV/K0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmkDMNP0HwPymJL6F/uV97CUQa8CLSGK2n63PxjvmYiZNnIfj9EWiMKNbPIiFE0i2a6iIEWFhBJ8v7KQye7xk5lYuP9fm5LUkALya+cNtqhyBzQnQ39tPJUFA8AEj4CMcsD8I1qnwKq11y469VV6Mqpo6lgcZoDjqewHdV35OKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMBAetEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMBAetEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E301FC4CEE9;
	Tue, 11 Mar 2025 04:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741667097;
	bh=5LpIL/EujMPvhVCqAA7q9JsPd3uF70adob8qwJV/K0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZMBAetEl4DNSGxpsvkI6K7uwQjG0n1o0QZHw5Uwfq6rPnwweWxY7BMOiGX+Iq/iHQ
	 twnxye0epbj4vHi5A5qIyJzcWZIVju6efdCRE26sffT1yX3h04D+C86GXMU8UPiK2K
	 OPM4a3rtczgBiILg/03MzD3vg9zpD4vW3VY94BFuja1rwSqQYdtAm/GQrqeuA/oIZY
	 ySuHkWGq+84Bdj2Rw1tS1gKPeFaVQ+iQv3xW6CwS9uzjRQWVz5RGrO/kVYsX6rSDaQ
	 h0u8XDfYB4tFcxHJFumo4DFTrhRXKKmHKAWZURwD8eI9N+Z08j5gRkWulN8flkRXkz
	 lZYoMX0Ky+HtA==
Message-ID: <938c0376842a7873ca28802aae71bf655d9d2e2f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v10 04/12] mptcp: add struct_group in
 mptcp_pm_data
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 11 Mar 2025 12:24:51 +0800
In-Reply-To: <26482cc0-abce-464e-96ba-826217c779d8@kernel.org>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
	 <9133981edb83438ee10e6da9ef4e5cc6bf7f188b.1741258415.git.tanggeliang@kylinos.cn>
	 <26482cc0-abce-464e-96ba-826217c779d8@kernel.org>
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

Thanks for the review.

On Tue, 2025-03-11 at 00:17 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2025 12:01, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds a "struct_group(reset, ...)" in struct
> > mptcp_pm_data to
> > simplify the reset, and make sure we don't miss any.
> 
> Do you mind checking if, before this patch, we didn't already miss
> the
> reset of some fields? (I think I quickly checked last time and
> everything was reset here, or a bit later (e.g. server_side). If we

Yes, I did check this, and nothing is missing.

> missed something, we will need a dedicated patch reseting the missing
> fields first, with a Fixes tag, for -net, then this patch using
> 'struct_group' to ease the reset.
> 
> > Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm.c       | 14 +-------------
> >  net/mptcp/protocol.h |  4 ++++
> >  2 files changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index eefed554dcc9..1400bfed4b0d 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -983,12 +983,7 @@ void mptcp_pm_data_reset(struct mptcp_sock
> > *msk)
> >  	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock
> > *)msk));
> >  	struct mptcp_pm_data *pm = &msk->pm;
> >  
> > -	pm->add_addr_signaled = 0;
> > -	pm->add_addr_accepted = 0;
> > -	pm->local_addr_used = 0;
> > -	pm->subflows = 0;
> > -	pm->rm_list_tx.nr = 0;
> > -	pm->rm_list_rx.nr = 0;
> 
> Just to be sure, is it OK to reset the list with memset(0)? (I didn't
> check)

I kept this unchanged in v11.

> 
> > +	memset(&pm->reset, 0, sizeof(pm->reset));
> >  	WRITE_ONCE(pm->pm_type, pm_type);
> >  
> >  	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> > @@ -1005,15 +1000,8 @@ void mptcp_pm_data_reset(struct mptcp_sock
> > *msk)
> >  			   !!mptcp_pm_get_add_addr_accept_max(msk)
> > &&
> >  			   subflows_allowed);
> >  		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> > -	} else {
> > -		WRITE_ONCE(pm->work_pending, 0);
> > -		WRITE_ONCE(pm->accept_addr, 0);
> > -		WRITE_ONCE(pm->accept_subflow, 0);
> >  	}
> >  
> > -	WRITE_ONCE(pm->addr_signal, 0);
> > -	WRITE_ONCE(pm->remote_deny_join_id0, false);
> > -	pm->status = 0;
> >  	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID +
> > 1);
> >  }
> >  
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 0ef758d233b7..47710db243f4 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -223,6 +223,8 @@ struct mptcp_pm_data {
> >  
> >  	spinlock_t	lock;		/*protects the whole PM
> > data */
> >  
> > +	struct_group(reset,
> > +
> >  	u8		addr_signal;
> >  	bool		server_side;
> >  	bool		work_pending;
> > @@ -238,6 +240,8 @@ struct mptcp_pm_data {
> >  	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 
> Maybe better to move this bitmap after the reset group, because it is
> large, and it will be overwritten with 1 just after the reset.

I agree. I moved this, together with rm_list_tx and rm_list_rx, after
the reset group in v11.

Thanks,
-Geliang

> 
> >  	struct mptcp_rm_list rm_list_tx;
> >  	struct mptcp_rm_list rm_list_rx;
> > +
> > +	);
> >  };
> >  
> >  struct mptcp_pm_local {
> Cheers,
> Matt

