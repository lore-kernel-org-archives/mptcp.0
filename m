Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4A1844
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:57:36 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so2436456wms.0
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681963055; x=1684555055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdC5Hzt40WIls72VHQHlXcFCkVov8q/PD0YdlEIfaYE=;
        b=ONT/pk3pcxkH8dl/T8/Ad8A8im0UqdnHfDMo8t72r9+Co/XRnvsiBzzFvTN/GGq2rX
         iDa4JCYFjeqbVkHRShqcXOwJ0bhtVYabId54YYRqU9br07CClgkwKxTPz9Rh/6LcT+jE
         u2jIbqV8L9vlZ60JeVVaqSYD7JwKGR2QmHRtFbJwuYLbUzBY/44Qx+HXB7fDyjvPWVfl
         6JWLBr9du+C76N1Mf2sINlqFLNZT/i9xyz4DQO5q8opASdGCTQ7uwnRHCZW4gvw56Z67
         +5nJVCKg0hCrhEvlLTJusfLka0Qzfv2CUs18GEPRuc2fdkuafB2UOFc+NEI1igPMfdQ5
         fPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681963055; x=1684555055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdC5Hzt40WIls72VHQHlXcFCkVov8q/PD0YdlEIfaYE=;
        b=Z1KnNTmWbn4PYaENhMfb+Tq0iqQr0ZyFpNj2WHmJI25NVE/XhTupkIB/rC8Xz++S+7
         ZrLDQpNBv+9YcQs6moLJHacPmtzGDYa9OymKD82znFv4dP4QYC8YbfvmQwSwcthl607s
         k2b4+KoVsvDq/jTyNcxwaxbR4vKaUFFaMM+HgFnbFaBLgFBkxSBFwLQXBlMYN1khIqz6
         7kK6y17NsOnjfu5Fa6OANnxMT+bte78BevbaoaT68hFY8B4IfU9biCG7zWAS3dt9FWZa
         tnb3/EWN3gIABkxjEwvUPuWx8+fnNa2wB5T+DZETqg01BWQv0dNP3zjyMAhAigegY1ok
         QWQA==
X-Gm-Message-State: AAQBX9dVsXqy7QXHCZwdjLapIRFXmbYBHNnWYmjbczIvyem2/RZ89Wa/
	QgUdOb76FUuT/u5wtv/dwYD17z9+0jXw3NW6ZDo=
X-Google-Smtp-Source: AKy350Zbdb7ntoQi5p0atEdT/WScOuh5pBP2JvwR6ht97nhpj8dUK34/9CpOKosJ4xqfU0I1fpueeH5lfrnz+E/mrp4=
X-Received: by 2002:a7b:cb96:0:b0:3e0:87d:959b with SMTP id
 m22-20020a7bcb96000000b003e0087d959bmr414wmi.7.1681963054759; Wed, 19 Apr
 2023 20:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681481877.git.pabeni@redhat.com> <57449d46a6d254446a227aa22597dd0837dfe331.1681481877.git.pabeni@redhat.com>
In-Reply-To: <57449d46a6d254446a227aa22597dd0837dfe331.1681481877.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 20 Apr 2023 11:57:45 +0800
Message-ID: <CA+WQbwtkNZTMKsuAwN3oroB5MBkSXwLw3eCoKr5agP15yWgzvA@mail.gmail.com>
Subject: Re: [PATCH v2 mptcp-next 1/3] mptcp: introduces more address related mibs
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

How about also renaming AddAddr to AddAddrRx, and EchoAdd to
EchoAddRx, RmAddr to RmAddrRx, RmAddrDrop to RmAddrRxDrop?

