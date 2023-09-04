Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1687E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693818800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lwUXUIJLjm4L/Rn/LIWjl7vrUikl0HPvg43F1At2Gw=;
	b=fnZCP44NUdeMCKcFBlf9TQ5ZKjqLcb+01Q6MXdtghpLYjm/9rcUkAT3aKcddbUQ5mmSiyC
	dob/wyHDm7s/LETaDqEWzNp/XS2b8Z3J0lA9a479cUgs+kOc+DRLUAdvjHBZvfpxmWziam
	psYahAajHGYI6CBBkr+uguH44sVI2Ow=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-zlg1EaCmOqmEYDhzy3BNQQ-1; Mon, 04 Sep 2023 05:13:18 -0400
X-MC-Unique: zlg1EaCmOqmEYDhzy3BNQQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52c0134dfcdso216827a12.1
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693818797; x=1694423597;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+0UuEEN4l+vGKaj3c0d+zs+1iJyZvE5tpg60HiIedo=;
        b=ky3IDnE/TAZEpS9OwXkitWH3k5cttdszpwK/EL3+9EthDhrfeCNE9Q8gM/LEL2o2L2
         0pzOjGQM7EYSY0MPdoECAkn3E01ySYZbWa5DcchhVkHLuT8eYubGqeggTaNuSgjZkPK3
         Bh1FxliyKnbronWwyJd/lN8JHCDhskFN27bLAgOAtPn2mnkQmpSQ9DJIRfjPEW61F9a2
         UOG0mV2X5mcO5Sq2ztU0oc+tWrOyDOv+P42rn3UmIgS98q0rWJJHqPeSGvHSXC+R+gfw
         X8SbgZdRj+p4YGsPs2UVT+Vch1Rxv10Pp427Xn5hpJ8IjjKEJ5crigAIybsZ1sMV6ml6
         LH7g==
X-Gm-Message-State: AOJu0YxiDi6tS9ALf0jk2fJurkSRyjQhvE26hvwbOtvKV8N5XP5a4qsC
	JeClYIJ4Zj/ORJcTYzMtiW0jEZZcTC92LODE3PCkPS6aiu0I5EcGO4lflkBvE0OAuewmace/UzJ
	Whnj+FznSAiIr6Hs=
X-Received: by 2002:a05:6402:3582:b0:51e:5dd8:fc59 with SMTP id y2-20020a056402358200b0051e5dd8fc59mr7744693edc.1.1693818797385;
        Mon, 04 Sep 2023 02:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDOJqTdaZTnp9fjQl5U+UZcbM4UKGPly+EgX4U9ia/Y0A+h/noaH1MEX0BBihHGL7L4EY7mg==
X-Received: by 2002:a05:6402:3582:b0:51e:5dd8:fc59 with SMTP id y2-20020a056402358200b0051e5dd8fc59mr7744685edc.1.1693818797099;
        Mon, 04 Sep 2023 02:13:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id f24-20020aa7d858000000b0052544441babsm5576469eds.72.2023.09.04.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:13:16 -0700 (PDT)
Message-ID: <70d408aed5fe8f7a307aa024f3614d1daae6a6ad.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: convert netlink from small_ops
 to ops
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 04 Sep 2023 11:13:15 +0200
In-Reply-To: <9079cf99466869474845cf89b55de5dfa7e01326.1693591676.git.dcaratti@redhat.com>
References: <cover.1693591676.git.dcaratti@redhat.com>
	 <9079cf99466869474845cf89b55de5dfa7e01326.1693591676.git.dcaratti@redhat.com>
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

On Fri, 2023-09-01 at 20:10 +0200, Davide Caratti wrote:
> in the current MPTCP control plane, all operations use a netlink
> attribute of the same type "MPTCP_PM_ATTR". However, add/del/get/flush
> operations only parse the first element in the message _ the one that
> describes MPTCP endpoints (that was named MPTCP_PM_ATTR_ADDR and
> mostly used in ADD_ADDR operations _ probably the similarity of "attr",
> "addr" and "add" might cause some confusion to human readers).
> Convert MPTCP from 'small_ops' to 'ops', thus allowing different attribut=
es
> for each single operation, hopefully makes all this clearer to human
> readers.

Minor nit: I'm wondering if it would make sense factoring out only the
bits replacing MPTCP_PM_ATTR_ADDR with MPTCP_PM_ENDPOINT_ADDR, to make
it clearer what is happening here.

Likely not a big deal either ways.=C2=A0
=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9661f3812682..3859a206c298 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -48,6 +48,53 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX=098
>  #define ADD_ADDR_RETRANS_MAX=093
> =20
> +const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF=
_IDX + 1] =3D {

The above is a little confusing...

> +=09[MPTCP_PM_ADDR_ATTR_FAMILY] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR4] =3D { .type =3D NLA_U32, },
> +=09[MPTCP_PM_ADDR_ATTR_ADDR6] =3D { .len =3D 16, },
> +=09[MPTCP_PM_ADDR_ATTR_ID] =3D { .type =3D NLA_U8, },
> +=09[MPTCP_PM_ADDR_ATTR_PORT] =3D { .type =3D NLA_U16, },
> +=09[MPTCP_PM_ADDR_ATTR_IF_IDX] =3D { .type =3D NLA_S32, },
> +=09[MPTCP_PM_ADDR_ATTR_FLAGS] =3D { .type =3D NLA_U32, },
> +};

... given that MPTCP_PM_ADDR_ATTR_IF_IDX is not listed last here.

I guess this layout has been chosen to match what the tool generates
for the spec, right?

What if we reorder the 'attributes' in 'operations/list' in patch 3/6
to respect the corresponding numeric order? would that lead to more
natural order here, too?

Thanks!

/P

