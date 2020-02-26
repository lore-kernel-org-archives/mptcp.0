Content-Type: multipart/mixed; boundary="===============0529755545575808576=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 13:05:28 +0100
Message-ID: <b465c87876ec0b34370bf2dc0b9c1a9e573ae1a2.camel@redhat.com>
In-Reply-To: 4f111fb6-2ec9-8ab0-4543-46161995a13a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3811

--===============0529755545575808576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-26 at 12:44 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 26/02/2020 12:36, Paolo Abeni wrote:
> > On Mon, 2020-02-24 at 16:51 +0100, Paolo Abeni wrote:
> > > +enum {
> > > +	MPTCP_PM_CMD_UNSPEC,
> > > +
> > > +	MPTCP_PM_CMD_ADD_ADDR,
> > > +	MPTCP_PM_CMD_DEL_ADDR,
> > > +	MPTCP_PM_CMD_GET_ADDR,
> > > +	MPTCP_PM_CMD_FLUSH_ADDRS,
> > > +	MPTCP_PM_CMD_SET_RCV_ADD_ADDRS,
> > > +	MPTCP_PM_CMD_GET_RCV_ADD_ADDRS,
> > =

> > To enforce the server subflow limits, the idea would be to change (in a
> > separated series) the above 2 commands to:
> > 	MPTCP_PM_CMD_SET_LIMITS,
> > 	MPTCP_PM_CMD_GET_LIMITS,
> > =

> > and add a new attribute for the max subflow limits
> > =

> > Plus the core infrastructure/hooks to let the PM really enforce such
> > limit.
> > =

> > WDYT?
> =

> That sounds good to me and more "natural". Thank you for looking at this!
> =

> Just one question: would they be generic commands to add/get limits? Or =

> should we set a more specific name, e.g.:
> =

>    MPTCP_PM_CMD_SET_MAX_SUBFLOWS
>    MPTCP_PM_CMD_GET_MAX_SUBFLOWS

Before doing the actual coding, I think the first option would lead to
smaller/simpler implementation (no duplicate boilerplates) and should
be also more easily extendible for the same reason.

But I guess is mostly a matter of taste, and I know I'm moslty wrong on
that kind of topics - except for important subjects like pizza and
coffee ;)

/P

--===============0529755545575808576==--
