Content-Type: multipart/mixed; boundary="===============7074115398936290070=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] add support for mptcp netlink interface.
Date: Fri, 17 Apr 2020 16:59:43 +0200
Message-ID: <f9bf68f86712510a67680e02385786484c99140a.camel@redhat.com>
In-Reply-To: 01f75ca9-3672-8783-4dfa-58fad7d44cc8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4198

--===============7074115398936290070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-16 at 12:22 +0200, Matthieu Baerts wrote:
> On 15/04/2020 19:12, Paolo Abeni wrote:
> > On Wed, 2020-04-15 at 18:28 +0200, Matthieu Baerts wrote:
> > > On 15/04/2020 14:28, Paolo Abeni wrote:
> > > > +	if (flags) {
> > > > +		/* unknown flags */
> > > > +		SPRINT_BUF(b1);
> > > > +
> > > > +		snprintf(b1, sizeof(b1), "%02x", flags);
> > > > +		print_string(PRINT_ANY, "rawflags", "rawflags %s ", b1);
> > > =

> > > (it looks strange to me to end with a space even in json context but I
> > > don't know the code of iproute2 :) )
> > =

> > It's just to keep the code simple, otherwise we have to check for 'last
> > flag' condition.
> =

> Yes, JSON supports doesn't make the code easy to do.
> It is maybe fine like that for upstream for the moment.

reading the above again, it *should* not introduce whitespaces for
JSON: it will emit:
	<key>:<value>

where <key> is "rawflags" and <value> the hex flags

[...]

> > > > +
> > > > +		if (!matches(*argv, "set"))
> > > > +			return mptcp_limit_get_set(argc-1, argv+1,
> > > > +						   MPTCP_PM_CMD_SET_LIMITS);
> > > > +		if (!matches(*argv, "show"))
> > > > +			return mptcp_limit_get_set(argc-1, argv+1,
> > > > +						   MPTCP_PM_CMD_GET_LIMITS);
> > > > +	}
> > > > +
> > > > +unknown:
> > > > +	fprintf(stderr,
> > > > +		"Command \"%s\" is unknown, try \"ip mptcp help\".\n",
> > > > +		*argv);
> > > > +	exit(-1);
> > =

> > and here invarg("unknown", *argv) would fit.
> =

> It seems this last fprintf() is used almost everywhere. Maybe better not =

> to use invarg() here?

ok,

Paolo

--===============7074115398936290070==--
