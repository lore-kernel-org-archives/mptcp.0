Content-Type: multipart/mixed; boundary="===============5994068741430930472=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 14:17:26 +0200
Message-ID: <fc0e8602-ea24-5558-f455-7f5ecd2420a3@tessares.net>
In-Reply-To: 20191015102645.GP25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2138

--===============5994068741430930472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Davide,

On 15/10/2019 12:26, Florian Westphal wrote:
> Davide Caratti <dcaratti(a)redhat.com> wrote:
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -18,7 +18,8 @@
>>   =

>>   #include <netdb.h>
>>   #include <netinet/in.h>
>> -#include <netinet/tcp.h>
>> +
>> +#include <linux/tcp.h>
>>
>> ^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
>> is newer than 4.13.
> =

> ii  linux-libc-dev:amd64            4.9.168-1+deb9u5               amd64
> Linux support headers for userspace development
> =

> I don't care though, I can carry this patch in my private branch.

Thank you for the patch and the review.
I would prefer to apply the patch, it doesn't cost anything to have this =

in the code.

If there is no objection from Davide, I am going to apply it. We can =

still revert later if needed.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5994068741430930472==--
