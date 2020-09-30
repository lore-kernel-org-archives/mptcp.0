Content-Type: multipart/mixed; boundary="===============0209198625782424966=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 2/2] selftests: mptcp: add
 ADD_ADDR timeout test case
Date: Wed, 30 Sep 2020 14:25:02 +0200
Message-ID: <54699d65-b47a-76c5-3c29-37692d15be31@tessares.net>
In-Reply-To: 3b965516e6d9c89b6b7e785142f61164673327a6.1601455568.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6116

--===============0209198625782424966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 30/09/2020 10:50, Geliang Tang wrote:
> This patch added the test case for retransmitting ADD_ADDR when timeout
> occurs. It set NS1's add_addr_timeout to 1 second, and drop NS2's ADD_ADDR
> echo packets.
> =

> And we need to slow down the transfer process of all data to let the
> ADD_ADDR suboptions can be retransmitted three times.
> =

> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---

Thank you for this useful new test! Sorry for the late review.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 08f53d86dedc..ed03ed503655 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -82,6 +82,18 @@ reset_with_cookies()
>   	done
>   }
>   =

> +reset_with_add_addr_timeout()
> +{
> +	reset
> +
> +	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
> +	ip netns exec $ns2 iptables -A OUTPUT -p tcp \
> +		-m tcp --tcp-option 30 \
> +		-m bpf --bytecode \
> +		"$(nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30')" \

I would suggest here to put the result in a variable with a comment =

about how to re-generate the value. Because I don't think many setups =

already have this dependence available by default (and many might not =

want to include it). Maybe you can declare something like this at the =

top of the file.

   # generated using $(nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30')
   CBPF_MPTCP_SUBTYPE_ADD_ADDR=3D"13,48 0 0 0,84 0 0 240,21 0 9 64,48 0 0 =

9,21 0 7 6,40 0 0 6,69 5 0 8191,177 0 0 0,80 0 0 34,84 0 0 240,21 0 1 =

48,6 0 0 65535,6 0 0 0"

> +		-j DROP
> +}
> +
>   for arg in "$@"; do
>   	if [ "$arg" =3D "-c" ]; then
>   		capture=3D1
> @@ -135,6 +147,7 @@ do_transfer()
>   	connect_addr=3D"$5"
>   	rm_nr_ns1=3D"$6"
>   	rm_nr_ns2=3D"$7"
> +	slow=3D"$8"
>   =

>   	port=3D$((10000+$TEST_COUNT))
>   	TEST_COUNT=3D$((TEST_COUNT+1))
> @@ -159,7 +172,7 @@ do_transfer()
>   		sleep 1
>   	fi
>   =

> -	if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
> +	if [ $slow -eq 0 ]; then
>   		mptcp_connect=3D"./mptcp_connect -j"
>   	else
>   		mptcp_connect=3D"./mptcp_connect -r"
> @@ -252,7 +265,22 @@ run_tests()
>   	connect_addr=3D"$3"
>   	lret=3D0
>   =

> -	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} =
0 0
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} =
0 0 0

No need to modify this here but in the future, we should maybe avoid =

these "0/1" value but use string, e.g. "slow/fast",

> +	lret=3D$?
> +	if [ $lret -ne 0 ]; then
> +		ret=3D$lret
> +		return
> +	fi
> +}
> +
> +run_tests_slow()
> +{
> +	listener_ns=3D"$1"
> +	connector_ns=3D"$2"
> +	connect_addr=3D"$3"
> +	lret=3D0
> +
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} =
0 0 1

Maybe and if you have to modify this patch, should we avoid duplicate =

the code here with run_tests() and run_tests_slow()? We could have =

run_tests() taking an optional 4th argument, e.g.

   run_tests()
   {
       (...)
       slow=3D"${4:-0}"
       (...)
   }

   run_tests_slow()
   {
       run_tests "${@}" 1
   }

(or only defined run_tests() and below, call run_tests() directly with a =

4th argument)

WDYT?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0209198625782424966==--
