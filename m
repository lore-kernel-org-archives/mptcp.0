Content-Type: multipart/mixed; boundary="===============1655236945056137776=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: fix option length of mp_capable syn/ack
Date: Thu, 05 Dec 2019 11:52:26 +0100
Message-ID: <f8d39448e23897fd79450718b20a9a17e2c9a616.camel@redhat.com>
In-Reply-To: 87a9f579567e428774ae6a00858daad663f0831a.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2793

--===============1655236945056137776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello Peter!

On Wed, 2019-12-04 at 11:35 -0800, Peter Krystad wrote:
> Hi Davide -
> =

> On Mon, 2019-12-02 at 11:04 +0100, Davide Caratti wrote:
> > in current MPTCP, the server sends the client's key back in the syn/ack
> > packet. Because of that, both tcpdump and packetdrill refuse to parse
> > the mp_capable option in the syn/ack. Both RFC6824 and RFC6824bis don't
> > require this in section 3.1, only the server's key should be sent in
> > the syn/ack.

[...]

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index acad61c70de9..10347c9b4dff 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -34,7 +34,7 @@
> >  =

> >  /* MPTCP suboption lengths */
> >  #define TCPOLEN_MPTCP_MPC_SYN		12
> > -#define TCPOLEN_MPTCP_MPC_SYNACK	20
> > +#define TCPOLEN_MPTCP_MPC_SYNACK	12
> >  #define TCPOLEN_MPTCP_MPC_ACK		20
> >  #define TCPOLEN_MPTCP_MPJ_SYN		12
> >  #define TCPOLEN_MPTCP_MPJ_SYNACK	16
> =

> This is minor but I think for clarity in mptcp_synack_options() we should
> remove the line that copies the remote_key into the option space:
> =

> 	if (subflow_req->mp_capable) {
> 		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
> 		opts->sndr_key =3D subflow_req->local_key;
> 		opts->rcvr_key =3D subflow_req->remote_key;  <=3D=3D delete this
> 		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;

> The new value for TCPOLEN_MPTCP_MPC_SYNACK means it won't be sent as inte=
nded
> by this change, but this line is now irrevelant.

correct, I will fix this in v4.

thanks!
-- =

davide


--===============1655236945056137776==--
