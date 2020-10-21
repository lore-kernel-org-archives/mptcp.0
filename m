Content-Type: multipart/mixed; boundary="===============9193633678926765084=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead
 of selecting it
Date: Wed, 21 Oct 2020 11:47:09 +0200
Message-ID: <619601b2-40c1-9257-ef2a-2c667361aa75@tessares.net>
In-Reply-To: CAMuHMdW=1LfE8UoGRVBvrvrintQMNKUdTe5PPQz=PN3=gJmw=Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6386

--===============9193633678926765084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On 21/10/2020 11:43, Geert Uytterhoeven wrote:
> Hi Jakub,
> =

> On Wed, Oct 21, 2020 at 5:56 AM Jakub Kicinski <kuba(a)kernel.org> wrote:
>> On Tue, 20 Oct 2020 11:26:34 +0200 Matthieu Baerts wrote:
>>> On 20/10/2020 09:38, Geert Uytterhoeven wrote:
>>>> MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user may
>>>> not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, like
>>>> is done for all other IPv6 features.
>>>
>>> Here again, the intension was to select IPv6 from MPTCP but I understand
>>> the issue: if we enable MPTCP, we will select IPV6 as well by default.
>>> Maybe not what we want on some embedded devices with very limited memory
>>> where IPV6 is already off. We should instead enable MPTCP_IPV6 only if
>>> IPV6=3Dy. LGTM then!
>>>
>>> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>
>> Applied, thanks!
> =

> My apologies, this fails for the CONFIG_IPV6=3Dm and CONFIG_MPTCP=3Dy
> case:

Good point, MPTCP cannot be compiled as a module (like TCP). It should =

then depends on IPV6=3Dy. I thought it would be the case.

Do you want me to send a patch or do you already have one?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============9193633678926765084==--
