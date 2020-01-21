Content-Type: multipart/mixed; boundary="===============7812945694399391617=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Tue, 21 Jan 2020 22:16:41 +0100
Message-ID: <8e9e393d-db3d-430c-e710-0a07a43ebb63@tessares.net>
In-Reply-To: 78aef43d80722a559f4ef725f0e36674e74133ea.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3460

--===============7812945694399391617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/01/2020 22:04, Paolo Abeni wrote:
> On Tue, 2020-01-21 at 12:58 -0800, Peter Krystad wrote:
>> On Tue, 2020-01-21 at 21:49 +0100, Paolo Abeni wrote:
>>> kbuildbot reported a build breakage with IPV6 disabled.
>>>
>>> v1 -> v2:
>>>   - fixed preprocessor conditional (Mat)
>>>   - fixed SoB (Mat)
>>>
>>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>>   net/mptcp/protocol.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 6da609791c7a..69b229607ab8 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -26,6 +26,15 @@
>>>   =

>>>   static void __mptcp_close(struct sock *sk, long timeout);
>>>   =

>>> +static const struct proto_ops * tcp_proto_ops(struct sock *sk)
>>> +{
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>
>> Why not CONFIG_MPTCP_IPV6?
> =

> The breakage happens with:
> =

> CONFIG_MPTCP=3Dy
> # CONFIG_IPV6 is not set
> # CONFIG_MPTCP_IPV6 is not set
> =

> so even CONFIG_MPTCP_IPV6 would work.
> =

> The offending code is using a symbol defined with CONFIG_IPV6 and copes
> with TCP fallback, that is when the relevant socket is [no more] MPTCP,
> so it felt more straightforward to me use the latter conditional.

Are we going to fallback to v6 if we don't accept IPv6 MPTCP connections?

If we decide to use CONFIG_IPV6 instead of CONFIG_MPTCP_IPV6, should we =

add a comment about that to avoid questions later?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7812945694399391617==--
