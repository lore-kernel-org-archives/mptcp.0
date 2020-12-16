Content-Type: multipart/mixed; boundary="===============8962613518112432574=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 1/4] mptcp: fix security context on server
 socket
Date: Wed, 16 Dec 2020 15:36:45 -0800
Message-ID: <79aeed3-e480-9e5c-6498-40893e81f1f4@linux.intel.com>
In-Reply-To: 1bf3ee9b0c79a1e619fe4749d926aab71f0a7bcc.1608114076.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7200

--===============8962613518112432574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Dec 2020, Paolo Abeni wrote:

> Currently MPTCP is not propagating the security context
> from the ingress request socket to newly created msk
> at clone time.
>
> Address the issue invoking the missing security helper.
>
> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connectio=
ns")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 2 ++
> 1 file changed, 2 insertions(+)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============8962613518112432574==--
