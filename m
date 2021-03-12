Content-Type: multipart/mixed; boundary="===============2906081043170750131=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 22:06:02 +0800
Message-ID: <CA+WQbwuBi+fUvbFPo-QxVrxAzY64QWpMxiWCKZak8=8Cvfk+8g@mail.gmail.com>
In-Reply-To: 20210312125425.3199991-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8115

--===============2906081043170750131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for this fix.

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Avoid calling pm_nl_ctl with id > 255.
>
> Without this patch, we can see this when running the selftests:
>
>   selftests: net/mptcp: pm_netlink.sh
>   (...)
>   above hard addr limit                              [ OK ]
>   ./pm_nl_ctl add|get|set|del|flush|dump|accept
>    add [flags signal|subflow|backup] [id <nr>] [dev <name>] <ip>
>   del <id>
>    get <id>
>    set <ip> [flags backup|nobackup]
>    flush
>    dump
>   limits [<rcv addr max> <subflow max>]
>
>   id limit                                           [ OK ]
>   (...)
>
> That's because we were calling:
>
>   $ pm_nl_ctl del 256
>
> In the code, the parsed ID is written in a u_int8_t. Then the value
> "256" is stored as "0" which is now a special case and requires an IP.
>
> We could modify pm_nl_ctl but stop if the ID is negative or higher than
> 255 but not sure we need this for a tool only used in selftests.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>     to be squashed in "selftests: mptcp: add addr argument for del_addr"

I think this patch should be a single standalone patch, not a squash-to
one.

>
>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/test=
ing/selftests/net/mptcp/pm_netlink.sh
> index a617e293734c..365ba4611ae7 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -100,9 +100,10 @@ done
>  check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9=
" "hard addr limit"
>  check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
>
> -for i in `seq 9 256`; do

Could we just simply change this '256' to '255', with no other changes?
Like this:

    -for i in `seq 9 256`; do
    +for i in `seq 9 255`; do

Thanks.

-Geliang

> +ip netns exec $ns1 ./pm_nl_ctl del 9
> +for i in `seq 10 255`; do
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
>         ip netns exec $ns1 ./pm_nl_ctl del $i
> -       ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
>  done
>  check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
>  id 2 flags  10.0.0.9
> --
> 2.30.2
>
--===============2906081043170750131==--
