Content-Type: multipart/mixed; boundary="===============5712108299306989482=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Tue, 03 Dec 2019 08:54:17 +0100
Message-ID: <54e7bf46-cc9d-0372-b9d5-0e8bb45b4a70@tessares.net>
In-Reply-To: 20191202171504.88739-2-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2758

--===============5712108299306989482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Paolo,

On 02/12/2019 18:15, Christoph Paasch wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> For simplicity's sake use directly sha256 primitives (and pull them
> as a required build dep).
> Add optional, boot-time self-tests for the hmac function.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Sorry for this detail but regarding the Signed-off-by, should I write =

this instead?

   Co-developed-by: Christoph Paasch <cpaasch(a)apple.com>
   Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
   Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Or do we have a "Signed-off-by" here from Christoph because you =

(Christoph) are the sender of this patch here? But can we keep it if you =

are not the one who will send this patch to netdev? :)

The rest looks good to me!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5712108299306989482==--
