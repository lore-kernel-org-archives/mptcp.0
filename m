Content-Type: multipart/mixed; boundary="===============0418640507300803879=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 1/2] mptcp: cache msk on MP_JOIN init_req
Date: Wed, 17 Jun 2020 11:13:22 -0700
Message-ID: <alpine.OSX.2.22.394.2006171112280.1663@mjmartin-mac01.local>
In-Reply-To: 3213f22a1fa85217032ba3de482f2209c63f2870.1592388398.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4720

--===============0418640507300803879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2020, Paolo Abeni wrote:

> The msk ownership is transferred to the child socket at
> 3rd ack time, so that we avoid more lookups later. If the
> request does not reach the 3rd ack, the MSK reference is
> dropped at request sock release time.
>
> As a side effect, fallback is now tracked by a NULL msk
> reference instead of zeroed 'mp_join' field. This will
> simplify the next patch.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 39 +++++++++++++++++----------------------
> 2 files changed, 18 insertions(+), 22 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0418640507300803879==--
