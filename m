Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822D2FBF
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 10:11:17 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so1271812pjb.2
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VZW9gWkFmYifvbDjtRj5x2/p3oauYImsD4NbhWVCDVM=;
        b=FzJI5WI1Ux/VxHFkzCglctZRUITl2vWJUSwmNaj/FnPasCJ8+qXCiaXDJaFlj5J/SA
         CODInyuPqAPTyPkSeWHZh09jkKoSijbRgpHe2U9gN8WCUid4Workjb5srguj0vYkRBS0
         enwnmkez5dEqpUqtb+fEoM1ci3It5jsInVd0LSV65UjqOzfweU+j8oZM6Y/w4bWRA1gu
         XaeSSAlgiv7/CgWvO/lV6H9B2u1qSKPnMiwO9OHu3HZFTTLvjERiqV53xAfV16SU1Y7E
         6O80SMIYWIjC3yt/vDr7u3ePy3UCc1YUZxavJGRdIv8agoYvHNdyk0VHXIOl9o9clxSM
         EwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VZW9gWkFmYifvbDjtRj5x2/p3oauYImsD4NbhWVCDVM=;
        b=JngEgKihH7tZ+/MBWRBbylJwrPUfAJ6BorhbVE1Y7QIpa8xQbdocQog7z1C28Pesyn
         xheun9+EohqR2oWn+DpENSKh37GqA4JwKwCrsqXM/2MjrkA4zpOw3VoRHCh/oaSrgnvE
         +vZ+B7HUrzmX5A6l9E7Sg0Ysyd7ex42UjaeUGrmlgF5f4nnsXPeT7P3Wnl40nvUhHC1a
         mMOHi+3Vfee6R0Daq+JqHGynor2WwwHitZHd2OabX/ZuaG1ZcQYMQaBR6rehg2DvvpSw
         9uiLS1d+45Q2RB7lgW5pjFeArkBziGtkNU1H0D1MT6XSMrSPFAheyBzW4+oq5SUR9SrE
         fTlA==
X-Gm-Message-State: AOAM533YRjBYBC/a8Ju+Diyo8/ElgbAsxhiuZQ62Oy3MScOe71jhKRjs
	9tIR+02uodGwcsuuBOPHT4c6axC/1h4yKYjZ5d1NVougEwc=
X-Google-Smtp-Source: ABdhPJzaNgCvMNRsk2oy7Rg9r4hHV4N7NcRoqYKfp9k3Z8xQhQMW76+1LW2VPEUMRNxp1wwGfmGa4gOpwYW+Y4IwfSY=
X-Received: by 2002:a17:90a:17c5:: with SMTP id q63mr2513708pja.190.1621332676865;
 Tue, 18 May 2021 03:11:16 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1621002341.git.geliangtang@gmail.com> <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>
 <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>
