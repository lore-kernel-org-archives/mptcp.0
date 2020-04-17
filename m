Content-Type: multipart/mixed; boundary="===============7830895136235126283=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 3/4] ss: allow dumping MPTCP subflow information
Date: Fri, 17 Apr 2020 09:19:55 +0200
Message-ID: <e8af268691cf1b4717c6e2f1b962388150ccc1bf.camel@redhat.com>
In-Reply-To: f806e634-bc0f-7845-00ad-8b76d22ba7fe@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4197

--===============7830895136235126283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 18:36 +0200, Matthieu Baerts wrote:
> Hi Davide,
> =

> On 15/04/2020 14:28, Paolo Abeni wrote:
> > From: Davide Caratti <dcaratti(a)redhat.com>
> > =

> >   [root(a)f31 packetdrill]# ss -tni
> > =

> >   ESTAB    0        0           192.168.82.247:8080           192.0.2.1=
:35273
> >            cubic wscale:7,8 [...] tcp-ulp-mptcp flags: Mec token:0000(i=
d:0)/5f856c60(id:0) seq:b810457db34209a5 sfseq:1 ssnoff:0 maplen:190
> =

> Thank you for this patch!
> =

> For the output, should it not be "flags:Mec" without space? If no, I =

> guess it should not contain space for the parsing (flags: Mec)

yes, there is an extra space after the ':', I will fix it.

> Is there a place where these flags can be explained?

the place might be ss.8, let me see if I can write something decent. =


> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> >   misc/ss.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > =

> > diff --git a/misc/ss.c b/misc/ss.c
> > index 3ef151fb..3fac4be8 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -53,6 +53,7 @@
> >   #include <linux/tipc_netlink.h>
> >   #include <linux/tipc_sockets_diag.h>
> >   #include <linux/tls.h>
> > +#include <linux/mptcp.h>
> >   =

> >   /* AF_VSOCK/PF_VSOCK is only provided since glibc 2.18 */
> >   #ifndef PF_VSOCK
> > @@ -2836,6 +2837,59 @@ static void tcp_tls_conf(const char *name, struc=
t rtattr *attr)
> >   	}
> >   }
> >   =

> > +static void mptcp_subflow_info(struct rtattr *tb[])
> > +{
> > +	u_int32_t flags =3D 0;
> > +
> > +	if (tb[MPTCP_SUBFLOW_ATTR_FLAGS]) {
> > +		char caps[32 + 1] =3D { 0 }, *cap =3D &caps[0];
> > +
> > +		flags =3D rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_FLAGS]);
> > +
> > +		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_REM)
> > +			*cap++ =3D 'M';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_LOC)
> > +			*cap++ =3D 'm';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_REM)
> > +			*cap++ =3D 'J';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_LOC)
> > +			*cap++ =3D 'j';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_REM)
> > +			*cap++ =3D 'B';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_LOC)
> > +			*cap++ =3D 'b';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED)
> > +			*cap++ =3D 'e';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_CONNECTED)
> > +			*cap++ =3D 'c';
> > +		if (flags & MPTCP_SUBFLOW_FLAG_MAPVALID)
> > +			*cap++ =3D 'v';
> > +		if (flags)
> > +			out(" flags:%s", caps);
> > +	}
> > +	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
> > +	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
> > +	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
> > +	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
> > +		out(" token:%04x(id:%d)/%04x(id:%d)",
> =

> For the id, I guess it is fine with %d (because it's a u8) and not %u? =

> (Just to avoid possible warnings with the compiler ;-) )

right, or even better %hhu so we don't do the implicit cast. =


-- =

davide


--===============7830895136235126283==--
