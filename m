Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE791A52
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 05:56:50 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id i1so13467624plg.7
        for <mptcp@lists.linux.dev>; Sun, 15 May 2022 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B+Hqzju6VDK5KrEndBmnFefXD0HFV3v5N+/GGIBDlhQ=;
        b=iO45jJHP2kUxGqr8cqwVNa1LAdajOf3RxgLeQRw+Ei0WQV83uQTZmo4Ng81qi44SC0
         inCKclTmd782/vK1IQYmrrkYKzPx7eX4TulHhPvuZPtUmRqQLKUbEdf+KBp3YwSwJorF
         5nKMatjN91sz+WrQPgFQT/NHCwn7hZ4+drRjRISj8T44bt5Itp7bbwM0GUxxqbZ1EtAP
         foawmqLOGOGhyFPT0tllkCpesEboWZnu47kRRTOhBRelbD2PSZSH1uRG0DP61u6Sztn4
         l57P4alylzQOiulNjexe3/T8P8nITWQDp9ckxO6Y01I2dYoz4xehCtaClUyr6KMyYOm9
         0GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B+Hqzju6VDK5KrEndBmnFefXD0HFV3v5N+/GGIBDlhQ=;
        b=Lw8hs273nPSD029H5alfA/OAmqeCln/Xo6Yd4yE/noOFpWDLUC9XJ9YgiTc9hepYWI
         Ri8pcAkWf2PLogFOiBlPETgA9h7i89BFbVca76cfEvsWMaanGbjdCmVtocqbbMrxd+2Z
         3u0EKA/0hzNlGYFg9WJCt40/n2mN0zxYy0ttn8G3tA2dGV1yI6gTmhimBrCStEvFFBoA
         metzU5DYtwAyEjOmgiCTcVzTo0AGm/0zVJiu3RJWqcvaqFUGk9i1XK45FrmQPxXws8AO
         iRL8l7pR8lQg2BLGNro0qmbPbx9XC24Q5nBlk46wckPFDlImYngXjNFXQcfoBEMvy1nr
         3A5Q==
X-Gm-Message-State: AOAM531bVnJlnncJkSI0bcZM+0SCiNlYQ/lP/GcHG0a2xfnXFxHuvd55
	OXCt1U9YoUZEjpj0kX0/jz5lx/8+uzEmptmrCRE=
X-Google-Smtp-Source: ABdhPJzfunX+EFiyvAi9NfcZhcyR0BxsWbe81sYuhPH8fw7jTGrC/AsBV3GHabWzday/+xw/1jV1KE26CZLy7I8pcZs=
X-Received: by 2002:a17:90b:4b4b:b0:1dc:8724:3f75 with SMTP id
 mi11-20020a17090b4b4b00b001dc87243f75mr28695767pjb.178.1652680610370; Sun, 15
 May 2022 22:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1652255615.git.geliang.tang@suse.com> <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
 <20220514154845.GA4189@bogon.HOST> <f697c655-618e-841c-4f60-3c57078e4a76@tessares.net>
In-Reply-To: <f697c655-618e-841c-4f60-3c57078e4a76@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 16 May 2022 13:56:51 +0800
Message-ID: <CA+WQbwtSnOYMfwaug4W1SsaBmtCxCB_9N41ZjbQPNOgNVdoq2w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B45=E6=
=9C=8815=E6=97=A5=E5=91=A8=E6=97=A5 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 14/05/2022 17:48, Geliang Tang wrote:
> > On Sat, May 14, 2022 at 01:25:35PM +0200, Matthieu Baerts wrote:
> >> Hi Geliang, Mat
> >>
> >> On 11/05/2022 09:56, Geliang Tang wrote:
> >>> v2:
> >>>  - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
> >>>  - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin=
 & Andrii)
> >>>
> >>> base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
> >>> net-next-next") on export/20220510T054929
> >>>
> >>> v1:
> >>>  - drop bpf_mptcp_helpers.h (Andrii)
> >>>  - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat=
)
> >>
> >> Thank you for the patches.
> >>
> >> I *think* everything is now sync in our tree but feel free to check
> >> because I had to "manually" compare patches with what was in our tree.
> >>
> >> But in theory, our tree is now ready for a v5.
> >
> > Thanks Matt, but three patches still need to be updated:
> >
> > Patch #4, selftests/bpf: test bpf_skc_to_mptcp_sock
> >
> > if (!tcp_sk->is_mptcp) {
> >
> > ->
> >
> > if (!is_mptcp) {
>
> Thank you, I missed that!
>
> - a973ee164a70 tg: fix wrong merge conflict resolution

Hi Matt,

Here should be:
        if (!is_mptcp) {
not:
        if (is_mptcp) {

Otherwise, the mptcp bpf selftests failed.

I just sent a squash-to patch to fix this.

Thanks,
-Geliang

>
> > Patch #10, mptcp: add sched in mptcp_sock
> >
> >  struct mptcp_sock {
> >       struct inet_connection_sock     sk;
> >
> > -     __u32           token;
> > -     struct sock     *first;
> > -     char            ca_name[TCP_CA_NAME_MAX];
> > +     __u32                   token;
> > +     struct sock             *first;
> > +     struct mptcp_sched_ops  *sched;
> > +     char                    ca_name[TCP_CA_NAME_MAX];
> >  } __attribute__((preserve_access_index));
> >
> > ->
> >
> >       __u32           token;
> >       struct sock     *first;
> > +     struct mptcp_sched_ops *sched;
> >       char            ca_name[TCP_CA_NAME_MAX];
> >  } __attribute__((preserve_access_index));
>
> I did that on purpose, I thought it was clearer to read after.
>
> Do you prefer not to change the alignment?
>
> > Patch #13, selftests/bpf: add bpf_first scheduler
> >
> > bpf_mptcp_helpers.h
> >
> > ->
> >
> > bpf_tcp_helpers.h
>
> Thanks!
>
> - fc2aafca4737: bpf: use bpf_tcp_helpers.h instead of the mptcp one
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
