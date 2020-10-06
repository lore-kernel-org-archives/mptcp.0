Content-Type: multipart/mixed; boundary="===============7751123497363067675=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 17:11:09 +0200
Message-ID: <4d8f5681-e0de-b4be-0bd6-6dd3b4f1391b@tessares.net>
In-Reply-To: 66550eee4efdef058cce389740545b4bb9fc95c8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6224

--===============7751123497363067675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 06/10/2020 16:30, Davide Caratti wrote:
> On Tue, 2020-10-06 at 16:03 +0200, Matthieu Baerts wrote:
>> Hi Davide, Paolo,
>>
>> On 06/10/2020 15:07, Paolo Abeni wrote:
>>> On Tue, 2020-10-06 at 14:22 +0200, Davide Caratti wrote:
>>>> using packetdrill it's possible to observe the same MPTCP DSN being ac=
ked
>>>> by different subflows with DACK4 and DACK8. This is in contrast with w=
hat
>>>> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-=
bit wide
>>>> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_a=
ck'
>>>> variable to make it a property of MPTCP sockets, not TCP subflows.
>>>>
>>>> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
>>>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
>>>
>>> LGTM, thanks Davide!
>>
>> Thank you for the patch and the review!
> =

> hello Matthieu, thanks for looking at this.
> =

>> @Davide: be careful that this patch doesn't apply as is on -net (or
>> net-next). I had a small conflict when applying it on top of net-next,
>> not at the end of the "export" branch?
> =

> right, I did that on top of export/20201006T083856 - but it requires
> some adjustment to apply to "net", because context mismatches in
> protocol.h.

It looks like if you cherry-pick your patch that is going to be in the =

next "export" branch (or 79519fc3f520 from the TopGit tree), you will =

not have any conflicts! :-)

> FTR, this is another strange thing I noticed while working on
> https://github.com/multipath-tcp/mptcp_net-next/issues/94 : after a call
> to close(), subflow-0 does DSS (DACK4+DATAFIN), while subflow-1 does
> DSS(DACK8+DATAFIN) :)

Good catch! Always good to play with packetdrill to fix new bugs :-)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7751123497363067675==--
