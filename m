Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5B72
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627024757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4wILZXAs/Itz4byblXd3Q7Gxpb44pWRW1ant7rHFWE=;
	b=BzIscvhs9p87nzJ9ww30J0IPqAbROeib9cPNkdqMxf7ngzJVfqCix0Hbc31TnW05xTw8hy
	vaN20BRViT8qQyaGC04ZBvGQkiy5YinmcNuDeupNi7fs4bZeoHJ27evwB6ssgZgLPjdix8
	ldCmdox4obKVJzpD+ckL9KbC1WNtUtk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-fgD-3a6KMIK6RRQRL9STZQ-1; Fri, 23 Jul 2021 03:19:15 -0400
X-MC-Unique: fgD-3a6KMIK6RRQRL9STZQ-1
Received: by mail-wm1-f69.google.com with SMTP id 15-20020a05600c230fb0290218ad9a8d4aso1113065wmo.1
        for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 00:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M4wILZXAs/Itz4byblXd3Q7Gxpb44pWRW1ant7rHFWE=;
        b=c0poQNeepAqlMnkMHLDxDXwEh2oxR2bN6oNbrI4L+MDeF3YQ3+ItmnlRF/BUTHiAGS
         rYz3cjGE0ZOEZroUg25CpBqkNyJm9/T0ZClIQtlTQ0Gp2GtsHrHpRENqOwap5avujSKL
         VXIditHFBl5wiOZhpAR0tqFxWpz6jpkDj2a+xeAKAGp36FOR0orOmaXlRW5bFvp14N2W
         W0wa5AAbmTBzIDMEIoewJYO0Zjdi6TQ9q9MsROHATmmSuPjHNsJlhxdv1EHCJdPVRMHL
         LjuFyDDd6GXHVuRFWrD7IC8dQe9uUWFesfdRWV3WW2GlQ/0z7Po/pSbbC4sa7+tr/W2C
         bnUg==
X-Gm-Message-State: AOAM530v2GDhajmUJScdKOi5wXR/pPD4HzeP9vi3b+ZTTNmg3/ubXBB9
	/0gPzlXSi2WJD9AP87lCM/4LHLlbYRNwZo49xKHbM8Z0yrDgToXsgba6R9PbjSTPw+th1ZYK973
	MdWs+SX65JdyWaWg=
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr2923056wmj.15.1627024754332;
        Fri, 23 Jul 2021 00:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKPHjMn4KpQiLLHAJuNlSbrZ4Lz/ajevEA48B/uOgi+YmtuXIz3w23AQL3OooWzXnvo2ftng==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr2923039wmj.15.1627024754102;
        Fri, 23 Jul 2021 00:19:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id s4sm30251253wmh.41.2021.07.23.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:19:13 -0700 (PDT)
Message-ID: <4d1d59b2c9cfb9ad08a7fc4ff531434479e5778c.camel@redhat.com>
Subject: Re: IRC snippet
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 23 Jul 2021 09:19:12 +0200
In-Reply-To: <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com>
References: <d05f15b3381a4827e4c55826ca5597d9242d222f.camel@redhat.com>
	 <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-23 at 12:01 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for your information, it's very helpful. And I have two more
> questions below.
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年7月22日周四 下午7:23写道：
> > Hello,
> > 
> > moving here from IRC, to avoid disconnection issues...
> > < geliang >   Yes, Netd has the similar thing
> >   < geliang >   It can get the IP up/down event too
> >   < geliang >   https://android.googlesource.com/platform/system/netd/
> >   < geliang >   So I need to add a new flag full-mesh to netlink
> >   < geliang >   and drop the notifiers
> >   < geliang >   and add the addresses array in
> > mptcp_pm_create_subflow_or_signal_addr
> > < geliang >   I'll do these things, thanks Paolo
> > 
> > Note that the array size should be limited by the
> > current add_addr_signal_max (and thus should be max 8).
> > 
> > Each array entry should be mptcp_addr_info, that is 24 bytes.
> > 
> > 24*8 = 192
> > 
> > The above *could* be a little too much for a stack-based local
> > variable, anyhow the kernel should tell, if so, you will get a warning
> > at run time alike 'x function is using y bytes of stack'.
> > 
> > In case of such warn you could:
> > - dynamically allocate such array (and fail if allocation fail)
> > [or]
> > - add such stiorage inside mptcp_pm_data
> > [or]
> > - something in between e.g. use a local variable to a very limited
> > amount of addresses and then dynamically allocate a variable.
> 
> If the endpoint's flag is subflow,fullmesh, we need to get all the remote
> addresses. So we need to record all the received ADD_ADDRs. 

For simplicity's sake, I think we could start using the remote_addr of
the established subflows, plus the one in pm.remote, if avail.

> Should these
> two old patches work?
> 
> mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> mptcp: add add_list in mptcp_pm_data
> https://patchwork.kernel.org/project/mptcp/patch/ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com/
> https://patchwork.kernel.org/project/mptcp/patch/850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com/
> 
> If we use these two patches, then we can connect all the remote addresses
> like this in mptcp_pm_create_subflow_or_signal_addr:
> 
> if (local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
>         struct mptcp_pm_add_entry *entry;
> 
>         list_for_each_entry(entry, &msk->pm.add_list. list)
>                 __mptcp_subflow_connect(sk, &local->addr,
> &entry->addr, local->flags, local->ifindex);
> }
> 
> What do you think about this approach?

We still need to copy the addresses in a temporary array - or refactor
the patches - as such list is under the pm lock and we must walk the
remote addresses without helding such lock - we can't
call __mptcp_subflow_connect under such lock.

I think we should consider that approch only if the simpler one shows
unsolvable [including: too much new code needed] problems.

> > I *think* the latter could be an interesting option.
> > 
> > Finally note that similar changes will be required
> > in mptcp_pm_nl_add_addr_received(), with the main difference
> > that mptcp_pm_nl_add_addr_received will fill the array with all the
> > known local addresses, while mptcp_pm_create_subflow_or_signal_addr()
> > will fill it with remote addresses.
> 
> If the endpoint's flag is signal,fullmesh, we announce this address, send
> this address with ADD_ADDR to the peer. The peer received the ADD_ADDR in
> mptcp_pm_nl_add_addr_received. It's easy to get all the local addresses,
> it's on the local_addr_list.

Uhmm... I think there is some misunderstanding here. Full-mash topology
should _not_ relay on any additional actions to be performed on the
peer side (e.g. taking action for ADD_ADDR send by the local side).
AFAICS the schema I proposed don't require that.

The point is, when the client using 'signal,fullmesh' endpoints to
implement a full-mash topology _receives_ an ADD_ADDR from the peer, it
should create a subflow for each 'signal,fullmesh' endpoint, as opposed
to the current behaviour where a single subflow, using the local
address selected by the routing, is created.

To do the above, the client, in mptcp_pm_nl_add_addr_received() should
again copy the known local list in a temporary array -
because local_addr_list is RCU protected and we can't
call __mptcp_subflow_connect() in an RCU critical section.

> But how can we know whether the received address is a fullmesh one or not
> in mptcp_pm_nl_add_addr_received? The endpoint's flag is set on the other
> side. In mptcp_pm_nl_add_addr_received, we can't get this flag.

Hopefully the above should clarify/respond to your question. The main
point is that the full-mash topology configuration is all on a single
side (e.g. the client one). The other side (the server) simply
announces additional addreses (if any). It's the client to take any
required actions as needed (and as specified by the 'subflow,fullmash'
endpoints).

Please let me know if the above is clear!

Thanks,

Paolo


