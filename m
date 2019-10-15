Content-Type: multipart/mixed; boundary="===============3659261829973837532=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 14:36:36 +0200
Message-ID: <a0dca57f-de6c-86a4-04b0-6eadb13e607e@tessares.net>
In-Reply-To: 5fab2cfe5c72b0188770363c4657c7e1ccbfd560.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2140

--===============3659261829973837532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 15/10/2019 14:31, Davide Caratti wrote:
> On Tue, 2019-10-15 at 12:26 +0200, Florian Westphal wrote:
>> Davide Caratti <dcaratti(a)redhat.com> wrote:
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -18,7 +18,8 @@
>>>   =

>>>   #include <netdb.h>
>>>   #include <netinet/in.h>
>>> -#include <netinet/tcp.h>
>>> +
>>> +#include <linux/tcp.h>
>>>
>>> ^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
>>> is newer than 4.13.
>>
>> ii  linux-libc-dev:amd64            4.9.168-1+deb9u5               amd64
>> Linux support headers for userspace development
>>
>> I don't care though, I can carry this patch in my private branch.
> =

> we can also keep this patch merged until the whole thing is addressed
> entirely (because the same argument also applies to the definition of
> IPPROTO_MPTCP)-

There is already something for IPPROTO_MPTCP:

   #ifndef IPPROTO_MPTCP
   #define IPPROTO_MPTCP 262
   #endif

> the patch LGTM and probably it also fixes a build failure on some system,
> like Florian's Debian, that has been introduced with "selftests: test
> setsockopt(..., TCP_ULP, "mptcp", ...)".

Did you introduce this on purpose to make sure Florian would be forced =

not to use Debian but RHEL/Fedora??? Sneaky!!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3659261829973837532==--
