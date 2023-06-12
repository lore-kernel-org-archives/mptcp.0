Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225B18AE1
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686564963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ouEu5DX7mD/0FXYSngpeDmICS6EBQ75Z3puUj6IIgg=;
	b=JImABLHaBwkHROxCvAiO7bwwDGRg+KHTY0AYmmlSMkIclV/VVMnvr08tOxkjqDE4la21Dy
	bVEIxRjEIH2JiqUzaddePg+VsXXRPC1V3pTNob/mFxp4PFgTQ0RVYzljTr+sA3qLAGcL6P
	cADpQVcUQfuCTzyumcBDlCE0IkG7Ozo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-P5-LElSlNYyCt1WNb_DwSw-1; Mon, 12 Jun 2023 06:16:02 -0400
X-MC-Unique: P5-LElSlNYyCt1WNb_DwSw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7f3333b2bso6354055e9.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 03:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564961; x=1689156961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+mEZwPOJG3GZwSdzCtSdLquwYdjZwFfkovGlfmQAcY=;
        b=KgbNXQ5mz2e0yxVwt1EiAZpmGgUzw0L1OBPENBT4RCi22jBhTfTjNU3QtFsgejw1wh
         viQxXOAuVpl6CSwmbnqMZWe4fq5keKb6L100dzGagy+GSAOqkTvwLbRYjiTn0KFhO1D8
         CiUJwDDBJsXp6+2LeKWtqEEZkJdL8mPRuQBX0cFjIB976mVPvxQdYC6IX3UDf2QWLHlo
         LdjZxtTeoammBUSUNaZAZF4qWlGs4l3f/m92S8omIm9IK4bneBfABFs+jme1OLylsCg4
         qgCIK4QBYDfHKq/ZDiDKQelHEgeEIerbKuZJ6hgcZpVckytRYpY2+kVyGo2bU0C20bNj
         ozSg==
X-Gm-Message-State: AC+VfDw4MlbHzgfFati5GkyBZcb6rBjmtKKSM6Gx1WK1IRO4eM18/rep
	58/kHMrBzkCrfoBUodlRWp4cDoUkvc/pzue4V+Krtk+J2cQEDgeRHQ6K5+ZstiBCgG3b9Nxgaho
	i+k/iOsgm34AaaEk=
X-Received: by 2002:a5d:510d:0:b0:2d2:9c19:f75 with SMTP id s13-20020a5d510d000000b002d29c190f75mr5738753wrt.1.1686564961256;
        Mon, 12 Jun 2023 03:16:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4P8El91V/KT0MkwfFGCNwFP7SIZaEdQTfGJj7J6BDKK8XWqTiC9KUEvtO/5idPzI7mVILaOA==
X-Received: by 2002:a5d:510d:0:b0:2d2:9c19:f75 with SMTP id s13-20020a5d510d000000b002d29c190f75mr5738741wrt.1.1686564960926;
        Mon, 12 Jun 2023 03:16:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b0030ae5a0516csm11994650wro.17.2023.06.12.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:16:00 -0700 (PDT)
Message-ID: <a5feec31cd5025a0357b8f60293b0879d3bb1461.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: convert netlink from small_ops to
 ops
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Jun 2023 12:15:59 +0200
In-Reply-To: <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
References: <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
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

Hi Davide,

Overall LGTM, there are just a few small hints see below.

On Mon, 2023-06-12 at 11:39 +0200, Davide Caratti wrote:
> this prepares MPTCP control plane to be described as YAML spec.

I think the commit message should be expanded, alike

"""
After the change the mptcp protocol will use per op policy. Update
the commands implementation to pass the relevant policy all the way
down to the actual impl.
"""

