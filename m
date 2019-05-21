Content-Type: multipart/mixed; boundary="===============8130835838119589005=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 15:28:34 +0200
Message-ID: <0d15009a-c994-765a-11ba-f96f85e1f1f2@tessares.net>
In-Reply-To: 20190521105141.6zcptk6sog4qt42r@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1205

--===============8130835838119589005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

Thank you for the patch and the review!

That's nice nothing is broken after this!

On 21/05/2019 12:51, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> On Tue, 2019-05-21 at 11:08 +0200, Florian Westphal wrote:
>>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>>> This introduces a few artifacts on the virtual network topology
>>>> via the netem scheduler and disabling features on some veth, so
>>>> that we exercise the MTCP stack more.
>>>
>>> I would suggest to not do this unconditionally.
>>>
>>> Perhaps we can make it so that the tests are run twice,
>>> once as-is and once with tc+tso off?
>>>
>>> This way we might still catch tso-related bugs, as feature path
>>> is slightly different.
>>
>> I thought about that. Currently we have a set of very similar test -
>> e.g. ns1 -> ns3, ns1 -> ns4 and the opposite directions should be
>> basically the same, with a little higher latencies for ns1<->ns4
>> compared to ns1 <-> ns3
>>
>> With the proposed patch we still have some tests with no artifact (ns1
>> -> ns2) but we effectively lose the forwarding scenario with no
>> artifact.
>>
>> I'd like to avoid the excessive grow (in term of time) of these tests.
> =

> Ah, thats right, we still have it enabled on other netns.
> =

> OK, thats fine then.
> =

>> What if we remove a ns (ns4) and we do 2 iteration of the remaining,
>> one with no TC/with TSO and the other with such artifacts?
> =

> Thats another option, but I don't have a preference, your change is fine
> as-is.

Paolo, do you want to change something or can I apply this patch?

Cheers,
Matt

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8130835838119589005==--
