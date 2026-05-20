Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002033AD9D
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282295; cv=none; b=dvHwsrXnkZjcTKg3nI9Pf/mseYnxkX+vyoQkOXHeZMvuGxhHV9aklx7vj5Mkvocug4HHtjIQZr4f213L/35vKxJvymP/sWg03Spw7E+KWwg7MZQLwN1YaCa/dqhoUOB4zCxfnOTrYLK24qx1Sk6V2vElFyoQz5WQL54A8DP+fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282295; c=relaxed/simple;
	bh=Vr5lFF97fUgn+q6Ig/VBNPzjdBZ/9d6sjZNYIm3DjPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAIo9Da639r3OjqMa6gePbB92rfg3mnoc4J6exp2T9Z2Ne3wseUvFhnNUHa8L4ief/y55KMJjKBTPQ7u8un2t3C9FvpEdNGID9fV+yaZFeBtlPWXKXjhb5rBPK/Kxie44cMmHK4RZttjYbvo44vy6l+xfEKDLHUvP0EXN3y2aMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npt+NN48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npt+NN48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95FA1F000E9;
	Wed, 20 May 2026 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282291;
	bh=w0mFT9kHadYrP1Yk8LK41qqYVr5l+cqRC46UQZpsGl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Npt+NN48veGxNGmDCV52YnrCmIBfVAEg+KVNW0RdxvtDuVNX7jJGwkNof3MUoX/Kt
	 MaQYi8xD9Coo2l4YZzV+m2h1Yly8A4wP32iukKhqOadgwKpJppIW8ylpZMSAFqPsGH
	 QF/9LTsNJZwS2J2qCfaD3qwcF0QLRIItkCfo3HW61v2ZX+onUIDQ6UjrujkC9fDwEY
	 LJ8tg/aTtuhFPcZCJqz2FF+E/+5+SSsVGGNtwHAZCo4OS8auHzasIb845Vx+nP4DQT
	 zX08qmyfGaUpNjUMzu4jktR5dDZ0Ignnb7MxZihYg4EhAnVpE9QCHetBGhvdG86h8v
	 DJBrgB0GgWOqA==
Message-ID: <5226f432-930e-463b-97db-95e687b2396e@kernel.org>
Date: Wed, 20 May 2026 23:04:48 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: pm: fix extra_subflows leak on
 userspace PM subflow close race
Content-Language: fr
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
References: <20260514132925.410184-1-cuitao@kylinos.cn>
 <20260514132925.410184-3-cuitao@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260514132925.410184-3-cuitao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao,

(only kept MPTCP ML in Cc)

On 14/05/2026 23:29, Tao Cui wrote:
> In the userspace PM subflow creation path, extra_subflows is incremented
> after release_sock(sk). If a TCP RST arrives for the newly created
> subflow, mptcp_worker can acquire the socket lock during the gap between
> release_sock(sk) and the subsequent spin_lock_bh(&msk->pm.lock), close
> the subflow via mptcp_pm_subflow_check_next(), and decrement the counter
> before it was incremented -- causing a u8 underflow from 0 to 255.
> 
> Move extra_subflows++ into the lock_sock(sk) section, before
> release_sock(sk), so that the worker always sees a non-zero counter and
> decrements correctly. This also eliminates the transient underflow window
> visible to lockless readers (e.g. sosockopt READ_ONCE).
> 
> Additionally, add an underflow guard in mptcp_pm_subflow_check_next() as
> a safety net for other edge cases.

A Fixes tag is also needed if this is a fix.

(...)

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3c152bf66cd5..a83a56b467f9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -655,7 +655,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  	if (mptcp_pm_is_userspace(msk)) {
>  		if (update_subflows) {
>  			spin_lock_bh(&pm->lock);
> -			pm->extra_subflows--;
> +			if (pm->extra_subflows)

Best not to ignore errors here: use a WARN_ON_ONCE() then.

  if (!WARN_ON_ONCE(pm->extra_subflows == 0))

Also, probably best to do the same in protocol.h, the other place where
extra_subflows is decremented. Then, move that to a dedicated patch that
can be applied in -next.

> +				pm->extra_subflows--;
>  			spin_unlock_bh(&pm->lock);
>  		}
>  		return;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8cbc1920afb4..61c10ec00be0 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -410,6 +410,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	lock_sock(sk);
>  	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> +	if (!err) {

See my previous comment on the previous patch: do it before calling
__mptcp_subflow_connect(), unconditionally.

> +		spin_lock_bh(&msk->pm.lock);
> +		msk->pm.extra_subflows++;
> +		spin_unlock_bh(&msk->pm.lock);
> +	}
>  	release_sock(sk);
>  
>  	if (err)
> @@ -418,8 +423,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  	if (err)
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> -	else
> -		msk->pm.extra_subflows++;

Here, if only mptcp_userspace_pm_delete_local_addr() is called in case
of error, best to have the spin_lock_bh taken only in case of error. You
can merge everything with the previous condition:

  if (err) {
      GENL_SET_ERR_MSG_FMT(...);
      spin_lock_bh(...);
      mptcp_userspace_pm_delete_local_addr(...);
      spin_unlock_bh(...);
  }

>  	spin_unlock_bh(&msk->pm.lock);
>  
>   create_err:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

