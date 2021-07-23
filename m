Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3872
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 11:18:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id m1so1688890pjv.2
        for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DF+tzXYftjyrt/od/9PsUdxpTkcyc7w5rOll/N/yJdo=;
        b=MCb423OyvFFML4bGi8ximMf/oKvjsJqF/s9oUZQwBQHvpiB/yKMkZvVpYk3Aw5N7sz
         H/fb3sFylLlqYIS/xKX+HxooeaoYAkkbvDlWiJWnCyMHMbekdPATmuvSELhidL12YWoW
         Kz2MWkS4pLPfecPAhN12IB/V0Kdf8RWpyD6imda1WFxtH5Iop/CfFEGmH9cG9wi6HgQv
         7FAAH7ARCnOx8ChZGobT4hXprjyNxVD/NvOWAicEONvWZOLRdTDpSXVxItheyVMOi3v2
         4JmloXPwbfZyqjS2SDqtWvuIIVQx0ZKB3WI4o0ZXLUEW2n/UOtbYlNF3j4v15jxgQzOq
         GOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DF+tzXYftjyrt/od/9PsUdxpTkcyc7w5rOll/N/yJdo=;
        b=agBhfP85x/LXixmAbHPJbkxbWAYfjobFbLAMDFG7NgNjtcaxcDHznv67pC7+UUWTRa
         bj5mo/ySPU+BkQI2qBcuvCimghMPMiAtB3z5Slqlu/b/zh9E/OGmc1IaEQGCEhoNBWPq
         jb7tbKykNX5yFgL5KP8v8FReuQfaweubBUBinHnfgL51bZQ+z4NO7zBdLzfZc1yPN8SP
         BfnzH1ozUA7Awgq8wyvYVE9yvZOqJ1+KVTOntZ34dJaz83gY41L15UDcBYHeVY/IzJNY
         VZ/g9/FHDjBV56mvGT6HGj8LX+QSqIr0sTq8UlfhmUuwrNTLa7f86e2g1bZfAdnF7um7
         MUHA==
X-Gm-Message-State: AOAM5338V8Ojh1fDiTDUgw9F271SqS/UOb3EGWkm0GdbfubZLNNf4X1B
	fGndNSH7KDqZPjBAUGa3Vu1BajLiITHp925TTFc=
X-Google-Smtp-Source: ABdhPJwYMoZ3/Bza77vcrA112dCHfrMzkBjkcuOQrRi3R8wxzPCi1XJvaP+ps3QWugJaTSZy1xarRmYg0nPFCny3OCw=
X-Received: by 2002:a63:f751:: with SMTP id f17mr4328879pgk.373.1627039097092;
 Fri, 23 Jul 2021 04:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d05f15b3381a4827e4c55826ca5597d9242d222f.camel@redhat.com>
 <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com> <4d1d59b2c9cfb9ad08a7fc4ff531434479e5778c.camel@redhat.com>
