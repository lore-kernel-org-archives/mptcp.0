Content-Type: multipart/mixed; boundary="===============7130000540962018162=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 1/7] selftests: mptcp: make tc delays random
Date: Wed, 23 Oct 2019 16:17:34 -0700
Message-ID: <alpine.OSX.2.21.1910231515230.37761@rjszuste-mobl.amr.corp.intel.com>
In-Reply-To: 20191023131325.18895-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2300

--===============7130000540962018162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 23 Oct 2019, Florian Westphal wrote:

> test with less predictable setups:
> tc qdisc delay is now random, same for reordering and loss.
> Motivation is to cover more scenarios without a increase in test-time.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.sh      | 26 +++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index f0528df9ac31..96be39a476ee 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -302,8 +302,30 @@ for sender in 1 2 3 4;do
> 	do_ping ns4 ns$sender 10.0.3.1
> done
>
> -tc -net ns2 qdisc add dev ns2eth3 root netem loss random 1
> -tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% =
gap 5
> +loss=3D$((RANDOM%101))
> +if [ $loss -eq 100 ] ;then
> +	loss=3D1%
> +	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
> +elif [ $loss -ge 10 ]; then
> +	loss=3D0.$loss%
> +	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
> +elif [ $loss -ge 1 ]; then
> +	loss=3D0.0$loss%
> +	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
> +fi
> +
> +delay=3D$((RANDOM%1000))
> +reorder1=3D$((RANDOM%10))
> +reorder1=3D$((100 - reorder1))
> +reorder2=3D$((RANDOM%100))
> +
> +if [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
> +  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms reorder =
${reorder1}% ${reorder2}%
> +  echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, =
$reorder2 on ns3eth4"
> +elif [ $delay -gt 0 ]; then
> +  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms
> +  echo "INFO: Using loss of $loss, delay $delay ms on ns3eth4"
> +fi

I think it's ok to merge this patch, but randomly configuring with/without =

reordering does seem like a significant difference in test cases (and =

maybe the gso/tso/gro changes in patch 4 reach that threshold too).

There are situations where execution time is less of a concern than =

coverage. What do you think about randomizing the netem and ethtool =

settings by default, but having a command line option to run a larger set =

of test cases?

--
Mat Martineau
Intel
--===============7130000540962018162==--
