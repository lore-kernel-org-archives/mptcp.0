Content-Type: multipart/mixed; boundary="===============3600826128507245814=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: use ipv6-specific proto struct
Date: Thu, 21 Nov 2019 15:23:57 +0100
Message-ID: <be0f5441b6e22429cedc3fa4bbd9ef2089972caa.camel@redhat.com>
In-Reply-To: 3e9f3743-2c9e-7c88-5940-77ae1f80157f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2650

--===============3600826128507245814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 15:14 +0100, Matthieu Baerts wrote:
> On 21/11/2019 13:25, Paolo Abeni wrote:
> > Because it needs a different (greater) obj_size.
> > =

> > Squash-to: "mptcp: Add MPTCP socket stubs"
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> [...]
> =

> > @@ -985,6 +986,11 @@ int mptcp_proto_v6_init(void)
> >   {
> >   	int err;
> >   =

> > +	mptcp_v6_prot =3D mptcp_prot;
> > +	strcpy(mptcp_v6_prot.name, "TCPv6");
> =

> Should we call it "MPTCPv6" (mptcp_prot is called "MPTCP")

Indeed! I rushed too much to assemble this patches, sorry.
> =

> > +	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp_sock) +
> > +				 sizeof(struct ipv6_pinfo);
> =

> Very good catch!
> =

> Why did we not have the crash before?

Just a matter of luck !?! It depends on how the trailing part of =

mptcp_sock struct overlap with ipv6_pinfo. If we have NULL values at
the 'correct' places, we can't observe the issue without setsockopt()

Possibly mptcp_struct layout changed a bit with the rebase (e.g. fields
swapped)??? I haven't double checked that.

Will send v2 soon.

Paolo

p.s. we likely want to add some more self-tests doing [almost random]
setsockopt on the mptcp socket before the transfer...



--===============3600826128507245814==--
