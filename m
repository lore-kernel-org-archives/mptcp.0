Content-Type: multipart/mixed; boundary="===============2247785982120786202=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 23:45:55 +0100
Message-ID: <6171fe97-c353-283a-a55a-05159dd31513@tessares.net>
In-Reply-To: 02e36edc-bee5-d34e-69b3-8910795fdc96@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3462

--===============2247785982120786202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 21/01/2020 23:13, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 21/01/2020 21:40, Paolo Abeni wrote:
>> On Tue, 2020-01-21 at 18:20 +0100, Matthieu Baerts wrote:
>>> Hi Paolo, Mat,
>>>
>>> On 21/01/2020 17:32, Paolo Abeni wrote:
>>>> kbuildbot reported a build breakage with IPV6 disabled.
>>>
>>> Do you know why my CI didn't get the issue?
>>>
>>> It runs:
>>>
>>> =C2=A0=C2=A0=C2=A0 make defconfig
>>> =C2=A0=C2=A0=C2=A0 echo | scripts/config -d (...) ## to disable DRM, SO=
UND, USB, etc.
>>> =C2=A0=C2=A0=C2=A0 echo | scripts/config -e MPTCP -e MPTCP_IPV6
>>> =C2=A0=C2=A0=C2=A0 echo | scripts/config -d IPV6 -d MPTCP_IPV6
>>> =C2=A0=C2=A0=C2=A0 make
>>>
>>> MPTCP is enabled and IPV6 is not.
>>>
>>> Which combination did I miss?
>>
>> weird. I can reproduce the build failure with
>>
>> CONFIG_MPTCP=3Dy
>> # CONFIG_IPV6 is not set
>> # CONFIG_MPTCP_IPV6 is not set
>>
>>
>> net/mptcp/protocol.o: In function `__mptcp_fallback_to_tcp':
>> /home/pabeni/linux-net/net/mptcp/protocol.c:63: undefined reference to
>> `inet6_stream_ops'
>>
>> the inet6_stream_ops struct is unconditionally referenced by the mptcp
>> code.
> =

> I don't understand why but my CI didn't catch errors when compiling =

> without IPv6 :-/

Mat found the issue:

In short if you have this script:


=3D=3D=3D
#!/bin/bash
set -e

ff() {
	echo before
	false
	echo after
}

ff
=3D=3D=3D


only "before" will be printed. But with this one:


=3D=3D=3D
#!/bin/bash
set -e

ff() {
	echo before
	false
	echo after
}

ff || echo "error"
=3D=3D=3D

both "before" and "after" are printed.


Mat also found the explanation in the manual:

    Exit immediately unless the command is "part of any command executed =

in a && or || list except the command following the final && or ||"


In other words, better to always use 'if ! X; then Y; fi' then 'X || Y'.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2247785982120786202==--