Thanks,
-Geliang

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 22:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently we don't track explicitly a few events related to address
> management suboption handling; this patch adds new mibs for ADD_ADDR
> and RM_ADDR options tx and for missed tx events due to internal storage
> exahustion.
>
> The self-tests must be updated to properly handle different mibs with
> the same/shared prefix.
>
> Additionally removes a couple of warning tracking the loss event.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/mib.c                                |  6 ++++++
>  net/mptcp/mib.h                                | 18 ++++++++++++++++++
>  net/mptcp/options.c                            |  5 ++++-
>  net/mptcp/pm.c                                 |  6 ++++--
>  .../testing/selftests/net/mptcp/mptcp_join.sh  |  4 ++--
>  5 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 0dac2863c6e1..a0990c365a2e 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -34,7 +34,11 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>         SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
>         SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
>         SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
> +       SNMP_MIB_ITEM("AddAddrTx", MPTCP_MIB_ADDADDRTX),
> +       SNMP_MIB_ITEM("AddAddrTxDrop", MPTCP_MIB_ADDADDRTXDROP),
>         SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
> +       SNMP_MIB_ITEM("EchoAddTx", MPTCP_MIB_ECHOADDTX),
> +       SNMP_MIB_ITEM("EchoAddTxDrop", MPTCP_MIB_ECHOADDTXDROP),
>         SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
>         SNMP_MIB_ITEM("AddAddrDrop", MPTCP_MIB_ADDADDRDROP),
>         SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
> @@ -44,6 +48,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>         SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
>         SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
>         SNMP_MIB_ITEM("RmAddrDrop", MPTCP_MIB_RMADDRDROP),
> +       SNMP_MIB_ITEM("RmAddrTx", MPTCP_MIB_RMADDRTX),
> +       SNMP_MIB_ITEM("RmAddrTxDrop", MPTCP_MIB_RMADDRTXDROP),
>         SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
>         SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
>         SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 2be3596374f4..cae71d947252 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -27,7 +27,15 @@ enum linux_mptcp_mib_field {
>         MPTCP_MIB_NODSSWINDOW,          /* Segments not in MPTCP windows =
*/
>         MPTCP_MIB_DUPDATA,              /* Segments discarded due to dupl=
icate DSS */
>         MPTCP_MIB_ADDADDR,              /* Received ADD_ADDR with echo-fl=
ag=3D0 */
> +       MPTCP_MIB_ADDADDRTX,            /* Sent ADD_ADDR with echo-flag=
=3D0 */
> +       MPTCP_MIB_ADDADDRTXDROP,        /* ADD_ADDR with echo-flag=3D0 no=
t send due to
> +                                        * resource exhaustion
> +                                        */
>         MPTCP_MIB_ECHOADD,              /* Received ADD_ADDR with echo-fl=
ag=3D1 */
> +       MPTCP_MIB_ECHOADDTX,            /* Send ADD_ADDR with echo-flag=
=3D1 */
> +       MPTCP_MIB_ECHOADDTXDROP,        /* ADD_ADDR with echo-flag=3D1 no=
t send due
> +                                        * to resource exhaustion
> +                                        */
>         MPTCP_MIB_PORTADD,              /* Received ADD_ADDR with a port-=
number */
>         MPTCP_MIB_ADDADDRDROP,          /* Dropped incoming ADD_ADDR */
>         MPTCP_MIB_JOINPORTSYNRX,        /* Received a SYN MP_JOIN with a =
different port-number */
> @@ -37,6 +45,8 @@ enum linux_mptcp_mib_field {
>         MPTCP_MIB_MISMATCHPORTACKRX,    /* Received an ACK MP_JOIN with a=
 mismatched port-number */
>         MPTCP_MIB_RMADDR,               /* Received RM_ADDR */
>         MPTCP_MIB_RMADDRDROP,           /* Dropped incoming RM_ADDR */
> +       MPTCP_MIB_RMADDRTX,             /* Sent RM_ADDR */
> +       MPTCP_MIB_RMADDRTXDROP,         /* RM_ADDR not sent due to resour=
ce exhaustion */
>         MPTCP_MIB_RMSUBFLOW,            /* Remove a subflow */
>         MPTCP_MIB_MPPRIOTX,             /* Transmit a MP_PRIO */
>         MPTCP_MIB_MPPRIORX,             /* Received a MP_PRIO */
> @@ -63,6 +73,14 @@ struct mptcp_mib {
>         unsigned long mibs[LINUX_MIB_MPTCP_MAX];
>  };
>
> +static inline void MPTCP_ADD_STATS(struct net *net,
> +                                  enum linux_mptcp_mib_field field,
> +                                  int val)
> +{
> +       if (likely(net->mib.mptcp_statistics))
> +               SNMP_ADD_STATS(net->mib.mptcp_statistics, field, val);
> +}
> +
>  static inline void MPTCP_INC_STATS(struct net *net,
>                                    enum linux_mptcp_mib_field field)
>  {
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 19a01b6566f1..8a8083207be4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -687,9 +687,12 @@ static bool mptcp_established_options_add_addr(struc=
t sock *sk, struct sk_buff *
>         }
>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
>         if (!echo) {
> +               MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
>                                                      msk->remote_key,
>                                                      &opts->addr);
> +       } else {
> +               MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
>         }
>         pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
>                  opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
> @@ -723,7 +726,7 @@ static bool mptcp_established_options_rm_addr(struct =
sock *sk,
>
>         for (i =3D 0; i < opts->rm_list.nr; i++)
>                 pr_debug("rm_list_ids[%d]=3D%d", i, opts->rm_list.ids[i])=
;
> -
> +       MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_RMADDRTX, opts->rm_list.n=
r);
>         return true;
>  }
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4ed4d29d9c11..7539137719ef 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -26,7 +26,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>
>         if (add_addr &
>             (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL)=
)) {
> -               pr_warn("addr_signal error, add_addr=3D%d, echo=3D%d", ad=
d_addr, echo);
> +               MPTCP_INC_STATS(sock_net((struct sock *)msk),
> +                               echo ? MPTCP_MIB_ECHOADDTXDROP : MPTCP_MI=
B_ADDADDRTXDROP);
>                 return -EINVAL;
>         }
>
> @@ -48,7 +49,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const =
struct mptcp_rm_list *rm_
>         pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
>
>         if (rm_addr) {
> -               pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
> +               MPTCP_ADD_STATS(sock_net((struct sock *)msk),
> +                               MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
>                 return -EINVAL;
>         }
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index fafd19ec7e1f..095ddd747ffc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1486,7 +1486,7 @@ chk_add_nr()
>         fi
>
>         echo -n " - echo  "
> -       count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | a=
wk '{print $2}')
> +       count=3D$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPT=
cpExtEchoAdd | awk '{print $2}')
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$echo_nr" ]; then
>                 echo "[fail] got $count ADD_ADDR echo[s] expected $echo_n=
r"
> @@ -1608,7 +1608,7 @@ chk_rm_nr()
>         fi
>
>         printf "%-${nr_blank}s %s" " " "rm "
> -       count=3D$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr =
| awk '{print $2}')
> +       count=3D$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep =
MPTcpExtRmAddr | awk '{print $2}')
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$rm_addr_nr" ]; then
>                 echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
> --
> 2.39.2
>
>
