Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1B522B
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686666105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAERH0VOauDZESztd853b48iB525qwyp7jX1Nk4Tfvw=;
	b=AaAzBUd+dvRogluhYP8DciWI2Tvou1gFXK1jM7u84Es40nkMDZEtli7LbjlEX0PYoW1wdQ
	gNc4aslXkRoHFSsfmTTWWsgB+7VPfRbxlSnPyFtm248y0HG20W7rEIGIeowaQIOdbvZzwz
	i1bQcpfBDmuA4NwHo0HaGu6bI1TbjKU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-MRp_GnjeNcKoixsBKwxpRg-1; Tue, 13 Jun 2023 10:21:44 -0400
X-MC-Unique: MRp_GnjeNcKoixsBKwxpRg-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b1659b5cb2so468625a34.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 07:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666100; x=1689258100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s+aGRhYtewIlK8u0019XF0b+dlpjT6opqwqeXzKSP8U=;
        b=K2D9gvZEa5cAECiAz212BnDWvsa8RPWTw8RLdNwjmSZgHK07W6weV18wXREfCF/pGp
         pid/oOpsQj3AzGpnJYj68WGN5WG5tWChu7x2N+iTaQ5dZTYmCprh0oRl3Q8dOu5hNSH9
         f9RMWOOLW6CmsryALuzGzC9Hg1DhyEiCeZfHUoog500O1pf0eofgVjmf7MAM5cZouDXa
         BMPnvz/0GI2P8KnfuUgSynldxLVNaI0X/nTHmsC+9xHzk/5oQRgcVtSAfKs/KHw4ItLn
         VzJed5bTa16U+VYZMVrLb5DOK4gLX5ra46QVIHeALIdeFnVd8S0/8xl5pHHxK1He7KkN
         gsZA==
X-Gm-Message-State: AC+VfDyPBhe2yGwT/TGiXJoRz/tdI/nZNT2r9tbqAI+hp0lEX78+ee2y
	Yo6QmAbzMHlYUXiO9pEfkqo3FMkwoqTqxyFw3rmkD4J+3KJzMOpFTRa57ZaN7cQjoZ3sEbT/HTl
	mH7pfSUQeH5yq2ss=
X-Received: by 2002:a05:6359:63a5:b0:12b:d953:fc5 with SMTP id sg37-20020a05635963a500b0012bd9530fc5mr2676316rwb.2.1686666100125;
        Tue, 13 Jun 2023 07:21:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hVxDn1iOfhtufbtEQNNS9PyU9or80aK5KL3fxRzlZM41qT5QrT3YdZ8k6E7zXYkoTHvitLA==
X-Received: by 2002:a05:6359:63a5:b0:12b:d953:fc5 with SMTP id sg37-20020a05635963a500b0012bd9530fc5mr2676291rwb.2.1686666099581;
        Tue, 13 Jun 2023 07:21:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-147.dyn.eolo.it. [146.241.245.147])
        by smtp.gmail.com with ESMTPSA id h27-20020ac8777b000000b003f6f83de87esm4205904qtu.92.2023.06.13.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:21:39 -0700 (PDT)
Message-ID: <d0a5e0a15698dc3d060e6d4526b07db93b0a7355.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: make the contexts array of sched_data
 invisible in BPF
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Tue, 13 Jun 2023 16:21:32 +0200
In-Reply-To: <c2bd83d119631caf435a7498104f075781ce4969.1686664380.git.geliang.tang@suse.com>
References: <c2bd83d119631caf435a7498104f075781ce4969.1686664380.git.geliang.tang@suse.com>
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

Hi,

