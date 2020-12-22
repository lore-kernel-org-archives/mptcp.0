Content-Type: multipart/mixed; boundary="===============0915109381825782062=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 3/3] selftests: mptcp: add
 testcases for newly added addresses
Date: Tue, 22 Dec 2020 10:56:41 +0100
Message-ID: <e83e5301785ccd2964462087d6677d92d5719724.camel@redhat.com>
In-Reply-To: a550c3ef94152262e12e24f459c01fcdb1220e80.1608304480.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7241

--===============0915109381825782062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-18 at 23:24 +0800, Geliang Tang wrote:
> This patch added the testcases to create subflows or signal addresses
> for the newly added IPv4 or IPv6 addresses.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 73 ++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index cbc48ed5b267..ef0b008c09c6 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -264,7 +264,23 @@ do_transfer()
>  	fi
>  	cpid=3D$!
>  =

> -	if [ $addr_nr_ns1 -lt 0 ]; then
> +	if [ $addr_nr_ns1 -gt 0 ]; then
> +		let add_nr_ns1=3Daddr_nr_ns1
> +		counter=3D2
> +		sleep 1
> +		while [ $add_nr_ns1 -gt 0 ]; do
> +			local addr
> +			if is_v6 "${connect_addr}"; then
> +				addr=3D"dead:beef:$counter::1"
> +			else
> +				addr=3D"10.0.$counter.1"
> +			fi
> +			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
> +			let counter+=3D1
> +			let add_nr_ns1-=3D1
> +		done
> +		sleep 1
> +	elif [ $addr_nr_ns1 -lt 0 ]; then
>  		let rm_nr_ns1=3D-addr_nr_ns1
>  		if [ $rm_nr_ns1 -lt 8 ]; then
>  			counter=3D1
> @@ -282,7 +298,23 @@ do_transfer()
>  		fi
>  	fi
>  =

> -	if [ $addr_nr_ns2 -lt 0 ]; then
> +	if [ $addr_nr_ns2 -gt 0 ]; then
> +		let add_nr_ns2=3Daddr_nr_ns2
> +		counter=3D3
> +		sleep 1
> +		while [ $add_nr_ns2 -gt 0 ]; do
> +			local addr
> +			if is_v6 "${connect_addr}"; then
> +				addr=3D"dead:beef:$counter::2"
> +			else
> +				addr=3D"10.0.$counter.2"
> +			fi
> +			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
> +			let counter+=3D1
> +			let add_nr_ns2-=3D1
> +		done
> +		sleep 1
> +	elif [ $addr_nr_ns2 -lt 0 ]; then
>  		let rm_nr_ns2=3D-addr_nr_ns2
>  		if [ $rm_nr_ns2 -lt 8 ]; then
>  			counter=3D1
> @@ -738,6 +770,43 @@ chk_join_nr "flush subflows and signal" 3 3 3
>  chk_add_nr 1 1
>  chk_rm_nr 2 2
>  =

> +# add single subflow
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> +chk_join_nr "add single subflow" 1 1 1
> +
> +# add signal address
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +chk_join_nr "add signal address" 1 1 1
> +chk_add_nr 1 1
> +
> +# add multiple subflows
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> +chk_join_nr "add multiple subflows" 2 2 2
> +
> +# add multiple subflows IPv6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> +chk_join_nr "add multiple subflows IPv6" 2 2 2
> +
> +# add multiple addresses IPv6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> +run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> +chk_join_nr "add multiple addresses IPv6" 2 2 2
> +chk_add_nr 2 2
> +
>  # subflow IPv6
>  reset
>  ip netns exec $ns1 ./pm_nl_ctl limits 0 1


The new tests are all good!

Side note: I fear that mptcp_join.sh is becoming too big, containing
many different/quite unrelated tests. =


Perhaps we could split it in smaller chunk ?!? e.g. all subflows only
test, all other addr related tests, syncookies

/P

--===============0915109381825782062==--
