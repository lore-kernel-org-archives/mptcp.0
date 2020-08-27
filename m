Content-Type: multipart/mixed; boundary="===============4882505710635129402=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cleanup
 mptcp_subflow_discard_data()"
Date: Thu, 27 Aug 2020 08:19:35 -0700
Message-ID: <alpine.OSX.2.23.453.2008270818090.5728@waberry-mobl2.amr.corp.intel.com>
In-Reply-To: a0eb7395e598b77cac358e35820f0280ed49a024.1598520797.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5646

--===============4882505710635129402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 27 Aug 2020, Paolo Abeni wrote:

> While discarding old data we also need to flush the
> related map, if completed/exausted.
>
> Additionally, use a safer condition to check for to-be-eaten
> skbs
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - fix seq check using before - Mat
>
> with this and pending Florian's patches, the kernel survived
> the following loop for quite a bit.
>
> while true; do
> 	./mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((100 * 1024 * 1024)) -m po=
ll
> done
>
> I still see poll timeout with both ends not readable - not
> investigated yet.
> ---
> net/mptcp/subflow.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Looks good to me, thanks!

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 3585fd63c757..b920aa23c567 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -819,8 +819,10 @@ static void mptcp_subflow_discard_data(struct sock *=
ssk, struct sk_buff *skb,
> 		 subflow->map_subflow_seq);
> 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
> 	tcp_sk(ssk)->copied_seq +=3D incr;
> -	if (incr >=3D skb->len)
> +	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
> 		sk_eat_skb(ssk, skb);
> +	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
> +		subflow->map_valid =3D 0;
> }
>
> static bool subflow_check_data_avail(struct sock *ssk)
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4882505710635129402==--
