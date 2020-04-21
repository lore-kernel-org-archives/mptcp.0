Content-Type: multipart/mixed; boundary="===============6548684772521065915=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix data_fin handing in RX path
Date: Tue, 21 Apr 2020 11:30:17 -0700
Message-ID: <alpine.OSX.2.22.394.2004211129200.18697@tedri-mobl.ger.corp.intel.com>
In-Reply-To: 0d354f71e8cc62e916091ae5361b1895f904f8c9.1587457680.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4215

--===============6548684772521065915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 21 Apr 2020, Paolo Abeni wrote:

> The data fin flag is set only via a DSS option, but currently
> mptcp_incoming_options() copies it inconditionally from the
> provided RX options.
>
> Since the tcp sock RX options are not explicitly cleared on
> socket free/alloc cycle, we can end-up with a stray data_fin
> value while parsing e.g. MPC packets.
>
> That would lead to mapping data corruption and will trigger
> a few WARN_ON() in the RX path.
>
> Instead of adding a costly memset(), fetch the data_fin flag
> only for DSS packets - when we always expicitly initialize
> such bit at option parsing time.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3d541b60dcf3..129e9c214b2d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -878,12 +878,11 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb,
> 			mpext->data_seq =3D mp_opt->data_seq;
> 			mpext->subflow_seq =3D mp_opt->subflow_seq;
> 			mpext->dsn64 =3D mp_opt->dsn64;
> +			mpext->data_fin =3D mp_opt->data_fin;
> 		}
> 		mpext->data_len =3D mp_opt->data_len;
> 		mpext->use_map =3D 1;
> 	}
> -
> -	mpext->data_fin =3D mp_opt->data_fin;
> }
>
> void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)

Thanks for fixing that, Paolo. Looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


--
Mat Martineau
Intel
--===============6548684772521065915==--
