Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14972
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 03:32:01 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso469745pjg.2
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4lLhu462EjRLx2NUtgxVwtKciU6nLojmYMLYxgRXuWk=;
        b=QdqZFfT3bWymHQECwrpIV3BP0AgtjCC+KeGlKV7c5ZFJ+6gozbBppNjcLYFT3x5hVk
         e1keR2SLdYlaWSgLwki+I97PKd5BEFVB6iGGtgV978hTRGgKS+nh6QKkN/LYaHE7sSRX
         qXjfWt/PZxzKWq0N/n40K8TyeftXrntEMhiaY9USoVouShP2kAKasiViZviawtHx8iwG
         AitGZcBQMr0RKtInOhcOfjJosQA8386yatw15qsrd+FqvMi05GhvuK8sLPVINyDujtbz
         afEI9rnQppWOV8dnoPXv14A6IduC0xvH7zn3EA0wRfpO7Dir6d8BzkN3qBETZodos2x+
         nYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4lLhu462EjRLx2NUtgxVwtKciU6nLojmYMLYxgRXuWk=;
        b=kCZujH/m5J5GLk5z8OkpgFccyRNGLkaYmRQqZvbayTfoyc1i+T/lUCvAlcrnccuIFN
         EXCNUr17p9osDsU1LIMIb2vwjCBBb+ekCEZW+c9CKfWrZ9jU1yEk/zLdDLqSzpWcfFil
         hlYhZ0nBraJUGpzI/kp/aJU/Sf/iZihxp40x7Kqq2d7+CgQqluZwkhf6kcpp3L6RQvCu
         y9sEBP/Ulzw0Rn1+xPsS5njWkasJIPdzpthkfYsffQaqDSWAygF7Nt/sImzPUoaU3MpO
         hSs1enC+grikAME3ABskNSCbmHCGGcpw/ITGBSx+4tsTm6h6VwzPaNhU3263MnQ9kXHY
         Z6kA==
X-Gm-Message-State: AOAM531cemeafo7vE1XRWXvo/ANEdo9IwdPwm5dZhY2+nIaMeoaxHCjz
	doA08qOwUQfkGYHxgysDTOeQOfWkmxw9RFYy8zeOBcQhaq8=
X-Google-Smtp-Source: ABdhPJzIP2K3Cje/ftRmu5Jy2oaE7MxGRq6vDKWOYleiBjC3JjU2jvPW2cB7MAXjd+cC8FGBIyAX73cGVlDfTcshYyg=
X-Received: by 2002:a17:90b:180b:: with SMTP id lw11mr3458408pjb.6.1619148721409;
 Thu, 22 Apr 2021 20:32:01 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619035356.git.pabeni@redhat.com> <a61b61ef9ba9df2c47f91bcfd668cb33afc5dc43.1619035356.git.pabeni@redhat.com>
In-Reply-To: <a61b61ef9ba9df2c47f91bcfd668cb33afc5dc43.1619035356.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 11:31:50 +0800
Message-ID: <CA+WQbwuDWCusxuCJ3tpcRtdJS=1a5hQ1DtfaC7o7MwRLrWzPcg@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 16/21] Squash-to: mptcp: validate the data checksum
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Move the RX csum validation into get_mapping_status().
> If the current mapping is valid and csum is enabled traverse the
> later pending skbs and compute csum incrementally till the whole
> mapping has been covered. If not enough data is available in the
> rx queue, return MAPPING_EMPTY - that is, no data.
>
> Next subflow_data_ready invocation will trigger again csum computation.
>
> When the full DSS is available, validate the csum and return to the
> caller an appropriate error code, to trigger subflow reset of fallback
> as required by the RFC.
>
> Additionally:
> - if the csum prevence in the DSS don't match the negotiated value
> e.g. csum present, but not requested, return invalid mapping to trigger
> subflow reset.
> - keep some csum state, to avoid re-compute the csum on the
> same data when multiple rx queue traversal are required.
> - clean-up the uncompleted mapping from the receive queue on close,
> to allow proper subflow disposal
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I want to sign your name in the patch "mptcp: validate the data checksum"
as the author, and sign my name as Co-developed-by if you don't mind.

