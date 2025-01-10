Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D52063F3
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495116; cv=none; b=g1NrNnT0ub9NwaAvREIjnjNyzMLYFhounSgMbooLKfLuCotCdEas/vE+tVgDO2BL3YO51S7JiQrmSaL3emPVOHdshoC31xofRsZzOG0Ln7/QeZwY0Un899TOmqOt6UWeHiXWR4/YY/o1qVzzmz2M8Holl7eH1mLBNnzcINqMycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495116; c=relaxed/simple;
	bh=DwMS8kaenTiCdMrv8BEGo6g7J3m8xjz35I8XDoc13Ww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShoWEM5o5UaTIu2ZFzvNQM/GWzldUJWd415K8B7mmEPHW9RnVUmvyg9SMruiMLuJ/oWSwQPgRIZAKz/cQikTqeOOlOHDo9DVNJPe227gmX68wETmw7AwuHq7kLpNW/0w5RDvGIYx2AxWy7jv0Ig2bcelSQsnZmPlfVVWcixnU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p71TM2Is; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p71TM2Is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2680C4CEDF;
	Fri, 10 Jan 2025 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736495116;
	bh=DwMS8kaenTiCdMrv8BEGo6g7J3m8xjz35I8XDoc13Ww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p71TM2IsCcASpbphN1vtfC8J4XhwoPXjWaAYl/X9KK0YXIF695gE87TIWaoMwA5UD
	 OZ/1iAnb1oR31ti/89k8ot48JMr0Dq+fxtlTQgcg8ZsAHmmhIEvgzR7LHWTT8A9jLp
	 1rdgTxZKYPl5wVTcmUkyoqUgxCXq86XsMUQYi8Sw29s/Gd6719G4hhKS0Hb8naZXy9
	 b6tBrupliD/4L3eHUEnvsSyN8r87aRyx+/Llv4ntU8xuzfLFPFWpW9dX42jlueNhSm
	 IiocsCBYG8nWZuhLriEccUPCls+8/Oz8uHjpqSPO5ckEquzj7B7ge9eziwyXj4X8+P
	 AnVbt7gfkQVMw==
Message-ID: <74351649e55ba9312705aa7a52a2f48750130bfd.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 5/8] mptcp: userspace pm set_flags id
 support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 10 Jan 2025 15:45:11 +0800
In-Reply-To: <9f8c7031-4f5d-4195-93de-e23491799367@kernel.org>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
	 <30061158e34c4fbf9063150e6aec40c0eed42b6b.1736308884.git.tanggeliang@kylinos.cn>
	 <f3e45b8c-54e4-44af-bad2-63b6221cbcf0@kernel.org>
	 <3284b879-8844-4324-ae92-970c4fe5d686@kernel.org>
	 <51c240cd267760b883bd2749e0a01be5854f62a9.camel@kernel.org>
	 <9f8c7031-4f5d-4195-93de-e23491799367@kernel.org>
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

