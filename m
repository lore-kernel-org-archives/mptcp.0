Content-Type: multipart/mixed; boundary="===============6196178093116973219=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix wrong merge resolution
Date: Mon, 02 Mar 2020 16:39:14 +0100
Message-ID: <c6182435-07ba-fac4-5c12-96c05ea1c08a@tessares.net>
In-Reply-To: 4cf244b31673213a3cc2428fd9079c77a77d9b77.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3840

--===============6196178093116973219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 02/03/2020 14:43, Paolo Abeni wrote:
> On Mon, 2020-03-02 at 10:34 +0100, Matthieu Baerts wrote:
>> Otherwise the data are never init and we get warnings in workqueue code.
>>
>> I really don't know how I made this mistake :-/
>>
>> Fixes: ce2d7fb36478 (tgupdate: merge t/mptcp-introduce-MPTCP-retransmiss=
ion-timer base into t/mptcp-introduce-MPTCP-retransmission-timer)
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> =

> LGTM, Thanks!

Thank you for the review:

- 05d850dd0f09: "squashed" in "mptcp: introduce MPTCP retransmission timer"
- I didn't add the signed-off-by, it was a wrong merge resolution.
- fa603a295c69..ee3a464ce517: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6196178093116973219==--
