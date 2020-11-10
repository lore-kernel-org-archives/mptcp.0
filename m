Content-Type: multipart/mixed; boundary="===============4366776562250014299=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/4] Squash to "mptcp: add port
 support for ADD_ADDR suboption writing"
Date: Mon, 09 Nov 2020 16:03:12 -0800
Message-ID: <f08d285-9760-fd15-a7e0-a0682158794a@linux.intel.com>
In-Reply-To: 9503a048f063b5b55504103be037038a04d122e4.1604845519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6617

--===============4366776562250014299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sun, 8 Nov 2020, Geliang Tang wrote:

> Here is the new commit message, please update it:
> """
> In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
> is 18 octets, but mptcp_write_options is 32-bit aligned, so we need to
> pad it to 20 octets. All the other port related option lengths need to
> be added up 2 octets similarly.
>
> This patch added a new field 'port' in mptcp_out_options. When this
> field is set with a port number, we need to add up 4 octets for the
> ADD_ADDR suboption, and put the port number into the suboption.
> """
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c | 17 ++++++++++-------
> 1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f611fbcbd6d0..5df31d0b885b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1116,13 +1116,16 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
> 			}
> 		} else {
> 			if (opts->ahmac) {
> -				put_unaligned_be32(opts->port << 16 |
> -						   opts->ahmac >> 48, ptr);
> -				ptr +=3D 1;
> -				put_unaligned_be64(opts->ahmac << 16 |
> -						   TCPOPT_NOP << 8 |
> -						   TCPOPT_NOP, ptr);
> -				ptr +=3D 2;
> +				u8 *bptr =3D (u8 *)ptr;
> +
> +				put_unaligned_be16(opts->port, bptr);
> +				bptr +=3D 2;
> +				put_unaligned_be64(opts->ahmac, bptr);
> +				bptr +=3D 8;
> +				put_unaligned_be16(TCPOPT_NOP << 8 |
> +						   TCPOPT_NOP, bptr);
> +
> +				ptr +=3D 3;

Thanks, looks good to me.

> 			} else {
> 				put_unaligned_be32(opts->port << 16 |
> 						   TCPOPT_NOP << 8 |
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4366776562250014299==--
