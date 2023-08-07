Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D74435
	for <mptcp@lists.linux.dev>; Mon,  7 Aug 2023 07:08:58 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so6829407e87.0
        for <mptcp@lists.linux.dev>; Mon, 07 Aug 2023 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691392137; x=1691996937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDfmzlZTAAjXwz0mEDcWeguEhV6K2865LuhXtE0gSO8=;
        b=m9uSOswTYigUWlCbd78HW5vnkgeCT3IAFXfabQ9eq1i5I40NT89gSRPu1DIcQQfeSC
         fVovVNj9epQFZG+YhTcaKTStTUzeKIqcQhlnBnpUhFqg0slREqmIL6DsC4P5WvWoXNAk
         8Qabc3rzvkz5HInCBK55y+se/cUxpN5zcGPCp+iH5pF+K3py+W53yUo1GnSDimvbI5Cz
         r92y7em8qjrJ88tbvBEq7kOZESGwpqH+FpU7bTC7iyQmjL1I/IzBdApxh8H76LhIJwEz
         T9NnoQKUAx0yHIEUyFNhf9hcZRjHaOoGNfEM3H2oJtO6B/OaqHXWx1ggYAH/ZKPVV6bb
         2LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392137; x=1691996937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDfmzlZTAAjXwz0mEDcWeguEhV6K2865LuhXtE0gSO8=;
        b=ZmJmO7L7jM2OdAdjhUjKVnKr3gVTkHL2/XnzgIExtoxiSnGiO9XewUwz6Ijiv/5RSI
         VEfOTdxcsWDXsAEqd7LnCAtqNmgdR0CQlSxVX4oVSl5kWMMANOJ0umeLCagSxL2DCoEK
         U1igbat2J0xcuP0ZTqQrGtds5x7DRerlrtMHX/w/zFao2xfghZPJ5ANKpsG0L9E13mjt
         FCrNj2ZJPMlE8tynZUnRF8u1yeecX5MDFodBT+ol0+xvvFqx/qeWfxxEQF3UbMZchZDV
         9gKZjKnhCkAHHug6+BCyYU5poFot/PnF6kz+69dwDvaJ4SMG/d7wVAkkxii7EkoFmBpn
         x/dw==
X-Gm-Message-State: AOJu0Yy+CYuytPA+9LOsZhQvyUCt9Gsz8nHRV6pKBq1CXVwTwAYNGPV6
	vGUAmSZC3+w2z5IBE2BSIFoX/5OLT5O65Y/bfLA=
X-Google-Smtp-Source: AGHT+IGZamZW0PtjhesseGG79X2hMR+1B9hKEE9AtLnyQWpoV3OmIexAtWEzJ8C4cU5drcw/5ZAgOVP9wTF3uC4gvnc=
X-Received: by 2002:a05:6512:4894:b0:4fd:d7ac:2654 with SMTP id
 eq20-20020a056512489400b004fdd7ac2654mr4891199lfb.13.1691392136427; Mon, 07
 Aug 2023 00:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <336e8b92-8416-44a3-917f-5fcb1ae3a919@tessares.net>
 <CA+WQbwuhjitKkgobY7vgFMSQE5JTsPpq9VjC0KEO2Ldm_TT2gQ@mail.gmail.com> <772ed33e-8893-41e2-9783-4b225f0d90ca@tessares.net>
