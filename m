Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8569624
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 16:46:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so10493205pjm.1
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUZRVKOOfeqCRceVd3UKCZK5M/bcGzdRqpgQT4pV7rE=;
        b=NfFVNgGdmHvhAaj5PwoI21Aq6mIek0wUmyWzMnYYio1TGevQOkkgUUbHjTuMH6oZjl
         40mzK2AXJCE6FG0AMv+ZKTFjjOKPlcpCVFS3eeRUlyMsW4yJkgpqaFPBf3/mLNvHDmge
         dFcflcs/+pr3fHRnZof1gYIVEWnsD1BIvGOy3Cf6eQmkB9vngm4TagW4LadQcL9Xilam
         /PjbS08sUVgBBR72/bMgevLN0yDFuN0nYlk4qHBI7f24lRYfgmCXVCDAOdA6Oavm/7mN
         mWHz46aUaBoCU0m6/VOiP3fMjtuBiRY07sUqNI3LCsIMilb7qXvAlf0c6Oga5tdVHUTY
         hM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUZRVKOOfeqCRceVd3UKCZK5M/bcGzdRqpgQT4pV7rE=;
        b=tJMiRqwQokaMDq1XysH98ziEH4ntdsxMAVLCxVA1JY2H6cNEZF1h/MxzRuOdtoIZks
         IZ3+1Ymm2Z9sGtY3rUJcpCj7GLzBO0bfCb5Rd8UpVg5zLLCTx0y9PR9mRiz54fpbuYVy
         cVg5IZPoV+B4NS1VJemF8erv++Uqf2/3NQq9emV25wg4WLJc6Q56OkrVQx9NZHkaLjU+
         thR415YxWdaE3cc9Ls0rGnGAbU6LIhHzp/AKg1StPkDfXND5NRrvbNgUsthWUQLsIqz9
         NtHFmIIMVcM5qPpiQKaIpHu3oR+X1kq88W6fRU7eWG3YspAiSmsJxb6BxCb1mL4g4bwP
         jl0w==
X-Gm-Message-State: AOAM531otmj0sA6m/ye5r/gItaKxyuT8XZms5LfCPoSwJ7E45g7A+ufK
	sTFIA/k+1RWT1MIfPIz+X+X6YNBDOrS9GWpxsbnohTSS51U=
X-Google-Smtp-Source: ABdhPJwuo/wuodVenxqC4tVXrc2Jhu8iPYHti9lNzImBGXhA3/TKON39Qgwa4WqI348meQ8o92rSwj47QLjerf2aYwM=
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id
 x3-20020a170902820300b0015f44236e9cmr9914488pln.25.1652546817983; Sat, 14 May
 2022 09:46:57 -0700 (PDT)
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
Date: Sun, 15 May 2022 00:46:56 +0800
Message-ID: <CA+WQbwvKWodtjjjFyidvzXVCAj=0-qYinvvbUUd=QjUQ+oejyQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

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

Yes, I prefer not to change the alignments, it's much easier. If we
want to change them, it's better to squash the changes into the
original patches.

Thanks,
-Geliang

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
