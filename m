Content-Type: multipart/mixed; boundary="===============6156481531023478476=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] selftests: increase the new default timeout
Date: Fri, 25 Oct 2019 17:36:17 +0200
Message-ID: <7d1fc384-6da9-c3a2-c36c-36e925a04228@tessares.net>
In-Reply-To: 20191023064854.20453-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2323

--===============6156481531023478476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/10/2019 08:48, Matthieu Baerts wrote:
> A new commit from upstream now sets a timeout of 45 seconds per test. Tha=
t's
> too low for MPTCP. We need more.
> =

> But increasing the timeout was not working because selftests scripts were
> looking for this new 'settings' file in the wrong directory. I am going t=
o send
> the first patch upstream as it might be required for other selftests and =
not
> specific to MPTCP.

I hope you don't mind if I apply these 2 patches to be able to run the =

selftests with the latest net-next. I propose to decrease the timeout =

value later on when the new enhancements from Florian are applied.

- ef0a0e4954b3: "squashed" patch 1/2 in "mptcp: add basic kselftest for =

mptcp"
- 3adea0746236: "squashed" patch 2/2 in "mptcp: add basic kselftest for =

mptcp"
- e2c9d4cc70f9..789fc73cc101: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6156481531023478476==--
