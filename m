Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0C3FCB
	for <mptcp@lists.linux.dev>; Tue, 28 Sep 2021 02:19:52 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id s11so19572881pgr.11
        for <mptcp@lists.linux.dev>; Mon, 27 Sep 2021 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGqw8K1+BVjNYS2TM9vsKlmr19KBIKAjiukI2+f+fb8=;
        b=S+lM/RHB1oJxIAmSFdkzD2m+o1Vzkb3hRmMrlE9RC/QvR3WWt+h9KFRZCYiq4GrXOS
         8iW3juyG+SnWkoXaU1I7fLUs8yOuQxaOaHriTJfaRy0vrtb7PmfItFN8qAqY6M7h+E+X
         eOq3ZaVxefPbYq/8Nrxtfu+BDg2nJyFfozGgfSoDSzAmi7+aafWIg+hiQfmVdFfOkz8/
         RoqqWBsKhqsSl9MaIZ5GXLYRdfXN2EHaOHtXEn0vPlSJAkB6KQ4IHd1638ZWi++MpNmv
         ra7kYrSY24+Ix5y97NMKHKzdb07dKsVvd5sTX830hLACFReOpLaNy9sclUOctCgI79vP
         AWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGqw8K1+BVjNYS2TM9vsKlmr19KBIKAjiukI2+f+fb8=;
        b=wfOtOoEd5wolj3B5risZa1g6idNreIsqtEy5ssO6a49DTsriTsLpxaiLsHG5T6Sq3q
         8NnrQ6+E4iDbNuPpYy+AfGXI9BgzMrvf/q0fyanEvKCCMTuhe93YHtIc3zsfYOqeXjTH
         c3zS/3rS/jEk6ZHrb4iYbrRgCOex6EX8F+osnJWLhT+CgAdapcmFq8cwrND/JYLN+J/d
         fIvOZ9dX/70aMywLbU9uTzktoSsjLrLeANknPp84wqQi9uknS/+AfV3xkds4ea3lAsF1
         /QApUnpC8XwrQ/Ov5Zp/chJu7ZWQZU+odYCMNZ2SQsCqAud5e2Ik2fyDp3Ld0e523EWV
         i5IA==
X-Gm-Message-State: AOAM5323TCl7G5vjlwlCv0NayYWP7b9yJH1KS3T0blB45ktReC559EIG
	wzlXNQ7WhPSarfK8bVUDnJFXGp2sJ/IKOP4UlAg=
X-Google-Smtp-Source: ABdhPJzcmef38s7Kj0x+o8/uv3Q1ENWcShlSXmJyWRCrEMGwuRRLiOVRlZztrSK/KKhZIetfRcyvFRc2+8LvzI+ZxwU=
X-Received: by 2002:a63:1606:: with SMTP id w6mr473817pgl.253.1632795591770;
 Mon, 27 Sep 2021 19:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1632666254.git.geliangtang@gmail.com> <50885831cb65affbe180d3d9be3ba879f8e331f2.1632666254.git.geliangtang@gmail.com>
 <ccd12bb9-df4b-e646-9a65-e8de219e15c2@linux.intel.com>
In-Reply-To: <ccd12bb9-df4b-e646-9a65-e8de219e15c2@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 28 Sep 2021 10:19:40 +0800
Message-ID: <CA+WQbwuQ_J2r6JmunhUX4z7jb3V3PPotertyUwFMCoS51fj+dQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 1/8] mptcp: track and update contiguous data status
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B49=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=888:52=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Sun, 26 Sep 2021, Geliang Tang wrote:
>
> > This patch added a new member last_retrans_seq in mptcp_subflow_context
> > to track the last retransmitting sequence number.
> >
> > Add a new helper named mptcp_is_data_contiguous() to check whether the
> > data is contiguous on a subflow.
> >
> > When a bad checksum is detected and a single contiguous subflow is in u=
se,
> > don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>
> Hi Geliang -
>
> I know there's been a lot of churn in this part of the patch series,
> hopefully we can simplify a little to allow us to merge the first step of
> infinite mapping send/recv.

Hi Mat, Paolo, Matt,

I prefer to continue doing more iterations of this series instead of
merging part of them first. There's still some work to do in it, but it's
nearly finished. I'll send a v6 recently.

And the infinite mapping support is the last issue assigned to me on
GitHub. So I'm thinking about what should I do next. Could you give me
some suggestions?

Thanks,
-Geliang

