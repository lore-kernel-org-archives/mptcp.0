Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8211D47C7
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853241; cv=none; b=T1U0FSwC5isScOi+jHp8Vm2gApiS056LMUhTfWnIlVVtCgzvZZ8XlePqkxgxuceRzutv2ChkZWZIqgT165tE3XWTXB6NxzjPe8DffKY381FpGuI9MgQF3J/pJMyID519kru2s+oK9tlXSCRKcMjG4J1Iefccr0FG8MP9mRJDtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853241; c=relaxed/simple;
	bh=TAB7Crq6hpkeIQgo48SrnderZmX7JLE6o/ZrqYpfVl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aucdbv2C2l7PmlZXrbGeLxke8TQ4qS8iPykJTOUJVgTD/52bUBAPK9lIbclQDaSCNzqQTLxYO9LxWe42cCbZNHu30bpkThXwUcSwlIiajBt1KsT+TTzIOPT4+T155YGt9kz0WpnAhU3qSZ8/TnvAkquVNrPOe1J71BJHhseONbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL0uBZw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL0uBZw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D92C4CEC3;
	Fri, 25 Oct 2024 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729853241;
	bh=TAB7Crq6hpkeIQgo48SrnderZmX7JLE6o/ZrqYpfVl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JL0uBZw5iHum2YMP5MZ3B55HPGHi9GUR7S6grEp0DcLqblRM9iNE1weUiPhpGIu34
	 TQSVq8bpjRVAQdGAmVL+ZGnJJm17UpaPajih3pbZjYx1eSEKwq/P4WLSgBL8mKDe3T
	 KxfwupvzLTM/ZDQHQDnyyezXAbowIAosnakvATiAoGypguijCFU0+7CTA2Swk6BqtW
	 69C6iTvJItKoo7yUo0bQskIn8SM118SKn6tIprUMHxfRNTtn3H1DjwD7O9N6mK03iR
	 YHOW1pvPw7UekfkdwOxr8xTLx7BQDzKTXNAIh8rTPsxLI508Wq7PKbmLcMErftf9ad
	 DWQCs3za0oHMQ==
Message-ID: <7e60e4ce41620c58c79c916d3480d2cf46f82834.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 3/3] mptcp: pm: avoid code duplication to
 lookup endp
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 25 Oct 2024 18:47:17 +0800
In-Reply-To: <42e959952d1a9a15e19e51bd17b129d1938364c5.camel@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
		 <20241025-mptcp-pm-lookup_addr_rcu-v2-3-1478f6c4b205@kernel.org>
	 <42e959952d1a9a15e19e51bd17b129d1938364c5.camel@kernel.org>
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

On Fri, 2024-10-25 at 18:37 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0) wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The helper __lookup_addr_rcu() can be used in
> > mptcp_pm_nl_get_local_id()
> > and mptcp_pm_nl_is_backup() to simplify the code, and avoid code
> > duplication.
> > 
> > Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > Notes:
> >  - This is also for -next.
> > ---
> >  net/mptcp/pm_netlink.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index
> > f38e1ccd34e95cd88b179a8b50e6965731542871..7c6e664b236d1659a554d003c
> > 78
> > c72ec91895ba5 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1154,17 +1154,13 @@ int mptcp_pm_nl_get_local_id(struct
> > mptcp_sock *msk, struct mptcp_addr_info *skc
> >  {
> >  	struct mptcp_pm_addr_entry *entry;
> >  	struct pm_nl_pernet *pernet;
> > -	int ret = -1;
> > +	int ret;
> >  
> >  	pernet = pm_nl_get_pernet_from_msk(msk);
> >  
> >  	rcu_read_lock();
> > -	list_for_each_entry_rcu(entry, &pernet->local_addr_list,
> > list) {
> > -		if (mptcp_addresses_equal(&entry->addr, skc,
> > entry-
> > > addr.port)) {
> > -			ret = entry->addr.id;
> > -			break;
> > -		}
> > -	}
> > +	entry = __lookup_addr_rcu(pernet, skc);
> > +	ret = entry ? entry->addr.id : -1;
> >  	rcu_read_unlock();
> >  	if (ret >= 0)
> >  		return ret;
> > @@ -1191,15 +1187,11 @@ bool mptcp_pm_nl_is_backup(struct
> > mptcp_sock
> > *msk, struct mptcp_addr_info *skc)
> >  {
> >  	struct pm_nl_pernet *pernet =
> > pm_nl_get_pernet_from_msk(msk);
> >  	struct mptcp_pm_addr_entry *entry;
> > -	bool backup = false;
> > +	bool backup;
> >  
> >  	rcu_read_lock();
> > -	list_for_each_entry_rcu(entry, &pernet->local_addr_list,
> > list) {
> > -		if (mptcp_addresses_equal(&entry->addr, skc,
> > entry-
> > > addr.port)) {
> > -			backup = !!(entry->flags &
> > MPTCP_PM_ADDR_FLAG_BACKUP);
> > -			break;
> > -		}
> > -	}
> > +	entry = __lookup_addr_rcu(pernet, skc);
> > +	backup = entry && !!(entry->flags &
> > MPTCP_PM_ADDR_FLAG_BACKUP);
> 
> I think we should check whether entry is NULL here too. No?

Sorry, ignore my comment, your code is correct. :)

-Geliang

> 
> -Geliang
> 
> >  	rcu_read_unlock();
> >  
> >  	return backup;
> > 
> 
> 

