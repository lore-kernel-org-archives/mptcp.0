Content-Type: multipart/mixed; boundary="===============7964891045066731205=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: get a ref to the current net
Date: Thu, 16 Jan 2020 17:47:32 +0100
Message-ID: <63db0bce-8a99-704b-18d5-a3045b98c8e2@tessares.net>
In-Reply-To: 43354232f69ebf85d4e54e822f8019930b1ccb57.1579038306.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3379

--===============7964891045066731205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 14/01/2020 22:46, Paolo Abeni wrote:
> The MPTCP subflows are created via sock_create_kern(), so they
> do not held any references to the current network namespace.
> =

> The TCP timer infrastructure assumes the current net is always
> alive/goes away after the relevant sock.
> =

> Due to the above packetdrill is able to trigger UAF with some
> simple scenario (and fast netns tear-down).
> =

> Acquire a reference to the current net at creation time.
> =

> Note: using __sock_create(/*...*/, 0) will break lockdep (kernel
> socket get a different lockdep key).
> =

> Squash-to: "mptcp: Associate MPTCP context with TCP socket"

Thank you for the patch and the review (in the RFC thread):

- beab459af74c: "squashed" in "mptcp: Associate MPTCP context with TCP =

socket"
- 4fe8bda1127e..41b3253570a8: result

Tests + export will be launched soon!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7964891045066731205==--