In-Reply-To: <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 18 May 2021 18:11:05 +0800
Message-ID: <CA+WQbwswQHJB5fhxj949wXA-=VbrT-Z9M+LunzneOVKPER8yog@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B45=
=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:59=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 17 May 2021, Paolo Abeni wrote:
>
> > Hello,
> >
> > On Fri, 2021-05-14 at 22:32 +0800, Geliang Tang wrote:
> >> v6:
> >>  - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> >>  - update mptcp_pm_free_add_list
> >>  - update code in mptcp_pm_nl_add_addr_received
> >>  - tag: export/20210514T055902
> >>
> >> v5:
> >>  - add a new patch "mptcp: add add_list in mptcp_pm_data"
> >>  - fix !CONFIG_SYSCTL case
> >>  - tag: export/20210507T174457
> >>
> >> v4:
> >>  - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
> >>  - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
> >>  - add comments for self test cases
> >>  - apply: export/20210504T064955 +
> >>           "data checksum support" +
> >>           "data checksum support cleanups"
> >>
> >> v3:
> >>  - use 'u8 allow_join_initial_addr_port'
> >>  - drop the spinlock in patch 3
> >>
> >> v2:
> >>  - rename join_denied to allow_join_id0 in mptcp_out_options
> >>  - rename join_denied to deny_join_id0 in mptcp_options_received
> >>  - add a new function mptcp_pm_deny_join_id0_received
> >>  - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
> >>  - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
> >> instead of in mptcp_syn_options.
> >>
> >> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
> >>
> >> Geliang Tang (6):
> >>   mptcp: add sysctl allow_join_initial_addr_port
> >>   mptcp: add allow_join_id0 in mptcp_out_options
> >>   mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> >>   mptcp: add add_list in mptcp_pm_data
> >>   mptcp: add deny_join_id0 in mptcp_options_received
> >>   selftests: mptcp: add deny_join_id0 testcases
> >>
> >>  Documentation/networking/mptcp-sysctl.rst     |  13 ++
> >>  include/net/mptcp.h                           |   3 +-
> >>  net/mptcp/ctrl.c                              |  16 ++
> >>  net/mptcp/options.c                           |  14 +-
> >>  net/mptcp/pm.c                                |   2 +
> >>  net/mptcp/pm_netlink.c                        | 151 ++++++++++++++---=
-
> >>  net/mptcp/protocol.c                          |   1 +
> >>  net/mptcp/protocol.h                          |  21 ++-
> >>  net/mptcp/subflow.c                           |   3 +
> >>  .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
> >>  10 files changed, 238 insertions(+), 42 deletions(-)
> >>
> > I'm very sorry to give feedback this late, but I was unable to review
> > this before.
> >
> > I have some very generic/broad questions:
> > 1) shuold 'allow_join_initial_addr_port' be by default 0 for clients?
> > If I read correctly, will be 1 after this patch.
>
> It should default to 1 because that is what keeps the current behavior.
>
> The logic is flipped from the 'C' bit: C=3D1 in the header means "do not
> connect to initial subflow addr/port", but allow_join_initial_addr_port=
=3D1
> means "*do* connect to the initial subflow addr/port".
>
> > 2) is the additional add_addr accounting required? I mean storing the
> > received addrs in the msk pm add_list (patch 4/6). Can we instead
> > simply enforce !allow_join_initial_addr_port looking up the relevant
> > address into the existing subflows? (or caching first subflow dst addr
> > and port in some new msk fields, whatever is simpler)
> >
> > if !allow_join_initial_addr_port && <exists subflow with target
> > ip/port> && <such subflow is mp_capable/>
> >       <do not create new subflow>
> >
>
> Caching the first subflow dst addr/port is enough to prevent sending a
> MP_JOIN to that address, but I don't think it does quite enough.
>
> Consider:
>
> 1. Initial connection is made between Peer A and Peer B with C=3D1 (both
> directions).
>
> 2. Peer A sends ADD_ADDR. Peer B currently has limits set that don't allo=
w
> outgoing MP_JOINs.
>
> 3. Later, Peer B updates limits to allow outgoing MP_JOINs.
>
> At this point, Peer B needs to know what to connect to. Without the
> add_list, the only active address it knows for Peer A is one it is not
> allowed to connect to.
>
>
> I've expected that we would add better tracking of ADD_ADDRs - remember
> that ADD_ADDR is an advertisement, not a request to "please connect to
> this address right now". Userspace path managers will certainly have more
> persistance of the peer's advertised addresses. Any more comprehensive
> in-kernel PM will also need the add_list. The main concern is that the
> list doesn't consume excessive memory, and the add_list is not expanded
> when pm->accept_addr is false.
>
>
> > 3) If I read correctly the series enforce the peer who could create the
> > new subflow to respect the 'allow_join_initial_addr_port' field, but
> > does not implement the corrsponding check on the other end. e.g. if a
> > server sets 'allow_join_initial_addr_port' to 0 and a client tries to
> > create additional subflows, the server will not forbit that. I
> > think/fear the missing complexity here is quite significant.
> >
> > I think it would be nice avoid adding additional complexity for the 'C'
> > bit - currently even mptcp.org support it.
> >
>
> Assuming you intended to say "currently even mptcp.org does not support
> it."
>
> You're right: the incoming join address check is missing. But I'm not sur=
e
> the complexity is so bad, the PM can already reject joins. I think we
> could pass enough information to mptcp_pm_allow_new_subflow() to implemen=
t
> this check. Am I oversimplifying - is it harder to get at the dest
> addr/port? Or is it something else?

Thanks for your review.

I just sent out a patch named (Squash to "mptcp: add deny_join_id0 in
mptcp_options_received") to fix this.

-Geliang

>
> > Perhaps we could keep 'allow_join_initial_addr_port' constant (always 0
> > for client, always 0 for server) - avoding the additional complexity of
> > point 3) above.
> >
>
> Given the answer to #1 is this still what you'd propose?
> allow_join_initial_addr_port=3D1 is unchanged behavior from the kernel
> today, and is the simpler case.
>
> --
> Mat Martineau
> Intel