In-Reply-To: <4d1d59b2c9cfb9ad08a7fc4ff531434479e5778c.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Jul 2021 19:18:05 +0800
Message-ID: <CA+WQbwvL57HZV6X=YBjWiQwVwF-LLcqH2DUVaYZSzF1XtKG_pA@mail.gmail.com>
Subject: Re: IRC snippet
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2021-07-23 at 12:01 +0800, Geliang Tang wrote:
> > Hi Paolo,
> >
> > Thanks for your information, it's very helpful. And I have two more
> > questions below.
> >
> > Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8822=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:23=E5=86=99=E9=81=93=EF=BC=9A
> > > Hello,
> > >
> > > moving here from IRC, to avoid disconnection issues...
> > > < geliang >   Yes, Netd has the similar thing
> > >   < geliang >   It can get the IP up/down event too
> > >   < geliang >   https://android.googlesource.com/platform/system/netd=
/
> > >   < geliang >   So I need to add a new flag full-mesh to netlink
> > >   < geliang >   and drop the notifiers
> > >   < geliang >   and add the addresses array in
> > > mptcp_pm_create_subflow_or_signal_addr
> > > < geliang >   I'll do these things, thanks Paolo
> > >
> > > Note that the array size should be limited by the
> > > current add_addr_signal_max (and thus should be max 8).
> > >
> > > Each array entry should be mptcp_addr_info, that is 24 bytes.
> > >
> > > 24*8 =3D 192
> > >
> > > The above *could* be a little too much for a stack-based local
> > > variable, anyhow the kernel should tell, if so, you will get a warnin=
g
> > > at run time alike 'x function is using y bytes of stack'.
> > >
> > > In case of such warn you could:
> > > - dynamically allocate such array (and fail if allocation fail)
> > > [or]
> > > - add such stiorage inside mptcp_pm_data
> > > [or]
> > > - something in between e.g. use a local variable to a very limited
> > > amount of addresses and then dynamically allocate a variable.
> >
> > If the endpoint's flag is subflow,fullmesh, we need to get all the remo=
te
> > addresses. So we need to record all the received ADD_ADDRs.
>
> For simplicity's sake, I think we could start using the remote_addr of
> the established subflows, plus the one in pm.remote, if avail.
>
> > Should these
> > two old patches work?
> >
> > mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> > mptcp: add add_list in mptcp_pm_data
> > https://patchwork.kernel.org/project/mptcp/patch/ae0d32922128771f09b230=
e5718774472a088207.1621002341.git.geliangtang@gmail.com/
> > https://patchwork.kernel.org/project/mptcp/patch/850406b0f49fa0a76b4825=
b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com/
> >
> > If we use these two patches, then we can connect all the remote address=
es
> > like this in mptcp_pm_create_subflow_or_signal_addr:
> >
> > if (local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> >         struct mptcp_pm_add_entry *entry;
> >
> >         list_for_each_entry(entry, &msk->pm.add_list. list)
> >                 __mptcp_subflow_connect(sk, &local->addr,
> > &entry->addr, local->flags, local->ifindex);
> > }
> >
> > What do you think about this approach?
>
> We still need to copy the addresses in a temporary array - or refactor
> the patches - as such list is under the pm lock and we must walk the
> remote addresses without helding such lock - we can't
> call __mptcp_subflow_connect under such lock.
>
> I think we should consider that approch only if the simpler one shows
> unsolvable [including: too much new code needed] problems.
>
> > > I *think* the latter could be an interesting option.
> > >
> > > Finally note that similar changes will be required
> > > in mptcp_pm_nl_add_addr_received(), with the main difference
> > > that mptcp_pm_nl_add_addr_received will fill the array with all the
> > > known local addresses, while mptcp_pm_create_subflow_or_signal_addr()
> > > will fill it with remote addresses.
> >
> > If the endpoint's flag is signal,fullmesh, we announce this address, se=
nd
> > this address with ADD_ADDR to the peer. The peer received the ADD_ADDR =
in
> > mptcp_pm_nl_add_addr_received. It's easy to get all the local addresses=
,
> > it's on the local_addr_list.
>
> Uhmm... I think there is some misunderstanding here. Full-mash topology
> should _not_ relay on any additional actions to be performed on the
> peer side (e.g. taking action for ADD_ADDR send by the local side).
> AFAICS the schema I proposed don't require that.
>
> The point is, when the client using 'signal,fullmesh' endpoints to
> implement a full-mash topology _receives_ an ADD_ADDR from the peer, it
> should create a subflow for each 'signal,fullmesh' endpoint, as opposed
> to the current behaviour where a single subflow, using the local
> address selected by the routing, is created.
>
> To do the above, the client, in mptcp_pm_nl_add_addr_received() should
> again copy the known local list in a temporary array -
> because local_addr_list is RCU protected and we can't
> call __mptcp_subflow_connect() in an RCU critical section.
>
> > But how can we know whether the received address is a fullmesh one or n=
ot
> > in mptcp_pm_nl_add_addr_received? The endpoint's flag is set on the oth=
er
> > side. In mptcp_pm_nl_add_addr_received, we can't get this flag.
>
> Hopefully the above should clarify/respond to your question. The main
> point is that the full-mash topology configuration is all on a single
> side (e.g. the client one). The other side (the server) simply
> announces additional addreses (if any). It's the client to take any
> required actions as needed (and as specified by the 'subflow,fullmash'
> endpoints).
>
> Please let me know if the above is clear!

Thanks Paolo, it's much clearer now. I'll implement it recently and send
the code to you for review.

-Geliang

>
> Thanks,
>
> Paolo
>
>
