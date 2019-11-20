Content-Type: multipart/mixed; boundary="===============5380934465491339460=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/10] selftests: IPv6 by default and time
 reduction
Date: Wed, 20 Nov 2019 17:07:22 +0100
Message-ID: <a33a666f-7f59-25c7-3cf7-8abc6a66d181@tessares.net>
In-Reply-To: 20191116134140.GL19558@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2620

--===============5380934465491339460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 16/11/2019 14:41, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Here are a few improvements in the selftests. Nothing complex, some
>> details to have the results more readable (I think), IPv6 enabled by
>> default, the time of the execution is reduced (around 30 seconds now
>> with the same launched tests), and the script is more robust for the
>> future.
>>
>> I hope we can apply the one before the last one: IPV6 is now forced in
>> the config, we can then always apply the IPv6 network config and remove
>> a lot of 'if $ipv6' in the code.
>>
>> For the last one, I guess we should not apply it now because some tests
>> are really slow in some conditions. More details in the patch and a
>> separated email has been sent.
>>
>> All the patches can be squashed in the commit introducing the selftests:
>>
>>    mptcp: add basic kselftest for mptcp
> =

> These look good, thanks Matthieu.

Thank you for your review!

I just "squashed" all these patches *except* the last one in "mptcp: add =

basic kselftest for mptcp".

eb9de3c3e89b..84af4075aa4f: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5380934465491339460==--
