Content-Type: multipart/mixed; boundary="===============7682283169446769856=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: Add MPTCP socket stubs"
Date: Wed, 18 Dec 2019 17:19:34 +0100
Message-ID: <7b99209e-a64e-9715-2944-e4ee91d3c55f@tessares.net>
In-Reply-To: 3e4ffcf745e9f34ad46a21bff91f199c882ef740.1576685173.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3142

--===============7682283169446769856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 18/12/2019 17:11, Paolo Abeni wrote:
> whoops, bad bitmask in previous commit - we must enumerate
> the supported {recv,send}msg flags.

Thank you for the quick fix!

- 4474e23c1aaa: "squashed" in "mptcp: Add MPTCP socket stubs"
- 5a00cac10d5f..df2ff7c12d47: result

Tests + export are in progress

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7682283169446769856==--
