Content-Type: multipart/mixed; boundary="===============8889648222783121391=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: cope with later TCP fallback.
Date: Mon, 16 Dec 2019 19:40:25 +0100
Message-ID: <1528d86de7e15cdf639cf120c39605f4960a2ace.camel@redhat.com>
In-Reply-To: ff7ef19f-5e1d-20d0-dd63-0a0c0c2ce3d2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3089

--===============8889648222783121391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 19:53 +0100, Matthieu Baerts wrote:
> Hi Paolo, Florian, Mat,
> =

> On 13/12/2019 17:31, Paolo Abeni wrote:
> > With V1 passive connections can fallback TCP after that the
> > subflow become established:
> > =

> > syn+ MP_CAPABLE ->
> >                 <- syn, ack + MP_CAPABLE
> > =

> > ack, seq =3D 3    ->
> >          // OoO packet is accepted because in-sequence
> >          // passive socket is created, is in ESTABLISHED
> > 	// status and tentatively as MP_CAPABLE
> > =

> > ack, seq =3D 2     ->
> >          // no MP_CAPABLE opt, subflow should fallback to TCP
> > =

> > We can't use the 'subflow' socket fallback, as we don't have
> > it available for passive connection.
> > =

> > Instead, when the fallback is detected, replace the mptcp
> > socket with the underlining TCP subflow. Beyond covering
> > the above scenario, it makes TCP fallback socket as efficient
> > as plain TCP ones.
> > =

> > Co-developed-by: Florian Westphal <fw(a)strlen.de>
> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > RFC -> v1:
> >   - fixed WARN_ON splat on fallback
> >   - added a few more comments about locking
> >   - tested on both of v1 patches and top of current export
> >     branch
> > =

> > Note: should be applied just after "mptcp: process MP_CAPABLE data opti=
on."
> =

> I just applied this patch just after "mptcp: process MP_CAPABLE data =

> option". Please review at least the resolution of the second conflict:
> =

> =3D=3D=3D=3D=3D
> diff --cc net/mptcp/protocol.c
> index 9970487a855d,08d686c5f614..000000000000
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@@ -202,11 -189,8 +249,16 @@@ static int mptcp_sendmsg_frag(struct so
>                  ret =3D sk_stream_wait_memory(ssk, timeo);
>                  if (ret)
>                          return ret;
> ++<<<<<<< t/mptcp-queue-data-for-mptcp-level-retransmission
>   +
>   +              /* id sk_stream_wait_memory() sleeps snd_una can change
>   +               * significantly, refresh the rtx queue
>   +               */
>   +              mptcp_clean_una(sk);
> ++=3D=3D=3D=3D=3D=3D=3D
> +               if (unlikely(__mptcp_needs_tcp_fallback(msk)))
> +                       return 0;
> ++>>>>>>> top-bases/t/mptcp-queue-data-for-mptcp-level-retransmission
>          }
> =

>          /* compute copy limit */
> =3D=3D=3D=3D=3D
__mptcp_tcp_fallback
Conflicts resolution LGTM! =


Additionally I thought/fear we would need some additional cleanup in
__mptcp_tcp_fallback() in part 4, but since we call into
__mptcp_close() we should be good!

Thanks,

Paolo

--===============8889648222783121391==--
