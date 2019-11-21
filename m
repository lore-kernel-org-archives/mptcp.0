Content-Type: multipart/mixed; boundary="===============8424623515622807909=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: fix for ipv6-related oops
Date: Thu, 21 Nov 2019 16:58:12 +0100
Message-ID: <a73f71ce-248f-5b31-fc3e-dee1a7866b08@tessares.net>
In-Reply-To: cover.1574350681.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2655

--===============8424623515622807909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/11/2019 16:41, Paolo Abeni wrote:
> We need to allocate a larger struct sock for mptcp v6 master sockets,
> otherwise inet6_sk() will access mptcp related data instead of
> struct ipv6_pinfo.
> =

> This should fix the crash reported by Matt.
> =

> The protocol.c code changes are split in 2 patches to simplify the
> squashing.
> (yep, I know we somewhat agreed to big giant rebase, but this specific
> should be trivial).
> =

> Additionally adds some fixlet for the ipv6 tests
> =

> v1 -> v2:
>   - address Matt feedback on patches 1 && 2
>   - add missing mptcp_v6 proto registration (I don't know why the previous
>     iteration of these patches did not explode without that!!! :(((

Thank you for the new version and good catch for the proto registration!

The new version looks good to me. I am going to apply it if there is no =

objections (post fixes are still possible of course).

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8424623515622807909==--
