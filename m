Content-Type: multipart/mixed; boundary="===============4448815147125245896=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: plug subflow context memory leak
Date: Fri, 04 Dec 2020 17:46:47 +0100
Message-ID: <6aef51da-e3a2-5d70-96f0-e844ce17b2da@tessares.net>
In-Reply-To: 8d57c51a359d2c3867b7a6712af4d431167ecb92.1607081800.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7051

--===============4448815147125245896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 04/12/2020 12:37, Paolo Abeni wrote:
> When a MPTCP listener socket is closed with unaccepted
> children pending, the ULP release callback will be invoked,
> but nobody will call into __mptcp_close_ssk() on the
> corresponding subflow.
> =

> As a consequence, at ULP release time, the 'disposable' flag
> will be cleared and the subflow context memory will be leaked.
> =

> This change addresses the issue always freeing the context if
> the subflow is still in the accept queue at ULP release time.
> =

> Additionally, this fixes an incorrect code reference in the
> related comment.
> =

> Note: this fix leverages the changes introduced by the previous
> commit.
> =

> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for this patch!

- b89ebad43317: mptcp: plug subflow context memory leak
- Results: 3df24f8e9d36..7ca534d9bde5

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4448815147125245896==--
