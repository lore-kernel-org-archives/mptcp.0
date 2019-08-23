Content-Type: multipart/mixed; boundary="===============4371832905901906458=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 01/10] Extend path manager interface
Date: Fri, 23 Aug 2019 20:05:22 +0200
Message-ID: <fa7b2753-2569-2e6f-18f5-addfc19ef8b9@tessares.net>
In-Reply-To: 39c07dc34dd445382e948ed152ce5d608fdc69db.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1691

--===============4371832905901906458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 23/08/2019 00:31, Peter Krystad wrote:
> =

> Hi Matthieu -
> =

> It seems a hunk went missing when this was split and squashed. The follow=
ing
> piece of code from this patch does not appear in mptcp_incoming_options()=
 in
> the current export branch as I would expect to.
> =

> +       if (msk && mp_opt->add_addr) {
> +               if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
> +                       pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
> +#if IS_ENABLED(CONFIG_IPV6)
> +               else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
> +                       pm_add_addr6(msk, &mp_opt->addr6, mp_opt->addr_id=
);
> +#endif
> +               mp_opt->add_addr =3D 0;
> +       }
> +
> =

> This causes the received ADD_ADDR option to not be passed up to the path
> manager. I'll send a patch.

Oh sorry, I thought I carefully checked that everything was there. I
will apply this missing part ASAP!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4371832905901906458==--
