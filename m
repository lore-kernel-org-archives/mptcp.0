Content-Type: multipart/mixed; boundary="===============4768142483706202039=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: DSS map overrun in recvmsg()
Date: Tue, 14 May 2019 17:47:37 -0700
Message-ID: <alpine.OSX.2.21.1905141743570.17351@jdicke-mobl1.amr.corp.intel.com>
In-Reply-To: c49adb5448c7120981a2397c56016f1e45874b1d.1557821729.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1172

--===============4768142483706202039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 14 May 2019, Paolo Abeni wrote:

> The code used to compute the remaning bytes in the current DSS
> mapping in recvmsg() looks wrong.
>
> Since we compute map_offset in two different places, factor out
> an helper for that tasks and use it.

Thanks for catching this Paolo. Your new map_remaining math is the correct =

calculation. I also tested against the multipath-tcp.org kernel (v0.94 =

branch) and that worked fine.


Mat


>
> Fixes: 8dbe2f4c7f21 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> notes:
> - This fixes some of the self-tests failures, but other issues are
> still there. Sending this early, as progress here looks slow and
> hard, and a complete solution could be not so near
> - This can be squashed into the 'fixes' commit
> ---
> net/mptcp/protocol.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1c9b1e183d12..65f1df196657 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -230,13 +230,16 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len=
, u64 seq)
> 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63,32));
> }
>
> -static u64 get_mapped_dsn(struct subflow_context *subflow)
> +static u64 get_map_offset(struct subflow_context *subflow)
> {
> -	u32 map_offset =3D (tcp_sk(sock_sk(subflow))->copied_seq -
> +	return tcp_sk(sock_sk(subflow))->copied_seq -
> 			  subflow->ssn_offset -
> -			  subflow->map_subflow_seq);
> +			  subflow->map_subflow_seq;
> +}
>
> -	return subflow->map_seq + map_offset;
> +static u64 get_mapped_dsn(struct subflow_context *subflow)
> +{
> +	return subflow->map_seq + get_map_offset(subflow);
> }
>
> static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
> @@ -481,8 +484,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 		}
>
> 		/* Read mapped data */
> -		map_remaining =3D (ssn - subflow->map_subflow_seq +
> -				 subflow->map_data_len);
> +		map_remaining =3D subflow->map_data_len - get_map_offset(subflow);
> 		desc.count =3D min_t(size_t, len - copied, map_remaining);
> 		arg.msg =3D msg;
> 		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============4768142483706202039==--
