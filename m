Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58D1BF7FE
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165506; cv=none; b=Pg9rVqKJudgtA56nTkA/qQZd/MMI3h0HMbFXbEcl9uO+htSR7ewCmNDHRCbJgJAVg9MVnBo7VphQ6ggdZhIU28Xkx61cjRibRJRwSB03ED9lQscv9Jnv8Gr38Xu/YmgMz81sLGIbaiCBAo0mLWwe1mmH62VdpBoRcwQkSIOndlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165506; c=relaxed/simple;
	bh=CqgKJoU70/zaNBXLmS7MX8pWs9zwUqIvB69GsgVsNas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO9LPoDKqxQMiafsS3f3FRcIrDR81esZVQ0WCHndOMd08bB+ONqquXUGWRTnMYqwku2JmErIXC+ZPAKRFDje5CY0fkInHeMlPanDbuuG2oiW0cWoxhlBwJfBQiNxC/OUmtO2M41DXwx057/MopwDNWzF4fCLPlsK++EKjBATSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF0GFVH3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF0GFVH3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so919744a91.1
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165503; x=1726770303; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx4ywAvrCZYPD4eVBSgg3GbZmRWxGgFxGIcgKq1xC+4=;
        b=nF0GFVH3Qdj4zvTnJd4HfGy84tTdTFZDzCca/ZyWBpNJEwOoNshn136edWrnYnCvsa
         cfzFt+brU3qsZcQvGxAEdv1g/EiTHTkqWsdxPsnL25qTmBvueKyo9jbRY7QhqHHutRWJ
         WlyDpPzgzaXKtFE80BOLOGajPqtf30eZYckRyM9LiXkl1Yj7tMfufQhaLD3N4J81XOHZ
         LLlPZ68vCM9tfn7fTf0TPsFXXq0pJ0Dena1q68EB/v1UqFl7Ra0UKsDzZ2eif1q2Bdb/
         PLMh3Otnqa98ojGmtOlZb37vMjEL66w/SKguWBp17+lDHLWIwhcEBhMLt62FH8TQ4CuU
         JMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165503; x=1726770303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx4ywAvrCZYPD4eVBSgg3GbZmRWxGgFxGIcgKq1xC+4=;
        b=iqudUIR85WMkyV0aPERyW79IcaGw0lzwxZOp7FPARBHAIJ3DwAPry4Un7dZ7WsLKij
         aZ23M88d1mKHuFM1oCxWyGGhiSS3oVFNz/tlTyKTeJ8SewioknkCJRhum5WmPghodG3O
         VzXggIrhK+0yB8nHOi7+qwWhU/saYPc7MVy9JttamhCV9g+mztt0WUrjcOaxKcQqfPHD
         lJQKXOHn/+WFhmFq3UwHXwxefSdZm5vKoCGRqBoRynaCn05lWLmX/cVqmcw8VZEOdFNz
         I/hxuYO1bKV8c11Hs5h8+xpIo2V0bNMZ2fp44nd7TkFSQkFrtrOV2OMprh+tkqUdmQtl
         +Q7Q==
X-Gm-Message-State: AOJu0YyUJJFl65RTSj4r2DhJRaByKBYvim53jcKnEkrKJMuKx2rxhMKi
	Gbn0Pb5+OuZq1TI3H9tvn+OOes2QyMDWZkiEoDL9337oUz5f1qSJzzYJ7Wi7WrKugpOqEtew3wS
	z3x+SMIXrcDVDCZpzwWU286GFLVA=
X-Google-Smtp-Source: AGHT+IHvzcPyknydMfiYIEZ1M+ai1N0iMQd0+KlJbmGq9bHrJWaDfXL0p8iLCO3JQKPPk1o400N0yqoUYbEMMXful4w=
X-Received: by 2002:a17:90a:2c0f:b0:2d8:25ce:e6e3 with SMTP id
 98e67ed59e1d1-2db6718d8b4mr18054090a91.5.1726165503593; Thu, 12 Sep 2024
 11:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1726132802.git.tanggeliang@kylinos.cn> <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
In-Reply-To: <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:24:51 -0700
Message-ID: <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:26=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
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
> Since these bpf_iter mptcp_subflow helpers are invoked in its selftest
> in a ftrace hook for mptcp_sched_get_send(), it's necessary to register
> them into a BPF_PROG_TYPE_TRACING type kfunc set together with other
> two used kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled().
>
> Then bpf_for_each() for mptcp_subflow can be used in BPF program like
> this:
>
>         i =3D 0;
>         bpf_rcu_read_lock();
>         bpf_for_each(mptcp_subflow, subflow, msk) {
>                 if (i++ >=3D MPTCP_SUBFLOWS_MAX)
>                         break;
>                 kfunc(subflow);
>         }
>         bpf_rcu_read_unlock();
>
> v2: remove msk->pm.lock in _new() and _destroy() (Martin)
>     drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
> v3: drop bpf_iter__mptcp_subflow
> v4: if msk is NULL, initialize kit->msk to NULL in _new() and check it in
>     _next() (Andrii)
>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 5 deletions(-)
>

Looks ok from setting up open-coded iterator things, but I can't speak
for other aspects I mentioned below.

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6414824402e6..fec18e7e5e4a 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -201,9 +201,51 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodr=
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
> +       kit->msk =3D msk;
> +       if (!msk)
> +               return -EINVAL;
> +
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
> +       if (!msk)
> +               return NULL;
> +
> +       subflow =3D list_entry(kit->pos->next, struct mptcp_subflow_conte=
xt, node);
> +       if (!subflow || list_entry_is_head(subflow, &msk->conn_list, node=
))

it's a bit weird that you need both !subflow and list_entry_is_head().
Can you have NULL subflow at all? But this is the question to
msk->conn_list semantics.

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
> @@ -218,12 +260,15 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(str=
uct sock *sk)
>         return tcp_rtx_queue_empty(sk);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)

I'm not 100% sure, but I suspect you might need to specify
KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk` is a
valid owned kernel object. Other BPF folks might help to clarify this.

> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> +BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
>  BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
> -BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, mptcp_set_timeout)
>  BTF_ID_FLAGS(func, mptcp_wnd_end)
>  BTF_ID_FLAGS(func, tcp_stream_memory_free)
> @@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
>         int ret;
>
>         ret =3D register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                              &bpf_mptcp_sched_kfunc_set=
);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
,
>                                                &bpf_mptcp_sched_kfunc_set=
);
>  #ifdef CONFIG_BPF_JIT
> --
> 2.43.0
>
>
