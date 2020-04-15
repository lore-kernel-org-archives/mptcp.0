Content-Type: multipart/mixed; boundary="===============2750666188258889933=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 4/4] man: mptcp man page
Date: Wed, 15 Apr 2020 18:49:00 +0200
Message-ID: <97238c0e-4c93-5d9f-9547-8af14e504e63@tessares.net>
In-Reply-To: 4fc768461852c4fbe44bd988bda5a809fb796577.1586953702.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4176

--===============2750666188258889933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 15/04/2020 14:28, Paolo Abeni wrote:
> describe the mptcp subcommands implemented so far.

(...)

> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> new file mode 100644
> index 00000000..5ed0457b
> --- /dev/null
> +++ b/man/man8/ip-mptcp.8

(...)

> +.ti -8
> +.BR "ip mptcp endpoint add "
> +.IR IFADDR
> +.RB "[ " dev
> +.IR IFNAME " ]"
> +.RB "[ " id
> +.I ID
> +.RB "] [ "
> +.I FLAG-LIST
> +.RB "] "

Should we show the same in the code for "usage()" (using FLAG-LIST)

> +.ti -8
> +.BR "ip mptcp endpoint del id "
> +.I ID
> +
> +.ti -8
> +.BR "ip mptcp endpoint show "
> +.RB "[ " id
> +.I ID
> +.RB "]"
> +
> +.ti -8
> +.BR "ip mptcp endpoint flush"
> +
> +.ti -8
> +.IR FLAG-LIST " :=3D [ "  FLAG-LIST " ] " FLAG
> +
> +.ti -8
> +.IR FLAG " :=3D ["
> +.B signal
> +.RB "|"
> +.B subflow
> +.RB "|"
> +.B backup
> +.RB  "]"
> +
> +.ti -8
> +.BR "ip mptcp limits set "
> +.RB "[ "
> +.B subflow
> +.IR SUBFLOW_NR " ]"
> +.RB "[ "
> +.B add_addr_accepted
> +.IR  ADD_ADDR_ACCEPTED_NR " ]"

Should it be?

   set { subflow SUBFLOW_NR | add_addr_accepted ADD_ADDR_ACCEPTED_NR }

or:

   set { subflow | add_addr_accepted } NR


> +
> +.ti -8
> +.BR "ip mptcp limits show"
> +
> +.SH DESCRIPTION
> +
> +MPTCP is a transport protocol build on top of TCP that allows TCP

(I guess it could be nice if some English natives can have a look at =

this :) )
I think here you need s/build/built/

> +connections to use multiple paths to maximize resource usage and increase
> +redundancy.

Should we mention that the socket needs to be open using the MPTCP option?

> The ip-mptcp sub-commands allow configuring several aspects of the
> +MPTCP path manager, which is in charge of subflows creation:
> +
> +.P
> +The
> +.B endpoint
> +object specifies the IP addresses that will be used and/or announced for
> +additional subflows:
> +
> +.TS
> +l l.
> +ip mptcp endpoint add	add new MPTCP endpoint
> +ip mptcp endpoint delete	delete existing MPTCP endpoint
> +ip mptcp endpoint show	get existing MPTCP endpoint
> +ip mptcp endpoint flush	flush all existing MPTCP endpoints
> +.TE
> +
> +.TP
> +.IR ID
> +is a unique numeric identifier for the given endpoint
> +
> +.TP
> +.BR signal
> +the endpoint will be announced/signaled to each peer via an ADD_ADDR MPT=
CP

s/signaled/signalled/

Cheers,
Matt

> +sub-option
> +
> +.TP
> +.BR subflow
> +If the MPTCP limits allow for additional subflows creation, the endpoint=
 will
> +be used as the source address to create an additional subflow after that
> +the MPTCP connection is established.
> +
> +.TP
> +.BR backup
> +the endpoint will be announced as a backup address, if this is a
> +.BR signal
> +endpoint, or the subflow will be created as a backup one if this a
> +.BR subflow
> +endpoint
> +
> +.sp
> +.PP
> +The
> +.B limits
> +object specifies the constraints for subflow creations:
> +
> +.TS
> +l l.
> +ip mptcp limits show	get current MPTCP subflow creation limits
> +ip mptcp limits set	change the MPTCP subflow creation limits
> +.TE
> +
> +.TP
> +.IR SUBFLOW_NR
> +specifies the maximum number of additional subflows allowed for each MPT=
CP
> +connection. Additional subflows can be created due to: incoming accepted
> +ADD_ADDR option, local
> +.BR subflow
> +endpoints, additional subflows started by the peer.
> +
> +.TP
> +.IR ADD_ADDR_ACCEPTED_NR
> +specifies the maximum number of ADD_ADDR suboptions accepted for each MP=
TCP
> +connection. The MPTCP path manager will try to create a new subflow for
> +each accepted ADD_ADDR option, respecting the
> +.IR SUBFLOW_NR
> +limit.
> +
> +.SH AUTHOR
> +Original Manpage by Paolo Abeni <pabeni(a)redhat.com>
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2750666188258889933==--
