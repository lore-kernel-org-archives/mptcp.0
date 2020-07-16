Content-Type: multipart/mixed; boundary="===============1081253083628651154=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 03/12] mptcp: Add mptcp_close_state()
 helper
Date: Thu, 16 Jul 2020 15:20:43 +0200
Message-ID: <dbd09873ffb51e8436feabd0af5340e827b03996.camel@redhat.com>
In-Reply-To: 20200716002036.705306-4-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5042

--===============1081253083628651154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
> This will be used to transition to the appropriate state on close and
> determine if a DATA_FIN needs to be sent for that state transition.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7cdf451ea3da..69100187490f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1424,7 +1424,33 @@ static void mptcp_subflow_shutdown(struct sock *ss=
k, int how,
>  	release_sock(ssk);
>  }
>  =

> -/* Called with msk lock held, releases such lock before returning */

Beware! this removes the above commit message, likely in an unintended
way.

/P

--===============1081253083628651154==--