>
> In v3 and v4 reviews, I suggested tracking the subflow sequence number
> like you do in this patch. After the discussion in the 2021-09-23 meeting=
,
> proper tracking of contiguous data appeared even more complicated, so
> Paolo had a suggestion to allow fallback in one simple-to-check case: Onl=
y
> do infinite mapping fallback if there is a single subflow AND there have
> been no retransmissions AND there have never been any MP_JOINs.
>
> That can be tracked with a "allow_infinite_fallback" bool in mptcp_sock,
> which gets initialized to 'true' when the connection begins and is set to
> 'false' on any retransmit or successful MP_JOIN.
>
> Paolo, is that an accurate summary?
>
>
> It's important that this type of fallback only happens when it is
> guaranteed that the stream is fully in-sequence, otherwise the
> application's data gets corrupted. The above suggestion lets us merge
> working infinite mapping code, and then figure out the more complicated
> "fallback after retransmissions or join" logic in a separate patch series=
.
>
>
> Thanks,
>
> Mat
>
>
>
> > ---
> > net/mptcp/protocol.c |  6 ++++++
> > net/mptcp/protocol.h |  8 ++++++++
> > net/mptcp/subflow.c  | 12 ++++++------
> > 3 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f8ad049d6941..cf8cccfefb51 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -729,6 +729,9 @@ void mptcp_data_ready(struct sock *sk, struct sock =
*ssk)
> >       if (unlikely(subflow->disposable))
> >               return;
> >
> > +     if (!subflow->last_retrans_seq || mptcp_is_data_contiguous(ssk))
> > +             subflow->last_retrans_seq =3D tcp_sk(ssk)->snd_una - 1;
> > +
> >       ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
> >       sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
> >       if (unlikely(ssk_rbuf > sk_rbuf))
> > @@ -2415,6 +2418,7 @@ static void mptcp_check_fastclose(struct mptcp_so=
ck *msk)
> > static void __mptcp_retrans(struct sock *sk)
> > {
> >       struct mptcp_sock *msk =3D mptcp_sk(sk);
> > +     struct mptcp_subflow_context *subflow;
> >       struct mptcp_sendmsg_info info =3D {};
> >       struct mptcp_data_frag *dfrag;
> >       size_t copied =3D 0;
> > @@ -2464,6 +2468,8 @@ static void __mptcp_retrans(struct sock *sk)
> >               dfrag->already_sent =3D max(dfrag->already_sent, info.sen=
t);
> >               tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> >                        info.size_goal);
> > +             subflow =3D mptcp_subflow_ctx(ssk);
> > +             subflow->last_retrans_seq =3D tcp_sk(ssk)->snd_nxt;
> >       }
> >
> >       release_sock(ssk);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 7379ab580a7e..e090a9244f8b 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -416,6 +416,7 @@ struct mptcp_subflow_context {
> >       u32     map_data_len;
> >       __wsum  map_data_csum;
> >       u32     map_csum_len;
> > +     u32     last_retrans_seq;
> >       u32     request_mptcp : 1,  /* send MP_CAPABLE */
> >               request_join : 1,   /* send MP_JOIN */
> >               request_bkup : 1,
> > @@ -625,6 +626,13 @@ static inline bool mptcp_has_another_subflow(struc=
t sock *ssk)
> >       return false;
> > }
> >
> > +static inline bool mptcp_is_data_contiguous(struct sock *ssk)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +
> > +     return before(subflow->last_retrans_seq, tcp_sk(ssk)->snd_una);
> > +}
> > +
> > void __init mptcp_proto_init(void);
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > int __init mptcp_proto_v6_init(void);
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 6172f380dfb7..a8f46a48feb1 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct soc=
k *ssk)
> > fallback:
> >       /* RFC 8684 section 3.7. */
> >       if (subflow->send_mp_fail) {
> > -             if (mptcp_has_another_subflow(ssk)) {
> > +             if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_cont=
iguous(ssk)) {
> > +                     ssk->sk_err =3D EBADMSG;
> > +                     tcp_set_state(ssk, TCP_CLOSE);
> > +                     subflow->reset_transient =3D 0;
> > +                     subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
> > +                     tcp_send_active_reset(ssk, GFP_ATOMIC);
> >                       while ((skb =3D skb_peek(&ssk->sk_receive_queue))=
)
> >                               sk_eat_skb(ssk, skb);
> >               }
> > -             ssk->sk_err =3D EBADMSG;
> > -             tcp_set_state(ssk, TCP_CLOSE);
> > -             subflow->reset_transient =3D 0;
> > -             subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
> > -             tcp_send_active_reset(ssk, GFP_ATOMIC);
> >               WRITE_ONCE(subflow->data_avail, 0);
> >               return true;
> >       }
> > --
> > 2.31.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel
>
