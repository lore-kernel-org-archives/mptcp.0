Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38509747B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:19:23 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 195so1848815pgc.6
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ns29R+aBIWI46Woyp30T0xwdAeI/vdijmVz/AvnvuMs=;
        b=kyxbMNd8w1LJxATBPQ6/1Oaj5YdPe+bZvwWTeUM7pKrUhZDj66LQUnDkFKIVSGTj70
         AC9VDGMXRpJ1hKFZf2TSRxJrnQKcV8T5cxxOfnRWi7iDr0Dia+4v5jcizIdMIv3k3AKF
         6Vd37xN/R5wzM3CUjcTY2BxBeLeA9Ztoxj+WJ0dmp/qEnV7bRb45uzHwbbxS78Vem7cz
         y3PyKx5jWzTffRXcmzKUz0Xy/3qaVDW1SLTd2xza5i1QVOx+9M0ZJm900jMWsSRcQ3ir
         AZpY+Y2wKjZV3JZyVTLVsEyiF2JGNsnT8KdVHdKhlF6GsF0Deg0+KIyhnYyXSouu1q/B
         eTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ns29R+aBIWI46Woyp30T0xwdAeI/vdijmVz/AvnvuMs=;
        b=kk5g5AKBMX6E1keAb5RuWR6Vskg4yqCFL6Rt4jvMYW3j3ps1HZRZJGbN75fk748QEp
         Zz0NUnvH4eJ6RsIDjce55DLh+JvEqBxxNWMlplJvvWQVlMfVDP8qxyFIlqtjMw6aqi+e
         p96bYiNxCBj5OP3UrB0col+YSMDmAue6S0Cdom/p06N2VnJqKfOqPRw6pfw2RDJ3SVjo
         42Fqek9BURepdeq7MEzVRRXo49KmLwkVlgWinw3o2hSsYPL6gntI5MN0UAX28yHiWDQV
         JKnxco1vPkh+SZFcL5tjwAla3oSjkY2RTVgHbJ+XkLeY/9+E87D90xvLAtypAVTU99nc
         hc+Q==
X-Gm-Message-State: AOAM532HoUyGnzXC9SBUDQQmrmRHidWzkDGGkTh/D1fYpcYlkfCTQvCz
	L5LzjBEglUtNZ4Zw8rY6eugWkWwMXGFzR5AaVaA=
X-Google-Smtp-Source: ABdhPJy/gFdZlU+S7UaAgcnmxict0WXuNqTAYgIJ8WEs3NfqVhNj6LHHHIUV9elr/xWaCnJ4RvL6iwQHsgjq3XAyoPQ=
X-Received: by 2002:a05:6a00:809:b0:4f1:14bb:40b1 with SMTP id
 m9-20020a056a00080900b004f114bb40b1mr3121178pfk.69.1645712362574; Thu, 24 Feb
 2022 06:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net> <20220224135619.2523272-9-matthieu.baerts@tessares.net>
