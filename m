Content-Type: multipart/mixed; boundary="===============4770072669722999837=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 01/10] Extend path manager interface
Date: Mon, 12 Aug 2019 21:35:25 +0200
Message-ID: <00fc29d4-31e5-f365-c2fc-c741e6c17b39@tessares.net>
In-Reply-To: 20190807224434.2829-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1616

--===============4770072669722999837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> A little more functionality and some comments clarifying
> which routines are for a path manager to call and which are
> callbacks.
> =

> squashto: Add path manager interface

Thank you for the patch and the reviews!

I had to split this patch in 2 parts:
- c8625a37c692: part 1: "squashed" in "mptcp: Add path manager interface"
- 4412b8e8e6c9: conflict in t/mptcp-Add-ADD_ADDR-handling
- 0757aec1b6f2: part 2: "squashed" in "mptcp: Add ADD_ADDR handling"
- b1477322bbb7..711ae3fdd44f: results

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4770072669722999837==--
