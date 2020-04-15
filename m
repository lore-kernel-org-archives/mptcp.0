Content-Type: multipart/mixed; boundary="===============6706219551692834068=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 4/4] man: mptcp man page
Date: Wed, 15 Apr 2020 19:19:29 +0200
Message-ID: <13c8087ab70a9c11299b3fc3fff1c45fd4f6dc4c.camel@redhat.com>
In-Reply-To: 97238c0e-4c93-5d9f-9547-8af14e504e63@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4178

--===============6706219551692834068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 18:49 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 15/04/2020 14:28, Paolo Abeni wrote:
> > describe the mptcp subcommands implemented so far.
> =

> (...)
> =

> > diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> > new file mode 100644
> > index 00000000..5ed0457b
> > --- /dev/null
> > +++ b/man/man8/ip-mptcp.8
> =

> (...)
> =

> > +.ti -8
> > +.BR "ip mptcp endpoint add "
> > +.IR IFADDR
> > +.RB "[ " dev
> > +.IR IFNAME " ]"
> > +.RB "[ " id
> > +.I ID
> > +.RB "] [ "
> > +.I FLAG-LIST
> > +.RB "] "
> =

> Should we show the same in the code for "usage()" (using FLAG-LIST)

oks. I'll do that!

> > +.ti -8
> > +.BR "ip mptcp endpoint del id "
> > +.I ID
> > +
> > +.ti -8
> > +.BR "ip mptcp endpoint show "
> > +.RB "[ " id
> > +.I ID
> > +.RB "]"
> > +
> > +.ti -8
> > +.BR "ip mptcp endpoint flush"
> > +
> > +.ti -8
> > +.IR FLAG-LIST " :=3D [ "  FLAG-LIST " ] " FLAG
> > +
> > +.ti -8
> > +.IR FLAG " :=3D ["
> > +.B signal
> > +.RB "|"
> > +.B subflow
> > +.RB "|"
> > +.B backup
> > +.RB  "]"
> > +
> > +.ti -8
> > +.BR "ip mptcp limits set "
> > +.RB "[ "
> > +.B subflow
> > +.IR SUBFLOW_NR " ]"
> > +.RB "[ "
> > +.B add_addr_accepted
> > +.IR  ADD_ADDR_ACCEPTED_NR " ]"
> =

> Should it be?
> =

>    set { subflow SUBFLOW_NR | add_addr_accepted ADD_ADDR_ACCEPTED_NR }
> =

> or:
> =

>    set { subflow | add_addr_accepted } NR

I think that the text you suggest has different semantic.
> =

> =

> > +
> > +.ti -8
> > +.BR "ip mptcp limits show"
> > +
> > +.SH DESCRIPTION
> > +
> > +MPTCP is a transport protocol build on top of TCP that allows TCP
> =

> (I guess it could be nice if some English natives can have a look at =

> this :) )
> I think here you need s/build/built/
> =

> > +connections to use multiple paths to maximize resource usage and incre=
ase
> > +redundancy.
> =

> Should we mention that the socket needs to be open using the MPTCP option?

I think that would should be in a different man page: man(7) mptcp in
the kernel man pages.

> > The ip-mptcp sub-commands allow configuring several aspects of the
> > +MPTCP path manager, which is in charge of subflows creation:
> > +
> > +.P
> > +The
> > +.B endpoint
> > +object specifies the IP addresses that will be used and/or announced f=
or
> > +additional subflows:
> > +
> > +.TS
> > +l l.
> > +ip mptcp endpoint add	add new MPTCP endpoint
> > +ip mptcp endpoint delete	delete existing MPTCP endpoint
> > +ip mptcp endpoint show	get existing MPTCP endpoint
> > +ip mptcp endpoint flush	flush all existing MPTCP endpoints
> > +.TE
> > +
> > +.TP
> > +.IR ID
> > +is a unique numeric identifier for the given endpoint
> > +
> > +.TP
> > +.BR signal
> > +the endpoint will be announced/signaled to each peer via an ADD_ADDR M=
PTCP
> =

> s/signaled/signalled/

ok

> =

> Cheers,
> Matt
> =

> > +sub-option
> > +
> > +.TP
> > +.BR subflow
> > +If the MPTCP limits allow for additional subflows creation, the endpoi=
nt will
> > +be used as the source address to create an additional subflow after th=
at
> > +the MPTCP connection is established.
> > +
> > +.TP
> > +.BR backup
> > +the endpoint will be announced as a backup address, if this is a
> > +.BR signal
> > +endpoint, or the subflow will be created as a backup one if this a
> > +.BR subflow
> > +endpoint
> > +
> > +.sp
> > +.PP
> > +The
> > +.B limits
> > +object specifies the constraints for subflow creations:
> > +
> > +.TS
> > +l l.
> > +ip mptcp limits show	get current MPTCP subflow creation limits
> > +ip mptcp limits set	change the MPTCP subflow creation limits
> > +.TE
> > +
> > +.TP
> > +.IR SUBFLOW_NR
> > +specifies the maximum number of additional subflows allowed for each M=
PTCP
> > +connection. Additional subflows can be created due to: incoming accept=
ed
> > +ADD_ADDR option, local
> > +.BR subflow
> > +endpoints, additional subflows started by the peer.
> > +
> > +.TP
> > +.IR ADD_ADDR_ACCEPTED_NR
> > +specifies the maximum number of ADD_ADDR suboptions accepted for each =
MPTCP
> > +connection. The MPTCP path manager will try to create a new subflow for
> > +each accepted ADD_ADDR option, respecting the
> > +.IR SUBFLOW_NR
> > +limit.
> > +
> > +.SH AUTHOR
> > +Original Manpage by Paolo Abeni <pabeni(a)redhat.com>

Thanks,

Paolo

--===============6706219551692834068==--
