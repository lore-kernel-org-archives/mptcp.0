Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977713AE9
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686304678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56xWbfoptaVkipk2f+FN0tvaqlSv7XhrHt1H26OUS4E=;
	b=MSiND9NQ5sINx7ggKfoGAxOcdgetV7NxuSTgtYYnxU7WfaA/WT8Cplg5V8uI9h3HSZgcYj
	J1w/3J0CL8L0DPg8svvJ3HB6u+T35mBOLJOtuRVTNAmqMOOLbiCj+9KmH7js3NlAe6ewgw
	3XhUioiZQBiN4A8JmKgXks+93zDQUEw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-g3NrZfjrP6uqLzLSJF6Nxw-1; Fri, 09 Jun 2023 05:57:56 -0400
X-MC-Unique: g3NrZfjrP6uqLzLSJF6Nxw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7ecda6eefso2811465e9.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 02:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304675; x=1688896675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fRAVT2WcigYSoKjuo/hBJkbGKy7cbMGvxzkWYHSbgX8=;
        b=lWxpNGwEpuMtBtl7S1z/AFSqnocVStqZewmIqU/N2ZrZOVGYM9MmKtj/RLJ+TBYPmT
         vXAUOus/OiRffFAvsyr7KU9n3xDDKtmJYHG3G0efI+/MK3lhrkmW72R8NPqnQncRZsl0
         yq2i9gmwp/vWqEScV2zcU1ZotpU3xfH9gYWoaG4BLdHEXdLPNQKT+XWJ+FXZTR4sCqBC
         ougmoR6QJePiDz3MxwPbnIWss2IdJ4VQpl3oMT261ZgYsNOhGx0p4Ljbxu/lvSqE65OA
         iU7o1S02wkqTaSU9MaNWYmI1+EnNmu9qb6Ky7ZwnQlHo3NYMn6ZZE4B5p7qoU6K3UpW7
         xa4Q==
X-Gm-Message-State: AC+VfDzVEDeNH9MZIJgNXHEEWYX6d8H8EZNj+IGS0eXsMCxfOmU6X/Sz
	5RH3Expc9jh5DcIwHhVUzN/eMgzM/WvkRn9ad88nNdKLI0r9wMAwpGP9PVWO1SfASQ77XHZ6V86
	GsVdhe6aYsr31bDsuVZoCIhY=
X-Received: by 2002:a5d:4c88:0:b0:307:a5d1:dbb5 with SMTP id z8-20020a5d4c88000000b00307a5d1dbb5mr581819wrs.6.1686304675588;
        Fri, 09 Jun 2023 02:57:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eMUDWwGmu0lLj7jMlNEm4FFnMIaBOI5+yOf+4LGbbVggpSjsvAimMfgVTR2rpsW1QmBpZkg==
X-Received: by 2002:a5d:4c88:0:b0:307:a5d1:dbb5 with SMTP id z8-20020a5d4c88000000b00307a5d1dbb5mr581809wrs.6.1686304675194;
        Fri, 09 Jun 2023 02:57:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c024400b003f60101074dsm2134764wmj.33.2023.06.09.02.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:57:54 -0700 (PDT)
Message-ID: <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 09 Jun 2023 11:57:53 +0200
In-Reply-To: <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
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