In-Reply-To: <20220224135619.2523272-9-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:19:57 +0800
Message-ID: <CA+WQbwsZT-eHu_OLF06S0qEHZC3YdF7iPPVmhMo7cizD_VRM5Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 08/12] selftests: mptcp: join: list failure
 at the end
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 21:56=E5=86=99=E9=81=93=EF=BC=9A
>
> With ~100 tests, it helps to have this summary at the end not to scroll
> to find which one has failed.
>
> It is especially interseting when looking at the output produced by the
> CI where the kernel logs from the serial are mixed together.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 89 ++++++++++++-------
>  1 file changed, 57 insertions(+), 32 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index c12b1baef29e..b07cbf1a80ca 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -22,6 +22,7 @@ init=3D0
>  declare -A all_tests
>  declare -a only_tests_ids
>  declare -a only_tests_names
> +declare -A failed_tests
>  TEST_COUNT=3D0
>  TEST_NAME=3D""
>  nr_blank=3D40
> @@ -302,6 +303,21 @@ reset_with_fail()
>                 index 100 || exit 1
>  }
>
> +fail_test()
> +{
> +       ret=3D1
> +       failed_tests[${TEST_COUNT}]=3D"${TEST_NAME}"
> +}
> +
> +get_failed_tests_ids()
> +{
> +       # sorted
> +       local i
> +       for i in "${!failed_tests[@]}"; do
> +               echo "${i}"
> +       done | sort -n
> +}
> +
>  print_file_err()
>  {
>         ls -l "$1" 1>&2
> @@ -323,7 +339,7 @@ check_transfer()
>                         echo "[ FAIL ] $what does not match (in, out):"
>                         print_file_err "$in"
>                         print_file_err "$out"
> -                       ret=3D1
> +                       fail_test
>
>                         return 1
>                 else
> @@ -343,7 +359,7 @@ do_ping()
>         ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/nu=
ll
>         if [ $? -ne 0 ] ; then
>                 echo "$listener_ns -> $connect_addr connectivity [ FAIL ]=
" 1>&2
> -               ret=3D1
> +               fail_test
>         fi
>  }
>
> @@ -588,7 +604,7 @@ pm_nl_check_endpoint()
>                 echo "[ ok ]"
>         else
>                 echo "[fail] expected '$expected_line' found '$line'"
> -               ret=3D1
> +               fail_test
>         fi
>  }
>
> @@ -842,7 +858,7 @@ do_transfer()
>                 cat /tmp/${connector_ns}.out
>
>                 cat "$capout"
> -               ret=3D1
> +               fail_test
>                 return 1
>         fi
>
> @@ -974,7 +990,7 @@ chk_csum_nr()
>         if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] |=
|
>            [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; t=
hen
>                 echo "[fail] got $count data checksum error[s] expected $=
csum_ns1"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -985,7 +1001,7 @@ chk_csum_nr()
>         if [ "$count" !=3D $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] |=
|
>            [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; t=
hen
>                 echo "[fail] got $count data checksum error[s] expected $=
csum_ns2"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1005,7 +1021,7 @@ chk_fail_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$fail_tx" ]; then
>                 echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1016,7 +1032,7 @@ chk_fail_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$fail_rx" ]; then
>                 echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1037,7 +1053,7 @@ chk_fclose_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$fclose_tx" ]; then
>                 echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclo=
se_tx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1048,7 +1064,7 @@ chk_fclose_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$fclose_rx" ]; then
>                 echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclo=
se_rx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1079,7 +1095,7 @@ chk_rst_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$rst_tx" ]; then
>                 echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1090,7 +1106,7 @@ chk_rst_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$rst_rx" ]; then
>                 echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1113,7 +1129,7 @@ chk_infi_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$infi_tx" ]; then
>                 echo "[fail] got $count infinite map[s] TX expected $infi=
_tx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1124,7 +1140,7 @@ chk_infi_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$infi_rx" ]; then
>                 echo "[fail] got $count infinite map[s] RX expected $infi=
_rx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1158,7 +1174,7 @@ chk_join_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$syn_nr" ]; then
>                 echo "[fail] got $count JOIN[s] syn expected $syn_nr"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1176,7 +1192,7 @@ chk_join_nr()
>                         echo -n "[ ok ]"
>                 else
>                         echo "[fail] got $count JOIN[s] synack expected $=
syn_ack_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 fi
>         else
> @@ -1188,7 +1204,7 @@ chk_join_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$ack_nr" ]; then
>                 echo "[fail] got $count JOIN[s] ack expected $ack_nr"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1229,7 +1245,7 @@ chk_stale_nr()
>                 echo "[fail] got $stale_nr stale[s] $recover_nr recover[s=
], " \
>                      " expected stale in range [$stale_min..$stale_max],"=
 \
