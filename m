Content-Type: multipart/mixed; boundary="===============4513793524948113972=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 17 Oct 2019 15:53:03 +0200
Message-ID: <f9aac1af-7b50-416c-88cb-d5fae159f29e@tessares.net>
In-Reply-To: 15d265f1-6130-4510-44dc-e710ef71a813@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2214

--===============4513793524948113972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 15:38, Matthieu Baerts wrote:
> Hi Paolo,
> =

> +cc Florian
> =

> Thank you for the reviews!
> =

> On 17/10/2019 15:26, Paolo Abeni wrote:
>> Hi,
>>
>> On Thu, 2019-10-10 at 16:27 +0200, Matthieu Baerts wrote:
>>> WARNING: line over 80 characters
>>> #233: FILE: net/mptcp/options.c:47:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * negotiated, the receiver MUST close the subflow =

>>> with a RST as it is
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>> ---
>>>
>>> Notes:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 to be squashed in "mptcp: Handle MPTCP TCP opt=
ions"
>>>
>>> =C2=A0 net/mptcp/options.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index cee4280647fe..adf65d3ff27b 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -44,8 +44,8 @@ void mptcp_parse_option(const unsigned char *ptr, =

>>> int opsize,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Section =
3.3.0:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * "If a ch=
ecksum is not present when its use has been
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * negotiated, the rec=
eiver MUST close the subflow with a =

>>> RST as it is
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * considered broken."
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * negotiated, the rec=
eiver MUST close the subflow with a =

>>> RST as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it is considered br=
oken."
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We don't=
 implement DSS checksum - fall back to TCP.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> This one and the next 2 patches are IMHO uncontroversially good, but
>> the 4th is a bit against my personal taste - I would keep the
>> checkpatch offenders instead;). No objections on the 5th patch.
> =

> I am fine to drop the 4th one. Florian mentioned earlier that it is =

> better to fix checkpatch issues than having comments about that during =

> the reviews or dedicated patches later to fix just that. But because =

> Florian wrote this code (mptcp_snmp_list + linux_mptcp_mib_field), I =

> guess he is also fine not to follow checkpatch rules :)
> =

> I am going to apply the other patches, they are not linked to each others.

- ca0aa2a7167f "squashed" patch 1/5 in "mptcp: Handle MPTCP TCP options"
- 6d74ebddfb37 "squashed" patch 2/5 in "mptcp: new sysctl to control the =

activation per NS"
- ce91edef4344 "squashed" patch 3/5 in "mptcp: queue data for mptcp =

level retransmission"
- patch 4/5 is not applied
- 2236d77c0c5f: "squashed" patch 5/5 in "mptcp: increment MIB counters =

in a few places"
- 6f951dc4ca1b..4c046ac001b8: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4513793524948113972==--
