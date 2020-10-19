Content-Type: multipart/mixed; boundary="===============5687952119229227141=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
 instead of selecting it
Date: Mon, 19 Oct 2020 17:47:20 +0200
Message-ID: <1968b7a6-a553-c882-c386-4b4fde2d7a87@tessares.net>
In-Reply-To: 20201019113240.11516-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 6351

--===============5687952119229227141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the patch!

On 19/10/2020 13:32, Geert Uytterhoeven wrote:
> MPTCP_KUNIT_TESTS selects MPTCP, thus enabling an optional feature the
> user may not want to enable.  Fix this by making the test depend on
> MPTCP instead.

I think the initial intension was to select MPTCP to have an easy way to =

enable all KUnit tests. We imitated what was and is still done in =

fs/ext4/Kconfig.

But it probably makes sense to depend on MPTCP instead of selecting it. =

So that's fine for me. But then please also send a patch to ext4 =

maintainer to do the same there.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5687952119229227141==--
