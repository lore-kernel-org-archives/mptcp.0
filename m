Content-Type: multipart/mixed; boundary="===============8133624070098913667=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 18:37:59 +0100
Message-ID: <5a2041da0daebb86182ecc3c6134aa3a4c4ec03d.camel@redhat.com>
In-Reply-To: 50b21bc2-1d6f-0c3e-5fed-a2cf4997a727@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2513

--===============8133624070098913667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 17:35 +0100, Matthieu Baerts wrote:
> Should we already add the MIB counter? And/or add a TODO in the code?

I think adding more MIB counter is a later tasks.

> We are not there yet but missing an ADD_ADDR can have bad consequences. =

> And it would be unexpected for the userspace to drop it, especially with =

> MPTCPv1 which should make it reliable :)

whoops... I missed that difference between v0 and v1. That opens a full
can of worms, I think/fear:

ADD_ADDR6 echo (30 bytes) can't fit TCP option space easily, without
dropping also the tstamp option. Why does echo includes the IP address
itself ?!? why is the address ID not enough?

bold/stupid question: is still possible change v1 specs in that regard?
(e.g. removing the address from ADD_ADDR echo option)

> > Inserting a (duplicate) ack to try to fit such option looks doable, but
> > also out-of-scope for this change.

Here I missed the side effects of duplicate acks on CC. We can't easily
plug there MPTCP specific behavior and if we start sending TCP dup ack
to carry MPTCP info we may end-up needing hook to avoid interference on
CC.

> Agreed. We should add this in a TODO list of "things for later" :) (or a =

> TODO in the code?)

I think tracking this on the framepad is the better option.

Cheers,

Paolo

--===============8133624070098913667==--
