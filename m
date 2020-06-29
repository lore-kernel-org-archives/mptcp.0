Content-Type: multipart/mixed; boundary="===============1377898560054907620=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 5/6] mptcp: __mptcp_tcp_fallback()
 returns a struct sock
Date: Mon, 29 Jun 2020 16:30:54 -0700
Message-ID: <alpine.OSX.2.23.453.2006291630390.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: f4474c22d50669fa3702224677fd2c2541b83ca9.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4858

--===============1377898560054907620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2020, Davide Caratti wrote:

> From: Paolo Abeni <pabeni(a)redhat.com>
>
> Currently __mptcp_tcp_fallback() always return NULL
> on incoming connections, because MPTCP does not create
> the additional socket for the first subflow.
> Since the previous commit no __mptcp_tcp_fallback()
> caller needs a struct socket, so let __mptcp_tcp_fallback()
> return the first subflow sock and cope correctly even with
> incoming connections.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/protocol.c | 22 ++++++++++------------
> 1 file changed, 10 insertions(+), 12 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1377898560054907620==--
