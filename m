Content-Type: multipart/mixed; boundary="===============0415616554823170487=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 18:20:39 +0100
Message-ID: <aa9bbf76-4c32-eee8-bc4e-25c73169f5fb@tessares.net>
In-Reply-To: 9e790506ede2adbc601e5f3f576c023118d87280.1579624298.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3452

--===============0415616554823170487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 21/01/2020 17:32, Paolo Abeni wrote:
> kbuildbot reported a build breakage with IPV6 disabled.

Do you know why my CI didn't get the issue?

It runs:

   make defconfig
   echo | scripts/config -d (...) ## to disable DRM, SOUND, USB, etc.
   echo | scripts/config -e MPTCP -e MPTCP_IPV6
   echo | scripts/config -d IPV6 -d MPTCP_IPV6
   make

MPTCP is enabled and IPV6 is not.

Which combination did I miss?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0415616554823170487==--
