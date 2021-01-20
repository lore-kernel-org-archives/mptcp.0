Content-Type: multipart/mixed; boundary="===============2631173828704328150=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 13:18:52 +0100
Message-ID: <20210120121852.GN19605@breakpoint.cc>
In-Reply-To: bfdcd9fc-6d71-ba4d-566d-bc8cb1c9cb69@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7440

--===============2631173828704328150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> On Thu, 14 Jan 2021, Florian Westphal wrote:
> =

> > Allow userspace (mptcpd) to subscribe to mptcp genl multicast events.
> > This implementation reuses the same event API as the mptcp kernel fork
> > to ease integration of existing tools, e.g. mptcpd.
> > =

> > Supported events include:
> > 1. start and close of an mptcp connection
> > 2. start and close of subflows (joins)
> > 3. announce and withdrawals of addresses
> > 4. subflow priority (backup/non-backup) change.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> =

> Thanks for the patch series, Florian. I have a few minor comments below, =
and
> will work with Ossama to get mptcpd listening to the events on the upstre=
am
> kernel and really test things out.

Thanks, that would help a lot.

> > #define MPTCP_PM_NAME		"mptcp_pm"
> > #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> > +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
> =

> Suggest "mptcp_pm_events" instead.

I don't mind changing it but it would mean one more change needed
on mptcpd side vs. the out of tree kernel.
--===============2631173828704328150==--
