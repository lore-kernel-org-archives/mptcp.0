Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4021A435
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182133; cv=none; b=pugdytxU7CuzeSFPKVLadUghaqRqFbkcaKA2dDUDqksCZ8r3dmBvaMF1BeD8lFoGSitqwV8XHGn2f45nDgXWjKk3djs2riQrTU0zc+Cs0fSj+vjb6S3LkxhbN3C9pcmjDbDtSc2JS1ZJZvHGoL8j8Q8R0E9kesbW4uzvtmz/4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182133; c=relaxed/simple;
	bh=6NNWPka8aejJFqoWJtLYoDmq1ElI8ZlJ3OWX09+x2XE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9btcp5EoDBMNNfhpP8bxMuLbfH7hQI9V8VssVeQFwIjuHl8d/2Am2++5PjLH5c/XMZhgJJSm13FCuM8PjftC3MOJ38tOXAcATQeKprd88bzmPe0qvLp3tAQObO4TEHXDOEx56jiq4u+sbglRAfUjqkpx5/1bdZYGi25XPWvo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvhUBzjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvhUBzjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C710FC4CEE7;
	Wed,  9 Apr 2025 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744182133;
	bh=6NNWPka8aejJFqoWJtLYoDmq1ElI8ZlJ3OWX09+x2XE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MvhUBzjM4P5Dx7N+SYVU4c+EA+OSQYdeG1Nu5QKgHv3HUjx56FNyt/UUtC00Sl56a
	 SHeEA3LVQXosYgmE2Xi7GWu35fQb+bSa35kXkE/fF+JWb1PdudVvVYuNaD4QbE7t7a
	 WbM2chIxeDPY2oSzC6Bz5Q9NE8cfHIktTWNgm67PdILAZ6u7UqSKhP8+0Aj5ZyYxM5
	 dQjxPXdNAADsgMbTIxa1PmUeu6eUYoqS4RqWzBMqAHKUNDYB5YpqIhOP3BB1xJhBL+
	 wOldr7x/4Pxikir7He5VLJ0vVfYVBa4qhuo5or8cmG/MaTt+9PjsU+Vqnc7zusA02u
	 Zhi5VNM8GDuBA==
Message-ID: <4242d065ef94a08694cf76658e74b841eb9939ed.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 09 Apr 2025 15:02:08 +0800
In-Reply-To: <a132ad93-029a-f083-d140-59929b4c4dc7@kernel.org>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
	 <a132ad93-029a-f083-d140-59929b4c4dc7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat,

On Tue, 2025-04-08 at 17:23 -0700, Mat Martineau wrote:
> On Wed, 2 Apr 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
> 
> Geliang and Matthieu -
> 
> Since this is a bug fix, should it go to mptcp-net rather than -next?
> Or 
> does the associated selftest change make that complicated?
> 
> I think there's a nearby bug in mptcp_pm_nl_remove_doit() that I
> noticed 
> while reviewing this series. If we upstream this series to the net
> tree it 
> might make sense to send the fixes together.
> 
> In this code:
> 
>  	list_del_rcu(&match->list);
>  	msk->pm.local_addr_used--;
>  	spin_unlock_bh(&msk->pm.lock);
> 
>  	mptcp_pm_remove_addr_entry(msk, match);
> 
>  	release_sock(sk);
> 
>  	sock_kfree_s(sk, match, sizeof(*match));
> 
> The struct is removed from a linked list with list_del_rcu(), but
> doesn't 
> wait for a grace period before the sock_kfree_s() in the final line.
> The 
> easy solution is to make the kfree rcu-aware and open-code the
> handling of 
> sk_omem_alloc, like this:
> 
>  	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
>  	kfree_rcu(match);

How about adding a new helper sock_kfree_rcu_s() here?

> 
> instead of calling sock_kfree_s(). tcp_md5_do_del() takes this
> approach. 
> This does allow possible allocation beyond the optmem limit, but only
> for 
> the duration of the rcu grace period.
> 
> I can send a patch tomorrow, unless someone wants to implement it
> before 

Great! Looking forward to your patch.

Thanks,
-Geliang

> then.
> 
> 
> - Mat
> 
> 
> > 
> > Geliang Tang (3):
> >  mptcp: pm: userspace: local_addr_used-- after sending REMOVE_ADDR
> >  mptcp: pm: userspace: drop delete_local_addr helper
> >  selftests: mptcp: send REMOVE_ADDR after subflow is deleted
> > 
> > net/mptcp/pm_userspace.c                      | 37 +++-------------
> > ---
> > .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
> > .../selftests/net/mptcp/userspace_pm.sh       |  6 +++
> > 3 files changed, 14 insertions(+), 33 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> > 
> > 

