Content-Type: multipart/mixed; boundary="===============2544342442707456517=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 01/13] selftest: add mmap-write support
Date: Thu, 21 Nov 2019 13:41:48 +0100
Message-ID: <47ca473b-b2a3-7495-d6b7-d660ec08ff0f@tessares.net>
In-Reply-To: 20191120203935.GG20235@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2645

--===============2544342442707456517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 20/11/2019 21:39, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools=
/testing/selftests/net/mptcp/mptcp_connect.sh
>>> index b5367fe2c6ea..478bc47c3d60 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> @@ -3,7 +3,7 @@
>>>    time_start=3D$(date +%s)
>>> -optstring=3D"d:e:l:r:h6c"
>>> +optstring=3D"b:d:e:l:r:h6c:m:"
>>
>> Just a small detail but the capture (-c) option doesn't any argument. I
>> guess we should also apply this:
> =

>> -optstring=3D"b:d:e:l:r:h4c:m:"
>> +optstring=3D"b:d:e:l:r:h4cm:"
>>   ret=3D0
>>   sin=3D""
>>   sout=3D""
> =

> Oh, absolutely.

Great!

- 8c39e2086d0f: selftests:mptcp: fix typo in opts

> Can you also apply this fixlet that Mat pointed out?
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -391,7 +391,7 @@ static int do_recvfile(int infd, int outfd)
>          ssize_t r;
>   =

>          do {
> -               char buf[16536];
> +               char buf[16384];

Just did:

- 2acf87c192a7: selftests:mptcp: buf with a power 2 size
- c35e69234be2..39d0ec7ab1eb: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2544342442707456517==--