In-Reply-To: <772ed33e-8893-41e2-9783-4b225f0d90ca@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 7 Aug 2023 15:09:10 +0800
Message-ID: <CA+WQbwv81UhdEpOxHWSON2yjNtevaPOhRJrQrVqWKs24=mCXqw@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 1st of August 2023
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <martineau@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B48=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 20:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 02/08/2023 11:34, Geliang Tang wrote:
> > Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=89 01:28=E5=86=99=E9=81=93=EF=BC=9A
>
> (...)
>
> >> Patches to send to netdev:
>
> (...)
>
> >>     - Features for other trees:
> >>
> >>         - [30c925a26900] mptcp: refactor push_pending logic (Geliang T=
ang)
> >>         - [d92e7c3ac566] mptcp: drop last_snd and MPTCP_RESET_SCHEDULE=
R
> >> (Geliang Tang)
> >>         - [2e2ed433f72f] mptcp: add struct mptcp_sched_ops (Geliang Ta=
ng)
> >>         - [8d3528b3804d] mptcp: add a new sysctl scheduler (Geliang Ta=
ng)
> >>         - [36329d82af78] mptcp: add sched in mptcp_sock (Geliang Tang)
> >>         - [58b653130078] mptcp: add scheduled in mptcp_subflow_context
> >> (Geliang Tang)
> >>         - [b86a7f3f4f2b] mptcp: add sched_data helpers (Geliang Tang)
> >>         - [1da743dfb834] mptcp: add scheduler wrappers (Geliang Tang)
> >>         - [172ae1f29b25] mptcp: use get_send wrapper (Geliang Tang)
> >>         - [7449b11ec26b] mptcp: use get_retrans wrapper (Geliang Tang)
> >>         - [abb330dac85f] mptcp: register default scheduler (Geliang Ta=
ng):
> >>             - can maybe be sent?
> >>             - Mat will re-review them to see what can be sent
> >
> > I read these bpf schedulers patches again today and found that some
> > patches need to be update:
> >
> > 1. mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> >
> > The commit log needs to update:
> > '''
> > mptcp_subflow_get_send(), it makes some msk->last_snd useless.
> > ->
> > mptcp_subflow_get_send(), it makes all msk->last_snd useless.
> > '''
> >
> > 2. mptcp: add struct mptcp_sched_ops
> >
> > The commit log needs to update:
> > '''
> > mptcp_sched_data parameter, which contains a reinject flag and a
> > mptcp_subflow_context array.
> >  ->
> > mptcp_sched_data parameter, which contains a reinject flag for
> > retrans or not, a subflows number and a mptcp_subflow_context array.
> > '''
> >
> > @Matt, could you please help me to update these commit logs? Thanks.
>
> Thank you for having checked that!
>
> I just applied these modifications in our tree. While at it, I also
> updated Mat's email in these "old patches":
>
> New patches for t/upstream:
> - 785ba39756ad: tg:msg: update requested by Geliang
> - 24db5bf84b4b: tg:msg: update requested by Geliang
> - d25098265693: tg:msg: fix Mat's email address
> - 4e6cab447490: tg:msg: fix Mat's email address
> - 827901fa9870: tg:msg: fix Mat's email address
> - 95f83ee5251f: tg:msg: fix Mat's email address
> - 7b2bd7e15d81: tg:msg: fix Mat's email address
> - f6a3e846c8c0: tg:msg: fix Mat's email address
> - e7bd30b91bad: tg:msg: fix Mat's email address
> - 554ca1bca6a0: tg:msg: fix Mat's email address
> - 2d7584de4856: tg:msg: fix Mat's email address
> - 21c4f32abcb2: tg:msg: fix Mat's email address
> - ec51dec45885: tg:msg: fix Mat's email address
> - f74165f83ed1: tg:msg: fix Mat's email address
> - 4d597c39f9b8: tg:msg: fix Mat's email address
> - 23acfa97c761: tg:msg: fix Mat's email address
> - 0f63ac824dcd: tg:msg: fix Mat's email address
> - 06e13746b715: tg:msg: fix Mat's email address
> - 84db4f5a6f57: tg:msg: fix Mat's email address
> - 8ce5149322c5: tg:msg: fix Mat's email address
> - e132cd47cce7: tg:msg: fix Mat's email address
> - c385961fa9e7: tg:msg: fix Mat's email address
> - 8ad3b922a1b1: tg:msg: fix Mat's email address
> - Results: d3ccb2956067..e54740d33eef (export)
>
> > 3. mptcp: add sched_data helpers
> >
> > This is a BPF related patch. Maybe we can send it together with the oth=
er
> > BPF patches.
>
> Good to know, thank you! Is it the only patches from this list above
> that is BPF related and not an MPTCP refactoring that can be sent?

Yes, it's the only BPF related patch.

>
> > If so, can we just move this patch between the commit "mptcp: register
> > default scheduler" and "bpf: Add bpf_mptcp_sched_ops"?
> If that's OK, I will wait before moving the commit (it's a manual
> operation, always a risk to do something wrong) to see if it is really
> needed: the next step is to select which patches we can send (Mat will
> also re-review these patches). We can always select which patches we
> send and omit some as long as there are no conflicts. If there are some,
> I will do the modifications in our tree before.

I tried to move this commit, and found the conflict is small, and easy
to resolve.

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
