Content-Type: multipart/mixed; boundary="===============1562493837711152247=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3] Squash-to: "mptcp: add netlink-based
 PM"
Date: Thu, 26 Mar 2020 15:45:45 +0100
Message-ID: <eda5e6ff-aff8-6a55-a469-f299f4b61974@tessares.net>
In-Reply-To: 60934ce2-342d-2d4f-ae01-de1917118dbd@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4076

--===============1562493837711152247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/03/2020 14:53, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 26/03/2020 12:53, Paolo Abeni wrote:
>> Let user space set a single limit at once and drop bogus
>> NL extack error message.
>>
>> v2 -> v3:
>> =C2=A0 - better error message (Mat)
>> =C2=A0 - add spinlock
>> =C2=A0 - relax admin constraint on 'getters'
>>
>> v1 -> v2:
>> =C2=A0 - do not include dumb dbg messages
> =

> Thank you for the v3, it looks good to=C2=A0 me!
> =

> Cheers,
> Matt

- 621737cebef3: "squashed" in "mptcp: add netlink-based PM"
- 8e8969983c72..cda56df42342: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1562493837711152247==--
