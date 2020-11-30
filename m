Content-Type: multipart/mixed; boundary="===============4975940298353380224=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Address ID assignment in netlink PM
Date: Mon, 30 Nov 2020 19:52:56 +0800
Message-ID: <CA+WQbws4QGk5CF+gAb1Ro33v=Aztijnz5AYU1Q_tfQaDc455ZQ@mail.gmail.com>
In-Reply-To: 2897e20eaa066829586e55846c96ab199bb1baa3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6987

--===============4975940298353380224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8828=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2020-11-25 at 21:48 +0000, Othman, Ossama wrote:
> > Hi Paolo,
> >
> > While debugging a netlink PM "get addr" issue I was having in mptcpd
> > I found that the address ID assigned by mptcpd was being overridden
> > by the kernel.  Based on the code in pm_nl_ctl.c in the MPTCP self
> > tests, and the code in pm_netlink.c in the kernel, the
> > MPTCP_PM_CMD_ADD_ADDR command accepts an optional address ID
> > attribute.  When that attribute is available the ID is stored in the
> > corresponding mptcp_pm_addr_entry instance by mptcp_pm_parse_addr():
> >
> >       if (tb[MPTCP_PM_ADDR_ATTR_ID])
> >               entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> >
> > However, that value is later overridden in mptcp_pm_nl_append_new_local=
_addr():
> >
> >       entry->addr.id =3D pernet->next_id++;
> >
> > That causes the userspace to lose track of an address it added with a
> > specific ID, at which point the only way to find out the new ID is to
> > dump the addrs to find the new ID corresponding to local address in
> > question.  Is this the intended behavior?
>
> This is indended. In the current status 'id' is used only for endpoint
> selection while dumping (IIRC).
>
> The 'id' override allows for very easy book-keeping on the kernel side,
> otherwise we would need something more complex (alike IDR) to keep
> track of IDs usage.
>
> > It seems like userspace- and kernel-based address ID assignment
> > should be mutually exclusive.  Otherwise we run into this sort of
> > scenario.  Is there a need for the kernel to assign IDs in the
> > netlink PM case?
>
> Not really, it was just to keep the kernel-side implementation easy.
> Since need arise, we can as well swap to a more complete/complex
> schema.
>
> I just filed:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/117
>
> for that. Any volonteer willing to pick the task more than welcome!

I can implement this feature. Please assign issue #117 to me.

Thanks.

-Geliang

>
> Cheers,
>
> Paolo
>
>
>
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4975940298353380224==--