Or whatever makes really sense ;)
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/mptcp/pm_netlink.c   | 259 +++++++++++++++++++++++++++++----------
>  net/mptcp/pm_userspace.c |   2 +-
>  net/mptcp/protocol.h     |   2 +-
>  3 files changed, 193 insertions(+), 70 deletions(-)
>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ba1406e601e4..b7c7e5f81fd1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -47,6 +47,103 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX=098
>  #define ADD_ADDR_RETRANS_MAX=093
> =20
> +static const struct nla_policy *mptcp_nl_cmd2policy(int cmd);
> +
> +#define mptcp_pm_endpoint_nl_policy mptcp_pm_add_addr_nl_policy
> +
> +/* MPTCP_PM_CMD_ADD_ADDR - do */
> +static const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ADDR=
_ATTR_IF_IDX + 1] =3D {
> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_DEL_ADDR - do */
> +static const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ADDR=
_ATTR_IF_IDX + 1] =3D {
> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_GET_ADDR - do */
> +static const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ADDR=
_ATTR_IF_IDX + 1] =3D {
> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_FLUSH_ADDRS - do */
> +static const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_A=
DDR_ATTR_IF_IDX + 1] =3D {
> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};

Out of sheer ignorance, to we need to declare 4 different structs with
the same contents? Can't we reuse a single one 4 times?
> +
> +/* MPTCP_PM_CMD_SET_LIMITS - do */
> +static const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_AT=
TR_SUBFLOWS + 1] =3D {
> +=09[MPTCP_PM_ATTR_RCV_ADD_ADDRS] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_SUBFLOWS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_GET_LIMITS - do */
> +static const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_AT=
TR_SUBFLOWS + 1] =3D {
> +=09[MPTCP_PM_ATTR_RCV_ADD_ADDRS] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_SUBFLOWS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_SET_FLAGS - do */
> +static const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ADD=
R_ATTR_IF_IDX + 1] =3D {
> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_ANNOUNCE - do */
> +static const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR=
_TOKEN + 1] =3D {
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_polic=
y),
> +};
> +
> +/* MPTCP_PM_CMD_REMOVE - do */
> +static const struct nla_policy mptcp_pm_remove_nl_policy[MPTCP_PM_ATTR_L=
OC_ID + 1] =3D {
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_LOC_ID] =3D { .type =3D NLA_U8, },
> +};
> +
> +/* MPTCP_PM_CMD_SUBFLOW_CREATE - do */
> +static const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_P=
M_ATTR_ADDR_REMOTE + 1] =3D {
> +=09[MPTCP_PM_ATTR_ADDR_REMOTE] =3D NLA_POLICY_NESTED(mptcp_pm_endpoint_n=
l_policy),
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_polic=
y),
> +};
> +
> +/* MPTCP_PM_CMD_SUBFLOW_DESTROY - do */
> +static const struct nla_policy mptcp_pm_subflow_destroy_nl_policy[MPTCP_=
PM_ATTR_ADDR_REMOTE + 1] =3D {
> +=09[MPTCP_PM_ATTR_ADDR_REMOTE] =3D NLA_POLICY_NESTED(mptcp_pm_endpoint_n=
l_policy),
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_polic=
y),
> +};
> +
>  static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
>  {
>  =09return net_generic(net, pm_nl_pernet_id);
> @@ -1099,29 +1196,6 @@ static const struct genl_multicast_group mptcp_pm_=
mcgrps[] =3D {
>  =09=09=09=09=09  },
>  };
> =20
> -static const struct nla_policy
> -mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_MAX + 1] =3D {
> -=09[MPTCP_PM_ADDR_ATTR_FAMILY]=09=3D { .type=09=3D NLA_U16,=09},
> -=09[MPTCP_PM_ADDR_ATTR_ID]=09=09=3D { .type=09=3D NLA_U8,=09},
> -=09[MPTCP_PM_ADDR_ATTR_ADDR4]=09=3D { .type=09=3D NLA_U32,=09},
> -=09[MPTCP_PM_ADDR_ATTR_ADDR6]=09=3D
> -=09=09NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
> -=09[MPTCP_PM_ADDR_ATTR_PORT]=09=3D { .type=09=3D NLA_U16=09},
> -=09[MPTCP_PM_ADDR_ATTR_FLAGS]=09=3D { .type=09=3D NLA_U32=09},
> -=09[MPTCP_PM_ADDR_ATTR_IF_IDX]     =3D { .type=09=3D NLA_S32=09},
> -};
> -
> -static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] =
=3D {
> -=09[MPTCP_PM_ATTR_ADDR]=09=09=3D
> -=09=09=09=09=09NLA_POLICY_NESTED(mptcp_pm_addr_policy),
> -=09[MPTCP_PM_ATTR_RCV_ADD_ADDRS]=09=3D { .type=09=3D NLA_U32,=09},
> -=09[MPTCP_PM_ATTR_SUBFLOWS]=09=3D { .type=09=3D NLA_U32,=09},
> -=09[MPTCP_PM_ATTR_TOKEN]=09=09=3D { .type=09=3D NLA_U32,=09},
> -=09[MPTCP_PM_ATTR_LOC_ID]=09=09=3D { .type=09=3D NLA_U8,=09},
> -=09[MPTCP_PM_ATTR_ADDR_REMOTE]=09=3D
> -=09=09=09=09=09NLA_POLICY_NESTED(mptcp_pm_addr_policy),
> -};
> -
>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct =
sock *ssk)
>  {
>  =09struct mptcp_subflow_context *iter, *subflow =3D mptcp_subflow_ctx(ss=
k);
> @@ -1171,6 +1245,7 @@ static int mptcp_pm_family_to_addr(int family)
>  static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
>  =09=09=09=09       const struct nlattr *attr,
>  =09=09=09=09       struct genl_info *info,
> +=09=09=09=09       const struct nla_policy *nla_policy,
>  =09=09=09=09       struct mptcp_addr_info *addr,
>  =09=09=09=09       bool require_family)
>  {
> @@ -1183,7 +1258,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlatt=
r *tb[],
> =20
>  =09/* no validation needed - was already done via nested policy */
>  =09err =3D nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> -=09=09=09=09=09  mptcp_pm_addr_policy, info->extack);
> +=09=09=09=09=09  nla_policy,
> +=09=09=09=09=09  info->extack);

