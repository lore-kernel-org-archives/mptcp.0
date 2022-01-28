Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1F168
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 04:06:37 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id e16so4148519pgn.4
        for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DjmvzXmpXqeT88gWWIbD0YSME1p6bx5qLP/+Ddt9yCs=;
        b=gPtkfD6LLwJl66Sp2luFW1GMwcdOQ5fzyx2fIwVSGzrSpXIBp39mUDamaV6NDfXbjU
         18AIoOdjqcyIQkOUCLF9LwRzZZNag55+n2eWH6+R/Ojlm1r7PAQg2WsOUlwLv09EFnfT
         uLHrj1SsbBIa8CbORm6HIVgqwBCpg7UFB1rmql89AK7COyHlDj0Q5Na9fcdtKQppIe15
         Q3g1f2yCUXgY1lYgIpB3wozK3ZzKWpAQGFxTXEYOMXbmgl9OCl9dqo+/+YNbItFVxJLF
         zpEmNksGFgTEoFDa9tBP74HiGxYYHyuFhVjIwcm44HIiEwqvzFa2Lo5Me8s5n0ptoBA/
         GxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DjmvzXmpXqeT88gWWIbD0YSME1p6bx5qLP/+Ddt9yCs=;
        b=t6pzijxbXy0DbIshKZM+tusSQ6k1mPTSI99cYKPoVswxpajwlM+eAPgZ0pyDCZ0Ez4
         hfYO1ehEBRtWv5WO173SJBQqOD8CWlVUJ67PjabPMTO89urTryDaYzxD9IqOafgAZZHy
         zk6nbL24WkRMKLNVRLJTqEOwetM6NwIc+jqS7GkYl6yAhkZDoXfR8u2/cioGvgNYV6C/
         H9GqejQ0wcgDDqI3LlV3DY3oOKXkbMyGIgunPFNW5dYwV6vy55vX+RjpIxANAEXwumdp
         fkxvIDBXD0JXM3KeJZExlCae3Tpcd6SF9AUFNT/V5wk+rT7fNumV48EB9NXelRNLsmhD
         Mu+g==
X-Gm-Message-State: AOAM533yShoV0+uUGS6Z5nA+dnpvTNdjH44tfQO6bcBOdU6AKBTn4uu0
	k9jEqnfki6yDoZc3YS/XCBH4gr+EUfhAvG/bOwzlGR6vw3XNJepA
X-Google-Smtp-Source: ABdhPJweZo3ctwPKdvI4MIy2F/M1GZyrtug+15eiKK4rnoCv8o+HrPIB3uEh/pjfuUM6/GzNhwu90oEy8Dk2hG+f7W8=
X-Received: by 2002:a63:743:: with SMTP id 64mr5120392pgh.356.1643342796563;
 Thu, 27 Jan 2022 20:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220128003812.2732609-1-kishen.maloor@intel.com> <20220128003812.2732609-4-kishen.maloor@intel.com>
In-Reply-To: <20220128003812.2732609-4-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 28 Jan 2022 12:07:44 +0800
Message-ID: <CA+WQbwsXeN-gCRksSZ_BaK8W8byzTFiqsfgc3tbcQT3=CS7V1w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 3/8] mptcp: reflect remote port (not 0) in
 ANNOUNCED events
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kishen,

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 08:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Per RFC 8684, if no port is specified in an ADD_ADDR message, MPTCP
> SHOULD attempt to connect to the specified address on the same port
> as the port that is already in use by the subflow on which the
> ADD_ADDR signal was sent.
>
> To facilitate that, this change reflects the specific remote port in
> use by that subflow in MPTCP_EVENT_ANNOUNCED events.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/options.c    | 2 +-
>  net/mptcp/pm.c         | 5 +++--
>  net/mptcp/pm_netlink.c | 8 ++++++--
>  net/mptcp/protocol.h   | 6 ++++--
>  4 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0d0d2eb8c8ca..0d3c8f7e5be6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1132,7 +1132,7 @@ bool mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>                 if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
>                     add_addr_hmac_valid(msk, &mp_opt)) {
>                         if (!mp_opt.echo) {
> -                               mptcp_pm_add_addr_received(msk, &mp_opt.a=
ddr);
> +                               mptcp_pm_add_addr_received(msk, &mp_opt.a=
ddr, sk);
>                                 MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_A=
DDADDR);
>                         } else {
>                                 mptcp_pm_add_addr_echoed(msk, &mp_opt.add=
r);
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6b6220895929..e5d5cb847209 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -200,14 +200,15 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock =
*msk, const struct sock *ssk,
>  }
>
>  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> -                               const struct mptcp_addr_info *addr)
> +                               const struct mptcp_addr_info *addr,
> +                               const struct sock *ssk)

I think the better parameters order of this function is:

(struct mptcp_sock *msk, const struct sock *ssk, const struct
mptcp_addr_info *addr)

Put the new parameter ssk just after msk.

Furthermore, I think instead of adding a new parameters ssk here, it's
better to change the parameter msk to ssk.

We can get the msk from ssk like this:

    struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
    struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);

>  {
>         struct mptcp_pm_data *pm =3D &msk->pm;
>
>         pr_debug("msk=3D%p remote_id=3D%d accept=3D%d", msk, addr->id,
>                  READ_ONCE(pm->accept_addr));
>
> -       mptcp_event_addr_announced(msk, addr);
> +       mptcp_event_addr_announced(msk, addr, ssk);
>
>         spin_lock_bh(&pm->lock);
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 93800f32fcb6..f90e77c3775d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1972,7 +1972,8 @@ void mptcp_event_addr_removed(const struct mptcp_so=
ck *msk, uint8_t id)
>  }
>
>  void mptcp_event_addr_announced(const struct mptcp_sock *msk,
> -                               const struct mptcp_addr_info *info)
> +                               const struct mptcp_addr_info *info,
> +                               const struct sock *ssk)

Here change the parameter msk to ssk too.

>  {
>         struct net *net =3D sock_net((const struct sock *)msk);

    struct net *net =3D sock_net(ssk);

>         struct nlmsghdr *nlh;
> @@ -1996,7 +1997,10 @@ void mptcp_event_addr_announced(const struct mptcp=
_sock *msk,
>         if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
>                 goto nla_put_failure;
>
> -       if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
> +       if (nla_put_be16(skb, MPTCP_ATTR_DPORT,
> +                        info->port  =3D=3D 0 ?

Here two blanks before '=3D=3D'.

Thanks,
-Geliang

> +                        ((struct inet_sock *)inet_sk(ssk))->inet_dport :
> +                        info->port))
>                 goto nla_put_failure;
>
>         switch (info->family) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c47d69a42fcb..d20c65fcba89 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -753,7 +753,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock=
 *msk);
>  void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct so=
ck *ssk,
>                                  const struct mptcp_subflow_context *subf=
low);
>  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> -                               const struct mptcp_addr_info *addr);
> +                               const struct mptcp_addr_info *addr,
> +                               const struct sock *ssk);
>  void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>                               struct mptcp_addr_info *addr);
>  void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> @@ -781,7 +782,8 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, c=
onst struct mptcp_rm_list *
>
>  void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *ms=
k,
>                  const struct sock *ssk, gfp_t gfp);
> -void mptcp_event_addr_announced(const struct mptcp_sock *msk, const stru=
ct mptcp_addr_info *info);
> +void mptcp_event_addr_announced(const struct mptcp_sock *msk, const stru=
ct mptcp_addr_info *info,
> +                               const struct sock *ssk);
>  void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
>
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> --
> 2.31.1
>
>
