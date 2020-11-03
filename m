Content-Type: multipart/mixed; boundary="===============2556761480488784697=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 10/10] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Tue, 03 Nov 2020 18:41:34 +0100
Message-ID: <0306a5e1-62f9-3281-8f56-8a95dcddc786@tessares.net>
In-Reply-To: 83024d39b0b057fffc73377d5e95219132a10780.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6524

--===============2556761480488784697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 31/10/2020 16:31, Geliang Tang wrote:
> This patch added a new argument with_port for run_tests and
> do_transfer, and added the testcases for ADD_ADDR with port.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>   .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 0eae628d1ffd..826d662a9bf8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -253,6 +254,11 @@ do_transfer()
>   		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
>   	spid=3D$!
>   =

> +	if [ "$with_port" -gt 0 ];then
> +		ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $with_po=
rt \
> +			-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &

Sorry, I am not sure to understand: why do you establish a new =

connection if the port is set? Just to make sure we can also initiate a =

new connection directly to this port (I am not sure we want this)?

> +	fi
> +
>   	sleep 1
>   =

>   	if [ "$test_link_fail" -eq 0 ];then

(...)

> @@ -717,6 +724,23 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
>   chk_add_nr 1 1
>   chk_rm_nr 1 1
>   =

> +# subflow with port
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow port 10100
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "single subflow with port" 1 1 1

Should we also check that the second subflow was established on the =

correct port?

> +
> +# signal address with port
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
> +chk_join_nr "signal address with port" 1 1 1
> +chk_add_nr 1 1

Should we also check we announce the address with a port?

(note that we could also have a MIB counter we increase when we =

establish a port on a different port than the original one)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2556761480488784697==--
