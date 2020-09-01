Content-Type: multipart/mixed; boundary="===============3092835014247807430=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 5/8] mptcp: fix subflow's
 remote_id is zero issue
Date: Tue, 01 Sep 2020 17:36:06 +0200
Message-ID: <3161b9d711004276e9156b2983cf86419b1d2d77.camel@redhat.com>
In-Reply-To: 690fe27e2779bb40aca87905ccc56c0403b9b92a.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5682

--===============3092835014247807430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-08-24 at 19:36 +0800, Geliang Tang wrote:
> This patch added the missing remote_id set in subflow_ulp_clone. And also
> updated the remote_id set in __mptcp_subflow_connect, to make the code mo=
re
> like local_id set.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/subflow.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 82f6d2d9e39e..0a7b80711096 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1042,6 +1042,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
>  	struct mptcp_subflow_context *subflow;
>  	struct sockaddr_storage addr;
>  	int local_id =3D loc->id;
> +	int remote_id =3D remote->id;
>  	struct socket *sf;
>  	struct sock *ssk;
>  	u32 remote_token;

very minor note: this does not respect the reverse x-mas tree order. =


Otherwise looks good.

Note: I think you can submit this patch and the previous one (4/8)
directly to -net (with an appropriate Fixes tag).

Cheers,

Paolo

--===============3092835014247807430==--
