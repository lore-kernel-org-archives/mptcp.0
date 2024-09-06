Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610253D0A9
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658188; cv=none; b=VRhYIpUS5BYiL/e/aqFUyj/UZlDQVvlwgyD+Md0XFTOIz6jc5wS14pie/KWD/ZumVWeGB4MN3+M7ymgNN3MrcfXVfyM0xzFECHvFxUNLse2oDiSu/0CRr7elVymxwuX7MAqhiP43rHfQcoCR0jYduwdvJEaltIVdVSs3DWrMC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658188; c=relaxed/simple;
	bh=PFdrokk0VEtQ17Zj+4safMzZBOLV9DjWazLLEv9yFp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJrhhXlzhGdAp1rHlrR8CqZIHfUpiR52eOkuO2lK1BoD8+lQHT5+aCVyGD3CVjkEqhEJsdltmrUiEA0zm2Q9d9Ke6HWTdseSoXeZ9vwoHl+58rsJr6JWC42YEvgkhf/tNA/smDB9R2pZY0wgo21W2ggiaAo99V0wQL92rYKCsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbyR3yMr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbyR3yMr"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1845442a12.3
        for <mptcp@lists.linux.dev>; Fri, 06 Sep 2024 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658186; x=1726262986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/9/E9nS3oZaqoMOUJYSBIGgv/b+BtHh+Wm6kmnxSnI=;
        b=gbyR3yMrVVHvORT4tnGAehZei8CwNLtrFpvTMZlHMAF194AKFgUv2/ivaKfkbIa/Zq
         h80jl3iFg7rsWEIpFK5rnYcyVh1XliME6x+XBX9VQwnq8d3VNf2x2yyu65NJkUaEqxkw
         iTy9BmW3jFC5YHWun472o/H7hAfPlHQNS3H+09244VAB3mcbg2DdtG5F4s5qKnuw4a10
         BRyVMbe8V+i1kAkAX3C/1+K2lM/p2+vwx7xZY5dFr7bXgPy2j9nWFtFLZkDa4bBH0KtI
         lFuEtdkqnoiY8PLmTXWb9GZE76LETznA1Z/ZRO6DNkFLVjsvhLpIaeHHiQmuTxsWfRmc
         OYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658186; x=1726262986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/9/E9nS3oZaqoMOUJYSBIGgv/b+BtHh+Wm6kmnxSnI=;
        b=rdQkEWrrYF1dlYJ/NmeAFIHzxdU4TM5YsHfrNm2hyzYReqj1F3u309PNuW8YKwgRk9
         7Tv/huc9cv1Tzu0ugtlqVP4lkmRBRPjVKqD8XCsLUS0heRFIE/PDdS0zMT8XbYHW4BYO
         QkUpNlelXygCh9ICftRG+ysZDGy1b6UDq/qtyaDO1Ar6x6q/bwtSgszI5i3qEDy/HAnR
         LH+yCVzMfPHE9H1ln72b6r1RkKvgjJBDG16gXsG0ohAjDhOOIj24J0zmUIamNDHJyA0k
         Bln+06Vp03REYdvxOPBexkprcJF033cdpOnnummmN8W5F5WEKL2uYsbUlJ5gPRY+7Rue
         0M5A==
X-Forwarded-Encrypted: i=1; AJvYcCVHgQHtXALSglWYsgOMGO+G8saLjgdxCF1h7sOtUka+2v+uV8TbANfbodhSpY4dPbUkdquYTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6N2JoE+1X8/mBaXKtVaRUGV/HU7jTLQB7gKRL+cohrJj0gw7y
	7QqASnOBYu52mH2XbswpiAukCR2vdUZsmCRdpcvr6eTj0k1AF656U0T5KXfGZYdt7/U8riFiciH
	MwVtdsziNyG1vKjl6DcU65y7S8Fs=
X-Google-Smtp-Source: AGHT+IFnvDa6GQQQQEhSiWTmjviyrde2w8FwHeWOc1+rrVPknOVdzD7xmaJSj/RUEGTJLG7N8whe1ojvRNbVyKiMLCQ=
X-Received: by 2002:a17:90a:c90c:b0:2d3:d728:6ebb with SMTP id
 98e67ed59e1d1-2dad4de1412mr4755331a91.5.1725658185658; Fri, 06 Sep 2024
 14:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1725544210.git.tanggeliang@kylinos.cn> <a75fc3e8df7141ce582448d3f092871a4943fbf4.1725544210.git.tanggeliang@kylinos.cn>
 <288ad1c2-501a-4319-bc1e-e7a7e276ff63@linux.dev>
