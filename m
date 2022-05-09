Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635423A8
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 21:00:30 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id f4so16661050iov.2
        for <mptcp@lists.linux.dev>; Mon, 09 May 2022 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfa+L1MKfwEVwek6Xm7/cKDId/OMBsX1x8UVDLlmeV4=;
        b=GCcrFI3Odr9GEQgYk8BV9rgcTKJnDUVqyrcwwE8GZdomb9ZZZ40xoKK1GBfnEosnPj
         u9IrBFEnhZVUHU8eaZjvaGo70R4xC5KXjvW29q5KhLYK/fo6usoEYN6MIeeV0lc2ZdR6
         x8dHu9Igf9AZjD0htWBDkZJgLP1JAG1nHNiKXfE+1TG9kOET4UfllxU5HDxhmv/jhDzO
         VuF8hIfIi1d9kPdYYJqH02+/Z6zpxd5R65F++gsJoKvarCKcd6lrZ29HtkORxGzOOxGT
         lP50Np5GQIk5WOeqdt8FqjvmP4yvwoaAG3FYMg8B6a91RV7dqj/fnUaYpvtKmNhjnjv7
         Hzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfa+L1MKfwEVwek6Xm7/cKDId/OMBsX1x8UVDLlmeV4=;
        b=xHPQlYCiojjlme5uAhjOQuxOxu3Y2uzPLXx4xiybKNFOlAha3uMlxLoRQcHpbUn1N0
         164d0pV9GAfBmJZQUzHF7X3T0fmNMvOmzYwZ36KOzvexCCRpWDDKsNWbtCxNnpkMw7jp
         OpJ0B4ydKpUTUW4625hHl7wHXnVtjr+Y3FWC8hFX4gFkuIhnk0+/owrannopD4Q7eCUr
         A9Hxv63L4h4w3WAU0ruz+WES9FUKLrLTsBUcf+jEBzba5Kct9TL1Abgy0kDWxRb+A2UE
         RNJWU0nB1ydFqvJt2xWCE2CWn1Z92VMhs3w+UVJurFMga07IhYKEOumwQ0tdmm9GPNz9
         /+xQ==
X-Gm-Message-State: AOAM530KG+wbbPNtEJsUSSKsynLDFkcv7D6OnswsU4YHyWtZr5W4p3Cm
	VHsYFKaN4MXv+MTPDDAl/7q0rb0g2ZS/Q3uCxkc=
X-Google-Smtp-Source: ABdhPJwSq+cVlV6IA0h/x6EIQOBZsDxmow6vmYrzlXG44EPzm6h31VbH2TlRahj+ZSCn2GWJWzi9tjE0CBuyemGsSfY=
X-Received: by 2002:a05:6638:16d6:b0:32b:a283:a822 with SMTP id
 g22-20020a05663816d600b0032ba283a822mr8275162jat.145.1652130029615; Mon, 09
 May 2022 14:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
 <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
 <CAEf4BzY-t=ZtmU+6yeSo5DD6+C==NUN=twAKq=OQyVb2rS2ENw@mail.gmail.com> <8afe6b33-49c1-5060-87ed-80ef21096bbb@tessares.net>
In-Reply-To: <8afe6b33-49c1-5060-87ed-80ef21096bbb@tessares.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 May 2022 14:00:18 -0700
Message-ID: <CAEf4BzbwGHtoEooE3wFotgoYi8uDRYJcK=Y0Vdt-JUtWi4rqhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/8] selftests: bpf: test bpf_skc_to_mptcp_sock
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Geliang Tang <geliang.tang@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, May 9, 2022 at 2:00 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Andrii,
>
> Thank you for the review!
>
> On 07/05/2022 00:26, Andrii Nakryiko wrote:
> > On Mon, May 2, 2022 at 2:12 PM Mat Martineau
> > <mathew.j.martineau@linux.intel.com> wrote:
>
> (...)
>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 359afc617b92..d48d3cb6abbc 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -13780,6 +13780,7 @@ F:      include/net/mptcp.h
> >>  F:     include/trace/events/mptcp.h
> >>  F:     include/uapi/linux/mptcp.h
> >>  F:     net/mptcp/
> >> +F:     tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> >>  F:     tools/testing/selftests/bpf/*/*mptcp*.c
> >>  F:     tools/testing/selftests/net/mptcp/
> >>
> >> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> >> new file mode 100644
> >> index 000000000000..18da4cc65e89
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> >> @@ -0,0 +1,14 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (c) 2022, SUSE. */
> >> +
> >> +#ifndef __BPF_MPTCP_HELPERS_H
> >> +#define __BPF_MPTCP_HELPERS_H
> >> +
> >> +#include "bpf_tcp_helpers.h"
> >> +
> >> +struct mptcp_sock {
> >> +       struct inet_connection_sock     sk;
> >> +
> >> +} __attribute__((preserve_access_index));
> >
> > why can't all this live in bpf_tcp_helpers.h? why do we need extra header?
>
> The main reason is related to the maintenance: to have MPTCP ML being
> cc'd for all patches modifying this file.
>
> Do you prefer if all these specific MPTCP structures and macros and
> mixed with TCP ones?
>

These definitions don't even have to be 1:1 w/ whatever is kernel
defining in terms of having all the fields, or their order, etc. So I
think it won't require active maintenance and thus can be merged into
bpf_tcp_helpers.h to keep it in one place.


> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