On Thu, 2025-01-09 at 13:20 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply!
> 
> On 09/01/2025 04:40, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for the review!
> > 
> > On Wed, 2025-01-08 at 19:51 +0100, Matthieu Baerts wrote:
> > > On 08/01/2025 19:47, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > > 
> > > > On 08/01/2025 05:21, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > 
> > > > > Similar to in-kernel PM, this patch adds address ID support
> > > > > to
> > > > > set_flags()
> > > > > interface of userspace PM, allowing it to work with either an
> > > > > address or
> > > > > an address ID.
> > > > > 
> > > > > When an address ID is used,
> > > > > mptcp_userspace_pm_lookup_addr_by_id() helper
> > > > > is used to look up the address entry in the local address
> > > > > list
> > > > > instead of
> > > > > using mptcp_userspace_pm_lookup_addr().
> > > > 
> > > > Mmh, I'm still not sure about that. As I was saying in [1], if
> > > > I'm
> > > > not
> > > > mistaken, with the userspace PM, it is possible not to find any
> > > > entries
> > > > here, e.g.: if a subflow using this address has not been added
> > > > or
> > > > the
> > > > address has not been announced. (I guess the initial address is
> > > > not
> > > > there then).
> > 
> > The previous version (in [1]) did have this issue and
> > userspace_pm.sh
> > tests would fail because of it, but this new version has fixed it.
> > 
> >  mptcp_pm_nl_mp_prio_send_ack(msk,
> >                               entry ? &entry->addr : &local->addr,
> >                               remote, bkup);
> > 
> > When the entry is not found, we continue to pass local->addr to
> > ensure
> > the same behavior as before.
> 
> Yes indeed, the tests are fixed, but if 'entry' is NULL, the address
> you
> will give will be empty, so it will not be able to find any subflow
> to
> send the MP_PRIO, right?
> 
> > > > Do you think this patch is worth it? Setting by ID for the in-
> > > > kernel PM
> > > > makes sense: unique ID for the netns, easier to type the ID
> > > > than
> > > > the
> > > > full address. While for the userspace PM, it will be managed by
> > > > a
> > > > daemon
> > > > that will have to track addresses anyway.
> > 
> > I think it's still useful to extend this functionality while the
> > original behavior is not affected, at least it doesn't hurt.
> 
> I'm sorry, I think it is not that simple: if we extend this
> functionality, it means we will have to maintain it. Here, the
> interface
> looks buggy because it will not work with all addresses: the initial
> ones, the ones not announced but implicitly used, etc.
> 
> If the interface does not always work, I don't think we will
> recommend
> using it, then why do we need to maintain it?
> 
> > We cannot assume that userspace PM is always managed by a daemon.
> > We
> > have exported its interfaces to BPF. We allow users to customize
> > path
> > managers. That means we also allow users to use their own userspace
> > PM
> > in any way.
> 
> I think the BPF PM is different: it is a different interface.
> 
> To interact with the userspace PM, it is required to monitor the
> MPTCP
> events sent via Netlink, e.g. to get the token. When a new subflow is
> created, the userspace will know which addresses (including the ID)
> it
> is linked to. In this case, why only setting the ID in the address
> structure if it doesn't always work, while setting the address will
> always work as expected.
> 
> > Another consideration is that we need to maintain the consistency
> > between in-kernel PM and userspace PM.
> 
> Not really: when they can do the same thing, yes, but the two
> interfaces
> are different. We don't have to keep the consistency if it doesn't
> make
> sense to do so.
> 
> > For ease of maintenance, we need
> > to make these two PMs use the same code as much as possible, and
> > only
> > abstract their differences through PM interfaces such as get_addr,
> > dump_addr, set_flags, etc.
> 
> Yes but there are some limits: if some code is shared between
> multiple
> interfaces, it is important not to break one of them when changing
> the
> code. In other words, if the behaviour is very similar (e.g.
> get_addr),
> that's fine. But if they start to be too different, you have complex
> common code where you need to think "OK, this one acts like that, but
> the other one like that", and complexity is not good for the
> maintenance. In this case, it sounds better to keep them separated.
> 
> > At present, the biggest difference between
> > the two is that they use different linked lists (pernet-
> > > local_addr_list vs. msk->pm.userspace_pm_local_addr_list) to
> > > store
> > address entries, so we only need to put the code for operating the
> > linked lists into the interfaces of each PM. This is also the goal
> > of
> > adjusting the pm interfaces in this series.
> 
> Yes, but that's not the only difference, because the interfaces are
> different.
> 
> With the in-kernel PM, we act per netns, while with the userspace PM,
> it
> is per connection. Because of that, addresses lists are managed
> differently, leading to different concept, e.g. the list not having
> all
> addresses, the addresses not having ID 0 in one, but OK in the other,
> etc. With shared code that acts for both of them, you need to keep
> thinking about these differences when reading or writing code, and
> that's a source of error I think.
> 
> > > > Or in other words, do you have a use-case for this? To me, it
> > > > looks
> > > > like
> > > > "yes, you can only set the ID, but it might not always work".
> > > > Then
> > > > maybe
> > > > better to always set the full address, no?
> > 
> > If you're worried that this functionality isn't covered by tests,
> > I've
> > added a test that covers it in BPF path manager selftests:
> > 
> >         err = userspace_pm_set_flags(token, addr, "backup");
> >         if (!ASSERT_OK(err, "userspace_pm_set_flags backup"))
> >                 goto close_accept;
> > 
> > 	...
> > 
> >         err = userspace_pm_set_flags_by_id(token, 100, "nobackup");
> >         if (!ASSERT_OK(err, "userspace_pm_set_flags_by_id
> > nobackup"))
> >                 goto close_accept;
> 
> I would need to check the BPF PM interface, but for me the userspace
> PM
> and BPF PM interfaces don't have to be the same, e.g. why having a
> dump
> if the BPF PM can directly access data from the kernel? Same here for
> the ID: it depends if all IDs are tracked in the corresponding list,
> e.g. it might not be the case with an "announced" list.
> 
> But also yes, if something is exposed to userspace (via Netlink), it
> should be covered by a test (using the userspace Netlink interface)
> 
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/mptcp/d01d0e8a-5606-4152-aabe-32e4402adeeb@kernel.org/
> > > 
> > > Note: if we drop this patch (I think it is better), maybe patch
> > > 8/8
> > > is
> > > not worth it: not to have a "common" section with plenty of 'if
> > > (token)', no? Or do you really need them for the BPF PM?
> > 
> > Here we are only adjusting set_flags interface of in-kernel PM and
> > userspace PM, which has nothing to do with the BPF PM
> > implementation.
> > 
> > It seems that moving the code in mptcp_pm_nl_set_flags_doit() to
> > mptcp_pm_set_flags() can remove these 'if (token)':
> > 
> > int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct
> > genl_info
> > *info)
> > {
> >         return mptcp_pm_set_flags(info);
> 
> I'm not sure whether it is useful to have one function simply calling
> another function that is only used once.

I kept this function in v4 to make it consistent with mptcp_pm_get_addr
and mptcp_pm_dump_addr.

And "mptcp: userspace pm set_flags id support" is moved out of this set
in v4.

Thanks,
-Geliang

> 
> > }
> > 
> > static int mptcp_pm_set_flags(struct genl_info *info)
> > {
> >         struct mptcp_pm_addr_entry loc = { .addr = { .family =
> > AF_UNSPEC }, };
> >         struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
> >         struct nlattr *attr_loc, *attr_rem;
> >         int ret;
> > 
> >         if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
> >                 return -EINVAL;
> > 
> >         attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
> >         ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
> >         if (ret < 0)
> >                 return ret;
> > 
> >         if (info->attrs[MPTCP_PM_ATTR_TOKEN]) {
> >                 if (GENL_REQ_ATTR_CHECK(info,
> > MPTCP_PM_ATTR_ADDR_REMOTE))
> >                         return -EINVAL;
> > 
> >                 attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> >                 ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
> >                 if (ret < 0)
> >                         return ret;
> > 
> >                 if (rem.family == AF_UNSPEC) {
> >                         NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
> >                                             "invalid remote address
> > family");
> >                         return -EINVAL;
> >                 }
> > 
> >                 return mptcp_userspace_pm_set_flags(&loc, &rem,
> > info);
> >         }
> 
> The problem is the same: ↑ is specific to the userspace PM, why
> moving
> the code here in the common section then?
> 
> Same for the code ↓.
> 
> So at the end, the only common code is the parsing of the local
> address,
> so just GENL_REQ_ATTR_CHECK(MPTCP_PM_ATTR_ADDR) and
> mptcp_pm_parse_entry(MPTCP_PM_ATTR_ADDR). Is it worth it?
> 
> So if we want to share code, all we can get I think is this:
> 
>   int mptcp_pm_nl_set_flags_doit(...)
>   {
>       (...)
> 
>       if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
>           return -EINVAL;
> 
>       attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
>       ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
>       if (ret < 0)
>           return ret;
> 
>       if (info->attrs[MPTCP_PM_ATTR_TOKEN])
>            return mptcp_userspace_pm_set_flags(&loc, info);
> 
>       return mptcp_pm_nl_set_flags(&loc, info);
>   }
> 
> Not a lot to share, but at least there is nothing PM specific here,
> except to pick the interface to continue with. And yes, that's
> something
> that could be done, but that's not much...
> 
> > 
> >         if (loc.addr.family == AF_UNSPEC) {
> >                 if (!loc.addr.id) {
> >                         NL_SET_ERR_MSG_ATTR(info->extack, attr_loc,
> >                                             "missing address ID");
> >                         return -EOPNOTSUPP;
> > 		}
> >         }
> > 
> >         return mptcp_pm_nl_set_flags(&loc, info);
> > }
> > 
> > WDYT?
> > 
> > -Geliang
> > 
> > > 
> > > Cheers,
> > > Matt
> > 
> 
> Cheers,
> Matt

