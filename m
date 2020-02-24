Content-Type: multipart/mixed; boundary="===============8241234346490916790=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Mon, 24 Feb 2020 16:50:53 +0100
Message-ID: <9820597ad22907ba4690593c0047651c3fdce1a3.camel@redhat.com>
In-Reply-To: bd907bec-f7ff-0ee2-82ea-ee4acfc386f4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3750

--===============8241234346490916790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-02-22 at 17:38 +0100, Matthieu Baerts wrote:
> > +#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
> > +
> > +#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
> > +#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> > +#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> =

> detail and we can fix it later if needed: I guess checkpatch will ask us =

> to use BIT(0), etc.

Addendum: BIT() is not available in uapi headers and checkpatch does
not complain, so I'll keep this unchanged

Cheers,

Paolo

--===============8241234346490916790==--