>                      " stale-recover delta $stale_delta "
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1266,7 +1282,7 @@ chk_add_nr()
>         # add addrs options, due to retransmissions
>         if [ "$count" !=3D "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" =
-lt "$add_nr" ]; then
>                 echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1277,7 +1293,7 @@ chk_add_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$echo_nr" ]; then
>                 echo "[fail] got $count ADD_ADDR echo[s] expected $echo_n=
r"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1289,7 +1305,7 @@ chk_add_nr()
>                 [ -z "$count" ] && count=3D0
>                 if [ "$count" !=3D "$port_nr" ]; then
>                         echo "[fail] got $count ADD_ADDR[s] with a port-n=
umber expected $port_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo "[ ok ]"
> @@ -1302,7 +1318,7 @@ chk_add_nr()
>                 if [ "$count" !=3D "$syn_nr" ]; then
>                         echo "[fail] got $count JOIN[s] syn with a differ=
ent \
>                                 port-number expected $syn_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo -n "[ ok ]"
> @@ -1315,7 +1331,7 @@ chk_add_nr()
>                 if [ "$count" !=3D "$syn_ack_nr" ]; then
>                         echo "[fail] got $count JOIN[s] synack with a dif=
ferent \
>                                 port-number expected $syn_ack_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo -n "[ ok ]"
> @@ -1328,7 +1344,7 @@ chk_add_nr()
>                 if [ "$count" !=3D "$ack_nr" ]; then
>                         echo "[fail] got $count JOIN[s] ack with a differ=
ent \
>                                 port-number expected $ack_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo "[ ok ]"
> @@ -1341,7 +1357,7 @@ chk_add_nr()
>                 if [ "$count" !=3D "$mis_syn_nr" ]; then
>                         echo "[fail] got $count JOIN[s] syn with a mismat=
ched \
>                                 port-number expected $mis_syn_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo -n "[ ok ]"
> @@ -1354,7 +1370,7 @@ chk_add_nr()
>                 if [ "$count" !=3D "$mis_ack_nr" ]; then
>                         echo "[fail] got $count JOIN[s] ack with a mismat=
ched \
>                                 port-number expected $mis_ack_nr"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 else
>                         echo "[ ok ]"
> @@ -1399,7 +1415,7 @@ chk_rm_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$rm_addr_nr" ]; then
>                 echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1422,14 +1438,14 @@ chk_rm_nr()
>                         echo "[ ok ] $suffix"
>                 else
>                         echo "[fail] got $count RM_SUBFLOW[s] expected in=
 range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
> -                       ret=3D1
> +                       fail_test
>                         dump_stats=3D1
>                 fi
>                 return
>         fi
>         if [ "$count" !=3D "$rm_subflow_nr" ]; then
>                 echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflo=
w_nr"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1452,7 +1468,7 @@ chk_prio_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
>                 echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_n=
r_tx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo -n "[ ok ]"
> @@ -1463,7 +1479,7 @@ chk_prio_nr()
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$mp_prio_nr_rx" ]; then
>                 echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_n=
r_rx"
> -               ret=3D1
> +               fail_test
>                 dump_stats=3D1
>         else
>                 echo "[ ok ]"
> @@ -1487,7 +1503,7 @@ chk_link_usage()
>         if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
>              $tx_rate -gt $((expected_rate + $tolerance)) ]; then
>                 echo "[fail] got $tx_rate% usage, expected $expected_rate=
%"
> -               ret=3D1
> +               fail_test
>         else
>                 echo "[ ok ]"
>         fi
> @@ -2806,4 +2822,13 @@ for subtests in "${tests[@]}"; do
>         "${subtests}"
>  done
>
> +if [ ${ret} -ne 0 ]; then
> +       echo
> +       echo "${#failed_tests[@]} failure(s) has(ve) been detected:"

How about using:

        echo -e "\n${#failed_tests[@]} failure(s) has(ve) been detected:"

> +       for i in $(get_failed_tests_ids); do
> +               echo -e "\t- ${i}: ${failed_tests[${i}]}"
> +       done
> +       echo
> +fi
> +
>  exit $ret
> --
> 2.34.1
>
>
