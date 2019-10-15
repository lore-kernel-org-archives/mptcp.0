Content-Type: multipart/mixed; boundary="===============7558156500156688838=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 15:29:45 +0200
Message-ID: <9fb5e141-2b43-e4b5-d978-1ddba59900a6@tessares.net>
In-Reply-To: fc0e8602-ea24-5558-f455-7f5ecd2420a3@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2142

--===============7558156500156688838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Davide,

On 15/10/2019 14:17, Matthieu Baerts wrote:
> Hi Florian, Davide,
> =

> On 15/10/2019 12:26, Florian Westphal wrote:
>> Davide Caratti <dcaratti(a)redhat.com> wrote:
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -18,7 +18,8 @@
>>> =C2=A0 #include <netdb.h>
>>> =C2=A0 #include <netinet/in.h>
>>> -#include <netinet/tcp.h>
>>> +
>>> +#include <linux/tcp.h>
>>>
>>> ^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
>>> is newer than 4.13.
>>
>> ii=C2=A0 linux-libc-dev:amd64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4.9.168-1+deb9u5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amd64
>> Linux support headers for userspace development
>>
>> I don't care though, I can carry this patch in my private branch.
> =

> Thank you for the patch and the review.
> I would prefer to apply the patch, it doesn't cost anything to have this =

> in the code.
> =

> If there is no objection from Davide, I am going to apply it. We can =

> still revert later if needed.

- 29950008bd42: "squashed" in "mptcp: add basic kselftest for mptcp"
- a6ac152c2671..d7c09401756b: results

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7558156500156688838==--
