Content-Type: multipart/mixed; boundary="===============1091972232189564446=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 17:43:44 -0700
Message-ID: <83c99e1a-3a6c-dbc0-b635-c5bc3a5be28f@oracle.com>
In-Reply-To: 20180426222054.GC19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 560

--===============1091972232189564446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2018 03:20 PM, Christoph Paasch wrote:
> On 26/04/18 - 14:25:24, Rao Shoaib wrote:
>>
>> On 04/26/2018 01:52 PM, Christoph Paasch wrote:
>>> This kind of lock-taking also causes trouble with RCU LOCKDEP debugging=
 - as
>>> I mentioned in a previous e-mail.
>> I have not looked into it so I can not comment. I am sure we will find a=
 way
>> to address it.
>>> And beyond that, it requires that everytime a TCP-change is being done,=
 one
>>> needs to take MPTCP into account. E.g., when upstream added the SOCK_DE=
STROY
>>> interface (and Samsung backported it to v4.4), there were panics on And=
roid
>>> devices (https://github.com/multipath-tcp/mptcp/issues/170).
>>>
>>> Avoid taking the meta-socket lock on subflow-work allows for much easier
>>> maintenance in the long-term.
>> The bug that you have pointed out is a run of the mill bug that we see
>> everyday, there is nothing special about it.
> Euh, you mean the issue #170 is happening frequently?
>
> It shouldn't! If it does, that's a big concern.
No we have not encountered the bug. What I meant to say was that when =

changes or enhancements are made to the code it is quite common that =

something breaks. That is the case in the bug that you pointed.
>
>> Taking meta lock actually simplifies things a lot and has reduced
>> maintainable cost, not taking the meta lock will create timing issues le=
ft
>> and right. So we are just trading one headache with another.
>>
>> Holding meta lock should not be piped up unnecessarily. Yes, if possible=
 if
>> should be changed, plus our patch has only 6 cases in TCP.
> I think, you are taking the MPTCP point-of-view here. Yes, taking the
> meta-level lock does reduce maintainability of MPTCP (which is why we did=
 it
> that way in the first place ;-))
>
> However, for upstreaming we have to think the other way around. TCP is the
> common-case, and MPTCP is the exotic corner-case only few care about.
>
> So, TCP-maintainability is of outmost importance. Way more important than
> MPTCP's.
I agree that TCP stability and maintainability is of extreme =

importantance. However, this code causes no instability or =

maintainability issues to TCP code. Consider the bug that you pointed =

out, MPTCP fails not TCP. We have to accept the fact that TCP changes =

will break=C2=A0 MPTCP no matter what the implementation is because TCP =

maintainers may or may not test MPTCP. So this is nothing out of the =

extraordinary.
Our patch tries to maintain the stability of TCP. We have reduced MPTCP =

code within TCP and anything that is left is under #ifdef MPTCP so that =

TCP developers can enhance, build and test TCP without worrying about =

MPTCP. Not only that, we have tried to limit any performance impact to =

pure TCP when MPTCP is enabled.

I really do not see any maintainability or stability issues for TCP. TCP =

will work and behave as it does today without MPTCP.

Rao.

>
> Christoph
>
>> Shoaib.
>>
>> [1] If MPTCP is built on top of TCP, any change in TCP will always have =
to
>> worry about MPTCP particularly in the control path. There is a overhead =
of
>> adding MPTCP on TCP and no one can argue against it.
>>
>>>
>>> Christoph
>>>


--===============1091972232189564446==--
