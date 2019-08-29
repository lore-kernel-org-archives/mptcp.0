Content-Type: multipart/mixed; boundary="===============8451929315759740627=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Thu, 29 Aug 2019 15:37:11 +0200
Message-ID: <3e0bd0e7-736a-cfcb-9d0c-f0a986ac95d6@tessares.net>
In-Reply-To: c619761004c77d9a7917dc4304af3897a2bb58f1.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1759

--===============8451929315759740627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 28/08/2019 02:18, Peter Krystad wrote:
> On Tue, 2019-08-27 at 20:06 +0200, Florian Westphal wrote:
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> For the 'mptcp_' prefix, we made sure to add them to all functions
>>> exposed outside net/mptcp and Peter got the excellent idea to move all
>>> functions only needed in net/mptcp into net/mptcp/protocol.h. We didn't
>>> add 'mptcp_' prefix for all these "internal" functions but it certainly
>>> makes sense to do that. I guess it is useful when debugging if you see
>>> these functions in a call trace or in the list of functions available
>>> for tracing.
>>>
>>> Do you think we should do the same for "crypto" and "subflow" and "pm"?
>>> I guess "pm" and "subflow" are keywords mainly used in "mptcp" but it is
>>> maybe not clear for everybody.
>>
>> Yes.  Subflow is maybe fine though.
>>
>> pm is 'power mangement', so I think it makes sense to prefix mptcp_
>> there.
> =

> Although I argued against this when creating net/mptcp/protocol.h I respe=
ct
> the namespace pollution issue more now. Matthieu are you volunteering to =
do
> this or do you want to have a go? Up to you.

I would be happy to do that but I guess I should focus on helping Mat
with the paper and slides.

If it is not already done by someone else, I can do it later. Maybe
after/at LPC if I really want to force myself to finish the paper/slides
as soon as possible :-)

Cheers,
Matt

> =

> Peter.
> =

>>> The patches look very good to me, just a few questions and one or two
>>> typos, nothing important. I guess other people will also have a look at
>>> them :)
>>
>> Thanks a lot for the review, I will respin a new version later this
>> week.
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8451929315759740627==--
