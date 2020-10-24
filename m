Content-Type: multipart/mixed; boundary="===============7994254194465883067=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] selftests: mptcp: add link failure
 test case
Date: Sat, 24 Oct 2020 14:17:52 +0200
Message-ID: <20201024121752.GK16895@breakpoint.cc>
In-Reply-To: 76abec4c-0056-e328-682c-ad135b979613@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6431

--===============7994254194465883067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>   ( cat "$cin" ; (...) ; cat "$cin" ) | \
>       tee "$cinsent" | \
>       (...) $mptcp_connect (...) > "$cout"
> =

> =

> If I am not mistaken, we then have:
> =

> - $cin =3D max 131MB: initial file
> - $cinsent =3D 2 times $cin
> - $sout =3D $cinsent
> =

> =E2=86=92 total: 5*$cin =3D max 655MB
> =

> Was it the intension? Could we reduce the maximum size while keeping the
> test valid?

Yes, I think its safe to reduce the size though.

Another option is to use /dev/zero as source and set the "sparse" flag for =
dd,
this would also reduce /tmp usage.
--===============7994254194465883067==--
