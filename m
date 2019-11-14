Content-Type: multipart/mixed; boundary="===============0714397048580304859=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Thu, 14 Nov 2019 10:36:58 -0800
Message-ID: <9244783E-C909-4115-A1DE-E9DC8033FDCF@apple.com>
In-Reply-To: 5a2041da0daebb86182ecc3c6134aa3a4c4ec03d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2549

--===============0714397048580304859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Nov 13, 2019, at 9:37 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> On Wed, 2019-11-13 at 17:35 +0100, Matthieu Baerts wrote:
>> Should we already add the MIB counter? And/or add a TODO in the code?
> =

> I think adding more MIB counter is a later tasks.
> =

>> We are not there yet but missing an ADD_ADDR can have bad consequences. =

>> And it would be unexpected for the userspace to drop it, especially with =

>> MPTCPv1 which should make it reliable :)
> =

> whoops... I missed that difference between v0 and v1. That opens a full
> can of worms, I think/fear:
> =

> ADD_ADDR6 echo (30 bytes) can't fit TCP option space easily, without
> dropping also the tstamp option. Why does echo includes the IP address
> itself ?!? why is the address ID not enough?
> =

> bold/stupid question: is still possible change v1 specs in that regard?
> (e.g. removing the address from ADD_ADDR echo option)

To clarify: When the echo-bit is set the HMAC is not present int the option=
. That means the ADD_ADDR option is at most 4 + 16 + 2 =3D 22 bytes on the =
echo.

However, on the initial ADD_ADDR (the one with echo =3D=3D 0), the maximum =
is indeed 30 bytes. That is only the case when it includes a port as well. =
And in that scenario I don't see another solution than to remove the TCP Ti=
mestamp option on that packet (it is not necessary to have the Timestamp op=
tion on each packet).

Does that work?


Christopbh


> =

>>> Inserting a (duplicate) ack to try to fit such option looks doable, but
>>> also out-of-scope for this change.
> =

> Here I missed the side effects of duplicate acks on CC. We can't easily
> plug there MPTCP specific behavior and if we start sending TCP dup ack
> to carry MPTCP info we may end-up needing hook to avoid interference on
> CC.
> =

>> Agreed. We should add this in a TODO list of "things for later" :) (or a =

>> TODO in the code?)
> =

> I think tracking this on the framepad is the better option.
> =

> Cheers,
> =

> Paolo
>=20

--===============0714397048580304859==--
