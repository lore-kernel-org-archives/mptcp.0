Content-Type: multipart/mixed; boundary="===============5056910763533474258=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Fix bug processing options
Date: Wed, 23 Oct 2019 14:19:06 +0200
Message-ID: <23966238-7748-ea49-391d-5613418391b7@tessares.net>
In-Reply-To: 20191022225459.15312-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2276

--===============5056910763533474258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 23/10/2019 00:54, Peter Krystad wrote:
> Observed crash when running against out-of-tree kernel with
> mis-matched checksum options.

Thank you for doing this kind of tests!

 > Do not process incoming options if the subflow is not MPTCP.

Are we not supposed not to deal with MPTCP options after a fallback to TCP?

If we fallback to TCP, should we not always set 'tp->is_mptcp' to false?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5056910763533474258==--
