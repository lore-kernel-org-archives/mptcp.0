Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE21DDF0
	for <mptcp@lists.linux.dev>; Fri, 21 Jul 2023 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689953700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctxm81EhgbTmMtQQfTLunQZbxYx5k32k/e2odA4ahcc=;
	b=H1UB9WXUeovW7fGHL+xH9nZjxZ1M0b+qgji7Z2T2TuvPvBzsKbkDxniE5fLbHNk7+uw6a9
	dHRELv73EqkVY7WsSCWNBgqvyB/QpJlmdytX4ZSKvzi9ZGpdo7l2qFE9hW+mMg7648FV7j
	EVte8ICFyuSXzvVx5of6Bvmjt3ATHd8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-GT7Mz-ONPGOA5VivClUgWA-1; Fri, 21 Jul 2023 11:34:59 -0400
X-MC-Unique: GT7Mz-ONPGOA5VivClUgWA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-639d9eaf37aso4978136d6.0
        for <mptcp@lists.linux.dev>; Fri, 21 Jul 2023 08:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953699; x=1690558499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTP64qa6VMF4xQ/5NmqvVSwGzYlZrD+x2TYTxNfLRus=;
        b=e1QP9AGtjqKKd6c6ZHC34QvDuJjWAiHYKGsKhTSKkyQkCOPm2yztS6nsBVrVsxMPm6
         HvXsfv3sJHLItDwtjQpUgEImZtmamdoN+nI9TWgWAzHD1TO0RpQg6NIclinbd7BVxdjH
         8phcGZhcUzAxHO48NVTCvYxOk9oOctgg5S2oQgy1/mxlF6Sa5VVCLL6qdj3GsJwTHFhU
         bzvqXSxmDA+PbhcvQn7zDddHxY+ppRUrcji4dDpeHA6O7hyFinVSyHsBIm60OIOXhn9c
         gjWPTe8Sq4HTqn+PO8hKDWGJSiCz+fyo4g6PBZ7LeZ96s1XAp1ocOThCGd7kcAeXuumI
         sKfg==
X-Gm-Message-State: ABy/qLaUs/nNySV/qeA0pl04HYpCn5dL9b6PTMQoXshOac2lmgQ5AQhw
	ZhesF5gW3FykbcXcCENACEMWmN02H0F/8GwZFTurCh5TknHIitRHEnEdltytC/cPM9BYAhLuvy3
	VhCHJw0N555Y6OmcC5F8UoQs=
X-Received: by 2002:a05:6214:262a:b0:635:ec47:bfb0 with SMTP id gv10-20020a056214262a00b00635ec47bfb0mr2898971qvb.5.1689953698994;
        Fri, 21 Jul 2023 08:34:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjeZYjgW6zOaHbox2ZCfpzVSV5mjYzeZfVukbz1cAKPvIFdIAl1ZCalh0F03dCzJPNY+iiew==
X-Received: by 2002:a05:6214:262a:b0:635:ec47:bfb0 with SMTP id gv10-20020a056214262a00b00635ec47bfb0mr2898942qvb.5.1689953698620;
        Fri, 21 Jul 2023 08:34:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id n14-20020a0ce48e000000b0062b76c29978sm1356087qvl.6.2023.07.21.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:34:58 -0700 (PDT)
Message-ID: <16adeb4199ee165e701413f941b063e01bf5d9df.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/5] mptcp: convert netlink from small_ops to
 ops
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 21 Jul 2023 17:34:55 +0200
In-Reply-To: <047495a2619c04f9edc7c37e74de25957bfccf92.1689932012.git.dcaratti@redhat.com>
References: <cover.1689932012.git.dcaratti@redhat.com>
	 <047495a2619c04f9edc7c37e74de25957bfccf92.1689932012.git.dcaratti@redhat.com>
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

On Fri, 2023-07-21 at 11:53 +0200, Davide Caratti wrote:
> - use a separate attribute set for add/del/get/flush address operation,
>   binary compatible with the existing one, to store the endpoint address.
>   MPTCP_PM_ENDPOINT_ADDR is added to the uAPI (with the same value as
>   MPTCP_PM_ATTR_ADDR) for these operations.

Perhaps describing with more details why the above is safe would help.

e.g. the current code abuses the MPTCP_PM_ATTR_ADDR with multiple
semathic meaning, etc.

Think again about it, such change could be worthy a separate patch.

