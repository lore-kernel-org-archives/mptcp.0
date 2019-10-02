Content-Type: multipart/mixed; boundary="===============9131153442988663950=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Remove all traces of checksum support
Date: Wed, 02 Oct 2019 09:50:19 -0700
Message-ID: <5c7f326bfbbf92b2212963a8f04087086a5c6f4e.camel@linux.intel.com>
In-Reply-To: 47140e5b-8b50-115a-51d8-292c2ef68130@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1987

--===============9131153442988663950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 17:39 +0200, Matthieu Baerts wrote:
> Hi Peter, Paolo, Mat,
> =

> On 26/09/2019 01:44, Peter Krystad wrote:
> > Since checksum support is not planned remove any references
> > that look it may be supported.
> > =

> > Also re-factor DSS option size calculation and make
> > DSS option size check for exactly correct lengths.
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> Thank you for this patch and the reviews!
> =

> - a03d15e6a899: "squashed" in "mptcp: Associate MPTCP context with TCP
> socket"
> - 5120702d34e9: conflict in
> t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
> - fa25b3cfa037: build-fix in "mptcp: Create SUBFLOW socket for incoming
> connections"
> - 7704ceb50e99: "squashed" in "mptcp: Create SUBFLOW socket for incoming
> connections" (note: I removed the "unused" field)
> - 4f11988a5b9e: "squashed" in "mptcp: Write MPTCP DSS headers to
> outgoing data packets"
> - 5b8a09821448: conflict in t/mptcp-Implement-MPTCP-receive-path
> - 4e656f41fa2e: "squashed" (part 2) in "mptcp: Write MPTCP DSS headers
> to outgoing data packets"
> - c1090854bf0c: conflict in t/mptcp-Implement-MPTCP-receive-path
> - d50aa0ccca60: "squashed" in "mptcp: Implement MPTCP receive path"
> - 8dc529a9be69: conflict in
> t/mptcp-allow-collapsing-consecutive-sendpages-on-the-same-substream
> - c94ba96b727c: "squashed" in "mptcp: Add ADD_ADDR handling"
> - 5261fb90316d: conflict in t/mptcp-Add-handling-of-incoming-MP_JOIN-requ=
est
> - ca58392a1268: conflict in
> t/mptcp-harmonize-locking-on-all-socket-operations
> - 868fc953e348: conflict in
> t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
> - 3d566a4b1ebc..6e3f43237e22: result
> =

> Tests are still OK!
> =

> Note: I still see some refs to "checksum" fields in include/net/mptcp.h
> and include/linux/tcp.h. I will do a follow-up patch for that :)
> =

> Also, I have one comment below:
> =

> > ---
> >  net/mptcp/options.c  | 70 +++++++++++++++++---------------------------
> >  net/mptcp/pm.c       |  1 -
> >  net/mptcp/protocol.c | 13 ++++----
> >  net/mptcp/protocol.h |  4 +--
> >  net/mptcp/subflow.c  |  5 ----
> >  5 files changed, 33 insertions(+), 60 deletions(-)
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index b02e3c0253f5..2e0b6650be63 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -74,7 +74,6 @@ int pm_create_subflow(u32 token, u8 remote_id, sa_fam=
ily_t family,
> >  	if (family =3D=3D AF_INET)
> >  		local.sin_addr.s_addr =3D addr->s_addr;
> >  	else
> > -		local.sin_addr.s_addr =3D INADDR_ANY;
> >  		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
> >  =

> >  	remote.sin_family =3D msk->pm.remote_family;
> =

> I guess this part was not supposed to be here, right?

Right.

Peter.
> =

> Cheers,
> Matt

--===============9131153442988663950==--
