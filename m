Content-Type: multipart/mixed; boundary="===============0770515952577678554=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/1] mptcp: Optimize struct mptcp_received_options.
Date: Fri, 06 Dec 2019 15:12:44 -0800
Message-ID: <7c6b64619bc663a5e1cd4552878462e145691f7c.camel@linux.intel.com>
In-Reply-To: a39ab2d4-9be2-2879-20a2-a544002e1459@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2838

--===============0770515952577678554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-06 at 17:32 +0100, Matthieu Baerts wrote:
> Hi Peter,
> =

> On 14/11/2019 07:01, Peter Krystad wrote:
> > Re-organize struct mptcp_received_options to be more efficient
> > with space, reducing size impact to struct tcp_sock.
> > =

> > Remove unneeded flags fields, make version a bit field. Use unions
> > to reflect that available option space is limited to 28 bytes, not
> > all options may be received at once. Options that may be received
> > at the same time are MP_CAPABLE and DSS ack-only or DSS ack-only and
> > IPv4 ADD_ADDR.
> =

> Thank you for the patch!
> =

> I was looking at applying it but I have a few comments here below and in =

> the source code.
> =

> I see that the two recent patches you sent are part of this RFC one. I =

> guess the best is to these patches first while they are still "fresh", =

> should be easier to apply. Then a rebase/split will be needed but from a =

> smaller patch.

Yes I split out the two recent patches, and plan to split the rest of the
contents of this RFC too, with adjustments for v1. The next patches are not
needed for part 1. You don't need to apply this RFC.

> =

> Because we decided to send patches in one week, I will not rush to apply =

> the rest. I will then wait for your reply and possible other reviews to =

> do anything. Of course, do not hesitate to continue the rebase and split =
:-D
> (but I can also help next week.)
> =

> (please see other questions below)
> =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > ---
> >   include/linux/tcp.h  |  97 ++++++++++++++++++++++++----------------
> >   net/mptcp/options.c  | 102 ++++++++++++++++++++++++-------------------
> >   net/mptcp/pm.c       |   2 +-
> >   net/mptcp/protocol.h |   2 +-
> >   4 files changed, 118 insertions(+), 85 deletions(-)
> > =

> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 41730d9bcb32..88245483ce11 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -78,6 +78,62 @@ struct tcp_sack_block {
> >   #define TCP_SACK_SEEN     (1 << 0)   /*1 =3D peer is SACK capable, */
> >   #define TCP_DSACK_SEEN    (1 << 2)   /*1 =3D DSACK was received from =
peer*/
> >   =

> > +#if IS_ENABLED(CONFIG_MPTCP)
> > +struct mptcp_options_received {
> > +	union {
> > +		struct {
> > +			u32	data_ack32;
> > +			u32	data_seq32;
> > +			union {
> > +				struct {
> > +					u64	sndr_key;
> > +					u64	rcvr_key;
> > +				};
> > +				struct {
> > +					struct in_addr	addr;
> > +					u8	addr_id;
> > +				};
> > +			};
> > +		};
> > +		struct {
> > +			u64	data_ack;
> > +			u64	data_seq;
> > +		};
> > +		union {
> > +			struct {
> > +				u64	thmac;
> > +				u32	token;
> > +				u32	nonce;
> > +				u8	join_id;
> > +			};
> > +			u8	hmac[20];
> > +		};
> > +#if IS_ENABLED(CONFIG_IPV6)
> =

> Should we use the MPTCP one? I mean: CONFIG_MPTCP_IPV6

You're right, we should. It looks like I forgot there was an enclosing
CONFIG_MPTCP.

> > +		struct in6_addr	addr6;
> > +#endif
> > +	};
> > +	u32	subflow_seq;
> > +	union {
> > +		u16	data_len;
> > +		u8	addr6_id;
> =

> Why these two? Why not addr6_id and addr_id?
> Should we not add "#if IS_ENABLED(CONFIG_IPV6)" around "addr6_id" to =

> save 8 bits if we never use it in the code?

For completeness addr6_id should be #if, but it doesn't save any space beca=
use
data_len will still use it. I can put addr6_id in a struct next to addr6 as
that will still be smaller than the largest item in the main union, like th=
is

#if IS_ENABLED(CONFIG_MPTCP_IPV6)
		struct {
			struct in6_addr	addr6
			u8	addr_id;
		};
#endif

 =

> > +	};
> > +	u8	mp_capable : 1,
> > +		mp_join : 1,
> > +		dss : 1,
> > +		add_addr : 1,
> > +		add_addr6 : 1,
> > +		rm_addr : 1,
> > +		backup : 1,
> > +		version : 1;
> > +	u8	use_map : 1,
> > +		dsn64 : 1,
> > +		use_ack : 1,
> > +		ack64 : 1,
> > +		data_fin : 1,
> > +		__unused : 3;
> > +};
> > +#endif
> =

> Should we not move this structure to mptcp.h file? Or better there =

> because it directly impact TCP header size?
> (or maybe not possible to include mptcp.h?)

It would be better there but I'm not sure if it is possible to add #include
"mptcp.h".

Peter.

> Cheers,
> Matt

--===============0770515952577678554==--