On Tue, 2023-06-13 at 21:53 +0800, Geliang Tang wrote:
> This patch adds a new member subflows in struct mptcp_sched_data to
> store the numbers of subflows. And remove contexts[] array of
> mptcp_sched_data in bpf_tcp_helpers.h.
>=20
> Depends on:
>  - BPF packet scheduler updates, v8
>  - Squash to "BPF packet scheduler updates v8"
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/net/mptcp.h                            |  1 +
>  net/mptcp/sched.c                              |  1 +
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h  |  2 +-
>  .../selftests/bpf/progs/mptcp_bpf_bkup.c       | 11 +++++++----
>  .../selftests/bpf/progs/mptcp_bpf_burst.c      | 12 ++++++------
>  .../selftests/bpf/progs/mptcp_bpf_first.c      |  2 +-
>  .../selftests/bpf/progs/mptcp_bpf_red.c        |  6 +++---
>  .../testing/selftests/bpf/progs/mptcp_bpf_rr.c | 15 +++++++++------
>  .../selftests/bpf/progs/mptcp_bpf_stale.c      | 18 ++++++++++++------
>  9 files changed, 41 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index fb4e6a59afc8..a6d5ede8877a 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -103,6 +103,7 @@ struct mptcp_sched_data {
>  =09struct sock=09*last_snd;
>  =09int=09=09snd_burst;
>  =09bool=09=09reinject;
> +=09int=09=09subflows;
>  =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
>  };
> =20
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 404be6cdb8a2..a6dc94d0f5b8 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -144,6 +144,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp=
_sock *msk,
>  =09=09mptcp_subflow_set_scheduled(subflow, false);
>  =09=09data->contexts[i++] =3D subflow;
>  =09}
> +=09data->subflows =3D i;
> =20
>  =09for (; i < MPTCP_SUBFLOWS_MAX; i++)
>  =09=09data->contexts[i] =3D NULL;
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
> index 4ac51f74e872..76a1e246fdfd 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -246,7 +246,7 @@ struct mptcp_sched_data {
>  =09struct sock=09*last_snd;
>  =09int=09=09snd_burst;
>  =09bool=09=09reinject;
> -=09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> +=09int=09=09subflows;
>  } __attribute__((preserve_access_index));
> =20
>  struct mptcp_sched_ops {
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/t=
esting/selftests/bpf/progs/mptcp_bpf_bkup.c
> index b2724426676e..a8c53f93bf9f 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
> @@ -27,17 +27,20 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct=
 mptcp_sock *msk,
>  {
>  =09int nr =3D 0;
> =20
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09struct mptcp_subflow_context *subflow;
> +
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(msk, i);
> +=09=09if (!subflow)
>  =09=09=09break;
> =20
> -=09=09if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
> +=09=09if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
>  =09=09=09nr =3D i;
>  =09=09=09break;
>  =09=09}
>  =09}
> =20
> -=09mptcp_subflow_set_scheduled(data->contexts[nr], true);
> +=09mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
>  =09return 0;
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_burst.c
> index 4ff4728faef8..7ff27c528bcb 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -71,11 +71,11 @@ static int bpf_burst_get_send(const struct mptcp_sock=
 *msk,
>  =09=09send_info[i].linger_time =3D -1;
>  =09}
> =20
> -=09for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->contexts[i])
> +=09for (i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(msk, i);
> +=09=09if (!subflow)
>  =09=09=09break;
> =20
> -=09=09subflow =3D data->contexts[i];
>  =09=09ssk =3D mptcp_subflow_tcp_sock(subflow);
>  =09=09if (!mptcp_subflow_active(subflow))
>  =09=09=09continue;
> @@ -131,11 +131,11 @@ static int bpf_burst_get_retrans(const struct mptcp=
_sock *msk,
>  =09int min_stale_count =3D INT_MAX;
>  =09struct sock *ssk;
> =20
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(msk, i);
> +=09=09if (!subflow)
>  =09=09=09break;
> =20
> -=09=09subflow =3D data->contexts[i];
>  =09=09if (!mptcp_subflow_active(subflow))
>  =09=09=09continue;
> =20
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_first.c
> index e4caa2dd8c6f..b9cc4a5a7125 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -25,7 +25,7 @@ void BPF_STRUCT_OPS(bpf_first_data_init, const struct m=
ptcp_sock *msk,
>  int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
>  =09=09   struct mptcp_sched_data *data)
>  {
> -=09mptcp_subflow_set_scheduled(data->contexts[0], true);
> +=09mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, 0), true);
>  =09return 0;
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_red.c
> index 30dd6f521b7f..320d46d78b2e 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> @@ -25,11 +25,11 @@ void BPF_STRUCT_OPS(bpf_red_data_init, const struct m=
ptcp_sock *msk,
>  int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
>  =09=09   struct mptcp_sched_data *data)
>  {
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09if (!mptcp_subflow_ctx_by_pos(msk, i))
>  =09=09=09break;
> =20
> -=09=09mptcp_subflow_set_scheduled(data->contexts[i], true);
> +=09=09mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, i), true=
);
>  =09}
> =20
>  =09return 0;
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_rr.c
> index e3ade9346f17..7c4c5f3b1134 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -25,14 +25,16 @@ void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mp=
tcp_sock *msk,
>  int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
>  =09=09   struct mptcp_sched_data *data)
>  {
> +=09struct mptcp_subflow_context *subflow;
>  =09int nr =3D 0;
> =20
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->last_snd || !data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(msk, i);
> +=09=09if (!data->last_snd || !subflow)
>  =09=09=09break;
> =20
> -=09=09if (mptcp_subflow_tcp_sock(data->contexts[i]) =3D=3D data->last_sn=
d) {
> -=09=09=09if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
> +=09=09if (mptcp_subflow_tcp_sock(subflow) =3D=3D data->last_snd) {
> +=09=09=09if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_po=
s(msk, i + 1))
>  =09=09=09=09break;
> =20
>  =09=09=09nr =3D i + 1;
> @@ -40,8 +42,9 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mpt=
cp_sock *msk,
>  =09=09}
>  =09}
> =20
> -=09mptcp_subflow_set_scheduled(data->contexts[nr], true);
> -=09data->last_snd =3D mptcp_subflow_tcp_sock(data->contexts[nr]);
> +=09subflow =3D mptcp_subflow_ctx_by_pos(msk, nr);
> +=09mptcp_subflow_set_scheduled(subflow, true);
> +=09data->last_snd =3D mptcp_subflow_tcp_sock(subflow);
>  =09return 0;
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_stale.c
> index 125e84a1e49e..4f21211b3931 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> @@ -25,9 +25,12 @@ void BPF_PROG(mptcp_sched_stale_release, const struct =
mptcp_sock *msk)
>  void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
>  =09=09    struct mptcp_sched_data *data)
>  {
> +=09struct mptcp_subflow_context *subflow;
> +
>  =09mptcp_sched_data_set_contexts(msk, data);
> -=09if (data->contexts[1])
> -=09=09mptcp_subflow_set_stale(data->contexts[1], 1);
> +=09subflow =3D mptcp_subflow_ctx_by_pos(msk, 1);
> +=09if (subflow)
> +=09=09mptcp_subflow_set_stale(subflow, 1);
>  }
> =20
>  int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
> @@ -35,17 +38,20 @@ int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struc=
t mptcp_sock *msk,
>  {
>  =09int nr =3D 0;
> =20
> -=09for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -=09=09if (!data->contexts[i])
> +=09for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) =
{
> +=09=09struct mptcp_subflow_context *subflow;
> +
> +=09=09subflow =3D mptcp_subflow_ctx_by_pos(msk, i);
> +=09=09if (!subflow)
>  =09=09=09break;
> =20
> -=09=09if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
> +=09=09if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
>  =09=09=09break;
> =20
>  =09=09nr =3D i;
>  =09}
> =20
> -=09mptcp_subflow_set_scheduled(data->contexts[nr], true);
> +=09mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
>  =09return 0;
>  }
>=20
The patch makes sense to me.

I think it would be better squashing it into the existing ones, to
avoid too much back-and-forth about the scheduler APIs.=20

Cheers,

Paolo
> =20

