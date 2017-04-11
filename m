Content-Type: multipart/mixed; boundary="===============6622948892702543009=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming introduction
Date: Tue, 11 Apr 2017 15:52:06 -0700
Message-ID: <alpine.OSX.2.21.1704111002110.40519@mlee4-mobl1.amr.corp.intel.com>
In-Reply-To: 20170410052845.GN11821@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 2

--===============6622948892702543009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

Rao and I talked with David Miller and Eric Dumazet. They aren't =

enthusiastic about MPTCP from a protocol perpective, and pointed to the =

example of kcm as something that builds on top of multiple TCP connections =

rather than modifying TCP itself. I think they're a little skeptical that =

there's a committment to put in the necessary effort to upstream.

A few specific points of our discussions:

* Intrusive changes to TCP are not acceptable, the code is already complex =

and they don't want to introduce bugs or create additional maintenance =

burden. Given the need to tie in to TCP for option parsing (and other =

changed behaviors), they're willing to look at adding hooks - but of =

course reserved judgment until there are actual patches to look at.

* Related to that, skb size cannot increase.

* Regular TCP connections should remain the default and should work like =

they do now.

* Expect the review process to take a while.

These points are what drives the goals I listed below. Identifying the =

right (limited) set of hooks in to the TCP code is going to be an =

important early step.

Best regards,
Mat


On Mon, 10 Apr 2017, Christoph Paasch wrote:

> Hi Mat,
>
> what was the feedback/info you got from netdev 2.1 ?
>
>
> Christoph
>
> On 09/04/17 - 13:12:26, Mat Martineau wrote:
>> Welcome to the MPTCP upstreaming mailing list!
>>
>> This list (mptcp(a)lists.01.org) is focused on integrating MPTCP (RFC 68=
24 /
>> RFC 6824bis) as part of the standard Linux kernel. In speaking with the
>> Linux networking / TCP maintainers, it is important that MPTCP does not
>> interfere with the performance or reliability of the TCP stack, or
>> complicate the existing TCP code.
>>
>> Given the Linux netdev maintainer's needs, we have the following high-le=
vel
>> design goals in mind:
>>
>> * Minimize changes to core TCP.
>>
>> * Favor atomic operations and RCU synchronization over more expensive
>> options like mutexes or spinlocks.
>>
>> * Implement features in userspace where latency isn't important and data
>> flow is not affected
>>
>> * TCP operates as "normal TCP" by default. Individual sockets may opt-in=
, or
>> systemwide configuration can be used to broadly enable MPTCP.
>>
>> The role of this list is to coordinate upstreaming efforts and share code
>> prior to upstream submission on netdev(a)lists.01.org . This list is sep=
arate
>> from the mptcp-dev list associated with the multipath-tcp.org kernel in
>> order to avoid confusion between netdev-focused efforts and work related=
 to
>> multipath-tcp.org . Anyone interested in MPTCP for the upstream kernel is
>> welcome on mptcp(a)lists.01.org, we appreciate your expertise and
>> contributions!
>>
>> You can manage your subscription or view list archives at
>> https://lists.01.org/mailman/listinfo/mptcp
>>
>> Best regards,
>>
>> --
>> Mat Martineau
>> Intel OTC
>

--
Mat Martineau
Intel OTC

--===============6622948892702543009==--