On Thu, 2023-06-08 at 13:46 +0800, Geliang Tang wrote:
> This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
> which is the default scheduler in protocol.c. bpf_burst_get_send() uses
> the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
> uses the same logic as mptcp_subflow_get_retrans().
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
>  .../selftests/bpf/progs/mptcp_bpf_burst.c     | 208 ++++++++++++++++++
>  2 files changed, 213 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
>=20
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
> index 44c356772798..927a00f663f2 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -36,6 +36,7 @@ enum sk_pacing {
>  struct sock {
>  =09struct sock_common=09__sk_common;
>  #define sk_state=09=09__sk_common.skc_state
> +=09int=09=09=09sk_wmem_queued;
>  =09unsigned long=09=09sk_pacing_rate;
>  =09__u32=09=09=09sk_pacing_status; /* see enum sk_pacing */
>  } __attribute__((preserve_access_index));
> @@ -234,12 +235,15 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, =
__u32 w, __u32 acked) __ksym;
>  #define MPTCP_SUBFLOWS_MAX=098
> =20
>  struct mptcp_subflow_context {
> +=09unsigned long avg_pacing_rate;
>  =09__u32=09backup : 1;
> +=09__u8=09stale_count;
>  =09struct=09sock *tcp_sock;=09    /* tcp sk backpointer */
>  } __attribute__((preserve_access_index));
> =20
>  struct mptcp_sched_data {
>  =09struct sock=09*last_snd;
> +=09int=09=09snd_burst;
>  =09bool=09=09reinject;
>  =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
>  } __attribute__((preserve_access_index));
> @@ -260,6 +264,7 @@ struct mptcp_sched_ops {
>  struct mptcp_sock {
>  =09struct inet_connection_sock=09sk;
> =20
> +=09__u64=09=09snd_nxt;
>  =09__u32=09=09token;
>  =09struct sock=09*first;
>  =09char=09=09ca_name[TCP_CA_NAME_MAX];
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_burst.c
> new file mode 100644
> index 000000000000..b860fd517787
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include <limits.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +#define MPTCP_SEND_BURST_SIZE=0965428
> +
> +struct subflow_send_info {
> +=09struct sock *ssk;
> +=09__u64 linger_time;
> +};
> +
> +static struct mptcp_subflow_context *
> +bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
> +{
> +=09int i, nr =3D 0;
> +
> +=09for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +=09=09if (!ssk || !data->contexts[i])
> +=09=09=09break;
> +
> +=09=09if (mptcp_subflow_tcp_sock(data->contexts[i]) =3D=3D ssk) {
> +=09=09=09nr =3D i;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return data->contexts[nr];
> +}
> +
> +static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *re=
mainder)
> +{
> +=09*remainder =3D dividend % divisor;
> +=09return dividend / divisor;
> +}
> +
> +static inline __u64 div_u64(__u64 dividend, __u32 divisor)
> +{
> +=09__u32 remainder;
> +
> +=09return div_u64_rem(dividend, divisor, &remainder);
> +}
> +
> +extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) =
__ksym;
> +extern void mptcp_set_timeout(struct sock *sk) __ksym;
> +extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
> +extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
> +extern bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk) __=
ksym;
> +extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, str=
uct sock *ssk) __ksym;
> +
> +#define SSK_MODE_ACTIVE=090
> +#define SSK_MODE_BACKUP=091
> +#define SSK_MODE_MAX=092
> +
> +SEC("struct_ops/mptcp_sched_burst_init")
> +void BPF_PROG(mptcp_sched_burst_init, const struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_burst_release")
> +void BPF_PROG(mptcp_sched_burst_release, const struct mptcp_sock *msk)
> +{
> +}
> +
> +void BPF_STRUCT_OPS(bpf_burst_data_init, const struct mptcp_sock *msk,
> +=09=09    struct mptcp_sched_data *data)
> +{
> +=09mptcp_sched_data_set_contexts(msk, data);
> +}
> +
> +static int bpf_burst_get_send(const struct mptcp_sock *msk,
> +=09=09=09      struct mptcp_sched_data *data)
> +{
> +=09struct subflow_send_info send_info[SSK_MODE_MAX];
> +=09struct mptcp_subflow_context *subflow;
> +=09struct sock *sk =3D (struct sock *)msk;
> +=09__u32 pace, burst, wmem;
> +=09int i, nr_active =3D 0;
> +=09__u64 linger_time;
> +=09struct sock *ssk;
> +
> +=09/* pick the subflow with the lower wmem/wspace ratio */
> +=09for (i =3D 0; i < SSK_MODE_MAX; ++i) {
> +=09=09send_info[i].ssk =3D NULL;
> +=09=09send_info[i].linger_time =3D -1;
> +=09}
> +
> +=09for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +=09=09if (!data->contexts[i])
> +=09=09=09break;
> +
> +=09=09subflow =3D data->contexts[i];
> +=09=09ssk =3D mptcp_subflow_tcp_sock(subflow);
> +=09=09if (!mptcp_subflow_active(subflow))
> +=09=09=09continue;
> +
> +=09=09nr_active +=3D !subflow->backup;
> +=09=09pace =3D subflow->avg_pacing_rate;
> +=09=09if (!pace) {
> +=09=09=09/* init pacing rate from socket */
> +=09=09=09subflow->avg_pacing_rate =3D ssk->sk_pacing_rate;
> +=09=09=09pace =3D subflow->avg_pacing_rate;
> +=09=09=09if (!pace)
> +=09=09=09=09continue;
> +=09=09}
> +
> +=09=09linger_time =3D div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
> +=09=09if (linger_time < send_info[subflow->backup].linger_time) {
> +=09=09=09send_info[subflow->backup].ssk =3D ssk;
> +=09=09=09send_info[subflow->backup].linger_time =3D linger_time;
> +=09=09}
> +=09}
> +=09mptcp_set_timeout(sk);
> +
> +=09/* pick the best backup if no other subflow is active */
> +=09if (!nr_active)
> +=09=09send_info[SSK_MODE_ACTIVE].ssk =3D send_info[SSK_MODE_BACKUP].ssk;
> +
> +=09/* Get the ssk directly like this "ssk =3D send_info[SSK_MODE_ACTIVE]=
.ssk;"
> +=09 * will get an error:
> +=09 *   arg#0 pointer type STRUCT sock must point to scalar, or struct w=
ith scalar
> +=09 * So here use bpf_mptcp_subflow_ctx() to get the subflow,

May I guess you get a similar error if you do:

=09subflow =3D mptcp_subflow_ctx(ssk)

? (just out of sheer ignorance and curiosity)

> +=09 * then use mptcp_subflow_tcp_sock() to get the ssk.
> +=09 */
> +=09subflow =3D mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk, da=
ta);
> +=09ssk =3D mptcp_subflow_tcp_sock(subflow);

What if you store the 'subflow' pointer in 'send_info'? Will the
verifier splat with that? and what if we store the corresponding
context index 'i' instead? that we avoid the 'mptcp_subflow_tcp_sock()'
call entirely.

Please, don't send directly a new version, I think it would be better
clarify this point before updating the code

thanks!

Paolo

