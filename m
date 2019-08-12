Content-Type: multipart/mixed; boundary="===============5515498675736997811=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 02/10] Fix locking in mptcp_finish_join.
Date: Mon, 12 Aug 2019 21:35:33 +0200
Message-ID: <a83ca0d1-afe5-907f-ed30-c495c2d46409@tessares.net>
In-Reply-To: 20190807224434.2829-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1617

--===============5515498675736997811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> Lock was being taken on the subflow sock, not mptcp_sock.
> =

> squashto:  Add handling of incoming MP_JOIN requests

Thank you for the patch and the reviews!

- 590cbe28643f: "squashed" in "mptcp: Add handling of incoming MP_JOIN
requests"
- 711ae3fdd44f..34fd270ae102: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5515498675736997811==--
