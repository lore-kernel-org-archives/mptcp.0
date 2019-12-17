Content-Type: multipart/mixed; boundary="===============6428943703014708380=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: Implement MPTCP receive path"
Date: Tue, 17 Dec 2019 19:35:14 +0100
Message-ID: <da266238-eea2-c787-ccde-aaea959e2716@tessares.net>
In-Reply-To: 6c8a763ddc3d9110354a197ab9b1f0f2aace020e.1576531786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3118

--===============6428943703014708380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 22:29, Paolo Abeni wrote:
> drop duplicate line indroduced by the 'Squash-to' commit.
> =

> Note: this will cause some conflict in v1 patches. Resolution
> is trivial, howver the patches must be rebased on top of this
> one.

Good catch but your prediction seems wrong, no conflicts!

- 77b04716a417: "squashed" in "mptcp: Implement MPTCP receive path"
- 63ed4f5b07f4..3b9cd12db9d1: empty but expected, right?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6428943703014708380==--
