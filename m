Content-Type: multipart/mixed; boundary="===============4204815241635047605=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: drop
 rm_addr_signal flag
Date: Fri, 20 Nov 2020 10:17:16 +0100
Message-ID: <42707067c9447a0f7d13e17785ed18fbd26cce07.camel@redhat.com>
In-Reply-To: f7a6bc69-1a31-1011-f582-4ec6dde2b60@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6870

--===============4204815241635047605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-19 at 17:12 -0800, Mat Martineau wrote:
> On Thu, 19 Nov 2020, Geliang Tang wrote:
> =

> > This patch reused add_addr_signal for the RM_ADDR announce signal, by
> > defining a new add_addr status named MPTCP_RM_ADDR_SIGNAL. Then the flag
> > rm_addr_signal in PM could be dropped.
> > =

> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm.c       | 22 +++++++++++++++++-----
> > net/mptcp/protocol.h |  4 ++--
> > 2 files changed, 19 insertions(+), 7 deletions(-)
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index e63e14f4cf2a..cc424222894b 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -18,7 +18,12 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> > {
> > 	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
> > =

> > -	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> > +	pr_debug("msk=3D%p, local_id=3D%d, add_addr=3D%d", msk, addr->id, add=
_addr);
> > +
> > +	if (add_addr) {
> > +		pr_err("addr_signal error.");
> =

> Hi Geliang,
> =

> One minor thing, pr_err() indicates a more serious problem that a user =

> might need to do something about. These seem like pr_warn() at most. Ther=
e =

> is only one pr_err() in the rest of the MPTCP code.

Looks like the condition checked there could happen just due to some
bugs in the pm code, right?

If so we could conside a WARN_ON_ONCE instead.

Otherwise, if is expected to enter that code path on some unusual
situation a pr_debug would be enough.

You can also add the current add_addr value.

/P



--===============4204815241635047605==--
