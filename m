Content-Type: multipart/mixed; boundary="===============5036321613382191272=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] mptcp: disallow setting the MPTCP ULP from
 userspace
Date: Tue, 08 Oct 2019 16:59:58 +0200
Message-ID: <437e54e4-9a41-a06c-668f-5e936dfde362@tessares.net>
In-Reply-To: cover.1570545679.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2051

--===============5036321613382191272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 08/10/2019 16:43, Davide Caratti wrote:
> with this series we make
> =

> setscokopt(..., IPPROTO_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));
> =

> return -1 and set errno to -EOPNOPSUPPORT.
> =

> this allows attaching MPTCP ULP only to a TCP socket that has been
> created through sock_create_kern().
> =

> - Patch 1/2 lets subflow_init() fail with -EOPNOTSUPPORT in case users
>   try to setsockopt(..., TCP_ULP) on a TCP socket that has been created
>   by a userspace program. I suggest squashing this patch in "mptcp:
>   Associate MPTCP context with TCP socket".
> - Patch 2/2 includes kselftest code. I suggest squashing it with "mptcp:
>   add basic kselftest for mptcp".*** SUBJECT HERE ***
> =

> Davide Caratti (2):
>   mptcp: subflow: disallow setsockopt(... TCP_ULP, "mptcp")
>   selftests: test setsockopt(..., TCP_ULP, "mptcp", ...)


Thank you for these two patches!

I just have a few questions, see my answers in my two other emails,
nothing blocking!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5036321613382191272==--
