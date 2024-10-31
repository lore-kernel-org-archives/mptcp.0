Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B714AD29
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360588; cv=none; b=Izh1ObMPXn3iRfUPnfME5B6ay+Cr6wFjYtsqBZoMQABjDSW/PN9IDCrHxPa3XR4GtkTA9OWlPHpe5kaZzALju1lhwR5KlKaW2qVgihEaJi1IT7bAHKUTWf/5pF7jsDVw4+rE+e/2xSK4aN04hVx+lfqD1EigNHeX6wma2yfTx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360588; c=relaxed/simple;
	bh=4idSFVIXGeZnzXY8TAOl1U9ozTXt47Gf3SINqwEXIx8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPBEapH/gnxWRfW+SjI6CQ3Kuv32y8+GqwcmSy9bpWwV7LE6DbPIuYg9+ZlxXQS6vr8Q0fNlji06MQRquOb67XZ5cIougN3jM7/rqmP5rmaNz6phkOJrlyLuBaL8K9rkciJJYRGnWuNosucc2Gkvj2KXac8/lfsf12VmZY7/7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxOwegmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxOwegmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8838C4CEC3;
	Thu, 31 Oct 2024 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360588;
	bh=4idSFVIXGeZnzXY8TAOl1U9ozTXt47Gf3SINqwEXIx8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bxOwegmC+u7kR/A5XK+FunO2yzY/HzzuIH4hba3ZKk0IjjBg3m/iteWYazGAjhMrN
	 z6NY/tonbEEV3jY1iaJ3cXAo0WMdMfdkieQ7ED9pXvkVHb/dQoYrWaZuL7XeN7o6Q3
	 tEo7XusDSeNOmNXRbGb/CeUzDfGG7XkuN2ZuzIB+dSDj8kWUYsrsgXayFi1X8XWyCj
	 M+m1gKi4onUEI0875MKs52HuX/s3gUiWznWV6YsfoMHcQHgYUxSwG0iqd9v37lLa9u
	 +FPwXqzTEP7BjBan+cRYm5SjN7jJ5lJ2Ls/Wz8uP7wwUNLmYulfj6Tk9k/4Y3W/ElU
	 YeGy0bSemRFiQ==
Message-ID: <c08bac5660266af7adaf0f1f2d225320cbf99753.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 04/36] mptcp: use sock_kfree_s instead of
 kfree
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 31 Oct 2024 15:43:03 +0800
In-Reply-To: <705f9119-8570-4f5c-a0c5-7be55f1ca1c7@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <a42d735295ec53ca466b7c274e6d1c465010d960.1729588019.git.tanggeliang@kylinos.cn>
	 <705f9119-8570-4f5c-a0c5-7be55f1ca1c7@kernel.org>
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

Hi Matt,

Thanks for your review.

On Wed, 2024-10-30 at 19:21 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The local address entries on the userspace_pm_local_addr_list are
> > allocated
> > by sock_kmalloc(). It's better to use sock_kfree_s() to free them,
> > instead
> 
> Good catch! Do you mind developing a bit why "it is better to use
> sock_kfree_s()"?
> 
> To me, it looks like a bug fix: we should use sock_kfree_s() to
> adjust
> the allocated size. In this case, a 'Fixes' tag should be added, and
> target mptcp-net. WDYT?

I'll send a v2 of this patch alone out of "BPF path manager" set to our
ML, with "mptcp-net" prefix and "Fixes" tag, and update the commit log
too.

-Geliang

> 
> > of using kfree().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_userspace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 00a7f9dd90cf..3fb5713cd988 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -91,6 +91,7 @@ static int
> > mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> >  						struct
> > mptcp_pm_addr_entry *addr)
> >  {
> >  	struct mptcp_pm_addr_entry *entry, *tmp;
> > +	struct sock *sk = (struct sock *)msk;
> >  
> >  	mptcp_for_each_address_safe(msk, entry, tmp) {
> >  		if (mptcp_addresses_equal(&entry->addr, &addr-
> > >addr, false)) {
> > @@ -98,7 +99,7 @@ static int
> > mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> >  			 * be used multiple times (e.g. fullmesh
> > mode).
> >  			 */
> >  			list_del_rcu(&entry->list);
> > -			kfree(entry);
> > +			sock_kfree_s(sk, entry, sizeof(*entry));
> >  			msk->pm.local_addr_used--;
> >  			return 0;
> >  		}
> 
> Cheers,
> Matt

