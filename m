Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAD5337F
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088473; cv=none; b=mCRKZJMKvJitpXayQKTPUCD8GjHpbxW75QF71ky9cqSvZqGrk/feYykI7229sGuyTwEu3uoj18zB3M5q7/1F+8BZAAfMJUyVRhRaw+zsdZrIWa98MUXG486s7kfPjT3o8GpFlEpM2cYF/NXyvxzc1iNlRUUGs1M7kWfyftMJMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088473; c=relaxed/simple;
	bh=VOvOWPlabNVYfY4BzZbBaY5/9Q5e8oJCdSTRjpiQc4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxQlvn1tDPwhPZgOEwWyOZbwESzaZ2ZlUJoaIszQAO25NArTzzx4U3KeeuVAH9sft67mvMWyAn/Qb35YCIrZIJgJ3mCOJNhrIWp6ph/FZ3iwZO7wNFVKdYFG0AUl0wD/o3Q06jll2li2fLhNw6CKPigMllnDOWn3Wav1zAWPevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7qdv89k; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7qdv89k"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso163062a91.1
        for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726088470; x=1726693270; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXNJSO1Gg8eH9d3wXpfGybLqy8DIcRDJJMrUl6hPhRs=;
        b=Z7qdv89kGUh7Aq/nmlAP8G8Ndz70FDWhSxG8/4smJGLdv5IoqUFG6YW9iPODJYJ2sF
         G+kWNECCNK+No1HaxRN7L9DLUo9sC/83IgpbMaf6GhTlXFxxh2DrYdLpgPPvQrD2g+fB
         mWaevSSlGyj2ke8J50CISGOd98m+KgWdD6UucLfq9ZPsKJT9rKyyWj5dHGxwy1avYMae
         liGQaSeYhKQBZQYL4dLpfBoI/IdJ4nAznwYUcMweCYcuUIHeVVejqNpbvf6rtEtHxE0n
         zyb7a95M+ST1VR1a0QAB0ekEQtYhmoRcDwB+H7oWSFkss0yGb0dvO9I2hv3Ket2QMxb6
         cdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088470; x=1726693270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXNJSO1Gg8eH9d3wXpfGybLqy8DIcRDJJMrUl6hPhRs=;
        b=hjASVtlXn4eox4g2ydoCl8e+ligjcvBoJuaUgpjmdhVgKf5H2ivA3cVz+Ykyo9nE0M
         l8mMqP5ojBn1+1HjtZbRZXaXGt7ihe4c/pJhr6wIC8gro5WicP441yhINTQlaEvlYN3Y
         Nbo1zEcQqRAlmygPqHFkcudXJEWu/S92M9tFvYBIX5FBz5NKaPKO38tdRFDfEzEzyHYe
         1zOgWdzpRHMUm3SJJtXR/y2k+ZyptJ7iC6Esw/vhFPhC6fBhClxiGaHNRL0Mo0T3ie0y
         P5UIyVXuV4DcNVyrL5VaOg+yZ0mwDQrUXgOqmKxYAVOgLWKMtA1382G0GOQhb5E2+c84
         s2sQ==
X-Gm-Message-State: AOJu0YzhqYrPz4SHS+yVB30iymA3nfpoQ9iF1a1bvj3sFHrnPi0Tgaut
	uyFu1L4ek//hebjQLxldeWl7mUrUavgm4O69afyk/toD4R+xOH90TSxB4cfcMksXP9mj2uiQMcc
	TMr5g4eIX1qy7KHymo3nDSW2hXKepmiaj
X-Google-Smtp-Source: AGHT+IFG/n3vuTWLJHTFv1o3YpQiGik3jsiSFAIfKhCfNXZulTHBrS/OLgUiotIo6to+VUH8BJPqGrEceXrEmEa7gjQ=
X-Received: by 2002:a17:90b:4b48:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2db9ffa4ef4mr555807a91.1.1726088470041; Wed, 11 Sep 2024
 14:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1725946276.git.tanggeliang@kylinos.cn> <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
In-Reply-To: <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:00:57 -0700
Message-ID: <CAEf4BzamHdsUnRJN1sVA2rrotug8dFOrSUdE6GZAaF83nU58Og@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:37=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> It's necessary to traverse all subflows on the conn_list of an MPTCP
> socket and then call kfunc to modify the fields of each subflow. In
> kernel space, mptcp_for_each_subflow() helper is used for this:
>
>         mptcp_for_each_subflow(msk, subflow)
>                 kfunc(subflow);
>
> But in the MPTCP BPF program, this has not yet been implemented. As
> Martin suggested recently, this conn_list walking + modify-by-kfunc
> usage fits the bpf_iter use case. So this patch adds a new bpf_iter
> type named "mptcp_subflow" to do this and implements its helpers
> bpf_iter_mptcp_subflow_new()/_next()/_destroy().
>
> Then bpf_for_each() for mptcp_subflow can be used in BPF program like
> this:
>
>         bpf_rcu_read_lock();
>         bpf_for_each(mptcp_subflow, subflow, msk)
>                 kfunc(subflow);
>         bpf_rcu_read_unlock();
>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>

Not sure why, but only this patch made it to the BPF mailing list? Did
you cc bpf@vger on all patches?

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6414824402e6..350672e24a3d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -201,9 +201,48 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodr=
et_set =3D {
>         .set   =3D &bpf_mptcp_fmodret_ids,
>  };
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "kfuncs which will be used in BPF programs");
> +struct bpf_iter_mptcp_subflow {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +       struct mptcp_sock *msk;
> +       struct list_head *pos;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow=
 *it,
> +                                          struct mptcp_sock *msk)
> +{
> +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> +
> +       if (!msk)
> +               return -EINVAL;

you still need to initialize at least kit->msk to NULL to prevent next
implementation below doing the wrong thing

keep in mind, iterator constructor returning error doesn't prevent BPF
program from still calling next() and destroy(), so implementation has
to set iterator state such that next can return NULL if iterator was
never successfully initialized

pw-bot: cr

> +
> +       kit->msk =3D msk;
> +       kit->pos =3D &msk->conn_list;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> +{
> +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> +       struct mptcp_subflow_context *subflow;
> +       struct mptcp_sock *msk =3D kit->msk;
> +

you should check if (!msk) early here, before accessing kit->pos->next belo=
w

> +       subflow =3D list_entry((kit->pos)->next, struct mptcp_subflow_con=
text, node);

nit: why () around kit->pos?

> +       if (!msk || list_entry_is_head(subflow, &msk->conn_list, node))

as I mentioned, !msk check seems too late. Maybe list_entry_is_head()
is a bit too late as well?

> +               return NULL;
> +
> +       kit->pos =3D &subflow->node;
> +       return subflow;
> +}
> +
> +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_su=
bflow *it)
> +{
> +}
>
>  __bpf_kfunc struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsign=
ed int pos)
> @@ -218,7 +257,7 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struc=
t sock *sk)
>         return tcp_rtx_queue_empty(sk);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> --
> 2.43.0
>
>
