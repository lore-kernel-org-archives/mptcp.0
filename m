Content-Type: multipart/mixed; boundary="===============0050973975248837474=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: switch mptcp_poll to use parent
 sock wait queue
Date: Fri, 25 Oct 2019 17:55:43 +0200
Message-ID: <86e42e1a-6510-f9fd-8595-6f825647f975@tessares.net>
In-Reply-To: 20191025153444.GY25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2324

--===============0050973975248837474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 25/10/2019 17:34, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>>
>>>> I think we could include patch 3/4 in the "first chunk"/preparatory
>>>> patches - e.g. apply just after "tcp, ulp: Add clone operation to
>>>> tcp_ulp_ops" - and squash 4/4 in "mptcp: add mptcp_poll"
>>>>
>>>> WDYT?
>>>
>>> Seems good, yes.
>>
>> Where can I apply patch 1/4 and 2/4? At the end?
> =

> 1 could probably be squashed with "mptcp: Implement MPTCP receive path",
> given that patch adds sk_data_ready for subflows.
> =

> Patch 2 I'd add at the end, we might be able to revert it eventually.

Thank you for the patches and the quick reply!
And thank you Paolo and Mat for the reviews!

- af383a1b6937: "squashed" patch 1/4 in "mptcp: Implement MPTCP receive =

path"
- 8e678a61f7b7: "Signed-off-by" + "Co-developed-by"
- 77cf55a4b1f1: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 789fc73cc101..c9ae282e1e87: result
- f0d0353bc148: patch 2 added at the end
- c9ae282e1e87..590467e30328: result
- 67590165a990: patch 3 added between "tcp, ulp: Add clone operation to =

tcp_ulp_ops" and "mptcp: Add MPTCP to skb extensions"
- 590467e30328..555678057b0c: result
- b52d7b74d906: "squashed" patch 4/4 in "mptcp: add mptcp_poll"
- 555678057b0c..460e610b3ca4: result

Tests are in progress, verifying that each commit can still compile.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0050973975248837474==--
