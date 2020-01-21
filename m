Content-Type: multipart/mixed; boundary="===============9095059686119320112=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Tue, 21 Jan 2020 23:58:38 +0100
Message-ID: <9e10ae31-3bd7-f248-4457-cc8730cc3603@tessares.net>
In-Reply-To: 78aef43d80722a559f4ef725f0e36674e74133ea.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3463

--===============9095059686119320112==
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

As discussed on IRC with Mat, we can apply this v2 of the patch:

- 5bdcbe810d64: "squashed" in "mptcp: cope with later TCP fallback"
- b0f4080cb362..fa392a833065: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============9095059686119320112==--
