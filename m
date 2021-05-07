Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2270
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 09:08:26 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id b21so4851641plz.0
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WRtBax7TSwOrUVSx+JT9mYE7t4rYOR59aF793iibzoM=;
        b=RNxGh6/DUo7D3NIiEY54b62D2bGxk+ifWadFMu7xVfmeVFmaa/vuaUiKa/D2Td3t31
         q9RDMKRhkBGJSeYanfIkP8iLhXML3QjvBCsh6AVc4aEofyIZ+ZbT9+Bm30IJ6tn+g5Vi
         6YWInxn35rWeskQkjx4YvOugtsjOwuEqzH+FVQQCi1gZejwxE5fZIKv2GVpn0Y44Ql7y
         rDXKm1nE3QQEdeDNZDwKwj/2Z3euofvdizInW8g51RG0r6cSJnzHYNpxlmDLlaYze0nM
         yVkVrZr2ylR1YeKD97lGILpQaDstiSAv40UcfhGzeo0t8eJzp+yvZmNleCCE7yQqqthk
         GRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WRtBax7TSwOrUVSx+JT9mYE7t4rYOR59aF793iibzoM=;
        b=EEDt1IS9fl1aeV6xI0/yOq2wzpq4uCXp7B2c7Zk1d77zK/QgNvzO76cuxxUOPVmaK5
         q2JEx2PEln+EM+rL6dc7Sfm6WM+1w7t4hEYFrLb+eOyCGf/UxO/JbplXgR9sHA1Gn/Mk
         P1MHZZeR2Xn66ZZX/0/iVMbnQHEV8kGVS6b1odUE+f2s9FhugExXXcKowsrSyci/RaBp
         VdKbJ3x7FEwDllm5kgmAmsSHk8nmpVFt8NdxZKSX+24pliYS4XJhIEBiFk9msBL528S9
         8jKhss3XLoKov1/zU8bqba95ZW1XRxV7Hoz3s3JtdISI9Q4PCDTTofHqhlmWdjqhwFQA
         aqlQ==
X-Gm-Message-State: AOAM530MrRbO4lhfqweXNIGKLdhTqIGw0bIG/jZuIwkFkQTq/4ND7jbH
	xnU0WEXsf/S9O0tmMSOBXAfsDxKRdC6AMuZDU1tz0qh/8hc=
X-Google-Smtp-Source: ABdhPJyrrSqqEY3juQ+ODI7c8Fz5pIZdMkYhz4295I7iSzUFUTeBCQKy/GnugfN96OKzHqInH5OK7TB1bMMpY4fXuAU=
X-Received: by 2002:a17:902:b68c:b029:e6:bb9f:7577 with SMTP id
 c12-20020a170902b68cb02900e6bb9f7577mr9061714pls.0.1620378506009; Fri, 07 May
 2021 02:08:26 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
 <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net>
In-Reply-To: <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 7 May 2021 17:08:14 +0800
Message-ID: <CA+WQbwvfLSqK5uWUmNrPwzazwXV2HNUXU_8HUz6dxifYmRTGCw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin enabled
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your review.

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Geliang,
>
> On 07/05/2021 09:58, Geliang Tang wrote:
> > This patch fixed this fallback error:
>
> Thank you for the patch!
>
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index f3e379a0f08d..940b32511443 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp_so=
ck *msk, struct sock *ssk,
> >        * MP_JOIN subflows.
> >        */
> >       if (!mp_opt->mp_capable) {
> > -             if (subflow->mp_join)
> > +             if (subflow->mp_join || mptcp_data_fin_enabled(msk))>    =
               goto reset;
>
> I don't think we should send a reset here. For me this behaviour is norma=
l.

Yes, we don't need to send a reset here. What about just return here?
Something like this:

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3428c163299b..bd62dadfefdb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -905,6 +905,8 @@ static bool check_fully_established(struct
mptcp_sock *msk, struct sock *ssk,
        if (!mp_opt->mp_capable) {
                if (subflow->mp_join)
                        goto reset;
+               if (mptcp_data_fin_enabled(msk))
+                       return false;
                subflow->mp_capable =3D 0;
                pr_fallback(msk);
                __mptcp_do_fallback(msk);

-Geliang

>
> When looking at the debug trace:
>
> > <7>[ 1485.133416] MPTCP: msk=3D00000000875940e7, token=3D2833190200 sid=
e=3D0
> > <7>[ 1485.134972] MPTCP: msk=3D00000000875940e7 snd_data_fin_enable=3D0
> shutdown=3D3 state=3D4 pending=3D0
>
> It looks like the userspace has closed the connection:
>
>   mptcp_close() =E2=86=92 __mptcp_wr_shutdown()
>
> There we do:
>
>   /* will be ignored by fallback sockets */
>   WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
>   WRITE_ONCE(msk->snd_data_fin_enable, 1);
>
> > <7>[ 1485.134987] MPTCP: msk=3D00000000875940e7 snd_data_fin_enable=3D1
> pending=3D0 snd_nxt=3D13562085501921405457
>
> From:
>
>   __mptcp_check_send_data_fin(sk);
>
> > <7>[ 1485.135233] MPTCP: msk=3D00000000875940e7 state=3D4
>
> From:
>
>   mptcp_close()
>
> > <7>[ 1485.135472] MPTCP: check_fully_established:fallback to TCP
> (msk=3D00000000875940e7)
>
> It means we certainly got a FIN back:
>
>   mptcp_incoming_options() =E2=86=92 check_fully_established()
>
> > <7>[ 1485.339305] MPTCP: msk=3D00000000875940e7 snd_data_fin_enable=3D1
> pending=3D0 snd_nxt=3D13562085501921405458 write_seq=3D135620855019214054=
58
>
> From:
>
>   __mptcp_check_send_data_fin()
>
> But here we will not send the DATA_FIN because we did a fallback to TCP.
> But we change the state to properly close the socket.
>
> > <7>[ 1485.339329] MPTCP: msk=3D00000000875940e7
>
> By chance, do you have a packet trace to confirm that?
>
> It's unclear to me if we send a DATA_FIN in this case. I guess we should
> not if we are not in fully_established and I think that's what we do but
> I'm unsure now.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