Minor nit: I think we can use a single line for both 'nla_policy' and
'info->extack);'

>  =09if (err)
>  =09=09return err;
> =20
> @@ -1236,19 +1312,22 @@ int mptcp_pm_parse_addr(struct nlattr *attr, stru=
ct genl_info *info,
> =20
>  =09memset(addr, 0, sizeof(*addr));
> =20
> -=09return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
> +=09return mptcp_pm_parse_pm_addr_attr(tb, attr, info, mptcp_pm_endpoint_=
nl_policy, addr, true);
>  }
> =20
>  int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> -=09=09=09 bool require_family,
> +=09=09=09 int cmd, bool require_family,
>  =09=09=09 struct mptcp_pm_addr_entry *entry)
>  {
>  =09struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +=09const struct nla_policy *nla_policy =3D mptcp_nl_cmd2policy(cmd);
>  =09int err;

Nit: reverse x-mas tree above

> =20
>  =09memset(entry, 0, sizeof(*entry));
> =20
> -=09err =3D mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, req=
uire_family);
> +=09err =3D mptcp_pm_parse_pm_addr_attr(tb, attr, info,
> +=09=09=09=09=09  nla_policy,
> +=09=09=09=09=09  &entry->addr, require_family);

Nit:=20
=09=09=09=09=09  tb, attr, info, nla_policy,

>  =09if (err)
>  =09=09return err;
> =20
> @@ -1305,7 +1384,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *sk=
b, struct genl_info *info)
>  =09struct mptcp_pm_addr_entry addr, *entry;
>  =09int ret;
> =20
> -=09ret =3D mptcp_pm_parse_entry(attr, info, true, &addr);
> +=09ret =3D mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_ADD_ADDR, true,=
 &addr);

Can we pass to mptcp_pm_parse_entry() directly the relevant policy
instead of the cmd? it will avoid the need for mptcp_nl_cmd2policy()
and possibly for the 'duplicated' definitions above.=20


Otherwise LGTM, thanks!

Paolo

