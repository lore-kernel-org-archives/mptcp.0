Content-Type: multipart/mixed; boundary="===============1133400067954188642=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 4/4] man: mptcp man page
Date: Thu, 16 Apr 2020 12:26:08 +0200
Message-ID: <5bd38ba5-bbde-e4a4-eca1-e733baf77b40@tessares.net>
In-Reply-To: 13c8087ab70a9c11299b3fc3fff1c45fd4f6dc4c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4191

--===============1133400067954188642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for your reply!

On 15/04/2020 19:19, Paolo Abeni wrote:
> On Wed, 2020-04-15 at 18:49 +0200, Matthieu Baerts wrote:
>> On 15/04/2020 14:28, Paolo Abeni wrote: >>> diff --git a/man/man8/ip-mpt=
cp.8 b/man/man8/ip-mptcp.8
>>> new file mode 100644
>>> index 00000000..5ed0457b
>>> --- /dev/null
>>> +++ b/man/man8/ip-mptcp.8

(...)

>>> +.ti -8
>>> +.BR "ip mptcp limits set "
>>> +.RB "[ "
>>> +.B subflow
>>> +.IR SUBFLOW_NR " ]"
>>> +.RB "[ "
>>> +.B add_addr_accepted
>>> +.IR  ADD_ADDR_ACCEPTED_NR " ]"
>>
>> Should it be?
>>
>>     set { subflow SUBFLOW_NR | add_addr_accepted ADD_ADDR_ACCEPTED_NR }
>>
>> or:
>>
>>     set { subflow | add_addr_accepted } NR
> =

> I think that the text you suggest has different semantic.

Indeed, my bad!

>>> +
>>> +.ti -8
>>> +.BR "ip mptcp limits show"
>>> +
>>> +.SH DESCRIPTION
>>> +
>>> +MPTCP is a transport protocol build on top of TCP that allows TCP
>>
>> (I guess it could be nice if some English natives can have a look at
>> this :) )
>> I think here you need s/build/built/
>>
>>> +connections to use multiple paths to maximize resource usage and incre=
ase
>>> +redundancy.
>>
>> Should we mention that the socket needs to be open using the MPTCP optio=
n?
> =

> I think that would should be in a different man page: man(7) mptcp in
> the kernel man pages.

I was thinking about a small sentence just to say that this can be =

applied only to sockets created with IPPROTO_MPTCP and not to all =

existing TCP connections but fine also for me to skip this.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1133400067954188642==--
