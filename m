Content-Type: multipart/mixed; boundary="===============3678216993130290917=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 14:14:50 +0100
Message-ID: <20210120131450.GP19605@breakpoint.cc>
In-Reply-To: 6318158a-6810-3e26-38ff-640ce7823b39@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7445

--===============3678216993130290917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Hi Florian,
> =

> On 20/01/2021 13:18, Florian Westphal wrote:
> > Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > > On Thu, 14 Jan 2021, Florian Westphal wrote:
> > > > #define MPTCP_PM_NAME		"mptcp_pm"
> > > > #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> > > > +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
> > > =

> > > Suggest "mptcp_pm_events" instead.
> > =

> > I don't mind changing it but it would mean one more change needed
> > on mptcpd side vs. the out of tree kernel.
> =

> Instinctively, I would prefer having different names just in case we need=
 to
> do something different from one implementation to another. In userspace, =
we
> would only have to try one or the other but at least we will know which o=
ne
> we are connected to, "just in case" we need different behaviours for one =
or
> the other.

mptcp kernel uses "mptcp" as the genetlink name, not "mptcp_pm", so it
already knows if its running on mptcp.org or upstream kernel.
--===============3678216993130290917==--
