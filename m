Content-Type: multipart/mixed; boundary="===============5451460870887656445=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests/mptcp: Better delay &
 reordering configuration
Date: Tue, 04 Aug 2020 18:16:50 +0200
Message-ID: <9530f681-9f79-d5d4-2eb3-7da3e935262b@tessares.net>
In-Reply-To: 20200727234759.25705-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 5470

--===============5451460870887656445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Thank you for sharing this patch!

On 28/07/2020 01:47, Christoph Paasch wrote:
> The delay was intended to be configured to "simulate" a high(er) BDP
> link. As such, it needs to be set as part of the loss-configuration and
> not as part of the netem reordering configuration.
> =

> The reordering-config also requires a delay but that delay is the
> reordering-extend. So, a good approach is to set the reordering-extend
> as a function of the configured latency. E.g., 25% of the overall
> latency.
> =

> Finally, the intention of tc_reorder was that when it is unset, the test
> picks a random configuration. However, currently it is always initialized
> and thus the random config won't be picked up.
> =

> Github-issue: https://github.com/multipath-tcp/mptcp_net-next/issues/6

You can use the "Closes:" tag if you want.
Or another one from:

https://docs.github.com/en/enterprise/2.16/user/github/managing-your-work-o=
n-github/closing-issues-using-keywords

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> =

> Notes:
>      Admittedly, two changes here in this patch (delay-fix and unitializi=
ng
>      tc_reorder). If you want, I can split them but I thought that's over=
kill for
>      a selftest-patch.

I am fine with that.

>   tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 6260520674d0..d29d189d1ae5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -16,7 +16,6 @@ ipv6=3Dtrue
>   ethtool_random_on=3Dtrue
>   tc_delay=3D"$((RANDOM%400))"
>   tc_loss=3D$((RANDOM%101))
> -tc_reorder=3D""
>   testmode=3D""
>   sndbuf=3D0
>   rcvbuf=3D0
> @@ -631,22 +630,24 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
>   	do_ping "$ns4" $sender dead:beef:3::1
>   done
>   =

> -[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem los=
s random $tc_loss
> +[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem los=
s random $tc_loss delay ${tc_delay}ms

It looks like it is too slow when we use this tc_delay for each packets, =

it is easy to timeout:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
00:28:49.725 # selftests: net/mptcp: mptcp_connect.sh
00:28:50.693 [   63.023982] ip (516) used greatest stack depth: 22984 =

bytes left
00:28:51.399 [   63.730210] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:28:51.872 [   64.202628] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link =

becomes ready
00:28:51.930 [   64.260700] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth2: link =

becomes ready
00:28:51.931 [   64.261982] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link =

becomes ready
00:28:52.414 [   64.744960] IPv6: ADDRCONF(NETDEV_CHANGE): ns4eth3: link =

becomes ready
00:28:52.415 [   64.746169] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link =

becomes ready
00:28:52.674 # INFO: set ns3-5f285c53-13cspj dev ns3eth2: ethtool -K =

gso off gro off
00:28:52.760 # INFO: set ns4-5f285c53-13cspj dev ns4eth3: ethtool -K tso off
00:28:53.183 # Created /tmp/tmp.giudffQ2E4 (size 7922716 =

/tmp/tmp.giudffQ2E4) containing data sent by client
00:28:53.528 # Created /tmp/tmp.Tie6RowCZz (size 7493660 =

/tmp/tmp.Tie6RowCZz) containing data sent by server
00:28:53.956 # New MPTCP socket can be blocked via sysctl		[ OK ]
00:28:54.164 # setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
00:28:54.215 # INFO: validating network environment with pings
00:28:58.551 # INFO: Using loss of 0.57% delay 197 ms reorder 93% 64% on =

ns3eth4
00:29:00.071 # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration =

323ms) [ OK ]
00:29:01.498 # ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration =

295ms) [ OK ]
00:29:02.850 # ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration =

256ms) [ OK ]
00:29:04.294 # ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration =

351ms) [ OK ]
00:29:05.697 # ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration =

257ms) [ OK ]
00:29:07.053 # ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	(duration =

