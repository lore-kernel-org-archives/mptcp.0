Content-Type: multipart/mixed; boundary="===============5351065252590986601=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
 instead of selecting it
Date: Tue, 20 Oct 2020 11:27:45 +0200
Message-ID: <2945fd68-6323-30f1-db6b-9ed1dba582a6@tessares.net>
In-Reply-To: CAMuHMdWEKszUOA6Q9Y+vpLdRnq3wstCj1ubV=8iUKZAQkew_wg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6361

--===============5351065252590986601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On 20/10/2020 09:40, Geert Uytterhoeven wrote:
> On Mon, Oct 19, 2020 at 10:38 PM Geert Uytterhoeven
> <geert(a)linux-m68k.org> wrote:
>> On Mon, Oct 19, 2020 at 5:47 PM Matthieu Baerts
>> <matthieu.baerts(a)tessares.net> wrote:
>>> On 19/10/2020 13:32, Geert Uytterhoeven wrote:
>>>> MPTCP_KUNIT_TESTS selects MPTCP, thus enabling an optional feature the
>>>> user may not want to enable.  Fix this by making the test depend on
>>>> MPTCP instead.
>>>
>>> I think the initial intension was to select MPTCP to have an easy way to
>>> enable all KUnit tests. We imitated what was and is still done in
>>> fs/ext4/Kconfig.
>>>
>>> But it probably makes sense to depend on MPTCP instead of selecting it.
>>> So that's fine for me. But then please also send a patch to ext4
>>> maintainer to do the same there.
>>
>> Thanks, good point.  I didn't notice, as I did have ext4 enabled anyway.
>> Will send a patch for ext4.  Looks like ext4 and MPTCP where the only
>> test modules selecting their dependencies.
> =

> FTR, "[PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead
> of  selecting it"
> https://lore.kernel.org/lkml/20201020073740.29081-1-geert(a)linux-m68k.or=
g/

Thank you for having sent this other patch and shared the link here!

Groetjes,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5351065252590986601==--
