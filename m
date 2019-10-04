Content-Type: multipart/mixed; boundary="===============5304881535471126845=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:diag: prefix exposed items
Date: Fri, 04 Oct 2019 19:35:29 +0200
Message-ID: <20191004173529.GI13866@breakpoint.cc>
In-Reply-To: 2c9a6fc9af5a110fec21d20aaf4e7b35a6f3edb6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2018

--===============5304881535471126845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> wrote:
> > > > +#define MPTCP_SUBFLOW_FLAGS_4THACK	BIT(6)
> > > > +#define MPTCP_SUBFLOW_FLAGS_CONNECTED	BIT(7)
> > > > +#define MPTCP_SUBFLOW_FLAGS_MAPVALID	BIT(8)
> > > =

> > > but then names may become too long and might hurt eyes that read misc=
/ss.c
> > > . Maybe the word 'FLAG' is pleonastic, since we are talking about BIT=
(x)
> > > of a netlink attribute whose name is MPTCP_SUBFLOW_FLAGS.
> > > =

> > > What about MPTCP_SUBFLOW_F_<...> ?
> > =

> > I can understand that names can be too long. For me, that's fine, at
> > least it is clear :-)
> =

> > Another idea could be to use "_SF_" instead of subflow. But still, I
> > think the best is to have something clear for everybody and only remove
> > the useless "S". But I am happy to short them more if it is needed!
> =

> just did a friday experiment with uAPI #defines:
> =

> $ while read -r a b _; do c=3D`echo $b | wc -c`; echo $c; done >data.txt =
<<-EOF
> `grep -r '#define' include/uapi/linux/*`
> EOF
> =

> roughly 95% of the values of $c are below 29 characters, which is the
> length of MPTCP_SUBFLOW_FLAGS_CONNECTED. So, if we remove the useless 'S',
> we can safely say that MPTCP is not a statistic anomaly.
>
> then, I'm ok with MPTCP_SUBFLOW_FLAG_<xxx>.

I'm fine with that as well.  Another alternative is to drop the _FLAG
and append _BIT, i.e.  MPTCP_SUBFLOW_CONNECTED_BIT, and so on.

> void mtcp_diag_subflow_init(truct tcp_ulp_ops * ops);
> =

> that does:
> =

> void mtcp_diag_subflow_init(truct tcp_ulp_ops * ops)
> {
> 	ops->get_info =3D subflow_get_info;
> 	ops->get_info_size =3D subflow_get_info_size;
> }
> =

> can be exported from diag,c, and called in mptcp_subflow_init(), before
> registering the ULP.
> =

> how does that sound?

Sounds good to me, thanks.
--===============5304881535471126845==--
