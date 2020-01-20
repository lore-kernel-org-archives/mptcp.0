Content-Type: multipart/mixed; boundary="===============7811182102268927087=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Refine some comments
Date: Mon, 20 Jan 2020 17:41:28 +0100
Message-ID: <50fb5242-7c94-0fdd-c098-922e2487535f@tessares.net>
In-Reply-To: 20200118014431.9925-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3435

--===============7811182102268927087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 18/01/2020 02:44, Peter Krystad wrote:
> squashto: Associate MPTCP context with TCP socket

Thank you for the patch!

Please double-check the changes in protocol.c because I had to do the =

changes manually.

- 396d41c5d0ff: "squashed" (with conflicts) in "mptcp: Associate MPTCP =

context with TCP socket"
- 46202118ff84: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- 40e638606fbc: conflict in t/mptcp-cope-with-later-TCP-fallback
- deb420f5399e..6f72af5829f8: result

Tests and export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7811182102268927087==--
