Content-Type: multipart/mixed; boundary="===============8564210339558504173=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 3/4] selftests: mptcp: add
 cfg_do_w for cfg_remove
Date: Mon, 22 Feb 2021 16:59:09 -0800
Message-ID: <6c18382c-5ee3-fb92-e44a-7f792f962af@linux.intel.com>
In-Reply-To: 4bd05617494686e9dabaf4b0a0e12b475a7529ce.1613965565.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7903

--===============8564210339558504173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Feb 2021, Geliang Tang wrote:

> In some testcases, we need to slow down the transmitting process. This
> patch added a new argument named cfg_do_w for cfg_remove to allow the
> caller to pass an argument to cfg_remove.
>
> In do_rnd_write, use this cfg_do_w to control the transmitting speed.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 77bb62feb872..533c3d8dc1cd 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -55,6 +55,7 @@ static int cfg_sndbuf;
> static int cfg_rcvbuf;
> static bool cfg_join;
> static bool cfg_remove;
> +static unsigned int cfg_do_w;
> static int cfg_wait;
>
> static void die_usage(void)
> @@ -272,8 +273,8 @@ static size_t do_rnd_write(const int fd, char *buf, c=
onst size_t len)
> 	if (cfg_join && first && do_w > 100)
> 		do_w =3D 100;
>
> -	if (cfg_remove && do_w > 50)
> -		do_w =3D 50;
> +	if (cfg_remove && do_w > cfg_do_w)
> +		do_w =3D cfg_do_w;
>
> 	bw =3D write(fd, buf, do_w);
> 	if (bw < 0)
> @@ -829,7 +830,7 @@ static void parse_opts(int argc, char **argv)
> {
> 	int c;
>
> -	while ((c =3D getopt(argc, argv, "6jrlp:s:hut:m:S:R:w:")) !=3D -1) {
> +	while ((c =3D getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:")) !=3D -1) {
> 		switch (c) {
> 		case 'j':
> 			cfg_join =3D true;
> @@ -840,6 +841,7 @@ static void parse_opts(int argc, char **argv)
> 			cfg_remove =3D true;
> 			cfg_mode =3D CFG_MODE_POLL;
> 			cfg_wait =3D 400000;
> +			cfg_do_w =3D atoi(optarg);

Even though this program is only driven by the test scripts, I think it =

would still be good to do a sanity check on the value of cfg_do_w. At =

least make sure it's greater than zero?

> 			break;
> 		case 'l':
> 			listen_mode =3D true;
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============8564210339558504173==--
