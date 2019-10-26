Content-Type: multipart/mixed; boundary="===============5091966344123354987=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: mptcp: Restore capture option
Date: Sat, 26 Oct 2019 08:46:34 +0200
Message-ID: <15887a04-e39e-8d2a-7712-c09a8e4222f3@tessares.net>
In-Reply-To: 20191025231957.7937-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2331

--===============5091966344123354987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 26/10/2019 01:19, Mat Martineau wrote:
> The addition of other command line parameter handling made "-c" show the
> usage message rather than allow packet capture with tcpdump. Integrate
> "-c" with getops handling and make sure the usage message covers all
> options.

Good catch! Thanks for the patch!

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>   .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 2cd62b041e70..b207ec12612e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh

[...]

> @@ -32,6 +32,8 @@ usage() {
>   	echo -e "\t-l: tc/netem loss percentage, e.g. \"-l 0.02\" (default ran=
dom)"
>   	echo -e "\t-r: tc/netem reorder mode, e.g. \"-r 25% 50% gap 5\", use "=
-r 0" to disable reordering (default random)"
>   	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (d=
efault: randomly disable any of tso/gso/gro)"
> +	echo -e "\t-6: enable IPv6 tests (default: only test IPv4)"

Good catch!

> +	echo -e "\t-c: capture packets for each test using tcpdump (default: no=
 capture)"
>   }
>   =

>   while getopts "$optstring" option;do

[...]

> @@ -334,7 +333,7 @@ do_transfer()
>   =

>   	stop=3D$(date +%s)
>   =

> -	if [ $capture -eq 1 ]; then
> +	if $capture; then

It's maybe just me but I usually prefer to avoid having to execute a =

binary hidden in a variable to return 0 or 1. ${capture} could be set to =

another binary/function, we will fork (except with some shells), etc.

But that's just for the tests, we will not launch that on a low end =

device and we are already doing that with ipv6, random, etc. so it looks =

good to me to apply this! :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5091966344123354987==--
