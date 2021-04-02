Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFE259F
	for <mptcp@lists.linux.dev>; Fri,  2 Apr 2021 03:36:03 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id l4so5747201ejc.10
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/feRqnk9XCAaBm8Co3/DfbKvz8sHVJ5rb1TiG3wG0A=;
        b=BPbtcN8JWynQ9/yTE/0ZkVKZduzGAU+H9550fwCgQ0d6p9f8ezOZ+BWOvpOHpTGW5x
         YkxwizQCZJvBBeMnhSrADPNmMlmqMzAzgJqkgnwWype3UEK5uTba1kws8TFfrroP12Sh
         mlHMLubnnoeSBmZM9b9HYcOOSiAC22vWL7v6akjbxEvtqosQqO6XKILgmuWwcySjuLMR
         /fodoDqYyJzsbk2U4IU1gtw+EzO40foJiXCc2ceeJ3T9JVu9I6UVyT2AMwwfFOfeByyV
         AMYC6HfiS8fOeFZN6KcgyoHuVwlZuWaXWE9u7/6cZ6w0BMAMVqm5ba1Iy9rnan2jPFWb
         cX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/feRqnk9XCAaBm8Co3/DfbKvz8sHVJ5rb1TiG3wG0A=;
        b=QjYFrClWnewB8TckqJpAAK/IJbDbp08SX1FC/W3Ra32qYdwTVKoFYIcOMyUG63QsXJ
         Cw7wYqhIRTzngCjk9/xTLtiL+UOMBCPdmiOePInaED7nSrO9IdhtShYR5u03m2jJODjg
         APft0mdwZ+tKy53P/OTmOeEWK9zqRhSqgPdlzXKe6J8gH1GEn7pqQ3xNaXXl7Li6VXX1
         DHLCf5E7WbwXJci7zvyZGE9678JEgCX8nvsPi8ylwiQEEocB3UP/Wb35cVvLc00N407z
         +8OGk6SX5nWkEAMgSP0JneD0AcdNFoJTgVY04F+P3QJXgaBzBjXWQNLB2IU6HtJCXWzW
         xKIw==
X-Gm-Message-State: AOAM531zFM5rZOIWhCyJa9JxZWTVNcSgI+XEQA8uGUZCEYjsIOM97nV0
	4zjiCxTa9V+tagGJZB6LZJp/D9VIbrr5yxrq8+c=
X-Google-Smtp-Source: ABdhPJysG5N5vmNghT698cc+DFG4WnCXuDs4RQUL+aNuw9md/ffh2/+UQjldVA06HHIDAo6V+C8kyNDA2WKopwoPtpI=
X-Received: by 2002:a17:906:d554:: with SMTP id cr20mr12355871ejc.61.1617334562624;
 Thu, 01 Apr 2021 20:36:02 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
 <323c294f0f6161da5dad17306775172add7d0dc5.camel@redhat.com>
In-Reply-To: <323c294f0f6161da5dad17306775172add7d0dc5.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 2 Apr 2021 11:35:49 +0800
Message-ID: <CA+WQbwug7fgP_sZurx2Bf8XfC1k+hDPLWf4rZ8wFpUFcB1xUYg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add tracepoint in mptcp_subflow_get_send"
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note: v2 wasn't shown in ML since I forgot to cc mptcp@lists.linux.dev in
it. Sorry about that.

-Geliang

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2021-04-02 at 00:54 +0800, Geliang Tang wrote:
> > Reduce the indentation level and zero the uninitialized fields.
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  include/trace/events/mptcp.h | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.=
h
> > index f1c836573744..b1617a0162da 100644
> > --- a/include/trace/events/mptcp.h
> > +++ b/include/trace/events/mptcp.h
> > @@ -23,22 +23,29 @@ TRACE_EVENT(mptcp_subflow_get_send,
> >       ),
> >
> >       TP_fast_assign(
> > -             bool sk =3D sk_fullsock(subflow->tcp_sock);
> > +             struct sock *ssk;
> >
> >               __entry->active =3D mptcp_subflow_active(subflow);
> >               __entry->backup =3D subflow->backup;
> > -             if (sk) {
> > -                     struct sock *ssk =3D mptcp_subflow_tcp_sock(subfl=
ow);
> >
> > +             if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
> >                       __entry->free =3D sk_stream_memory_free(subflow->=
tcp_sock);
> > -                     if (ssk) {
> > -                             __entry->snd_wnd =3D tcp_sk(ssk)->snd_wnd=
;
> > -                             __entry->pace =3D ssk->sk_pacing_rate;
> > -                             if (__entry->pace)
> > -                                     __entry->ratio =3D div_u64((u64)s=
sk->sk_wmem_queued << 32,
> > -                                                              __entry-=
>pace);
> > -                     }
> > +             else
> > +                     __entry->free =3D 0;
> > +
> > +             ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +             if (ssk && sk_fullsock(ssk)) {
> > +                     __entry->snd_wnd =3D tcp_sk(ssk)->snd_wnd;
> > +                     __entry->pace =3D ssk->sk_pacing_rate;
> > +             } else {
> > +                     __entry->snd_wnd =3D 0;
> > +                     __entry->pace =3D 0;
> >               }
> > +
> > +             if (ssk && sk_fullsock(ssk) && __entry->pace)
> > +                     __entry->ratio =3D div_u64((u64)ssk->sk_wmem_queu=
ed << 32, __entry->pace);
> > +             else
> > +                     __entry->ratio =3D 0;
> >       ),
> >
> >       TP_printk("active=3D%d free=3D%d snd_wnd=3D%u pace=3D%u backup=3D=
%u ratio=3D%llu",
>
> LGTM, thanks!
>
> Paolo
>
