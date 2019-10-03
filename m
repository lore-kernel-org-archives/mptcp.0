Content-Type: multipart/mixed; boundary="===============0994562252705319819=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: allow dumping subflow context to userspace
Date: Thu, 03 Oct 2019 10:51:31 +0200
Message-ID: <7e25fcd695bdb6cf88114559177fcde5e36027f4.camel@redhat.com>
In-Reply-To: 4d91db72-d938-de38-ab24-02d00dcce5dc@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2009

--===============0994562252705319819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 20:14 +0200, Matthieu Baerts wrote:
> Hi Davide, Paolo,
> =

> On 27/09/2019 22:51, Davide Caratti wrote:
> > add ulp-specific diagnostic functions, so that subflow information can =
be
> > dumped to userspace programs like 'ss'.
> =

> Thank you for the patch and the review!
> =

> I am applying this patch and I will continue doing it but I have 2
> questions here below. If they are relevant, this can be fixed in a
> follow-up patch.

[...]

> > =

> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_MPTCP_H
> > +#define _UAPI_MPTCP_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define SUBFLOW_FLAGS_MCAP_REM		BIT(0)
> > +#define SUBFLOW_FLAGS_MCAP_LOC		BIT(1)
> > +#define SUBFLOW_FLAGS_JOIN_REM		BIT(2)
> > +#define SUBFLOW_FLAGS_JOIN_LOC		BIT(3)
> > +#define SUBFLOW_FLAGS_BKUP_REM		BIT(4)
> > +#define SUBFLOW_FLAGS_BKUP_LOC		BIT(5)
> > +#define SUBFLOW_FLAGS_4THACK		BIT(6)
> > +#define SUBFLOW_FLAGS_CONNECTED		BIT(7)
> > +#define SUBFLOW_FLAGS_MAPVALID		BIT(8)
> =

> Should we not prefix all of these with MPTCP_?

yes, =


[...]

> Should we prefix them as well? If yes only with "mptcp_" or
> "mptcp_diag_"? (as linked to diag.c, not subflow.c)
> =


and yes. I see the follow-up patch is already posted, will review it.

thanks! =


-- =

davide

--===============0994562252705319819==--
