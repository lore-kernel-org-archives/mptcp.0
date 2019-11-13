Content-Type: multipart/mixed; boundary="===============2192864737104588026=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 19:13:48 +0100
Message-ID: <7ef4b901-57b7-4d0b-c599-ada67ea7a4f9@tessares.net>
In-Reply-To: 5a2041da0daebb86182ecc3c6134aa3a4c4ec03d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2516

--===============2192864737104588026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Christoph,

On 13/11/2019 18:37, Paolo Abeni wrote:
> On Wed, 2019-11-13 at 17:35 +0100, Matthieu Baerts wrote:
>> Should we already add the MIB counter? And/or add a TODO in the code?
> =

> I think adding more MIB counter is a later tasks.

Should we add a comment in the code is it useless when there are =

thousands of lines around? :)

>> We are not there yet but missing an ADD_ADDR can have bad consequences.
>> And it would be unexpected for the userspace to drop it, especially with
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

Good question. I just added a new topic in the list for the meeting =

tomorrow just in case Christoph misses the question :)

>>> Inserting a (duplicate) ack to try to fit such option looks doable, but
>>> also out-of-scope for this change.
> =

> Here I missed the side effects of duplicate acks on CC. We can't easily
> plug there MPTCP specific behavior and if we start sending TCP dup ack
> to carry MPTCP info we may end-up needing hook to avoid interference on
> CC.

I guess we will have to support that at some points.

>> Agreed. We should add this in a TODO list of "things for later" :) (or a
>> TODO in the code?)
> =

> I think tracking this on the framepad is the better option.

Thanks! I added a topic for tomorrow's meeting.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2192864737104588026==--
