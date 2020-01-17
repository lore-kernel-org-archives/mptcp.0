Content-Type: multipart/mixed; boundary="===============3274627732774670786=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: move from sha1 (v0)
 to sha256 (v1)"
Date: Fri, 17 Jan 2020 18:02:03 +0100
Message-ID: <95a0fe9a-0f76-12da-23b7-46f7d15ae747@tessares.net>
In-Reply-To: ba44d0a9f9045d296ebceb8ddbfd204bbac27a68.1579169521.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3399

--===============3274627732774670786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/01/2020 11:12, Paolo Abeni wrote:
> Fixes the late_initcall signature, as reported by kbuildbot
> =

> Also rename the test function to be more consistent with other
> in-kernel test-cases.

Good catch and good idea! LGTM!

- 5b8d891855df: "squashed" in "mptcp: move from sha1 (v0) to sha256 (v1)"
- 84c329311d4c..899bafd7d1a1: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3274627732774670786==--
