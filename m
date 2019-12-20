Content-Type: multipart/mixed; boundary="===============4026565713936862125=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Fri, 20 Dec 2019 17:21:19 +0100
Message-ID: <1563cacb2fb2f5c59bedc7a33667586d4c3ec6c5.camel@redhat.com>
In-Reply-To: de3e37b0-f3ff-c5d0-9a38-890ce04916c7@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3227

--===============4026565713936862125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-20 at 07:26 -0800, Eric Dumazet wrote:
> =

> On 12/19/19 2:34 PM, Mat Martineau wrote:
> > If ULP is used on a listening socket, icsk_ulp_ops and icsk_ulp_data are
> > copied when the listener is cloned. Sometimes the clone is immediately
> > deleted, which will invoke the release op on the clone and likely
> > corrupt the listening socket's icsk_ulp_data.
> > =

> > The clone operation is invoked immediately after the clone is copied and
> > gives the ULP type an opportunity to set up the clone socket and its
> > icsk_ulp_data.
> > =

> =

> Since the method is void, this means no error can happen.
> =

> For example we do not intend to attempt a memory allocation ?

if the MPTCP ULP clone fails, we fallback to plain TCP (the 'is_mptcp'
flag cleared on the tcp 'struct sock'), so we don't have an error
return code there.

If we change the 'clone' signature, than the only in-kernel user will
always return 0, would that be ok?

Thank you!

Paolo

--===============4026565713936862125==--
