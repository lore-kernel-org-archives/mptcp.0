Content-Type: multipart/mixed; boundary="===============3062304363830062591=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Wed, 02 Dec 2020 18:08:11 +0100
Message-ID: <9d40955d2d33dd36f8bc38067868c19dd8cb5173.camel@redhat.com>
In-Reply-To: 0c400986125dfdd42990ee4203a60d9b309d29c8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7017

--===============3062304363830062591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-02 at 17:51 +0100, Paolo Abeni wrote:
> On Wed, 2020-12-02 at 17:45 +0100, Eric Dumazet wrote:
> > Packetdrill recvmsg syntax would be something like
> > =

> >    +0	recvmsg(3, {msg_name(...)=3D...,
> > 		    msg_iov(1)=3D[{..., 0}],
> > 		    msg_flags=3D0
> > 		    }, 0) =3D 0
> =

> Thank you very much for all the effort!
> =

> Yes, with recvmsg() the packet drill hangs. I agree your proposed fix
> is correct.
> =

> I can test it explicitly later today.

The proposed fix passes successfully the pktdrill test and there are no
regressions in the other self-tests.

Feel free to add:

Tested-by: Paolo Abeni <pabeni(a)redhat.com>

thanks!

Paolo

--===============3062304363830062591==--
