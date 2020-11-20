Content-Type: multipart/mixed; boundary="===============2102078181470836458=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: use mptcp release_cb
 for delayed tasks"
Date: Fri, 20 Nov 2020 18:14:58 +0100
Message-ID: <65729b3e-9261-275d-608e-8fe40c72d4d4@tessares.net>
In-Reply-To: d1c5f67cad16df705f4ac9ab6d830fa02350e0a0.1605863183.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6882

--===============2102078181470836458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/11/2020 10:07, Paolo Abeni wrote:
> fix uninitialized local variable usage.

Thank you for the fix!

- 844e8defabb6: "squashed" in "mptcp: use mptcp release_cb for delayed =

tasks"
- Results: b86f4581b5c3..e7025af96b11

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2102078181470836458==--
