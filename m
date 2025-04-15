Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A832DFA41
	for <mptcp@lists.linux.dev>; Tue, 15 Apr 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686614; cv=none; b=UqJq6efFqZp/wb688PJkBSUcmYrT9i8t+RTL4C9FosQSZPZAIggCgUKUCieVWvoFYPFGH+BUnGbmPhPeV4jtESitRLdfdWYHb3rLZdDH9tekuygVjp/ZcVpC08XPGo+bYJOODJlphhvETzimnrXjer12HHt7ZVH7KtAmPqvYOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686614; c=relaxed/simple;
	bh=F3xhAxFD9Baf8avLx1inXi9pOCc3SA1ojRg4mFnJ72w=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qmOf8VfrrtbVM60/q/aGc929BIsEV1qn5UtixSmdEDcNLDagk6E1aQmquBRDKw/GS/E6EEFzI83Htho1kkP1jrnqNpdGguDWNsg/sbItVWY9rOvFMFZ/oCxzv7vzHWXTQVjRxIxfTrp5BLEAe/+CCqhTeiJw5+k82v5qQJCQ8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XodW/Y1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XodW/Y1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8A1C4CEE2;
	Tue, 15 Apr 2025 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744686613;
	bh=F3xhAxFD9Baf8avLx1inXi9pOCc3SA1ojRg4mFnJ72w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=XodW/Y1C5ibyh85RzdfcUXnH2VcCJqS+k3XkbDw7cpTPb+cRb7lfetgTwiImfyrSH
	 AsVeXsGe2WHEqkAab4MQXq3k71AIFpe4KfsVl+hIAMXVpC6utWAbCCPb6jej2GxV0W
	 QErw/XxGfKdCqu4BAbVx8OIkduBXIbUTnKhonaAZxUkU5SMyTkKwaobW8ktw8hYJxl
	 iaXtGXBBUfEzNYExMygPJlRm0/Zlc1vMKVuP1bHW0Dl9jPcKiC8LX878s7pRU3ROco
	 /iStiP9a+o4gquQCnEIXpihjnmKH7s0dywj6itOF6VJ6QhNw3JSS7kS7o+B79rFDsk
	 4cXeXWoNwafhQ==
Message-ID: <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop
 delete_local_addr helper
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
In-Reply-To: <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
	 <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
	 <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Apr 2025 11:09:56 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1 
Content-Transfer-Encoding: 8bit

Hi Mat, Matt,

On Fri, 2025-04-11 at 17:26 -0700, Mat Martineau wrote:
> On Thu, 10 Apr 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Address entries should not be removed from local_addr_list when a
> > subflow
> > is deleted by the userspace PM, should only be removed when sending
> > a
> > REMOVE_ADDR.
> > 
> > So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
> > called in
> > mptcp_pm_nl_subflow_create_doit() and
> > mptcp_pm_nl_subflow_destroy_doit().
> > 
> > Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it
> > can be
> > dropped now.
> > 
> > Address entries are removed from local_addr_list when sending a
> > REMOVE_ADDR
> > by the userspace PM, the local_addr_used counter of PM should also
> > be
> > decremented accordingly.
> > 
> 
> Hi Geliang -
> 
> Have you tried this patch with mptcpd? Does it affect any tests
> there?

I haven't tested it. To be honest, I don't know how to run the test
items of mptcpd. Can you give me some guidance?

Thanks,
-Geliang

> 
> 
> - Mat
> 
> 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/pm_userspace.c | 37 +++++--------------------------------
> > 1 file changed, 5 insertions(+), 32 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 7fc19b844384..3824b4165421 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -90,30 +90,6 @@ static int
> > mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> > 	return ret;
> > }
> > 
> > -/* If the subflow is closed from the other peer (not via a
> > - * subflow destroy command then), we want to keep the entry
> > - * not to assign the same ID to another address and to be
> > - * able to send RM_ADDR after the removal of the subflow.
> > - */
> > -static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock
> > *msk,
> > -						struct
> > mptcp_pm_addr_entry *addr)
> > -{
> > -	struct sock *sk = (struct sock *)msk;
> > -	struct mptcp_pm_addr_entry *entry;
> > -
> > -	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
> > -	if (!entry)
> > -		return -EINVAL;
> > -
> > -	/* TODO: a refcount is needed because the entry can
> > -	 * be used multiple times (e.g. fullmesh mode).
> > -	 */
> > -	list_del_rcu(&entry->list);
> > -	sock_kfree_s(sk, entry, sizeof(*entry));
> > -	msk->pm.local_addr_used--;
> > -	return 0;
> > -}
> > -
> > static struct mptcp_pm_addr_entry *
> > mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk,
> > unsigned int id)
> > {
> > @@ -331,6 +307,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff
> > *skb, struct genl_info *info)
> > 	}
> > 
> > 	list_del_rcu(&match->list);
> > +	msk->pm.local_addr_used--;
> > 	spin_unlock_bh(&msk->pm.lock);
> > 
> > 	mptcp_pm_remove_addr_entry(msk, match);
> > @@ -408,14 +385,13 @@ int mptcp_pm_nl_subflow_create_doit(struct
> > sk_buff *skb, struct genl_info *info)
> > 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> > 	release_sock(sk);
> > 
> > -	if (err)
> > +	if (err) {
> > 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d",
> > err);
> > +		goto create_err;
> > +	}
> > 
> > 	spin_lock_bh(&msk->pm.lock);
> > -	if (err)
> > -		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> > -	else
> > -		msk->pm.subflows++;
> > +	msk->pm.subflows++;
> > 	spin_unlock_bh(&msk->pm.lock);
> > 
> >  create_err:
> > @@ -534,9 +510,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> > sk_buff *skb, struct genl_info *info
> > 		goto release_sock;
> > 	}
> > 
> > -	spin_lock_bh(&msk->pm.lock);
> > -	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> > -	spin_unlock_bh(&msk->pm.lock);
> > 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> > SEND_SHUTDOWN);
> > 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> > 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> > -- 
> > 2.43.0
> > 
> > 
> > 

