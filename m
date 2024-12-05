Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBED7E0FF
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383805; cv=none; b=fT/cekoAP8meL2rezy9S8lgRi7HeC9vkxd4JMJBq7cFUy9/tJfiUsRTWM7/b5Cw2lWb0jEnF3laYMyCHkNsd6j3yz5boDk4yj+CcNt6LRMwLbZZWCktR4YnRYs5o6spyv0gBQHNHukVqYEQiFJLFBYiCvNRjm23814g4SoWc3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383805; c=relaxed/simple;
	bh=/8Zs+DTe0xTKSeb6Ur1N4yHlNjk34e7h/VfMMEZ6Fbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHyLLgLXS9QxbfJgrBMNuaxDhyMosdER9y2WYV1BpIliTEJb8XO+h376ntyAp+MfppT8VjHZXuDbUF3C8wJRhVB7T5RmggnIjy2NGvRxgN9CPZlLcu+roZENE0Qbtxkf5WP5G73+hvNuJnBysItNdRonJh7A+wgyAe5oTSuJVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsV+gNFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsV+gNFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A58C4CED1;
	Thu,  5 Dec 2024 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383804;
	bh=/8Zs+DTe0xTKSeb6Ur1N4yHlNjk34e7h/VfMMEZ6Fbs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VsV+gNFoShp/Q8E3CS/FBMpwmaVd+7lTWRnLNhHd1xJNhgz1BVtcwhkEQuW4KYXgE
	 EcRWYfaUxgPWGewOUofa4FOU5msaSH6IuyjlrUTpC8QdcOV/288xGWAwQobkBHyAfe
	 so8ehccVqn2UB/riazXfKvx5hvs+0/jgNLPH0ua5aU/ImKiS7sVrYsgVRi5zB9bfYA
	 8qtTtVAy5IuLjNxe2uivcJhmz1gtSgS2anAbXD6FFlSnN1h/PH8ZO8gsRy6hkqoCb8
	 MB3jWXlP50NuWJofjoPPF9BewHgC3+DcjsWJ328uUx24TqhBIp3++O+Fm/ixJp4u16
	 5LmEowYRgP3Pg==
Message-ID: <068c58b2652b39a95ea72ce0b58b1c30741ffdc5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 9/9] mptcp: drop useless "err = 0" in
 subflow_destroy
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 05 Dec 2024 15:30:01 +0800
In-Reply-To: <8ae81fdd-e402-4514-a446-0989bd49c32d@kernel.org>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
	 <6606e2c5b8b3536cad35baf722175a932242d820.1730961810.git.tanggeliang@kylinos.cn>
	 <8ae81fdd-e402-4514-a446-0989bd49c32d@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-04 at 18:49 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/11/2024 07:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Upon successful return, mptcp_pm_parse_addr() returns 0. There is
> > no need
> > to set "err = 0" after this. So after mptcp_nl_find_ssk() returns,
> > just
> > need to set "err = -ESRCH", then release and free msk socket if it
> > returns
> > NULL.
> > 
> > Also, no need to define the veriable "subflow" in
> > subflow_destroy(), use
> > mptcp_subflow_ctx(ssk) directly.
> > 
> > This patch doesn't change the behaviour of the code, just
> > refactoring.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_userspace.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 07e0c7259494..8545212f023e 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -535,19 +535,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> > sk_buff *skb, struct genl_info *info
> >  
> >  	lock_sock(sk);
> >  	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
> > -	if (ssk) {
> > -		struct mptcp_subflow_context *subflow =
> > mptcp_subflow_ctx(ssk);
> > -
> > -		spin_lock_bh(&msk->pm.lock);
> > -		mptcp_userspace_pm_delete_local_addr(msk,
> > &addr_l);
> > -		spin_unlock_bh(&msk->pm.lock);
> > -		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> > SEND_SHUTDOWN);
> > -		mptcp_close_ssk(sk, ssk, subflow);
> > -		MPTCP_INC_STATS(sock_net(sk),
> > MPTCP_MIB_RMSUBFLOW);
> > -		err = 0;
> 
> OK to drop 'err = 0' but...
> 
> > -	} else {
> > +	if (!ssk) {
> >  		err = -ESRCH;
> > +		release_sock(sk);
> > +		goto destroy_err;
> 
> ... I think it is always best to reduce the number of exit path: so
> here, I think it is best to add a new label before release_sock(sk)
> below, instead of duplicating this release_sock(sk). Something like:
> 
>       ssk = mptcp_nl_find_ssk(...);
>       if (!ssk) {
>           err = -ESRCH;
>           goto release_sock;
>       }
> 
>       (...)
> 
>   release_sock:
>       release_sock(sk);
> 
>   destroy_err:
>       (...)
> 
> WDYT?

I agree. Updated in v4.

Thanks,
-Geliang

> 
> >  	}
> > +
> > +	spin_lock_bh(&msk->pm.lock);
> > +	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> > +	spin_unlock_bh(&msk->pm.lock);
> > +	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> > SEND_SHUTDOWN);
> > +	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> > +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> >  	release_sock(sk);
> >  
> >  destroy_err:
> 
> Cheers,
> Matt

