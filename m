Content-Type: multipart/mixed; boundary="===============3824874151545195262=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix retransmit timer update
Date: Mon, 30 Sep 2019 16:26:58 +0200
Message-ID: <97a892f7-41c4-873f-01a5-202199b9174c@tessares.net>
In-Reply-To: 21b1af7b421981a219b64ae92da798e489010118.1569239317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1963

--===============3824874151545195262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 23/09/2019 13:49, Paolo Abeni wrote:
> Mat noted the current code access ssk data outside the relevant
> socket lock. Fix that moving the update in such scope
> =

> Fixes: 28d2e02041c9 ("mptcp: implement and use MPTCP-level retransmission=
")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> I'm ok with squashing this into the fixed commit

Thank you for the patch and the review!

- 88052ece1aff: "squashed" in "mptcp: implement and use MPTCP-level
retransmission"
- signoff was already there
- 22f1e768622b..08867957be0e: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3824874151545195262==--
