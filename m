Content-Type: multipart/mixed; boundary="===============4070582947811352161=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix bit MPTCP_PUSH_PENDING tests
Date: Fri, 12 Mar 2021 09:11:17 +0100
Message-ID: <00ef3b75-bc38-a55d-ddcb-cc100dc20e79@tessares.net>
In-Reply-To: YEsbGCmx4Jh3fApi@mwanda
X-Status: 
X-Keywords:                  
X-UID: 8107

--===============4070582947811352161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On 12/03/2021 08:41, Dan Carpenter wrote:
> The MPTCP_PUSH_PENDING define is 6 and these tests should be testing if
> BIT(6) is set.

Good catch, indeed, BIT() macro is missing!

It was not detected by our tests suite because in -net, that's the only =

flag that is set.

But another patch for net-next is coming and another flag can be set as =

well. What's funny is that this other flag is "9" which works well with =

"6" because their bits are not overlapping :)
Anyway, better with "BIT()" macro!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4070582947811352161==--