> ---
>  net/mptcp/protocol.c |  35 ------------
>  net/mptcp/protocol.h |   6 +--
>  net/mptcp/subflow.c  | 124 ++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 107 insertions(+), 58 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5160256de731..0d8005b480ab 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -520,35 +520,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
>         return ret;
>  }
>
> -static bool mptcp_validate_data_checksum(struct sock *ssk)
> -{
> -       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> -       struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> -       struct csum_pseudo_header header;
> -       __wsum csum;
> -
> -       if (__mptcp_check_fallback(msk))
> -               goto out;
> -
> -       if (subflow->csum_len < subflow->map_data_len)
> -               goto out;
> -
> -       header.data_seq =3D subflow->map_seq;
> -       header.subflow_seq =3D subflow->map_subflow_seq;
> -       header.data_len =3D subflow->map_data_len;
> -       header.csum =3D subflow->map_csum;
> -
> -       csum =3D csum_partial(&header, sizeof(header), subflow->data_csum=
);
> -
> -       if (csum_fold(csum))
> -               return false;
> -       subflow->data_csum =3D 0;
> -       subflow->csum_len =3D 0;
> -
> -out:
> -       return true;
> -}
> -
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>                                            struct sock *ssk,
>                                            unsigned int *bytes)
> @@ -617,12 +588,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mp=
tcp_sock *msk,
>                         if (tp->urg_data)
>                                 done =3D true;
>
> -                       if (READ_ONCE(msk->csum_enabled)) {
> -                               subflow->data_csum =3D skb_checksum(skb, =
offset, len,
> -                                                                 subflow=
->data_csum);
> -                               subflow->csum_len +=3D len;
> -                               mptcp_validate_data_checksum(ssk);
> -                       }
>                         if (__mptcp_move_skb(msk, ssk, skb, offset, len))
>                                 moved +=3D len;
>                         seq +=3D len;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 176f175a00bd..766412e50e73 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -399,9 +399,8 @@ struct mptcp_subflow_context {
>         u32     map_subflow_seq;
>         u32     ssn_offset;
>         u32     map_data_len;
> -       __wsum  data_csum;
> -       u32     csum_len;
> -       __sum16 map_csum;
> +       __wsum  map_data_csum;
> +       u32     map_csum_len;
>         u32     request_mptcp : 1,  /* send MP_CAPABLE */
>                 request_join : 1,   /* send MP_JOIN */
>                 request_bkup : 1,
> @@ -411,6 +410,7 @@ struct mptcp_subflow_context {
>                 pm_notified : 1,    /* PM hook called for established sta=
tus */
>                 conn_finished : 1,
>                 map_valid : 1,
> +               map_csum_reqd : 1,
>                 mpc_map : 1,
>                 backup : 1,
>                 send_mp_prio : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 68efc81eaf2c..6a3c161ebe34 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -829,10 +829,81 @@ static bool validate_mapping(struct sock *ssk, stru=
ct sk_buff *skb)
>         return true;
>  }
>
> +static enum mapping_status validate_data_csum(struct sock *ssk, struct s=
k_buff *skb,
> +                                             bool csum_reqd)
> +{
> +       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +       struct csum_pseudo_header header;
> +       u32 offset, seq, delta;
> +       __wsum csum;
> +       int len;
> +
> +       if (!csum_reqd)
> +               return MAPPING_OK;
> +
> +       /* mapping already validated on previous traversal */
> +       if (subflow->map_csum_len =3D=3D subflow->map_data_len)
> +               return MAPPING_OK;
> +
> +       /* traverse the receive queue, ensuring it contains a full
> +        * DSS mapping and accumulating the related csum.
> +        * Preserve the accoumlate csum across multiple calls, to compute
> +        * the csum only once
> +        */
> +       delta =3D subflow->map_data_len - subflow->map_csum_len;
> +       for (;;) {
> +               seq =3D tcp_sk(ssk)->copied_seq + subflow->map_csum_len;
> +               offset =3D seq - TCP_SKB_CB(skb)->seq;
> +
> +               /* if the current skb has not been accounted yet, csum it=
s contents
> +                * up to the amount covered by the current DSS
> +                */
> +               if (offset < skb->len) {
> +                       len =3D min(skb->len - offset, delta);
> +                       delta -=3D len;
> +                       subflow->map_csum_len +=3D len;
> +                       subflow->map_data_csum =3D skb_checksum(skb, offs=
et, len,
> +                                                             subflow->ma=
p_data_csum);
> +               }
> +               if (delta =3D=3D 0)
> +                       break;
> +
> +               if (skb_queue_is_last(&ssk->sk_receive_queue, skb)) {
> +                       /* if this subflow is closed, the partial mapping
> +                        * will be never completed; flush the pending skb=
s, so
> +                        * that subflow_sched_work_if_closed() can kick i=
n
> +                        */
> +                       if (unlikely(ssk->sk_state =3D=3D TCP_CLOSE))
> +                               while ((skb =3D skb_peek(&ssk->sk_receive=
_queue)))
> +                                       sk_eat_skb(ssk, skb);
> +
> +                       /* not enough data to validate the csum */
> +                       return MAPPING_EMPTY;
> +               }
> +
> +               /* the DSS mapping for next skbs will be validated later,
> +                * when a get_mapping_status call will process such skb
> +                */
> +               skb =3D skb->next;
> +       }
> +
> +       header.data_seq =3D subflow->map_seq;
> +       header.subflow_seq =3D subflow->map_subflow_seq;
> +       header.data_len =3D subflow->map_data_len;
> +       header.csum =3D 0;
> +
> +       csum =3D csum_partial(&header, sizeof(header), subflow->map_data_=
csum);
> +       if (unlikely(csum_fold(csum)))
> +               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY=
;
> +
> +       return MAPPING_OK;
> +}
> +
>  static enum mapping_status get_mapping_status(struct sock *ssk,
>                                               struct mptcp_sock *msk)
>  {
>         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +       bool csum_reqd =3D READ_ONCE(msk->csum_enabled);
>         struct mptcp_ext *mpext;
>         struct sk_buff *skb;
>         u16 data_len;
> @@ -926,9 +997,10 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>                 /* Allow replacing only with an identical map */
>                 if (subflow->map_seq =3D=3D map_seq &&
>                     subflow->map_subflow_seq =3D=3D mpext->subflow_seq &&
> -                   subflow->map_data_len =3D=3D data_len) {
> +                   subflow->map_data_len =3D=3D data_len &&
> +                   subflow->map_csum_reqd =3D=3D mpext->csum_reqd) {
>                         skb_ext_del(skb, SKB_EXT_MPTCP);
> -                       return MAPPING_OK;
> +                       goto validate_csum;
>                 }
>
>                 /* If this skb data are fully covered by the current mapp=
ing,
> @@ -940,7 +1012,7 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>                 }
>
>                 /* will validate the next map after consuming the current=
 one */
> -               return MAPPING_OK;
> +               goto validate_csum;
>         }
>
>         subflow->map_seq =3D map_seq;
> @@ -948,12 +1020,18 @@ static enum mapping_status get_mapping_status(stru=
ct sock *ssk,
>         subflow->map_data_len =3D data_len;
>         subflow->map_valid =3D 1;
>         subflow->mpc_map =3D mpext->mpc_map;
> -       subflow->data_csum =3D 0;
> -       subflow->csum_len =3D 0;
> -       subflow->map_csum =3D mpext->csum;
> -       pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u csum=
=3D%u",
> +       subflow->map_csum_reqd =3D mpext->csum_reqd;
> +       subflow->map_csum_len =3D 0;
> +       subflow->map_data_csum =3D csum_unfold(mpext->csum);
> +
> +       /* Cfr RFC 8684 Section 3.3.0 */
> +       if (unlikely(subflow->map_csum_reqd !=3D csum_reqd))
> +               return MAPPING_INVALID;
> +
> +       pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u csum=
=3D%d:%u",
>                  subflow->map_seq, subflow->map_subflow_seq,
> -                subflow->map_data_len, subflow->map_csum);
> +                subflow->map_data_len, subflow->map_csum_reqd,
> +                subflow->map_data_csum);
>
>  validate_seq:
>         /* we revalidate valid mapping on new skb, because we must ensure
> @@ -963,7 +1041,9 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>                 return MAPPING_INVALID;
>
>         skb_ext_del(skb, SKB_EXT_MPTCP);
> -       return MAPPING_OK;
> +
> +validate_csum:
> +       return validate_data_csum(ssk, skb, csum_reqd);
>  }
>
>  static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff =
*skb,
> @@ -1024,17 +1104,8 @@ static bool subflow_check_data_avail(struct sock *=
ssk)
>                         ssk->sk_err =3D EBADMSG;
>                         goto fatal;
>                 }
> -               if (status =3D=3D MAPPING_DUMMY) {
> -                       __mptcp_do_fallback(msk);
> -                       skb =3D skb_peek(&ssk->sk_receive_queue);
> -                       subflow->map_valid =3D 1;
> -                       subflow->map_seq =3D READ_ONCE(msk->ack_seq);
> -                       subflow->map_data_len =3D skb->len;
> -                       subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_=
seq -
> -                                                  subflow->ssn_offset;
> -                       subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
> -                       return true;
> -               }
> +               if (status =3D=3D MAPPING_DUMMY)
> +                       goto fallback;
>
>                 if (status !=3D MAPPING_OK)
>                         goto no_data;
> @@ -1089,6 +1160,19 @@ static bool subflow_check_data_avail(struct sock *=
ssk)
>         tcp_send_active_reset(ssk, GFP_ATOMIC);
>         subflow->data_avail =3D 0;
>         return false;
> +
> +fallback:
> +       __mptcp_do_fallback(msk);
> +       skb =3D skb_peek(&ssk->sk_receive_queue);
> +       subflow->map_csum_reqd =3D 0;
> +       subflow->map_valid =3D 1;
> +       subflow->map_seq =3D READ_ONCE(msk->ack_seq);
> +       subflow->map_data_len =3D skb->len;
> +       subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
> +                                  subflow->ssn_offset;
> +       subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
> +       return true;
> +

I'll drop this blank line here.

Furthermore, move this fallback trunk as a separated patch if you don't
mind.

Thanks.

-Geliang


>  }
>
>  bool mptcp_subflow_data_available(struct sock *sk)
> --
> 2.26.2
>