> - convert mptcp_pm_ops[] and add policy files accordingly.
>=20
> this prepares MPTCP control plane to be described as YAML spec.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/uapi/linux/mptcp.h |   8 ++
>  net/mptcp/pm_netlink.c     | 204 ++++++++++++++++++++++++-------------
>  net/mptcp/pm_userspace.c   |   2 +-
>  net/mptcp/protocol.h       |   4 +-
>  4 files changed, 146 insertions(+), 72 deletions(-)
>=20
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index ee9c49f949a2..34082c14c89b 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -65,6 +65,14 @@ enum {
> =20
>  #define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
> =20
> +enum {
> +        MPTCP_PM_ENDPOINT_ADDR =3D 1,
> +
> +        __MPTCP_PM_ENDPOINT_MAX
> +};
> +
> +#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
> +
>  enum {
>  =09MPTCP_PM_ADDR_ATTR_UNSPEC,
> =20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3be32f134d2a..936382f5f62e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -47,6 +47,53 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX=098
>  #define ADD_ADDR_RETRANS_MAX=093
> =20
> +const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ADDR_ATTR_I=
F_IDX + 1] =3D {

It looks like that renaming this policy 'mptcp_pm_address_nl_policy'
will reduce the delta in later patches, possibly making the series more
readable.

> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_ADD_ADDR / DEL / GET / FLUSH - do */
> +static const struct nla_policy mptcp_pm_endpoint_nl_policy[MPTCP_PM_ENDP=
OINT_ADDR + 1] =3D {
> +=09[MPTCP_PM_ENDPOINT_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_p=
olicy),
> +};
> +
> +/* MPTCP_PM_CMD_SET_LIMITS - do */
> +static const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_AT=
TR_SUBFLOWS + 1] =3D {
> +=09[MPTCP_PM_ATTR_RCV_ADD_ADDRS] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_SUBFLOWS] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_SET_FLAGS - do */
> +const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ATTR_ADDR_=
REMOTE + 1] =3D {
> +        [MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_=
policy),
> +        [MPTCP_PM_ATTR_ADDR_REMOTE] =3D NLA_POLICY_NESTED(mptcp_pm_add_a=
ddr_nl_policy),
> +        [MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* MPTCP_PM_CMD_ANNOUNCE - do */
> +static const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR=
_TOKEN + 1] =3D {
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_polic=
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
> +/* MPTCP_PM_CMD_SUBFLOW_CREATE / DESTROY - do */
> +static const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_P=
M_ATTR_ADDR_REMOTE + 1] =3D {
> +=09[MPTCP_PM_ATTR_ADDR_REMOTE] =3D NLA_POLICY_NESTED(mptcp_pm_add_addr_n=
l_policy),
> +=09[MPTCP_PM_ATTR_TOKEN] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ATTR_ADDR] =3D NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_polic=
y),
> +};
> +
>  static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
>  {
>  =09return net_generic(net, pm_nl_pernet_id);
> @@ -1100,29 +1147,6 @@ static const struct genl_multicast_group mptcp_pm_=
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
> @@ -1172,6 +1196,7 @@ static int mptcp_pm_family_to_addr(int family)
>  static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
>  =09=09=09=09       const struct nlattr *attr,
>  =09=09=09=09       struct genl_info *info,
> +=09=09=09=09       const struct nla_policy *nla_policy,
>  =09=09=09=09       struct mptcp_addr_info *addr,
>  =09=09=09=09       bool require_family)
>  {
> @@ -1184,7 +1209,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlatt=
r *tb[],
> =20
>  =09/* no validation needed - was already done via nested policy */
>  =09err =3D nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> -=09=09=09=09=09  mptcp_pm_addr_policy, info->extack);
> +=09=09=09=09=09  nla_policy, info->extack);
>  =09if (err)
>  =09=09return err;
> =20
> @@ -1237,19 +1262,20 @@ int mptcp_pm_parse_addr(struct nlattr *attr, stru=
ct genl_info *info,
> =20
>  =09memset(addr, 0, sizeof(*addr));
> =20
> -=09return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
> +=09return mptcp_pm_parse_pm_addr_attr(tb, attr, info, mptcp_pm_add_addr_=
nl_policy, addr, true);
>  }
> =20
>  int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> -=09=09=09 bool require_family,
> -=09=09=09 struct mptcp_pm_addr_entry *entry)
> +=09=09=09 const struct nla_policy *nla_policy,
> +=09=09=09 bool require_family, struct mptcp_pm_addr_entry *entry)

I *think* mptcp_pm_parse_entry() is always invoked with
'mptcp_pm_add_addr_nl_policy' as the policy argument. Can we just
remove such arg?

If so even mptcp_pm_parse_pm_addr_attr() is always invoked with the
same value for the policy arg, and we could remove even that argument.

The whole diff will be smaller and more readable IMHO.

Otherwise LGTM!

Cheers,

Paolo

