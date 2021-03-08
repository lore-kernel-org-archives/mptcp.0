Content-Type: multipart/mixed; boundary="===============7823774614933487308=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Mon, 08 Mar 2021 10:07:13 +0100
Message-ID: <e046688633b4689572e35754cbacbb8ac92e3894.camel@redhat.com>
In-Reply-To: f08b6167-4091-e301-d734-c7128045f317@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8065

--===============7823774614933487308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-03-06 at 08:30 +0100, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 06/03/2021 00:39, Mat Martineau wrote:
> > On Fri, 5 Mar 2021, Paolo Abeni wrote:
> =

> Thank you for the nice work and the reviews!
> =

> (...)
> =

>  >> +        /* the following 23 need a better implementation,
>  >> +         * but are quite common we want to preserve them
>  >> +         */
> =

> Maybe we should avoid writing numbers (23) here. It is likely something =

> we will forget to update and I don't think they are needed. Same below: =

> ten, nine, 14, one, 2, 18.
> =

> > > +        /* SO_OOBINLINE is not supported, let's avoid the related =

> > > mess */
> > > +        /* SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
> > > +         * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
> > > +         * we must be careful with subflows
> > > +         */
> > > +        /* SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
> > > +         * explicitly the sk_protocol field
> > > +         */
> > > +        /* SO_PEEK_OFF is unsupported, as it is for plain TCP */
> > > +        /* SO_MAX_PACING_RATE is unsupported, we must be careful wit=
h =

> > > subflows */
> > > +        /* SO_CNX_ADVICE is currently unsupported, could possibly be =

> > > relevant,
> > > +         * but likely needs careful design
> > > +         */
> > > +        /* SO_ZEROCOPY is currently unsupported, TODO in sndmsg */
> > > +        /* SO_TXTIME is currently unsupported */
> > =

> > The formatting here made the intent less clear - if you move the above =

> > block comments were after these lines:
> > =

> > > +            return true;
> > > +        }
> > =

> > ...it would be a lot more clear that the mentioned options are attached =

> > to the "return false;", and the case labels are for the "return true".
> > =

> > (this applies to the other SOL levels too)
> =

> Should we eventually add notes somewhere -- socket.h, in.h, in6.h, tcp.h =

> -- to ask other devs to eventually contact us when new sockopt are being =

> added?
> Not sure it is something common to do but it can be useful for us and =

> these devs.

Replying to this point here, as it will be the only comment I plan to
not include in the next iteration: I think this is on us for the time
being. I would avoid core networking changes.

Additionally, if a new socket option is added, the whitelist model will
fit gracefully, as the new socket option will be unimplemented for
MPTCP and user-space will get back a resonable error code.

Cheers,

Paolo

--===============7823774614933487308==--
