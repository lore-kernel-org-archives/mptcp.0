Content-Type: multipart/mixed; boundary="===============6136688864931199200=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead
 of selecting it
Date: Tue, 20 Oct 2020 11:26:34 +0200
Message-ID: <5dddd3fe-86d7-d07f-dbc9-51b89c7c8173@tessares.net>
In-Reply-To: 20201020073839.29226-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 6360

--===============6136688864931199200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the patch!

On 20/10/2020 09:38, Geert Uytterhoeven wrote:
> MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user may
> not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, like
> is done for all other IPv6 features.

Here again, the intension was to select IPv6 from MPTCP but I understand =

the issue: if we enable MPTCP, we will select IPV6 as well by default. =

Maybe not what we want on some embedded devices with very limited memory =

where IPV6 is already off. We should instead enable MPTCP_IPV6 only if =

IPV6=3Dy. LGTM then!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6136688864931199200==--
