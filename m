Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F85F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 10:23:37 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id dm8so1363234edb.2
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rYhuESB7BnA7/7dsWukJBI+GLt2C2w7cQbm6NcgV+RM=;
        b=aLUBusBQ+UeJlJHMmJbfsjIlXSXqclmQLecU6wScBjX1oheLvUKjVDON6er9xJ0MSM
         pImUk7lpHlkJd2Sk1+TtDtveRaeZZlobKQrN5xoRraAK1oxGl8oKrmzwUOSDRp+6HLKW
         j0wflycvMSDPlciLByBCZkrqvW1XtANTDdO5HBH3t1b6iQzm9oybGHmNSRCymrx9CSwK
         DXDjBguIXvfz0xKla7itXR7WoZNxoV3NjRSvUfo7FNaAW0J+RMT9OYmS6YRheFtt68Yj
         Xx9MqyynQMpBpVnzTJf7BenXpbhESqjlnDo6Ow7oAN4rhnT5C8uYrDzgHAuv3JnE1zSB
         JDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rYhuESB7BnA7/7dsWukJBI+GLt2C2w7cQbm6NcgV+RM=;
        b=nY7MtPMRR/8Z6/cS4jApcKLM54Tjy/eihYEqFAsWbw9LfsyLro4UKtWNfyK2CXdclj
         sOQhxQ5gzc+MS9gp2zsy0J1ntb3unNR5r/5if7BGhV+lZ1y/g3UGauiuD4hnYketIdKs
         d8q7XRk28AxnUqiQrO7TFEmsoTOM4Rt/evOer+d6sVxgSM6GsWPHT9dufF4T4IhhCfLm
         /rtxGzCXTwtaZYo+10+A4VueE6pQGPzgG2M1QDDhhCBTmsVLPnQ+x1lzh96IdPurNCjV
         HqV0Y6PvpNabtcpDOmgQVLDtx7XJ1fYRP9lt9bXiiEVMzThSl4zWp55BXUYWE7l7cQcM
         kV8g==
X-Gm-Message-State: AOAM530mDZ3k3gUg+SZyqQpcWrcuMMzssC7DTc0IGkIDk9NrJJ9h0mom
	MbkcHsgIkmo6MOcAotJXuq1AJRW2NZz8Z48wtN8=
X-Google-Smtp-Source: ABdhPJx4s+48pnkIwzHtFa1gzfapFg398TUm8E5FDINFrT0I209FaXMFpFgD3ul4+ksmk+xRS2e4Z9pKifcoEa9rpYU=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr8903901edw.348.1617272616096;
 Thu, 01 Apr 2021 03:23:36 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1617175133.git.geliangtang@gmail.com> <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com>
 <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
 <0c7cbf71e4c5709da87ea91ea15bc67694195edc.camel@redhat.com>
In-Reply-To: <0c7cbf71e4c5709da87ea91ea15bc67694195edc.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 1 Apr 2021 18:23:24 +0800
Message-ID: <CA+WQbwv71rFLRb1yjAKwe5qx_eQJL46FYTnQMSDkkxsvzi=J+g@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v4 mptcp-next 2/5] mptcp: add tracepoint in mptcp_subflow_get_send
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=881=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2021-03-31 at 15:23 +0800, Geliang Tang wrote:
> > This patch added a tracepoint in the packet scheduler function
> > mptcp_subflow_get_send().
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  include/trace/events/mptcp.h | 53 ++++++++++++++++++++++++++++++++++++
> >  net/mptcp/protocol.c         |  8 +++---
> >  2 files changed, 57 insertions(+), 4 deletions(-)
> >  create mode 100644 include/trace/events/mptcp.h
> >
> > diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.=
h
> > new file mode 100644
> > index 000000000000..f1c836573744
> > --- /dev/null
> > +++ b/include/trace/events/mptcp.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM mptcp
> > +
> > +#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_MPTCP_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(mptcp_subflow_get_send,
> > +
> > +     TP_PROTO(struct mptcp_subflow_context *subflow),
> > +
> > +     TP_ARGS(subflow),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(bool, active)
> > +             __field(bool, free)
> > +             __field(u32, snd_wnd)
> > +             __field(u32, pace)
> > +             __field(u8, backup)
> > +             __field(u64, ratio)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             bool sk =3D sk_fullsock(subflow->tcp_sock);
> > +
> > +             __entry->active =3D mptcp_subflow_active(subflow);
> > +             __entry->backup =3D subflow->backup;
> > +             if (sk) {
> > +                     struct sock *ssk =3D mptcp_subflow_tcp_sock(subfl=
ow);
> > +
> > +                     __entry->free =3D sk_stream_memory_free(subflow->=
tcp_sock);
> > +                     if (ssk) {
> > +                             __entry->snd_wnd =3D tcp_sk(ssk)->snd_wnd=
;
> > +                             __entry->pace =3D ssk->sk_pacing_rate;
> > +                             if (__entry->pace)
> > +                                     __entry->ratio =3D div_u64((u64)s=
sk->sk_wmem_queued << 32,
> > +                                                              __entry-=
>pace);
> > +                     }
> > +             }
> > +     ),
>
> Minor nit: I think we can reduce the indentation level and probably we
> should zeroed the uninitialized fields, but I think we can do that
> eventually later with a squash-to patch. I suggest to merge this as is
> and than eventually improve later.

Thanks Paolo, I'll send the squash-to patch later.

-Geliang

>
> Thanks!
>
> Paolo
>
