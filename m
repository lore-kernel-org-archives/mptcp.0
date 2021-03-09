Content-Type: multipart/mixed; boundary="===============1444939974426415333=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: add
 rm_list in mptcp_out_options" - fix RM_ADDR option writing
Date: Mon, 08 Mar 2021 16:50:27 -0800
Message-ID: <c69a248c-9a6a-9161-a4a-93909b3ba511@linux.intel.com>
In-Reply-To: a9a200291d259443af34bfdb3a1da76a4413d4d2.1615078654.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8078

--===============1444939974426415333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Mar 2021, Geliang Tang wrote:

> The original RM_ADDR option writing can only deal with 8 addresses, this
> patch fixed it.
>
> This patch fixed a bug in mptcp_rm_addr_len too.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
> - add the bugfix for mptcp_rm_addr_len.

Thanks for the fix. Functionality looks good but I'd like a couple of =

readability changes below.

> ---
> net/mptcp/options.c  | 23 +++++++++++------------
> net/mptcp/protocol.h |  2 +-
> 2 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 595b4b4279f7..46b5b276160e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1222,22 +1222,21 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
> 	}
>
> 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> -		u8 i;
> +		u8 i =3D 0;

I'd prefer to set 'i =3D 1' here

>
> -		for (i =3D opts->rm_list.nr; i < MPTCP_RM_IDS_MAX; i++)
> -			opts->rm_list.ids[i] =3D TCPOPT_NOP;
> 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
> 				      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
> -				      0, opts->rm_list.ids[0]);

and leave the line above with "opts->rm_list.ids[0]" unchanged - clearer =

that it's always the first id.

> -		if (opts->rm_list.nr > 1) {
> -			put_unaligned_be32(opts->rm_list.ids[1] << 24 | opts->rm_list.ids[2] =
<< 16 |
> -					   opts->rm_list.ids[3] << 8 | opts->rm_list.ids[4], ptr);
> -			ptr +=3D 1;
> -		}
> -		if (opts->rm_list.nr > 5) {
> -			put_unaligned_be32(opts->rm_list.ids[5] << 24 | opts->rm_list.ids[6] =
<< 16 |
> -					   opts->rm_list.ids[7] << 8 | TCPOPT_NOP, ptr);
> +				      0, opts->rm_list.ids[i++]);

Please also add an empty line here, before the while loop.

> +		while (i < opts->rm_list.nr) {
> +			u8 id1, id2, id3, id4;
> +
> +			id1 =3D opts->rm_list.ids[i];
> +			id2 =3D i + 1 < opts->rm_list.nr ? opts->rm_list.ids[i + 1] : TCPOPT_=
NOP;
> +			id3 =3D i + 2 < opts->rm_list.nr ? opts->rm_list.ids[i + 2] : TCPOPT_=
NOP;
> +			id4 =3D i + 3 < opts->rm_list.nr ? opts->rm_list.ids[i + 3] : TCPOPT_=
NOP;
> +			put_unaligned_be32(id1 << 24 | id2 << 16 | id3 << 8 | id4, ptr);
> 			ptr +=3D 1;
> +			i +=3D 4;
> 		}
> 	}
>

Thanks,

--
Mat Martineau
Intel
--===============1444939974426415333==--
