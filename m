Content-Type: multipart/mixed; boundary="===============1212228208724814900=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: use list_first_entry_or_null
Date: Fri, 12 Jun 2020 11:22:31 -0700
Message-ID: <alpine.OSX.2.22.394.2006121114030.74555@mjmartin-mac01.local>
In-Reply-To: 9958d3f15d2d181eb9d48ffe5bf3251ec900f27a.1591941826.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4662

--===============1212228208724814900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Geliang,

On Fri, 12 Jun 2020, Geliang Tang wrote:

> Use list_first_entry_or_null to simplify the code.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/protocol.h | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 86d265500cf6..55c65abcad64 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -234,10 +234,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head=
(const struct sock *sk)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
>
> -	if (list_empty(&msk->rtx_queue))
> -		return NULL;
> -
> -	return list_first_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
> +	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag=
, list);
> }
>
> struct mptcp_subflow_request_sock {
> -- =

> 2.17.1

As Matthieu mentioned on your earlier patch, please submit patches to =

netdev with either a [PATCH net] or [PATCH net-next] tag. In this case, =

these are non-critical bug fixes so they should be targeted at net-next.

Note that net-next branch is currently closed to submissions due to the =

v5.8 merge window. Please resubmit both MPTCP patches for net-next when =

David announces that it is open again. The change does look ok but will =

not be merged now.

Thanks for your patch,

--
Mat Martineau
Intel
--===============1212228208724814900==--
