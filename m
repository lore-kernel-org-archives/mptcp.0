Content-Type: multipart/mixed; boundary="===============7690293557076011854=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Thu, 11 Mar 2021 10:51:16 +0100
Message-ID: <33090df2-389b-783d-89ef-5fb0b9b489a2@tessares.net>
In-Reply-To: 5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8096

--===============7690293557076011854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for your quick reply!

On 11/03/2021 10:25, Paolo Abeni wrote:
> On Thu, 2021-03-11 at 09:25 +0100, Matthieu Baerts wrote:
>> On 05/03/2021 18:31, Paolo Abeni wrote:
>>> A note on optname order. For each sol level, I tried to follow the
>>> order used by the corresponding relevant setsockopt(), with the
>>> following additional contraint:
>>> [1] opt which should currently work correctly with no changes come first
>>> [2] than opt that need some impl effort, but should not cause bugs/splat
>>>     ATM
>>> [3] then opt that are really a no-op - and currently work as intended
>>> [4] (commented out) unsupported opt come last, with related reasoning.
>>>
>>> Note that [2] is likely too wide. This is intended as to start discussi=
on.
>>> Looks like fixing issue/170 will require a bit of time :(
>>
>> Out of curiosity, how did you define this first list?
> =

> Manual review of:
> - sock_setsockopt() in net/core/sock.c
> - do_ip_setsockopt() in net/ipv4/ip_sockglue.c
> - do_ipv6_setsockopt() in net/ipv6/ipv6_sockglue.c
> - do_tcp_setsockopt() in net/ipv4/tcp.c
> =

> as such is error prone :(

OK, that's clearer!
Possibly some are only in getsockopt() or have been missed, that's =

alright, it was a very good start :)

>> I mean: is it
>> normal that some sockopts are not present there: not in a "case" or in
>> the comments?
> =

> Well, it depends on how much do you consider and error being "normal":)
> =

> I intentionally omitted only nft and bpf stuff.

It makes sense for the moment!

>> For example, Geliang noticed that when launching eBPF selftests,
>> SO_SNDTIMEO* was not allowed for MPTCP sockets. But there is nothing
>> about them.
>>
>> Maybe this patch is enough: https://paste.centos.org/view/854d7e07
> =

> Yep, that is needed for sure.

OK, I can send a squash-to patch! (even if we need to improve it later, =

it is likely not causing issues)

>> It is under testing by Geliang. At least to have the test passing, not
>> sure if SO_SNDTIMEO is properly supported yet :)
> =

> Looks like 'SO_SNDTIMEO' still will not work as expected, because the
> setting is applied only to the first subflow, while
> mptcp_recvmsg()/mptcp_sendmsg() will look for the timeout value in the
> msk socket.
> =

> @Florian: do you think the above could be addressed by the sockopt()
> improvements?
> =

>> But should we check (and have a test executed by the CI) to make sure
>> all sockopts are at least written somewhere in the new sockopt.c file?
> =

> Uhmm... do you mean something alike a BUILD_BUG_ON()???

No, more a validation in CI scripts. Something a bit more advanced than:

   for i in $(grep "^#define\s\+SO_[A-Z_]\+\s\+[0-9]\+" \
                   include/uapi/asm-generic/socket.h | \
                         awk '{print $2}'); do
       grep -wq ${i} net/mptcp/sockopt.c || echo "Not there: ${i}"
   done

WDYT?

> I *think* it would be better more coverage via packetdrill ;)

Indeed, it would be good to have many PacketDrill tests to validate =

these sockopt!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7690293557076011854==--