244ms) [ OK ]
00:29:08.924 # ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP	(duration =

736ms) [ OK ]
00:29:10.537 # ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP	(duration =

530ms) [ OK ]
00:29:12.570 # ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP	(duration =

915ms) [ OK ]
00:29:14.483 # ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP	(duration =

807ms) [ OK ]
00:29:39.992 # ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP	(duration =

24444ms) [ OK ]
00:30:08.517 # ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP	(duration =

27434ms) [ OK ]
00:30:39.626 # ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP	(duration =

30024ms) [ OK ]
00:30:59.692 # ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP	(duration =

18959ms) [ OK ]
00:31:35.088 # ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP	(duration =

34303ms) [ OK ]
00:32:01.805 # ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP	(duration =

25614ms) [ OK ]
00:32:03.701 # ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP	(duration =

792ms) [ OK ]
00:32:05.375 # ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP	(duration =

568ms) [ OK ]
00:32:24.546 # ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP	(duration =

17980ms) [ OK ]
00:32:56.164 # ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP	(duration =

30497ms) [ OK ]
00:33:00.952 # ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP	(duration =

3684ms) [ OK ]
00:33:28.441 # ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP	(duration =

26375ms) [ OK ]
00:34:00.064 # ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP	(duration =

30538ms) [ OK ]
00:34:05.500 # ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP	(duration =

4352ms) [ OK ]
00:34:27.354 # ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP	(duration =

20759ms) [ OK ]
00:34:42.555 # ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP	(duration =

14098ms) [ OK ]
00:34:54.836 # ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP	(duration =

11197ms) [ OK ]
00:35:30.150 # ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP	(duration =

34225ms) [ OK ]
00:36:07.746 # ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP	(duration =

36505ms) [ OK ]
00:36:26.349 # ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP	#
00:36:26.350 not ok 1 selftests: net/mptcp: mptcp_connect.sh # TIMEOUT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Should we have a max of 50ms or less?

(+ ${reorder_delay} of max 50ms as well?)


>   echo -n "INFO: Using loss of $tc_loss "
>   test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
>   =

> +reorder_delay=3D`expr $tc_delay / 4`

It's a bit old school to use "`" :-D
No but it is usually recommended to use "$(...)" because it is more =

visible and can be nested.

Also only "$(...)" are used in this file.

And maybe even better to use this (if we still need to compute a value, =

see my comment above):

   reorder_delay=3D$((tc_delay / 4))

like we do just below with "reorder":

> +
>   if [ -z "${tc_reorder}" ]; then
>   	reorder1=3D$((RANDOM%10))
>   	reorder1=3D$((100 - reorder1))
>   	reorder2=3D$((RANDOM%100))
>   =

> -	if [ $tc_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ];=
 then
> +	if [ $reorder_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt=
 0 ]; then
>   		tc_reorder=3D"reorder ${reorder1}% ${reorder2}%"
>   		echo -n "$tc_reorder "
>   	fi
>   elif [ "$tc_reorder" =3D "0" ];then
>   	tc_reorder=3D""
> -elif [ "$tc_delay" -gt 0 ];then
> +elif [ "$reorder_delay" -gt 0 ];then
>   	# reordering requires some delay
>   	tc_reorder=3D"reorder $tc_reorder"
>   	echo -n "$tc_reorder "

Can you print ${reorder_delay} as well please?

> @@ -654,7 +655,7 @@ fi
>   =

>   echo "on ns3eth4"
>   =

> -tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${tc_delay}ms $tc_=
reorder
> +tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms=
 $tc_reorder
>   =

>   for sender in $ns1 $ns2 $ns3 $ns4;do
>   	run_tests_lo "$ns1" "$sender" 10.0.1.1 1
>

Note that I applied your patch in the export branch to do more tests =

with the CI but often, I was hitting the kselftest timeout. So I just =

reverted it.

I think it would be really good if these tests are quick to execute. =

Except if we think it is really important to do some tests with more =

than 50ms of delay? Maybe the proposed 50ms are already too high, 30ms =

max + reorder_delay could be OK no? If we need some tests with higher =

delay, maybe better to execute only a subset?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5451460870887656445==--
