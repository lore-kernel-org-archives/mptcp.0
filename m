Content-Type: multipart/mixed; boundary="===============2780820846976955101=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: add
 IPv4-mapped IPv6 testcases
Date: Mon, 21 Dec 2020 18:16:55 +0800
Message-ID: <CA+WQbws31bk_d2JzL8-zGH+pZ5baYctfQKKvyy=SYev49TT3QQ@mail.gmail.com>
In-Reply-To: 20201219130700.1053584-4-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7231

--===============2780820846976955101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=
=81=93=EF=BC=9A
>
> From: Geliang Tang <geliangtang(a)gmail.com>
>
> Here, we make sure we support IPv4-mapped in IPv6 addresses in different
> contexts:
>
> - a v4-mapped address is received by the PM and can be used as v4.
> - a v4 address is received by the PM and can be used even with a v4
>   mapped socket.
>
> We also make sure we don't try to establish subflows between v4 and v6
> addresses, e.g. if a real v6 address ends with a valid v4 address.
>
> Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index f74cd993b168..eff813819e6a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -790,6 +790,73 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
>  chk_add_nr 1 1
>  chk_rm_nr 1 1
>
> +# subflow IPv4-mapped to IPv4-mapped
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> +run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +chk_join_nr "single subflow IPv4-mapped" 1 1 1
> +
> +# signal address IPv4-mapped with IPv4-mapped sk
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> +run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +chk_join_nr "signal address IPv4-mapped" 1 1 1
> +chk_add_nr 1 1
> +
> +# subflow v4-map-v6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +chk_join_nr "single subflow v4-map-v6" 1 1 1
> +
> +# signal address v4-map-v6
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +chk_join_nr "signal address v4-map-v6" 1 1 1
> +chk_add_nr 1 1
> +
> +# subflow v6-map-v4
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "single subflow v6-map-v4" 1 1 1
> +
> +# signal address v6-map-v4
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "signal address v6-map-v4" 1 1 1
> +chk_add_nr 1 1
> +
> +# no subflow IPv6 to v4 address
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow

dead:beef:2::10.0.3.2 is a invalid address, should we use dead:beef:3::2 he=
re?

> +run_tests $ns1 $ns2 "10.0.1.1"

We can drop the quotation marks here, only the IPv4-mapped address need
the quotation marks.

And add "0 0 0 slow" behind it, since the test need to slow down when use
the IPv6 address.

> +chk_join_nr "no JOIN with different families v4-v6" 0 0 0

This string is too long, it break the alignment of the output. Can we use
"diff" here instead of "different"?

> +
> +# no subflow IPv4 to v6 address
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +run_tests $ns1 $ns2 dead:beef:1::1

Add "0 0 0 slow" here.

> +chk_join_nr "no JOIN with different families v6-v4" 0 0 0

This string is too long too.



-Geliang

> +
>  # single subflow, backup
>  reset
>  ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> --
> 2.29.2
>
--===============2780820846976955101==--