In-Reply-To: <288ad1c2-501a-4319-bc1e-e7a7e276ff63@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:29:33 -0700
Message-ID: <CAEf4BzY+FPNmX7VxQmbh-A4-QRCSLxGT3KOfGoHrdDJLg6QvDg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/4] bpf: Add mptcp_subflow bpf_iter
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Geliang Tang <tanggeliang@kylinos.cn>, Martin KaFai Lau <martin.lau@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:25=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/5/24 6:52 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > It's necessary to traverse all subflows on the conn_list of an MPTCP
> > socket and then call kfunc to modify the fields of each subflow. In
> > kernel space, mptcp_for_each_subflow() helper is used for this:
> >
> >   mptcp_for_each_subflow(msk, subflow)
> >           kfunc(subflow);
> >
> > But in the MPTCP BPF program, this has not yet been implemented. As
> > Martin suggested recently, this conn_list walking + modify-by-kfunc
> > usage fits the bpf_iter use case.
> >
> > This patch adds a new bpf_iter type named "mptcp_subflow" to do this.
> >
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >   kernel/bpf/helpers.c |  3 +++
> >   net/mptcp/bpf.c      | 57 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 60 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b5f0adae8293..2340ba967444 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3023,6 +3023,9 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> >   BTF_KFUNCS_END(common_btf_ids)
> >
> >   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 9672a70c24b0..cda09bbfd617 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -204,6 +204,63 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmo=
dret_set =3D {
> >       .set   =3D &bpf_mptcp_fmodret_ids,
> >   };
> >
> > +struct bpf_iter__mptcp_subflow {
> > +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > +     __bpf_md_ptr(struct mptcp_sock *, msk);
> > +     __bpf_md_ptr(struct list_head *, pos);
> > +};
> > +
> > +DEFINE_BPF_ITER_FUNC(mptcp_subflow, struct bpf_iter_meta *meta,
> > +                  struct mptcp_sock *msk, struct list_head *pos)

this is defining BPF iterator *program type* (effectively), which is
different from open-coded iterator. Do you need a BPF iterator program
type for this? Or open-coded iterator called from other BPF program
types would be sufficient?

> > +
> > +struct bpf_iter_mptcp_subflow {
> > +     __u64 __opaque[3];
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_iter_mptcp_subflow_kern {
> > +     struct mptcp_sock *msk;
> > +     struct list_head *pos;
> > +} __attribute__((aligned(8)));

opaque[3], but you are using two pointers here. Why the difference?

> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subfl=
ow *it,
> > +                                        struct mptcp_sock *msk)
> > +{
> > +     struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> > +
> > +     kit->msk =3D msk;
> > +     kit->pos =3D &msk->conn_list;
> > +     spin_lock_bh(&msk->pm.lock);
>
> I don't think spin_lock here without unlock can be used. e.g. What if
> bpf_iter_mptcp_subflow_new() is called twice back-to-back.
>
> I haven't looked at the mptcp details, some questions:
> The list is protected by msk->pm.lock?
> What happen to the sk_lock of the msk?
> Can this be rcu-ify? or it needs some cares when walking the established =
TCP
> subflow?
>
>
> [ Please cc the bpf list. Helping to review patches is a good way to cont=
ribute
> back to the mailing list. ]
>
> > +
> > +     return 0;
> > +}
> > +
> > +__bpf_kfunc struct mptcp_subflow_context *
> > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > +{
> > +     struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> > +     struct mptcp_subflow_context *subflow;
> > +     struct mptcp_sock *msk =3D kit->msk;
> > +
> > +     subflow =3D list_entry((kit->pos)->next, struct mptcp_subflow_con=
text, node);
> > +     if (list_entry_is_head(subflow, &msk->conn_list, node))
> > +             return NULL;
> > +
> > +     kit->pos =3D &subflow->node;
> > +     return subflow;
> > +}
> > +
> > +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_=
subflow *it)
> > +{
> > +     struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> > +     struct mptcp_sock *msk =3D kit->msk;
> > +
> > +     spin_unlock_bh(&msk->pm.lock);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> >   __diag_push();
> >   __diag_ignore_all("-Wmissing-prototypes",
> >                 "kfuncs which will be used in BPF programs");
>
>
