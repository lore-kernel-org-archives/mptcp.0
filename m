Content-Type: multipart/mixed; boundary="===============3374495421836178272=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/6] Squash-to: "mptcp: Add path manager
 interface"
Date: Wed, 12 Feb 2020 15:51:43 +0100
Message-ID: <fe214180e23b912c364a0f01e40e18acc360ed4e.camel@redhat.com>
In-Reply-To: 20200212142243.GL2991@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3629

--===============3374495421836178272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 15:22 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +struct mptcp_pm_data {
> > +	struct mptcp_addr_info local;
> > +	struct mptcp_addr_info remote;
> > +
> > +	spinlock_t	lock;
> > +
> > +	bool		addr_signal;
> > +	bool		server_side;
> > +	bool		fully_established;
> > +	enum mptcp_pm_status status;
> > +	u8		add_addr_signaled;
> > +	u8		add_addr_accepted;
> =

> Why are the first three bool and the rest u8?

'addr_signal', 'server_side' and 'fully_established' have bool
semantics, while the others are counter, maxing at 255.

> We should probably avoid "bool" in structs.

IIRC the bitfield usage force the compiler to emit worse code, as such
I thought it was suggested only for size-critical structs?!? (mptcp
pernet does not have stict memory constraint).

> Perhaps use foo:1 as most of net stack?

uhm?!? quick && dirty grep count shows more bool field than ':1;' under
include/net/ !?!

Thanks,

Paolo

--===============3374495421836178272==--
