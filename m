Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA64A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 12:02:50 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id h29so14415662vsq.9
        for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6qMESVU5eHy8DB9DW8FibIJq4nFBt6CjQ7R8xirnNI=;
        b=VXriok+9muCUpJkk6XMYZpAAcnL6I9NP1CKoeFTgRD5S6OD4Rulq4MSIGRmSCkmzOF
         u3ifAY8alNz14AEN2SKifJsFjOdHkv2RrGFG7VSG1oSuzLt82s6aA/z/8kf7E+84ItIY
         CbbIBVgMmkJDbcdWVfaWeNqwhvVfcJJ4aqBag5BJbgflcL5kVUQXY2QLdKxhJ16BrA7w
         c2tNHZXBQXKhOMSR7jLJ0Qh/6xSis4yAkCtWYPkUQp2is6sgRhDy5ilvyMjurnhYf/ab
         5vlug3ZI9BOrzd82WLF1Eq4h4c/b+V5MA3Ayr8awWYfr4vjKCNbaJRTNpCe6paL3pqN9
         4hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6qMESVU5eHy8DB9DW8FibIJq4nFBt6CjQ7R8xirnNI=;
        b=QnVNHVjG/vXNo0hquV3dF09P/HzInf4B5IppPPNE87MBKFj1h+FyFyOICp1KzJCJT/
         B4N1Zv/VjDsl8N4FTLTC6ZjBAjzy8n5fP7befBQhXIgQLRXR9Rg0ecTJ7fY4VV3f7Pr1
         13/p7/eecuWu+Y/VqqRoY3ZA8HV3bECVP/SemLX7TIf5TqKwerq5juqWd+9gwzPSxvat
         hGk0Q6FJ+3ZbMZ7/BSGdsKrJlksaeIWvOrt2W4HM/a4922wBoHviaFWgZswbFrhsD18z
         huMWypKMSUK8y9/+aFlAwCuC5zPY7O3jI8zzGXxasyHqGWsvCZLwhkP190ZbQto6AGZE
         RMpg==
X-Gm-Message-State: ACrzQf12QigwOD3sknkZ1Klyhie7FTZ3zpAMxg0v+if2JeQlLsN93U/5
	J/eaIGu7U1/hNoJQDCPVLTnw8SWd3KTFvs5ThJI=
X-Google-Smtp-Source: AMsMyM42lcXnDVmELbCxFIBEkOngvm55ioe/w9QxeXEcSkQfyay5GfmESVXk67C0+f6xqYOsrDvElMXwRZCTi0adc/M=
X-Received: by 2002:a05:6102:3131:b0:3a7:cd4:a284 with SMTP id
 f17-20020a056102313100b003a70cd4a284mr974165vsh.37.1666094568834; Tue, 18 Oct
 2022 05:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221011120137.5475-1-geliang.tang@suse.com> <20221011120137.5475-7-geliang.tang@suse.com>
 <d2926dc5-f72d-f104-d982-78215924d96e@linux.intel.com> <20221012103651.GA15335@bogon>
In-Reply-To: <20221012103651.GA15335@bogon>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 18 Oct 2022 20:02:41 +0800
Message-ID: <CA+WQbwv1+jcAHM0M=g7dkienex7Pog64vp3ZXhabOkpGmL8hsg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v6 06/13] mptcp: multi subflows push_pending
To: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliang.tang@suse.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 18:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 11, 2022 at 03:30:43PM -0700, Mat Martineau wrote:
> > On Tue, 11 Oct 2022, Geliang Tang wrote:
> >
> > > This patch adds the multiple subflows support for __mptcp_push_pendin=
g().
> > > Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send(=
) in
> > > it.
> > >
> > > Check the subflow scheduled flags to test which subflow or subflows a=
re
> > > picked by the scheduler, use them to send data.
> > >
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > ---
> > > net/mptcp/protocol.c | 32 ++++++++++++++++++++------------
> > > 1 file changed, 20 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 817e539d1d12..86ac38d10bc4 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -1561,22 +1561,30 @@ static int __subflow_push_pending(struct sock=
 *sk, struct sock *ssk,
> > > void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > > {
> > >     struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > -   struct mptcp_sendmsg_info info =3D {
> > > -                           .flags =3D flags,
> > > -   };
> > > -   struct sock *ssk;
> > >     int ret =3D 0;
> > >
> > > again:
> > > -   while (mptcp_send_head(sk) && (ssk =3D mptcp_subflow_get_send(msk=
))) {
> > > -           lock_sock(ssk);
> > > -           ret =3D __subflow_push_pending(sk, ssk, &info);
> > > -           release_sock(ssk);
> > > +   while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
> > > +           struct mptcp_subflow_context *subflow;
> > > +           struct mptcp_sendmsg_info info =3D {
> > > +                   .flags =3D flags,
> > > +           };
> > >
> > > -           if (ret <=3D 0) {
> > > -                   if (ret =3D=3D -EAGAIN)
> > > -                           goto again;
> > > -                   goto out;
> > > +           mptcp_for_each_subflow(msk, subflow) {
> > > +                   if (READ_ONCE(subflow->scheduled)) {
> > > +                           struct sock *ssk =3D mptcp_subflow_tcp_so=
ck(subflow);
> > > +
> > > +                           lock_sock(ssk);
> > > +                           ret =3D __subflow_push_pending(sk, ssk, &=
info);
> > > +                           release_sock(ssk);
> >
> > Geliang -
> >
> > It seems like this doesn't allow for redundant transmits, since
> > __subflow_push_pending() updates msk->first_pending. Did you find that
> > redundant sends were working correctly (maybe I've misunderstood)?
>
> Hi Mat,
>
> Redundant sends are not support in this series yet. It will be added in
> this __subflow_push_pending() function in the next series with the
> selftests patches.
>
> There are still some issues that haven't been solved in the redundant
> support patches. I'm still working on them.

Hi Mat,  I have good news. I finally solved these issues today and
sent a new version, "BPF redundant scheduler" v13 . Now redundant
sends are support in it, and all selftests (mptcp_connect.sh,
mptcp_join.sh and simult_flows.sh) passed.

>
> Thanks,
> -Geliang
>
> >
> > - Mat
> >
> > > +
> > > +                           if (ret <=3D 0) {
> > > +                                   if (ret =3D=3D -EAGAIN)
> > > +                                           goto again;
> > > +                                   goto out;
> > > +                           }
> > > +                           mptcp_subflow_set_scheduled(subflow, fals=
e);
> > > +                   }
> > >             }
> > >     }
> > >
> > > --
> > > 2.35.3
> > >
> > >
> > >
> >
> > --
> > Mat Martineau
> > Intel
>
