Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD363B5
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686157608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWM1RoIWBg8wXas6zAuFC84nAt3dTz08BIO6bx57TyA=;
	b=Whdu8JR3KEgopNTerhRe4CkXpZYu/MY9Ji33VoCgYFMETqgQ2JZgDbS2ShVMPy98I6krvQ
	5p+d5QskBWDquOws89w4Njz7dGf8x8gmoOqS/lIiWu11c/PAfE9h0Rmn663zfZ7wK7e5eC
	IqHaH2UaelIApN7FRJ3gEuN7d++2v30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Kg8MTiGaPHednoWV29lfXw-1; Wed, 07 Jun 2023 13:06:47 -0400
X-MC-Unique: Kg8MTiGaPHednoWV29lfXw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08900caadso14203515e9.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 10:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157606; x=1688749606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2dw+kjMFFmD/6ULb/EWXIDBAuvhkKdudazDJsLsbbw=;
        b=O49RW8jR3s+i5gwT6fQbI0/WdFTWZVzVLLLpc8P6PMoksdxARf7w2fx2cT68PWd3t+
         Iqt/yEQjNjq534Ie2qceTfgyqlTZjqRbvCJ39rQGdAg804ePJy7kY/JIMGlSwtAVFO7A
         VsaFh9DqiyfmAq8nCKyYUCunnD5yZR0WHSnurbYZkB24ypgDyjfhftM3ICRNzlfNcdHl
         HYCdqf94qnq87UV9+h77qP3Q5BWVkSoD4JI+h3yDemelxXnb9KhGe/PYM5vb0r/Ehlsp
         dxIbzK1lbmz+ff0dJrZ6oDMt6D/kbyTTONyAIoPF+Y0WZLoPX7OSNKGMx7Yp/7gnczDL
         UQEQ==
X-Gm-Message-State: AC+VfDx9g32yEcjxCHuo4MgUac1JarWgreqnas83yZ1Bm2qD54Wg1s65
	w2yvy83t7mghtbVCdw33AzjxOcJUfpPjLit40P65tg2HotLDzYBxXmBi+822JI6SPu+fgCcxwiW
	lw+ZZVpP7f4T/aiSIm5epsR8=
X-Received: by 2002:adf:e541:0:b0:306:3688:e5e5 with SMTP id z1-20020adfe541000000b003063688e5e5mr1712824wrm.3.1686157605794;
        Wed, 07 Jun 2023 10:06:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A3MV82kZ3Bgi5xNPPe4S6pmEpIwpIetAsbEuY2/0yLilkVZc6Pimroa4g58SoiJOzHXJtUg==
X-Received: by 2002:adf:e541:0:b0:306:3688:e5e5 with SMTP id z1-20020adfe541000000b003063688e5e5mr1712812wrm.3.1686157605453;
        Wed, 07 Jun 2023 10:06:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it. [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00307972e46fasm15880707wru.107.2023.06.07.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:06:43 -0700 (PDT)
Message-ID: <853fb4c5c117aea006421210d0166c02e78ee1b8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v7 15/19] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 07 Jun 2023 19:06:42 +0200
In-Reply-To: <673c7aee92c712651a7f37192cc0827be4e9bd14.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
	 <673c7aee92c712651a7f37192cc0827be4e9bd14.1686127032.git.geliang.tang@suse.com>
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

On Wed, 2023-06-07 at 16:38 +0800, Geliang Tang wrote:
> This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
> which is the default scheduler in protocol.c. bpf_burst_get_send() uses
> the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
> uses the same logic as mptcp_subflow_get_retrans().
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
>  .../selftests/bpf/progs/mptcp_bpf_burst.c     | 216 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
>=20
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
> index dddb51a47740..2c35cbe05d33 100644
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
> index 000000000000..15525eca98c9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -0,0 +1,216 @@
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
> +static inline struct sock *
> +mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> +{
> +=09return subflow->tcp_sock;
> +}
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
> +=09=09if (data->contexts[i]->tcp_sock =3D=3D ssk) {
> +=09=09=09nr =3D i;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return data->contexts[nr];
> +}

I'm sorry for the very dumb question, possibly already answered in the
past... why we can de-reference subflow->tcp_sock, but we use  ? Doing
the above loop instead of 'inet_csk(ssk)->icsk_ulp_data' look strange.

The functionality provided by bpf_mptcp_subflow_ctx() looks very useful
for every possible scheduler. I think we should provide that as an
helper available to all schedulers.

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
> +extern long mptcp_timeout_from_subflow(const struct mptcp_subflow_contex=
t *subflow) __ksym;
> +extern void mptcp_set_timer(struct sock *sk, long tout) __ksym;
> +extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
> +extern bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subf=
low) __ksym;
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
> +=09long tout =3D 0;
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
> +=09=09tout =3D max(tout, mptcp_timeout_from_subflow(subflow));
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
> +=09mptcp_set_timer(sk, tout);
> +
> +=09/* pick the best backup if no other subflow is active */
> +=09if (!nr_active)
> +=09=09send_info[SSK_MODE_ACTIVE].ssk =3D send_info[SSK_MODE_BACKUP].ssk;
> +
> +=09ssk =3D send_info[SSK_MODE_ACTIVE].ssk;
> +=09if (!ssk)
> +=09=09return -1;
> +
> +=09subflow =3D bpf_mptcp_subflow_ctx(ssk, data);
> +=09if (!bpf_sk_stream_memory_free(subflow))
> +=09=09return -1;
> +
> +=09burst =3D min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nx=
t);
> +=09if (!burst)
> +=09=09goto out;
> +
> +=09ssk =3D  mptcp_subflow_tcp_sock(subflow);

This looks like not needed, we already have 'ssk' available here ?!?


Cheers,

Paolo

