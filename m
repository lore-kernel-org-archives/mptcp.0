Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67531103
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 05:26:25 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id c9so16413937plh.2
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2WVonoFPACFUipe4NbRFbFN0nIUqkUG23uCq63i0slg=;
        b=kWZOdkG/WGjrNsg4LLI2XmwxAcqNqCArzdhqe6iMtZ69KhpjYOk6+iLNRtw4FykbJW
         umAmEN1y/7dY+S2CpIK5IDV3KFRO/D/VoKoAOF5x7rtB7+knZFi/IbSax8K+zOLTJ8Sy
         j8Jdgmnq4lmjtczodGEUHEaAWpFA4QLQjYzPzhdNnmb+RVi4rmwULabWH18XkTgam++L
         2+5++P4tk66RWklGfQ0bbgxya3lFy2QuVkK2VMiq3i7vpvGdU+nZ3+7t7Dqrx0sA8n2O
         k08NdQ3RhIEEqne4RqD952G79A2HidPPhIP7VPiErqQA62wzMo5XEvwGFzmA+ibCBq9I
         gXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2WVonoFPACFUipe4NbRFbFN0nIUqkUG23uCq63i0slg=;
        b=YtgkOdJfF2xEHW43xVW+qG//GtVy7rBdDH8StsrIzeE/Rb31sqs7RNuAVZ3IrrfhwL
         I9yvVtuemp+sKdx+u9dQ9ENOElyVPA7/fwDIs+9vsTd4XU+FubaShVcqUIu0UmG9/X2+
         fVkDhhKgg9GgVTZYRfvRAkV8WOW5OhqhqmK+5e0hjiG/lND0n+GDDgKtRwwa3mRtXEbJ
         9RsK68qqCuH0k1ZOfLdqBv1//+g0SDLWMSGoMXbmHjaa2P5mPRv1XLjOpVt3u++QXwOh
         9WHpjTu58u+u+rRnZ1C7FhuOg80vJLTyDWavcUQEACF39OIuw/0nehOXPQSGVpkQ3XzY
         4HgQ==
X-Gm-Message-State: AOAM530+hOY/lRFTIfVTMF7YB5GIecni8Fy4lMMpf6LheFS6aD/6PWOv
	2sgwsFesWf2sIilIQ5lzrL0CyPXAxjsdPetp/60=
X-Google-Smtp-Source: ABdhPJxK1Sb9OABVsqLNuytHUY1ylQaSlSN1Hel7uikdJalz39L2h+1JgEOmorQh2bp5PA3zlxmdvjWvP0sIBL27BX4=
X-Received: by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP id
 t15-20020a1709028c8f00b0015eab1c591bmr21116189plo.171.1652765185372; Mon, 16
 May 2022 22:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-2-mathew.j.martineau@linux.intel.com> <20220517010730.mmv6u2h25xyz4uwl@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220517010730.mmv6u2h25xyz4uwl@kafai-mbp.dhcp.thefacebook.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 17 May 2022 13:26:27 +0800
Message-ID: <CA+WQbwvHidwt0ua=g67CJfmjtCow8SCvZp4Sz=2AZa+ocDxnpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: add bpf_skc_to_mptcp_sock_proto
To: Martin KaFai Lau <kafai@fb.com>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 13, 2022 at 03:48:21PM -0700, Mat Martineau wrote:
> [ ... ]
>
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 8b1afd6f5cc4..2ba09de955c7 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -284,4 +284,10 @@ static inline int mptcpv6_init(void) { return 0; }
> >  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped)=
 { }
> >  #endif
> >
> > +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
> > +struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> Can this be inline ?

This function can't be inline since it uses struct mptcp_subflow_context.

mptcp_subflow_context is defined in net/mptcp/protocol.h, and we don't
want to export it to user space in net/mptcp/protocol.h.

>
> > +#else
> > +static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct so=
ck *sk) { return NULL; }
> > +#endif
> > +
> >  #endif /* __NET_MPTCP_H */
>
> [ ... ]
>
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > new file mode 100644
> > index 000000000000..535602ba2582
> > --- /dev/null
> > +++ b/net/mptcp/bpf.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Multipath TCP
> > + *
> > + * Copyright (c) 2020, Tessares SA.
> > + * Copyright (c) 2022, SUSE.
> > + *
> > + * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> > + */
> > +
> > +#define pr_fmt(fmt) "MPTCP: " fmt
> > +
> > +#include <linux/bpf.h>
> > +#include "protocol.h"
> > +
> > +struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> > +{
> > +     if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
& sk_is_mptcp(sk))
> > +             return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> > +
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
> Is EXPORT_SYMBOL needed ?

Will drop in v5.

Thanks,
-Geliang

>
