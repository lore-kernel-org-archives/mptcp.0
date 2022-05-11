Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38928F9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 14:10:34 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so5052837pjb.3
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EZ+jDd+v2dXo5BBFbvqwTNalv/D617O+tquq7CV/RXA=;
        b=cOzqw2sDkoQL6DjsFN8gwlAfYMDSsTJE/EMAwVqZYNS1wkIc6Z3CCfi7WOuSQ/F1mE
         dTjN2nb5Te63CtNmYkPyOPJI+67jreZko5Dts9ermZHN8JN/QxSeFsfxSkTv7VH2EyqB
         vCApCD+5P+nrK+mGd6svJ/lSMpz9gg+uDO+B5YY7FKRnAYSbIOY3Px9kf3cbIw1ewlih
         Pv28i37x7nlOJP8WUqp4WqLsfzLGXLMe+MciPuWGG/h5jmJmvAPbN+x32AY1fS3EGjzs
         kjsZvd7vdPEcfVz7m6yDu530nKIAbRWUAPYj2pZIln3ThOxNdMCpit6CclDYk+JgfU//
         PlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZ+jDd+v2dXo5BBFbvqwTNalv/D617O+tquq7CV/RXA=;
        b=O1FqlHNlzr05/6zMOOEmGOZW00HEceavdCMBE/pQwTFoV5kHU9HOyF0a49IuUiiDCy
         UkbJfdG3SCutJY8xAlkVMe6FTAM+8OhYAz4vTdO9EVqJhYpdwMuyzJu/KjirsO5Y4/4r
         9hsDdDlrdG7Qol8hdkk1y3mTkfzrgTdjz3RKWfnwKwPAVwPJwYvT7FaoPWNMdCUcsU1y
         /UZViLf5JPvdKz5faG89a5cMMgslpSsqejmsaoMsTQDoZ88qeIyfWCUhYTgJaDoi93R5
         VCWZHBN+fpf5k9HMaa7AWGihTyPJvzk/FluojshQZ+ydX0VOjDtj9ESsXiZoYfYCIbo4
         3oTQ==
X-Gm-Message-State: AOAM531B5oxQzJHrdd5nqjnc1Mm+LZI7QFpszzHcb9njokDU5c3j0QoG
	qVMy+RFj6/z++Kyup9NKgtBdA/l3SXiDpvcN4mLRL3DQoZQdy+so
X-Google-Smtp-Source: ABdhPJwYwR85GjwuzFAWwG+ypzDszL2XV84c/jlsqUXwTiGICIv9SAwsmLxSGBmbGPx3Y0jeW+Yrg+j9zZQ4RSAe3wM=
X-Received: by 2002:a17:90a:e38c:b0:1de:b43f:f969 with SMTP id
 b12-20020a17090ae38c00b001deb43ff969mr5640532pjz.126.1652278233794; Wed, 11
 May 2022 07:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220510000320.82652-1-mathew.j.martineau@linux.intel.com> <7f458d7eaf9ed5180d9e3d0295949a717ba3c895.camel@redhat.com>
