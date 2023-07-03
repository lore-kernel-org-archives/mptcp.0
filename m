Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267A100C0
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688398724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1F+yDJtD00CQwF53aRAVjfUZNjuAKHmQ+OMc6+quVU=;
	b=PP9tBKsN5QPn1aFQIT4fLVJtsW5IQP3HavH9tcbu8JhhlwUXCzCI9E3LjUtg12FLwdsnIr
	5eAEm5Zs+Xv9e0OMzJx+Tq8jWUHsN33S1Vxox8cgBWnDZv0fEBRHSkT+8BxEo0TOPwC/eL
	iiejm69SaVIMe89vfyWszczJN3RhTSQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rJDmqeRmNY2cCJ8r8Wd-GQ-1; Mon, 03 Jul 2023 11:38:43 -0400
X-MC-Unique: rJDmqeRmNY2cCJ8r8Wd-GQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62dd79f63e0so10555866d6.0
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 08:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688398722; x=1690990722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7Zr5soCybVGtO5WjF2gQ21apjbmBWWp8ai6bhTiGf8=;
        b=TsVeHzx032ikwvatBrGQMr+G5QgiJ7ZAFVG1GkKjHK7x+b8MoFEww9Pp7OTzULA3sW
         gnX65EUznjuE1SoXH4VKcJ4JG0dY+XxjpWQMM/ziFEBKSa7HrPfjWieOTRiUbJeE0hsM
         JtG3uFhPJw2MA/V5xsFVFgUV0lbrwr9IxtRpxN/dUzQ2qHK/xVo0tP9/erkBCin0j9yb
         o410Ttx5fU+3e7eWORPYXOge1LluVCqAceVkMhPZL0iTZKa6h0XlZXT79Jxs6IzARDgv
         lF/e3//9E2GvT/ulO3qUrXIArtgrBpZ14fAfzKy4wTwFSV9cOy979t7u6y1LAh9u4wAt
         UhJg==
X-Gm-Message-State: ABy/qLa29sI5xUbZlkfmT+TGnEE94XThj2lLRtaAoAyqSHoTDCE+HU2Y
	yrnBDhbs1MbEmimmH0HLTye3Zz2ecAUoR/y9WU/FxVNMD9ryw8lUHLeEB/A8IxiZ1/WnGmxvkqN
	p5UmIOtiJwDp0TDdDKYPlHpg=
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr11629679qvb.4.1688398722667;
        Mon, 03 Jul 2023 08:38:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEctVBogoSPR8fMepVgCr16EdIP1ZCzm0ALQCu+FC3nxDH+ZakuAmShgFu0YQRlKrtQR5DNgg==
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr11629666qvb.4.1688398722319;
        Mon, 03 Jul 2023 08:38:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id s16-20020a05621412d000b00636d2482dd4sm1565292qvv.17.2023.07.03.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:38:42 -0700 (PDT)
Message-ID: <d005f0e6692d6fdb175b5366c1b7afe253f7930e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v11 10/11] Squash to "selftests/bpf: Add
 bpf_rr scheduler"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 03 Jul 2023 17:38:39 +0200
In-Reply-To: <664d3df8d7d05c3cf5d092b6fe5c8e418a44cb16.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
	 <664d3df8d7d05c3cf5d092b6fe5c8e418a44cb16.1687827857.git.geliang.tang@suse.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-06-27 at 09:06 +0800, Geliang Tang wrote:
> Use sk_storage to store last_snd, instead of using msk->last_snd.
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++-
>  .../selftests/bpf/progs/mptcp_bpf_rr.c        | 44 ++++++++++++++-----
>  2 files changed, 39 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
> index b4b766c7a68f..945dd46c98c0 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -259,7 +259,6 @@ struct mptcp_sched_ops {
>  struct mptcp_sock {
>  =09struct inet_connection_sock=09sk;
> =20
> -=09struct sock=09*last_snd;
>  =09__u32=09=09token;
>  =09struct sock=09*first;
>  =09char=09=09ca_name[TCP_CA_NAME_MAX];
> @@ -271,5 +270,10 @@ extern void mptcp_sched_data_set_contexts(const stru=
ct mptcp_sock *msk,
>  =09=09=09=09=09  struct mptcp_sched_data *data) __ksym;
>  extern struct mptcp_subflow_context *
>  mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned i=
nt pos) __ksym;
> +static inline struct sock *
> +mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> +{
> +=09return subflow->tcp_sock;
> +}
> =20
>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_rr.c
> index e101428e5906..21144e96ba56 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -6,33 +6,49 @@
> =20
>  char _license[] SEC("license") =3D "GPL";
> =20
> +struct mptcp_rr_storage {
> +=09struct sock *last_snd;
> +};
> +struct sock *last_snd;
> +
> +struct {
> +=09__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +=09__uint(map_flags, BPF_F_NO_PREALLOC);
> +=09__type(key, int);
> +=09__type(value, struct mptcp_rr_storage);
> +} mptcp_rr_map SEC(".maps");
> +
>  SEC("struct_ops/mptcp_sched_rr_init")
> -void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
> +void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
>  {
>  }
> =20
>  SEC("struct_ops/mptcp_sched_rr_release")
> -void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
> +void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
>  {
> +=09bpf_sk_storage_delete(&mptcp_rr_map, msk);
>  }
> =20
> -void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
> +void BPF_STRUCT_OPS(bpf_rr_data_init, struct mptcp_sock *msk,
>  =09=09    struct mptcp_sched_data *data)
>  {
>  =09mptcp_sched_data_set_contexts(msk, data);
>  }
> =20
> -int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> -=09=09   struct mptcp_sched_data *data)
> +int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
> +=09=09   const struct mptcp_sched_data *data)
>  {
> +=09struct mptcp_subflow_context *subflow;
> +=09struct mptcp_rr_storage *ptr;
>  =09int nr =3D 0;
> =20
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!msk->last_snd || !data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(data, i);
> +=09=09if (!last_snd || !subflow)

It looks like this is accessing a global variable ('last_snd'), which
is probably not very safe.

I think you could instead use inet_csk(msk)->icsk_ca_priv - currently
unused.

As this is the only comment I have, no need to send a whole v12. I
think we can merge the series as-is and then squash the needed change
to replace the global variable and map used here with inet_csk(msk)-
>icsk_ca_priv.

Thanks!

Paolo

