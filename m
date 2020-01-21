Content-Type: multipart/mixed; boundary="===============2011528382969197033=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: uniform the use of CONFIG_MPTCP_IPV6
Date: Wed, 22 Jan 2020 00:27:07 +0100
Message-ID: <9d6c8725-41d1-290d-8994-23a937275443@tessares.net>
In-Reply-To: fa105b91-6ed7-7d60-aa4c-973287de7618@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3468

--===============2011528382969197033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 21/01/2020 22:10, Matthieu Baerts wrote:
> Hi Mat,
> =

> On 21/01/2020 18:51, Mat Martineau wrote:
>>
>> On Tue, 21 Jan 2020, Matthieu Baerts wrote:
>>
>>> We should not check CONFIG_IPV6 but CONFIG_MPTCP_IPV6.
>>> And better to always use:
>>>
>>> =C2=A0#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>> ---
>>>
>>> Notes:
>>> =C2=A0=C2=A0 to be squashed in "mptcp: Create SUBFLOW socket for incomi=
ng =

>>> connections"
>>>
>>> net/mptcp/protocol.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 7f1efe1aae5e..84799a5212a2 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -227,7 +227,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, =

>>> const struct sock *ssk)
>>> =C2=A0=C2=A0=C2=A0=C2=A0inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet=
_saddr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->=
inet_rcv_saddr;
>>>
>>> -#if IS_ENABLED(CONFIG_IPV6)
>>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>> =C2=A0=C2=A0=C2=A0=C2=A0msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
>>
>> I noticed that the declarations for msk6 and ssk6 at the beginning of =

>> this function are not #ifdef'd either - I suggest moving all the IPv6 =

>> code to the beginning of the function so the declaration and the =

>> assignments can all be in one ifdef.
> =

> Thank you for the review!
> =

> I see that inet6_sk() is an inline function which will return NULL if =

> CONFIG_IPV6 is not enabled.
> Also "struct ipv6_pinfo" is always available.
> =

> Do we need to add #ifdef then? Or to avoid declaring variables that are =

> not used if IPV6 is not enabled?

- bc1f4ea1bcdb: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"

Tests and export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2011528382969197033==--
