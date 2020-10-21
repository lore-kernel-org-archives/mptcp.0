Content-Type: multipart/mixed; boundary="===============6650225600975204345=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead
 of selecting it
Date: Wed, 21 Oct 2020 12:54:11 +0200
Message-ID: <f414539c-1370-1636-137e-38c735f449f6@tessares.net>
In-Reply-To: CAMuHMdXUs_2DodcYva8bP+Df979TMrmRD=+LUiVVzdH0zmxK1Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6390

--===============6650225600975204345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On 21/10/2020 11:52, Geert Uytterhoeven wrote:
> Hi Matthieu,
> =

> On Wed, Oct 21, 2020 at 11:47 AM Matthieu Baerts
> <matthieu.baerts(a)tessares.net> wrote:
>> On 21/10/2020 11:43, Geert Uytterhoeven wrote:
>>> On Wed, Oct 21, 2020 at 5:56 AM Jakub Kicinski <kuba(a)kernel.org> wrot=
e:
>>>> On Tue, 20 Oct 2020 11:26:34 +0200 Matthieu Baerts wrote:
>>>>> On 20/10/2020 09:38, Geert Uytterhoeven wrote:
>>>>>> MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user =
may
>>>>>> not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, l=
ike
>>>>>> is done for all other IPv6 features.
>>>>>
>>>>> Here again, the intension was to select IPv6 from MPTCP but I underst=
and
>>>>> the issue: if we enable MPTCP, we will select IPV6 as well by default.
>>>>> Maybe not what we want on some embedded devices with very limited mem=
ory
>>>>> where IPV6 is already off. We should instead enable MPTCP_IPV6 only if
>>>>> IPV6=3Dy. LGTM then!
>>>>>
>>>>> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>>>
>>>> Applied, thanks!
>>>
>>> My apologies, this fails for the CONFIG_IPV6=3Dm and CONFIG_MPTCP=3Dy
>>> case:
>>
>> Good point, MPTCP cannot be compiled as a module (like TCP). It should
>> then depends on IPV6=3Dy. I thought it would be the case.
>>
>> Do you want me to send a patch or do you already have one?
> =

> I don't have a patch yet, so feel free to send one.

Just did:

https://lore.kernel.org/netdev/20201021105154.628257-1-matthieu.baerts(a)te=
ssares.net/

Groetjes,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6650225600975204345==--
