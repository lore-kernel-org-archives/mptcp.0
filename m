Content-Type: multipart/mixed; boundary="===============7438539534607798186=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: allow MPTCP sockets by default
Date: Tue, 24 Sep 2019 15:45:59 -0700
Message-ID: <alpine.OSX.2.21.1909241501120.16564@leoliu1-mobl.amr.corp.intel.com>
In-Reply-To: 20190924160612.31093-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1920

--===============7438539534607798186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 24 Sep 2019, Matthieu Baerts wrote:

> At LPC2019, the feedback was that it should be easy to create MPTCP
> sockets to have testers. But still important to have ways to disable the
> creation of new MPTCP sockets. It can be easily done via this new
> sysctl, CGroups or SELinux. Netfilter can also be used to close existing
> MPTCP connections if needed.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---

Thanks Matthieu - I'd also noticed that we needed this. One comment below, =

otherwise looks good.

>
> Notes:
>    To be squashed in "mptcp: new sysctl to control the activation per NS"
>
> .topmsg                                            |  7 +++----
> net/mptcp/ctrl.c                                   |  7 +++++++
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++++----
> 3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/.topmsg b/.topmsg
> index 7ff9f3c96ff3..373f94c4b4bd 100644
> --- a/.topmsg
> +++ b/.topmsg
> @@ -5,10 +5,9 @@ New MPTCP sockets will return -ENOPROTOOPT if MPTCP supp=
ort is disabled
> for the current net namespace.
>
> For security reasons, it is interesting to have a global switch for
> -MPTCP. To start, MPTCP will be disabled by default and only privileged
> -users will be able to modify this. The reason is that because MPTCP is
> -new, it will not be tested and reviewed by many and security issues can
> -then take time to be discovered and fixed.
> +MPTCP. The reason is that because MPTCP is new, it will not be tested
> +and reviewed by many and security issues can then take time to be
> +discovered and fixed.
>
> The value of this new sysctl can be different per namespace. We can then
> restrict the usage of MPTCP to the selected NS. In case of serious
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 8d9f15f02369..07152c249531 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -43,6 +43,11 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
> 	{}
> };
>
> +static int mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)

Should be 'static void'? This code gives a compile warning because there's =

no return statement.

Mat


> +{
> +	pernet->mptcp_enabled =3D 1;
> +}
> +
> static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *p=
ernet)
> {
> 	struct ctl_table_header *hdr;
> @@ -85,6 +90,8 @@ static int __net_init mptcp_net_init(struct net *net)
> {
> 	struct mptcp_pernet *pernet =3D mptcp_get_pernet(net);
>
> +	mptcp_pernet_set_defaults(pernet);
> +
> 	return mptcp_pernet_new_table(net, pernet);
> }
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index d029bdc5946d..7d312bd9ac77 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -45,7 +45,6 @@ trap cleanup EXIT
> for i in 1 2 3 4;do
> 	ip netns add ns$i || exit $ksft_skip
> 	ip -net ns$i link set lo up
> -	ip netns exec ns$i sysctl -q net.mptcp.enabled=3D1
> done
>
> #  ns1              ns2                    ns3                     ns4
> @@ -111,7 +110,14 @@ check_mptcp_disabled()
> {
> 	disabled_ns=3D"ns_disabled"
> 	ip netns add ${disabled_ns} || exit $ksft_skip
> -	# by default: sysctl net.mptcp.enabled=3D0
> +
> +	# net.mptcp.enabled should be enabled by default
> +	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ =
print $3 }')" -ne 1 ]; then
> +		echo -e "net.mptcp.enabled sysctl is not 1 by default\t[ FAIL ]"
> +		ret=3D1
> +		return 1
> +	fi
> +	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=3D0
>
> 	local err=3D0
> 	LANG=3DC ip netns exec ${disabled_ns} ./mptcp_connect -t $timeout -p 100=
00 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
> @@ -119,12 +125,12 @@ check_mptcp_disabled()
> 	ip netns delete ${disabled_ns}
>
> 	if [ ${err} -eq 0 ]; then
> -		echo -e "MPTCP is not disabled by default as expected\t[ FAIL ]"
> +		echo -e "New MPTCP socket cannot be blocked via sysctl\t[ FAIL ]"
> 		ret=3D1
> 		return 1
> 	fi
>
> -	echo -e "MPTCP is disabled by default as expected\t[ OK ]"
> +	echo -e "New MPTCP socket can be blocked via sysctl\t[ OK ]"
> 	return 0
> }
>
> -- =

> 2.20.1

--
Mat Martineau
Intel

--===============7438539534607798186==--
