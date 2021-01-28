Content-Type: multipart/mixed; boundary="===============2821590806304959553=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: fix length of MP_PRIO sub-option
Date: Thu, 28 Jan 2021 12:57:35 +0100
Message-ID: <543d89b63f350739e8797c5b16ae87638794dc1c.camel@redhat.com>
In-Reply-To: CA+WQbwsaAZ=SuvTw8yNS+Di_s74CWi6H2nR1BXMN0V2CvxSCxg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7500

--===============2821590806304959553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello, thanks a lot for reviewing!
On Thu, 2021-01-28 at 11:08 +0800, Geliang Tang wrote:

[...]

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 447ce4631b43..7e18bbfe8f43 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -62,6 +62,7 @@
> > =C2=A0#define TCPOLEN_MPTCP_PORT_LEN         4
> > =C2=A0#define TCPOLEN_MPTCP_RM_ADDR_BASE     4
> > =C2=A0#define TCPOLEN_MPTCP_PRIO             4
> > +#define TCPOLEN_MPTCP_PRIO_NOID                3
> =

> I think it's better to change TCPOLEN_MPTCP_PRIO to 3 directly, rather th=
an
> adding a new macro TCPOLEN_MPTCP_PRIO_NOID, since the implementation in
> kernel is for v1 only, no need to consider compatibility with v0.

Ok, but please note that mptcp_option(x) writes always 4 bytes, even
when x is 3. Because of that, functions accounting MP_PRIO space in the
TCP options (namely, mptcp_established_options_mp_prio() ) will need to
use TCPOLEN_MPTCP_PRIO + 1 to account for the trailing NOP.

> Accordingly, the "Fixes" tags need to be updated too. This tag
> "Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")"
> needs to be dropped.
> =

sure, I added it because one of the lines I changed was introduced in
40453a5c61f4; moreover, this change also impacts reception, because the
kernel will start discarding MP_PRIO packets with Legth equal to 4.

Anyway it's non-realistic that somebody backports it without backporting
40453a5c61f4 and its follow-ups. I'm about to send v2 directly to net-
next including both of your suggestions.

thanks!
-- =

davide


--===============2821590806304959553==--
