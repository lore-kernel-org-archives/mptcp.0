Content-Type: multipart/mixed; boundary="===============6110884663206608507=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 16:30:24 +0200
Message-ID: <66550eee4efdef058cce389740545b4bb9fc95c8.camel@redhat.com>
In-Reply-To: b90ae5e6-9858-eccd-ef45-eb59250ae8a1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6222

--===============6110884663206608507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-06 at 16:03 +0200, Matthieu Baerts wrote:
> Hi Davide, Paolo,
> =

> On 06/10/2020 15:07, Paolo Abeni wrote:
> > On Tue, 2020-10-06 at 14:22 +0200, Davide Caratti wrote:
> > > using packetdrill it's possible to observe the same MPTCP DSN being a=
cked
> > > by different subflows with DACK4 and DACK8. This is in contrast with =
what
> > > specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64=
-bit wide
> > > DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_=
ack'
> > > variable to make it a property of MPTCP sockets, not TCP subflows.
> > > =

> > > Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
> > > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > =

> > LGTM, thanks Davide!
> =

> Thank you for the patch and the review!

hello Matthieu, thanks for looking at this.

> @Davide: be careful that this patch doesn't apply as is on -net (or =

> net-next). I had a small conflict when applying it on top of net-next, =

> not at the end of the "export" branch?

right, I did that on top of export/20201006T083856 - but it requires
some adjustment to apply to "net", because context mismatches in
protocol.h.

FTR, this is another strange thing I noticed while working on =

https://github.com/multipath-tcp/mptcp_net-next/issues/94 : after a call
to close(), subflow-0 does DSS (DACK4+DATAFIN), while subflow-1 does
DSS(DACK8+DATAFIN) :)

-- =

davide

--===============6110884663206608507==--
