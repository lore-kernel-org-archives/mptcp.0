Content-Type: multipart/mixed; boundary="===============0806124895399875920=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix retransmit timer update
Date: Wed, 25 Sep 2019 17:33:22 +0200
Message-ID: <fdc843af-48e8-8b9a-9abf-d4c86bb21c47@tessares.net>
In-Reply-To: 21b1af7b421981a219b64ae92da798e489010118.1569239317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1925

--===============0806124895399875920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 23/09/2019 13:49, Paolo Abeni wrote:
> Mat noted the current code access ssk data outside the relevant
> socket lock. Fix that moving the update in such scope

Is this modification still OK for you? :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0806124895399875920==--
