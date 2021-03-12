Content-Type: multipart/mixed; boundary="===============5935354842612591410=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add
 addr argument for del_addr"
Date: Fri, 12 Mar 2021 11:01:40 -0800
Message-ID: <86ce39db-8474-4dc1-5e12-42a9a4ecc12f@linux.intel.com>
In-Reply-To: 20210312141745.3326786-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8126

--===============5935354842612591410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Mar 2021, Matthieu Baerts wrote:

> Avoid calling pm_nl_ctl with id > 255.
>
> Without this patch, we can see this when running the selftests:
>
>  selftests: net/mptcp: pm_netlink.sh
>  (...)
>  above hard addr limit                              [ OK ]
>  ./pm_nl_ctl add|get|set|del|flush|dump|accept
>   add [flags signal|subflow|backup] [id <nr>] [dev <name>] <ip>
>  del <id>
>   get <id>
>   set <ip> [flags backup|nobackup]
>   flush
>   dump
>  limits [<rcv addr max> <subflow max>]
>
>  id limit                                           [ OK ]
>  (...)
>
> That's because we were calling:
>
>  $ pm_nl_ctl del 256
>
> In the code, the parsed ID is written in a u_int8_t. Then the value
> "256" is stored as "0" which is now a special case and requires an IP.
>
> We could modify pm_nl_ctl and stop if the ID is negative or higher than
> 255 but not sure we need this for a tool only used in selftests.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: add addr argument for del_addr"
>
>    v2:
>      - only modify the for-loop higher limit. (Geliang)
>
> tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/test=
ing/selftests/net/mptcp/pm_netlink.sh
> index a617e293734c..2ba91c63f24e 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -100,7 +100,7 @@ done
> check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9"=
 "hard addr limit"
> check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
>
> -for i in `seq 9 256`; do
> +for i in `seq 9 255`; do
> 	ip netns exec $ns1 ./pm_nl_ctl del $i
> 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
> done
> -- =

> 2.30.2

Thanks for the fix Matthieu, looks good to me.

--
Mat Martineau
Intel
--===============5935354842612591410==--
