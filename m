Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82456B81
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319652; cv=none; b=ovOSndTP6Y+z0X4b8m3xy/jYJhkcX/W2WJiTgio1O+gHfT5i6d9yMXd75hzHjtGZ+Z9dN9wdOVMYdebcNoldSxREzUAevejsbsB2+KKUZHyJ4pD+yZI/VD7RRZP/xi2vw+rQFhri+X+xUkDAp/oxD9dY1O6vg/aTN7I7NDDofRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319652; c=relaxed/simple;
	bh=MMrXTXDSii7GtOH9KGxm3gYO2JlDAtgQkBnFGF9nel0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jN2ebKaMMh4JzxDrldyqwuaVaFk23O2LPmhAsWqJy/khbFFzyUKqpZwhUJ6PsAcJNNyDe/OwYMrNgUMqekPwcsFBegJphCrR16h6dZa9Jp3lADlVIW6ppq74hoC7KR2k6HKZimDNkJ6G2RfaXFYbrGomvuZCtx1ndR5pHbjSPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsSB4/QQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsSB4/QQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC16C4CEE2;
	Fri,  7 Mar 2025 03:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741319652;
	bh=MMrXTXDSii7GtOH9KGxm3gYO2JlDAtgQkBnFGF9nel0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HsSB4/QQwp1e5WwTi2fsDe6LpWm3reTkIU6F1WheLRTfNBpKJwdBj/1oESgO5rOyM
	 vmYZDR0F+8y353YxS/28O13jbefaOYMC5v5HqA48Ioy9hdnHCYUZeNR3XrvqNQ7mcG
	 xfpabdF9IV1eAau9Mabl4Pcsg9xh+S21R6u76rTE1eoNKOluXwkF8RdneeKPTVJVCk
	 Py/ey/NPNA6P+7r9w41STtdlhBzVMBmr5Tov2Brqz9vGEpY9aUYE0gaIfEd3Uc+oVv
	 zWd1ZrdJ2Bnxm1ooUPvtRyBAx/IzoA7XNu+59aFolw9KrHFQUk49m+5RWF5s6lIfeT
	 1zhzMHu0k+2iw==
Message-ID: <b421949c3a5f111ad34d07f552be73c9f1388b9f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 3/5] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 07 Mar 2025 11:54:08 +0800
In-Reply-To: <c15a5390-a721-0d65-9b00-e9d1d02367de@kernel.org>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
	 <f8d59dcb8391483787f832ddb43035846055aafb.1740997925.git.tanggeliang@kylinos.cn>
	 <c15a5390-a721-0d65-9b00-e9d1d02367de@kernel.org>
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

Thanks for the review.

On Mon, 2025-03-03 at 17:39 -0800, Mat Martineau wrote:
> On Mon, 3 Mar 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop the NULL check for 'msk' as Martin suggested, add more checks
> > for 'sk'.
> > 
> > Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
> > the
> > argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
> > 
> > v5:
> > - check bpf_iter_task in mptcp_subflow_new()
> > 
> > v4:
> > - drop sock_owned_by_user_nocheck and spin_is_locked. According to
> >   comments from Mat [2] and Martin [1], in this set mptcp_subflow
> >   bpf_iter only used from a cg sockopt bpf prog, no need to add
> > these
> >   check at this moment.
> > 
> > [1]
> > https://lore.kernel.org/all/fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev/
> > [2]
> > https://patchwork.kernel.org/project/mptcp/patch/f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn/
> > 
> > v3:
> > - continue to use sock_owned_by_user_nocheck and spin_is_locked
> > checks instead of using msk_owned_by_me().
> > 
> > v2:
> > - check the owner before assigning the msk as Mat suggested.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/bpf.c | 21 +++++++++++++++------
> > 1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index aff92f458e7f..a307490bb20e 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -249,24 +249,33 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
> > 
> > __bpf_kfunc static int
> > bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> > -			   struct mptcp_sock *msk)
> > +			   struct sock *sk)
> > {
> > 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > -	struct sock *sk = (struct sock *)msk;
> > +	struct task_struct *task;
> > +	struct mptcp_sock *msk;
> > 
> > 	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
> > 		     sizeof(struct bpf_iter_mptcp_subflow));
> > 	BUILD_BUG_ON(__alignof__(struct
> > bpf_iter_mptcp_subflow_kern) !=
> > 		     __alignof__(struct bpf_iter_mptcp_subflow));
> > 
> > -	kit->msk = msk;
> > -	if (!msk)
> > +	if (unlikely(!sk || !sk_fullsock(sk)))
> > 		return -EINVAL;
> > 
> > -	if (!sock_owned_by_user_nocheck(sk) &&
> > -	    !spin_is_locked(&sk->sk_lock.slock))
> > +	if (sk->sk_protocol != IPPROTO_MPTCP)
> > 		return -EINVAL;
> > 
> > +	msk = mptcp_sk(sk);
> > +	task = mptcp_get_bpf_iter_task(msk);
> > +	if (!task || task != current)
> > +		return -EINVAL;
> 
> Hi Geliang -
> 
> The task checking logic would fit better inside the helper, since
> every 
> caller will be checking to see if it matches 'current'.
> 
> I also think it would read better as (task && task == current)

Yes, indeed.

> 
> 
> > +
> > +	mptcp_clear_bpf_iter_task(msk);
> 
> This needs to be cleared where the lock is released, not where the
> task is 
> checked.

Yes, indeed, I'll do that in the next version.

Thanks,
-Geliang

> 
> - Mat
> 
> > +
> > +	msk_owned_by_me(msk);
> > +
> > +	kit->msk = msk;
> > 	kit->pos = &msk->conn_list;
> > 	return 0;
> > }
> > -- 
> > 2.43.0
> > 
> > 
> > 

