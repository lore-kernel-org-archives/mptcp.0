Content-Type: multipart/mixed; boundary="===============8918051781617299714=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squashto: mptcp: allow dumping subflow context to
 userspace
Date: Fri, 27 Mar 2020 22:07:08 +0100
Message-ID: <1e188dd0-1572-e373-0bdb-f3de505cefd8@tessares.net>
In-Reply-To: 20200327195817.122912-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4098

--===============8918051781617299714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Davide,

On 27/03/2020 20:58, Mat Martineau wrote:
> Use bit macros appropriate for userspace.

Thank you for the patch and good catch for the missing bits!

- 9c766e8ddcec: "squashed" in "mptcp: allow dumping subflow context to =

userspace"
- c32f026cdf86..9fd2aa240f88: result
- 0a22c57a4750: topmsg: add changelog

- 0ca910a55213: mptcp:uapi: add missing import for _BITUL
- 9fd2aa240f88..b753d266aaa6: result

Test + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8918051781617299714==--
