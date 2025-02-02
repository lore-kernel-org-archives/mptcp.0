Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B4320B
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738471549; cv=none; b=rFHZi2xmbMu3GnytpUl65YBy24ujpcspfqlu3kEY+4JJ53KIfFfoSp1xko7CQfC654j4HENDcwOYhlWpwVQm0zvDprCToXEpKl0exXESNkwH5dpYAiPv/1r/IwRMQmYizW7N7JESnH4+rX2TwOUtugFKzpv16uE5QeJqjk4JY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738471549; c=relaxed/simple;
	bh=l2e0HfxY3zNtrJjuowbdkB44FtCo2UIfeTyb4C9Krto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEhClPauI8faUuBTStlMHoqWRdaVcqMIZjtKKzNalldHfgqcTJVG9n6eeZ4d1ncd757R/gOHV0RPnQnuOHkFTXkhoPDQeRO5BH/Mrl03W5dDvq+PKiR7Y6r0oFb67l61nbrahi8e3/+tVHzFRTCKoMC8YWu2kYP2haIwg3+pc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsWAUEh5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsWAUEh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D19C4CEE3;
	Sun,  2 Feb 2025 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738471548;
	bh=l2e0HfxY3zNtrJjuowbdkB44FtCo2UIfeTyb4C9Krto=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NsWAUEh5ZKwmp/zhObCYC0A+BblffmVPxBeUyiAGuCGBE4pXUYkfNKjvD4XR7MrJm
	 RbIuPXKrj8gSUx2b6NseDa+cN8XLE97IcgS5CZb9nKDna2lYbM2TNaNbmPvAGbmnV+
	 zYcQSTJTSp6QlcKgIkPgZ/XRbYN4oLBFjsfLHSpDAGPHwFEufDd0wWTTjgrmJLoDM4
	 GVKu4rxTPXVSpV+F4xKeryCvHWgCkwUHd0VHe+GZWYfU4kmAK9G0K+sZQDhcaHlko4
	 FdNAyZFRVuQx3Vm9rFkCU/rFDqbd6VeH9x+Ufvsd+HzYnEDEbFUgNXUlMQ0kXwimz/
	 +DuRFX+prSWmw==
Message-ID: <b1d1d11d0a1ed7f74da57f67a62b6002b7eedaa6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 02 Feb 2025 12:45:45 +0800
In-Reply-To: <a3547871-55f1-a9d5-cc63-c25a103ef63a@kernel.org>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
	 <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
	 <a3547871-55f1-a9d5-cc63-c25a103ef63a@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
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

Thanks for your review.

On Wed, 2025-01-29 at 12:49 -0800, Mat Martineau wrote:
> On Fri, 24 Jan 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop the NULL check as Martin suggested.
> > 
> > Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
> > the
> > argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
> > 
> > Use msk_owned_by_me().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/bpf.c | 15 +++++++++------
> > 1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 923895322b2c..def4de34666d 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -234,24 +234,27 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
> > 
> > __bpf_kfunc static int
> > bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> > -			   struct mptcp_sock *msk)
> > +			   struct sock *sk)
> > {
> > 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > -	struct sock *sk = (struct sock *)msk;
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
> > +	kit->msk = msk;
> > +
> > +	msk_owned_by_me(msk);
> 
> Hi Geliang -
> 
> The convention is to check the owner before assigning the msk.

Yes, indeed. Updated in v2.

> 
> I also noticed in the reply to patch 5 that Martin mentioned adding a
> "bpf_mptcp_sock_from_sock check" to bpf_iter_mptcp_subflow_new

bpf_mptcp_sock_from_sock should be dropped, so open-code it in
bpf_iter_mptcp_subflow_new.

Thanks,
-Geliang

>  
> (
> https://lore.kernel.org/netdev/9b373a23-c093-42d8-b4ae-99f2e62e7681@li
> nux.dev/)
> 
> - Mat
> 
> > +
> > 	kit->pos = &msk->conn_list;
> > 	return 0;
> > }
> > -- 
> > 2.43.0
> > 
> > 
> > 