In-Reply-To: <7f458d7eaf9ed5180d9e3d0295949a717ba3c895.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 11 May 2022 22:10:30 +0800
Message-ID: <CA+WQbwt4F=ymHM2CqnyNKLK6ds+uvV36kRfimq-sBE9uSxmGPA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: Do TCP fallback on early DSS checksum failure
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=89 18:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2022-05-09 at 17:03 -0700, Mat Martineau wrote:
> > RFC 8684 section 3.7 describes several opportunities for a MPTCP
> > connection to "fall back" to regular TCP early in the connection
> > process, before it has been confirmed that MPTCP options can be
> > successfully propagated on all SYN, SYN/ACK, and data packets. If a pee=
r
> > acknowledges the first received data packet with a regular TCP header
> > (no MPTCP options), fallback is allowed.
> >
> > If the recipient of that first data packet finds a MPTCP DSS checksum
> > error, this provides an opportunity to fail gracefully with a TCP
> > fallback rather than resetting the connection (as might happen if a
> > checksum failure were detected later).
> >
> > This commit modifies the checksum failure code to attempt fallback on
> > the initial subflow of a MPTCP connection, only if it's a failure in th=
e
> > first data mapping. In cases where the peer initiates the connection,
> > requests checksums, is the first to send data, and the peer is sending
> > incorrect checksums (see
> > https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allow=
s
> > the connection to proceed as TCP rather than reset.
> >
> > Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > ---
> >
> > I tested this on the export-net branch along with Paolo's proposed
> > checksum fix ("mptcp: fix checksum byte order"). Testing between the
> > patched export-net kernel and 5.17.5-200.fc35.x86_64 (Fedora) showed th=
e
> > fallback succeeding if checksums are enabled on one side, export-net wa=
s
> > the listener, and 5.17.5 initiated the connection and sent the first
> > data. Without this patch, if one side has the fixed checksum byte order
> > then all connections would reset after a checksum failure.
> >
> > ---
> >  net/mptcp/protocol.h |  3 ++-
> >  net/mptcp/subflow.c  | 15 ++++++++++++---
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f4ce28bb0fdc..6c7e78ec88e8 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -443,7 +443,8 @@ struct mptcp_subflow_context {
> >               can_ack : 1,        /* only after processing the remote a=
 key */
> >               disposable : 1,     /* ctx can be free at ulp release tim=
e */
> >               stale : 1,          /* unable to snd/rcv data, do not use=
 for xmit */
> > -             local_id_valid : 1; /* local_id is correctly initialized =
*/
> > +             local_id_valid : 1, /* local_id is correctly initialized =
*/
> > +             valid_csum_seen : 1;        /* at least one csum validate=
d */
> >       enum mptcp_data_avail data_avail;
> >       u32     remote_nonce;
> >       u64     thmac;
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 8c37087f0d84..3a7b02a92239 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -955,11 +955,14 @@ static enum mapping_status validate_data_csum(str=
uct sock *ssk, struct sk_buff *
> >                                subflow->map_data_csum);
> >       if (unlikely(csum)) {
> >               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> > -             subflow->send_mp_fail =3D 1;
> > -             MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
> > +             if (subflow->mp_join || subflow->valid_csum_seen) {
> > +                     subflow->send_mp_fail =3D 1;
> > +                     MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX=
);
> > +             }
> >               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY=
;
> >       }
> >
> > +     subflow->valid_csum_seen =3D 1;
> >       return MAPPING_OK;
> >  }
> >
> > @@ -1145,6 +1148,7 @@ static bool subflow_check_data_avail(struct sock =
*ssk)
> >  {
> >       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> >       enum mapping_status status;
> > +     bool fallback_impossible;
> >       struct mptcp_sock *msk;
> >       struct sk_buff *skb;
> >
> > @@ -1218,7 +1222,12 @@ static bool subflow_check_data_avail(struct sock=
 *ssk)
> >               return true;
> >       }
> >
> > -     if (subflow->mp_join || subflow->fully_established) {
> > +     if (READ_ONCE(msk->csum_enabled))
> > +             fallback_impossible =3D subflow->valid_csum_seen;
> > +     else
> > +             fallback_impossible =3D subflow->fully_established;
> > +

Mat, how about using this instead:

fallback_impossible =3D READ_ONCE(msk->csum_enabled) ? subflow->valid_csum_=
seen :

                          subflow->fully_established;

Thanks,
-Geliang

> > +     if (subflow->mp_join || fallback_impossible) {
> >               /* fatal protocol error, close the socket.
> >                * subflow_error_report() will introduce the appropriate =
barriers
> >                */
>
> LGTM, thanks! Perhaps the last chunk can be encapsulated in an helper:
>
> subflow_is_fallback_possible(subflow, msk)
>
> embedding all the relevant test?
>
> Either ways:
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>
>
