Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1D3482
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:43:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso7817099pjq.2
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FTX3IxpzCxR3cNO0rXS0NaRpuXRlApmXD3n9FDrg2gk=;
        b=Ksw5GYFG5B5bRLIhMLxbpvxPJx4v+kEKfSKYiftccwzSyZb7V6987pmd/o4GXT49OG
         EHZqlakPjT8OqzRVq3abL1WQ2xbo0jqOWQ4BGvwDUpxFwDpaGumK8RMrkFjgREEccWsg
         g1lWlpGmu+shE7+l4iPOAau+Wa0M2X9iYPWprSqHGdRQ/KyqrkZ7WYNvtxMDpwY2ZDf+
         UFiuC3BPVP+RVHGrJQDdwff5soDQmDy3m0vxYQwLB3oxSvvNlRFxgjEJnnOWk1P1UG6k
         3FO6v4o2+EIHKwcbsPfjZD4Pdk7Pr3ZTtYxLJYLLP2HusDQiI/2kCF8huvkpRLnZ+9DK
         ygpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FTX3IxpzCxR3cNO0rXS0NaRpuXRlApmXD3n9FDrg2gk=;
        b=SaOmgVLJipQCqRAx/V++z8WTXrpS45bfxKW7A5WEmZTaiYtwjU+Z5VUyrFCH7fHiN2
         wkVQm0WoUa8Bk/YGgevFeIngW2mqWdDTYOvhcc3twoUqR6YspbrGNONXm4/lxSiwf0VB
         k4zAXUsGMVpnTNyABLFYpOUTnaxgn6ApV2KBcVjjyArjnpgXn8VtnFe3A7bMk+PgzKzh
         6fJ6mmUJra6ReH++oa4pSUx2M0Yn2/akO1CMsib44qdKF1/OthJ57RjGstKaVxk7Z6Fq
         bFsIm9goOzojsmO4h/GrHKv2bcZz5qXNdtGQMn6Jh43GhquJ1JU1ImbCw+wuAERKR8vj
         O4rA==
X-Gm-Message-State: AOAM533fgUzt3VG53vqVNjtmNWnxmuf0cr0y6RUXCd84XEXMHCrpWTNZ
	GXPUbP+7ltVv3kJG2WGEfgZkti620ZIOqDULAQI=
X-Google-Smtp-Source: ABdhPJzs2F9OCpoX+ZHqsN6/yBlQ9UFfBcBq36YvDnBZBdWzhYmOYjoicAxdaOCnayMxzYcvFQrNDctn4BjjuynESgE=
X-Received: by 2002:a63:ef12:: with SMTP id u18mr26591403pgh.331.1627440206093;
 Tue, 27 Jul 2021 19:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627281326.git.geliangtang@xiaomi.com> <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
 <c41c35969415639a6e09036387ebe170da6b6fa5.camel@redhat.com>
In-Reply-To: <c41c35969415639a6e09036387ebe170da6b6fa5.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 28 Jul 2021 10:43:14 +0800
Message-ID: <CA+WQbwue6BB+H6CyE964hUyS0ajPWF4hT_U3GPThMnhkN7krcA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2021-07-26 at 14:45 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > This patch added the MP_FAIL suboption sending support.
> >
> > Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> > this flag is set, send out MP_FAIL suboption.
> >
> > Add a new member fail_seq in struct mptcp_out_options to save the data
> > sequence number to put into the MP_FAIL suboption.
> >
> > An MP_FAIL option could be included in a RST or on the subflow-level
> > ACK.
> >
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  include/net/mptcp.h  |  5 +++-
> >  net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
> >  net/mptcp/protocol.h |  3 +++
> >  3 files changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index d0b9e4a7121f..6c8c8592153d 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -60,7 +60,10 @@ struct mptcp_out_options {
> >       u16 suboptions;
> >       u64 sndr_key;
> >       u64 rcvr_key;
> > -     u64 ahmac;
> > +     union {
> > +             u64 ahmac;
> > +             u64 fail_seq;
> > +     };
> >       struct mptcp_addr_info local;
> >       struct mptcp_addr_info remote;
> >       struct mptcp_rm_list rm_list;
>
> This will conflict with: "mptcp: shrink mptcp_out_options struct". If
> this series is merged before the "mptcp: shrink mptcp_out_options
> struct" series, I think we can just add the new field here without any
> union and do the aliasing the the shirnk' patch.
>
> Otherwise ("mptcp: shrink mptcp_out_options struct" merged first), I
> think:
>
>                 struct mptcp_ext ext_copy;
>
> should be replace with:
>                 struct {
>                         struct mptcp_ext ext_copy;
>                         u64 ahmac;
>                 };

Do you mean that:

                struct mptcp_ext ext_copy;
should be replaced with:
                 struct {
                         struct mptcp_ext ext_copy;
                         u64 fail_seq;
                 };
?

Then the whole union is like this:

       union {
               struct {
                       u64 sndr_key;
                       u64 rcvr_key;
               };
               struct {
                       struct mptcp_addr_info addr;
                       u64 ahmac;
               };
               struct {
                       struct mptcp_ext ext_copy;
                       u64 fail_seq;
               };
               struct {
                       u32 nonce;
                       u32 token;
                       u64 thmac;
                       u8 hmac[20];
               };
       };

Do I understand correctly?

Thanks,
-Geliang






>
> mptcp_out_options should not change size that way.
>
> Cheers
>
> Paolo
>
