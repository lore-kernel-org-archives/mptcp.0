Content-Type: multipart/mixed; boundary="===============8571149251744784150=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 06/10] Fix return value if no DSS option is
 created.
Date: Mon, 12 Aug 2019 21:36:07 +0200
Message-ID: <0b59586a-7e4d-8c6d-9089-d223af8150f3@tessares.net>
In-Reply-To: 20190807224434.2829-7-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1621

--===============8571149251744784150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> Strictly speaking mptcp_established_options_dss() should
> return false if no DSS option is created.
> =

> squashto: Write MPTCP DSS headers to outgoing data packets

Thank you for the patch and the reviews!

- 7b039830202c: "squashed" in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
- 009b132dc29d..06256d7cf989: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8571149251744784150==--
