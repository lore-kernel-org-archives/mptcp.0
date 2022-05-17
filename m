Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78471854
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 17:00:58 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id a76so14994952qkg.12
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JQfz7/9xIwZXm9owxDLXdrtXLr0FcC/lv49DpFzTm/w=;
        b=KllF1yFDNMuYt8/7qrB0ktpdb+81T1SrApDtTOsVrHcMhq673CWem5wB4dLaly0uZB
         +0b4yDMOD+PUQ5PUeT61AfniwPm6jJfRNoaOTY5PEjT0a9Zg/UNuJSXbnp1OYnAyMJoP
         TPBwE6Vby5NWvsqTEhzb5xMRstgMpq4DPchwpx8a3w+nx1JkXIlYJovY04+TZyWe3C3+
         q+13GBcAXHa3Vh5Ef4VX6ka0TN4khAHdDou8zfQJTxA4MtI+OlWkN1I3I/8uDUOgh9sw
         G/AKWxJRpSKTEW1s42ASC1Vx0/5WdwiCAQkg9PFZaR/DArVMzvsPsXAflz+ftBLUMdKY
         EqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JQfz7/9xIwZXm9owxDLXdrtXLr0FcC/lv49DpFzTm/w=;
        b=CYm0t4l+hFtIhlr2mv2H5bnz4l75y8qJbJZteLrwGB4yfsUwT2rlPhcNLu+5SoKbJJ
         n7SYf0iNs/LFow5jBlK4Vz5pqJLqHFhBcx3SlcW1DbBZWMOiGy/GxDZf6KdGHunDaiAb
         6MhEPFEmZutBw1AkPN7rDQrL9hnZ8pRoPNDKMyQmSylOJ+W7IXf70QpRZhjR9syrSPpW
         t7noeNMi9CE2ZJCyN3RTW1v7TY6EIybzjnsAgvaMUbjsH9mewDByV/ku479m22UFPzvF
         9fCFoXUwpgScCT4Pzu4/TGz6uQEetCf0vKnnjRolIwFQvUAcgxMEqkcBaeuQo1dpIywH
         1cJg==
X-Gm-Message-State: AOAM530jCVjOpUDtjCtko6NrcPWqFaXfptbIN5ktpbyHaJn6wlf7Jywr
	/6qgIs6CjR4/Ia8r/aHnTXD6C44itsSF63v7rcs=
X-Google-Smtp-Source: ABdhPJyc0I91BWWjtZVgl+EUrAbG6Tfb9o74K2EpzYJFWxb9b781DfjS9ZrI6ajXliDgmZM28LTPoF7yVklrLtOEFRQ=
X-Received: by 2002:a05:620a:28c7:b0:6a0:5de3:e6 with SMTP id
 l7-20020a05620a28c700b006a05de300e6mr17521955qkp.464.1652806857719; Tue, 17
 May 2022 10:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-2-mathew.j.martineau@linux.intel.com>
 <20220517010730.mmv6u2h25xyz4uwl@kafai-mbp.dhcp.thefacebook.com> <CA+WQbwvHidwt0ua=g67CJfmjtCow8SCvZp4Sz=2AZa+ocDxnpg@mail.gmail.com>
In-Reply-To: <CA+WQbwvHidwt0ua=g67CJfmjtCow8SCvZp4Sz=2AZa+ocDxnpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 May 2022 10:00:46 -0700
Message-ID: <CAADnVQJ8V-B0GvOsQg1m37ij2nGJbzemB9p46o1PG4VSnf0kSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: add bpf_skc_to_mptcp_sock_proto
To: Geliang Tang <geliangtang@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>, Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2022 at 10:26 PM Geliang Tang <geliangtang@gmail.com> wrote=
:
>
> Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:07=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, May 13, 2022 at 03:48:21PM -0700, Mat Martineau wrote:
> > [ ... ]
> >
> > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > index 8b1afd6f5cc4..2ba09de955c7 100644
> > > --- a/include/net/mptcp.h
> > > +++ b/include/net/mptcp.h
> > > @@ -284,4 +284,10 @@ static inline int mptcpv6_init(void) { return 0;=
 }
> > >  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mappe=
d) { }
> > >  #endif
> > >
> > > +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
> > > +struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> > Can this be inline ?
>
> This function can't be inline since it uses struct mptcp_subflow_context.
>
> mptcp_subflow_context is defined in net/mptcp/protocol.h, and we don't
> want to export it to user space in net/mptcp/protocol.h.

The above function can be made static inline in a header file.
That doesn't automatically expose it to user space.
