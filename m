Content-Type: multipart/mixed; boundary="===============7377860883972529167=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCHi iproute2] mptcp: add support for event monitoring
Date: Sat, 16 Jan 2021 20:25:44 +0100
Message-ID: <dfbe7e69-1cf9-d5c9-19f3-37cf484983b2@tessares.net>
In-Reply-To: 20210116175732.GK19605@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7415

--===============7377860883972529167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 16/01/2021 18:57, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> On 14/01/2021 18:38, Florian Westphal wrote:
>>> Output will look similar to this:
>>>
>>> [       CREATED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2=
 daddr4=3D10.0.1.1 sport=3D58710 dport=3D10011
>>> [   ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2=
 daddr4=3D10.0.1.1 sport=3D58710 dport=3D10011
>>> [SF_ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D1 saddr4=3D10.0.2.2=
 daddr4=3D10.0.1.1 sport=3D40195 dport=3D10011 backup=3D0
>>> [        CLOSED] token=3D83f3a692
>>
>> Thank you for this new feature, that's a good idea!
>>
>> It looks good! Just the usage/man page to update I think! I just asked a=
 few
>> questions below if you don't mind looking :)
> =

> Right, will update this for the netdev submission.

Thanks!

And thank you for the other answers!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7377860883972529167==--
