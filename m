Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F97A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:33:52 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 132so1881467pga.5
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QmQDN5CXQqWKBYmsIhHNZY9S2IR4jJPiTfTrVu+BrVs=;
        b=UIyAqFXfxln2oXPLU0BZ4wfgqQQwBnpsamQ9Q5nNYJa1B6fLaaAoo8hA80CDHFVQfu
         S9qmc1PqOPsUBIg/6yz809xssvZwCkRls5KDpVPtGtUh8wIvm4yA9Y3cm/Kt/KH+rPiu
         uycdO7t7r6+en3aTTfFN8bkI/OfTg4tfcxVK2ulU2dnw6ufF/TI1UhGb5Z5zippbEWov
         UoUtSlw8ySKpSuUD/7w2FMYL8/U6BbXmbhYsYiyQOqiHnR6RQr+dejA0vBGA26HSiyoO
         +VpHCWacHLgOtNaksq1wqn61gTlYvfgNfrv/PdLIqfrp52wIAbVHWrG1woQIjYYldon9
         dP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QmQDN5CXQqWKBYmsIhHNZY9S2IR4jJPiTfTrVu+BrVs=;
        b=hqEUaVcrxtbsAW0QG0IW5fI+Spys0ZAte8Q0L6uVTMUfaFgNYD/76aI2x+SkQfYbRa
         7Rwlebfo+qG6CuOZrkAl/N92hjPBtFW/pbcaqmuzDRNy1tlK7sfaMy2nlpK8US0+/ws2
         53ii/Z9KhcVzoHfcgSSBk4bFc565Eyj+Kb7utrOtDxPQcuQoGqNEz4rCWWG6mrblOtH8
         L46kJIWSMpSFtMZjl4ug+HblMUqygxWKpT1K1XiakHSvUqcPW+bOEb/Zi8TMZgL1Y/HF
         XwHCO9qgZpmV2rc3n+8OZ1xduGR/2AngRZDVwLYL0b8p3vZtpFX6bNPQWwSnl418Ycd6
         rQdQ==
X-Gm-Message-State: AOAM532JEG8wBT8wQMS2Vik9LhZ7kxnBt6CIwgSh2XAbSLya9FBwCKP2
	HmLLtb/AI9ANY+ZV8a3nNx9NTXmZmbhIf1XsbCYDA05oBm/eV0lD
X-Google-Smtp-Source: ABdhPJwAVUIEG4FboNR5NISUoQEF+QVQ/K6lsVRWhWAq0SEaHrabIzBgY6rvCYqKrNUfvZfzIbR01xHuUyLUdtMUuvQ=
X-Received: by 2002:a05:6a02:193:b0:375:65a5:2fcd with SMTP id
 bj19-20020a056a02019300b0037565a52fcdmr2485471pgb.288.1645713232155; Thu, 24
 Feb 2022 06:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net> <20220224135619.2523272-12-matthieu.baerts@tessares.net>
In-Reply-To: <20220224135619.2523272-12-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:34:22 +0800
Message-ID: <CA+WQbwtTtGd18FQ9ndWoMR2dvnD_X7i+PbjuCS6ESFD9yLE4bw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 11/12] selftests: mptcp: join: make it
 shellcheck compliant
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 21:57=E5=86=99=E9=81=93=EF=BC=9A
>
> This fixes a few issues reported by ShellCheck:
>
> - SC2068: Double quote array expansions to avoid re-splitting elements.
> - SC2206: Quote to prevent word splitting/globbing, or split robustly
>           with mapfile or read -a.
> - SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.
> - SC2155: Declare and assign separately to avoid masking return values.
> - SC2162: read without -r will mangle backslashes.
> - SC2219: Instead of 'let expr', prefer (( expr )) .
> - SC2181: Check exit code directly with e.g. 'if mycmd;', not indirectly
>           with $?.
> - SC2236: Use -n instead of ! -z.
> - SC2004: $/${} is unnecessary on arithmetic variables.
> - SC2012: Use find instead of ls to better handle non-alphanumeric
>           filenames.
> - SC2002: Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..'
>           instead.
>
> SC2086 (Double quotes to prevent globbing and word splitting) is ignored
> because it is controlled for the moment and there are too many to
> change.
>
> While at it, also fixed the alignment in one comment.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 126 +++++++++---------
>  1 file changed, 66 insertions(+), 60 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index f61c3804f5e0..20ec31b05990 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1,6 +1,11 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>
> +# Double quotes to prevent globbing and word splitting is recommended in=
 new
> +# code but we accept it, especially because there were too many before h=
aving
> +# address all other issues detected by shellcheck.
> +#shellcheck disable=3DSC2086
> +
>  ret=3D0
>  sin=3D""
>  sinfail=3D""
> @@ -77,7 +82,7 @@ init_partial()
>         validate_checksum=3D$checksum
>         FAILING_LINKS=3D""
>
> -       #  ns1              ns2
> +       #  ns1         ns2
>         # ns1eth1    ns2eth1
>         # ns1eth2    ns2eth2
>         # ns1eth3    ns2eth3
> @@ -339,12 +344,11 @@ check_transfer()
>         local in=3D$1
>         local out=3D$2
>         local what=3D$3
> +       local i a b
>
>         local line
> -       cmp -l "$in" "$out" | while read line; do
> -               local arr=3D($line)
> -
> -               let sum=3D0${arr[1]}+0${arr[2]}
> +       cmp -l "$in" "$out" | while read -r i a b; do
> +               local sum=3D$((0${a} + 0${b}))
>                 if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; the=
n
>                         echo "[ FAIL ] $what does not match (in, out):"
>                         print_file_err "$in"
> @@ -353,7 +357,7 @@ check_transfer()
>
>                         return 1
>                 else
> -                       echo "$what has inverted byte at ${arr[0]}"
> +                       echo "$what has inverted byte at ${i}"
>                 fi
>         done
>
> @@ -366,8 +370,7 @@ do_ping()
>         local connector_ns=3D"$2"
>         local connect_addr=3D"$3"
>
> -       ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/nu=
ll
> -       if [ $? -ne 0 ] ; then
> +       if ! ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/d=
ev/null; then
>                 echo "$listener_ns -> $connect_addr connectivity [ FAIL ]=
" 1>&2
>                 fail_test
>         fi
> @@ -474,26 +477,26 @@ pm_nl_add_endpoint()
>         local nr=3D2
>
>         local p
> -       for p in $@
> +       for p in "${@}"
>         do
>                 if [ $p =3D "flags" ]; then
>                         eval _flags=3D\$"$nr"
> -                       [ ! -z $_flags ]; flags=3D"flags $_flags"
> +                       [ -n "$_flags" ]; flags=3D"flags $_flags"
>                 fi
>                 if [ $p =3D "dev" ]; then
>                         eval _dev=3D\$"$nr"
> -                       [ ! -z $_dev ]; dev=3D"dev $_dev"
> +                       [ -n "$_dev" ]; dev=3D"dev $_dev"
>                 fi
>                 if [ $p =3D "id" ]; then
>                         eval _id=3D\$"$nr"
> -                       [ ! -z $_id ]; id=3D"id $_id"
> +                       [ -n "$_id" ]; id=3D"id $_id"
>                 fi
>                 if [ $p =3D "port" ]; then
>                         eval _port=3D\$"$nr"
> -                       [ ! -z $_port ]; port=3D"port $_port"
> +                       [ -n "$_port" ]; port=3D"port $_port"
>                 fi
>
> -               let nr+=3D1
> +               nr=3D$((nr + 1))
>         done
>
>         if [ $ip_mptcp -eq 1 ]; then
> @@ -572,18 +575,18 @@ pm_nl_check_endpoint()
>         while [ -n "$1" ]; do
>                 if [ $1 =3D "flags" ]; then
>                         _flags=3D$2
> -                       [ ! -z $_flags ]; flags=3D"flags $_flags"
> +                       [ -n "$_flags" ]; flags=3D"flags $_flags"
>                         shift
>                 elif [ $1 =3D "dev" ]; then
> -                       [ ! -z $2 ]; dev=3D"dev $1"
> +                       [ -n "$2" ]; dev=3D"dev $1"
>                         shift
>                 elif [ $1 =3D "id" ]; then
>                         _id=3D$2
> -                       [ ! -z $_id ]; id=3D"id $_id"
> +                       [ -n "$_id" ]; id=3D"id $_id"
>                         shift
>                 elif [ $1 =3D "port" ]; then
>                         _port=3D$2
> -                       [ ! -z $_port ]; port=3D" port $_port"
> +                       [ -n "$_port" ]; port=3D" port $_port"
>                         shift
>                 fi
>
> @@ -713,7 +716,7 @@ do_transfer()
>                                         ./mptcp_connect -t ${timeout_poll=
} -p $port -s ${cl_proto} \
>                                                 $extra_args $connect_addr=
 > "$cout" &
>         else
> -               cat "$cinfail" | tee "$cinsent" | \
> +               tee "$cinsent"< "$cinfail" | \

Here a space is missing before '<'.

>                         timeout ${timeout_test} \
>                                 ip netns exec ${connector_ns} \
>                                         ./mptcp_connect -t ${timeout_poll=
} -p $port -s ${cl_proto} \
> @@ -723,12 +726,13 @@ do_transfer()
>
>         # let the mptcp subflow be established in background before
>         # do endpoint manipulation
> -       [ $addr_nr_ns1 =3D "0" -a $addr_nr_ns2 =3D "0" ] || sleep 1
> +       if [ $addr_nr_ns1 !=3D "0" ] || [ $addr_nr_ns2 !=3D "0" ]; then
> +               sleep 1
> +       fi
>
>         if [ $addr_nr_ns1 -gt 0 ]; then
>                 local counter=3D2
> -               local add_nr_ns1
> -               let add_nr_ns1=3Daddr_nr_ns1
> +               local add_nr_ns1=3D${addr_nr_ns1}
>                 while [ $add_nr_ns1 -gt 0 ]; do
>                         local addr
>                         if is_v6 "${connect_addr}"; then
> @@ -737,21 +741,21 @@ do_transfer()
>                                 addr=3D"10.0.$counter.1"
>                         fi
>                         pm_nl_add_endpoint $ns1 $addr flags signal
> -                       let counter+=3D1
> -                       let add_nr_ns1-=3D1
> +                       counter=3D$((counter + 1))
> +                       add_nr_ns1=3D$((add_nr_ns1 - 1))
>                 done
>         elif [ $addr_nr_ns1 -lt 0 ]; then
> -               local rm_nr_ns1
> -               let rm_nr_ns1=3D-addr_nr_ns1
> +               local rm_nr_ns1=3D$((-addr_nr_ns1))
>                 if [ $rm_nr_ns1 -lt 8 ]; then
>                         local counter=3D0
>                         local line
> -                       pm_nl_show_endpoints ${listener_ns} | while read =
line; do
> +                       pm_nl_show_endpoints ${listener_ns} | while read =
-r line; do
> +                               # shellcheck disable=3DSC2206 # we do wan=
t to split per word
>                                 local arr=3D($line)
>                                 local nr=3D0
>
>                                 local i
> -                               for i in ${arr[@]}; do
> +                               for i in "${arr[@]}"; do
>                                         if [ $i =3D "id" ]; then
>                                                 if [ $counter -eq $rm_nr_=
ns1 ]; then
>                                                         break
> @@ -760,9 +764,9 @@ do_transfer()
>                                                 rm_addr=3D$(rm_addr_count=
 ${connector_ns})
>                                                 pm_nl_del_endpoint ${list=
ener_ns} $id
>                                                 wait_rm_addr ${connector_=
ns} ${rm_addr}
> -                                               let counter+=3D1
> +                                               counter=3D$((counter + 1)=
)
>                                         fi
> -                                       let nr+=3D1
> +                                       nr=3D$((nr + 1))
>                                 done
>                         done
>                 elif [ $rm_nr_ns1 -eq 8 ]; then
> @@ -780,11 +784,10 @@ do_transfer()
>
>         # if newly added endpoints must be deleted, give the background m=
sk
>         # some time to created them
> -       [ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
> +       [ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
>
>         if [ $addr_nr_ns2 -gt 0 ]; then
> -               local add_nr_ns2
> -               let add_nr_ns2=3Daddr_nr_ns2
> +               local add_nr_ns2=3D${addr_nr_ns2}
>                 local counter=3D3
>                 while [ $add_nr_ns2 -gt 0 ]; do
>                         local addr
> @@ -794,20 +797,21 @@ do_transfer()
>                                 addr=3D"10.0.$counter.2"
>                         fi
>                         pm_nl_add_endpoint $ns2 $addr flags $flags
> -                       let counter+=3D1
> -                       let add_nr_ns2-=3D1
> +                       counter=3D$((counter + 1))
> +                       add_nr_ns2=3D$((add_nr_ns2 - 1))
>                 done
>         elif [ $addr_nr_ns2 -lt 0 ]; then
> -               local rm_nr_ns2
> +               local rm_nr_ns2=3D$((-addr_nr_ns2))
>                 if [ $rm_nr_ns2 -lt 8 ]; then
>                         local counter=3D0
>                         local line
> -                       pm_nl_show_endpoints ${connector_ns} | while read=
 line; do
> +                       pm_nl_show_endpoints ${connector_ns} | while read=
 -r line; do
> +                               # shellcheck disable=3DSC2206 # we do wan=
t to split per word
>                                 local arr=3D($line)
>                                 local nr=3D0
>
>                                 local i
> -                               for i in ${arr[@]}; do
> +                               for i in "${arr[@]}"; do
>                                         if [ $i =3D "id" ]; then
>                                                 if [ $counter -eq $rm_nr_=
ns2 ]; then
>                                                         break
> @@ -819,9 +823,9 @@ do_transfer()
>                                                 rm_addr=3D$(rm_addr_count=
 ${listener_ns})
>                                                 pm_nl_del_endpoint ${conn=
ector_ns} $id
>                                                 wait_rm_addr ${listener_n=
s} ${rm_addr}
> -                                               let counter+=3D1
> +                                               counter=3D$((counter + 1)=
)
>                                         fi
> -                                       let nr+=3D1
> +                                       nr=3D$((nr + 1))
>                                 done
>                         done
>                 elif [ $rm_nr_ns2 -eq 8 ]; then
> @@ -837,23 +841,24 @@ do_transfer()
>                 fi
>         fi
>
> -       if [ ! -z $sflags ]; then
> +       if [ -n "${sflags}" ]; then
>                 sleep 1
>
>                 local netns
>                 for netns in "$ns1" "$ns2"; do
>                         local line
> -                       pm_nl_show_endpoints $netns | while read line; do
> +                       pm_nl_show_endpoints $netns | while read -r line;=
 do
> +                               # shellcheck disable=3DSC2206 # we do wan=
t to split per word
>                                 local arr=3D($line)
>                                 local nr=3D0
>                                 local id
>
>                                 local i
> -                               for i in ${arr[@]}; do
> +                               for i in "${arr[@]}"; do
>                                         if [ $i =3D "id" ]; then
>                                                 id=3D${arr[$nr+1]}
>                                         fi
> -                                       let nr+=3D1
> +                                       nr=3D$((nr + 1))
>                                 done
>                                 pm_nl_change_endpoint $netns $id $sflags
>                         done
> @@ -947,14 +952,14 @@ run_tests()
>                 make_file "$cinfail" "client" $size
>         # create the input file for the failure test when
>         # the first failure test run
> -       elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> +       elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
>                 # the client file must be considerably larger
>                 # of the maximum expected cwin value, or the
>                 # link utilization will be not predicable
>                 size=3D$((RANDOM%2))
>                 size=3D$((size+1))
>                 size=3D$((size*8192))
> -               size=3D$((size + ( $RANDOM % 8192) ))
> +               size=3D$((size + ( RANDOM % 8192) ))
>
>                 cinfail=3D$(mktemp)
>                 make_file "$cinfail" "client" $size
> @@ -967,7 +972,7 @@ run_tests()
>                         sinfail=3D$(mktemp)
>                 fi
>                 make_file "$sinfail" "server" $size
> -       elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> +       elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
>                 size=3D$((RANDOM%16))
>                 size=3D$((size+1))
>                 size=3D$((size*2048))
> @@ -1016,8 +1021,8 @@ chk_csum_nr()
>         printf " %-36s %s" "$msg" "sum"
>         count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr=
 | awk '{print $2}')
>         [ -z "$count" ] && count=3D0
> -       if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] |=
|
> -          [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; t=
hen
> +       if { [ "$count" !=3D $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq=
 0 ]; } ||
> +          { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq =
1 ]; }; then
>                 echo "[fail] got $count data checksum error[s] expected $=
csum_ns1"
>                 fail_test
>                 dump_stats=3D1
> @@ -1027,8 +1032,8 @@ chk_csum_nr()
>         echo -n " - csum  "
>         count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr=
 | awk '{print $2}')
>         [ -z "$count" ] && count=3D0
> -       if [ "$count" !=3D $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] |=
|
> -          [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; t=
hen
> +       if { [ "$count" !=3D $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq=
 0 ]; } ||
> +          { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq =
1 ]; }; then
>                 echo "[fail] got $count data checksum error[s] expected $=
csum_ns2"
>                 fail_test
>                 dump_stats=3D1
> @@ -1269,8 +1274,8 @@ chk_stale_nr()
>         [ -z "$recover_nr" ] && recover_nr=3D0
>
>         if [ $stale_nr -lt $stale_min ] ||
> -          [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
> -          [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
> +          { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
> +          [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
>                 echo "[fail] got $stale_nr stale[s] $recover_nr recover[s=
], " \
>                      " expected stale in range [$stale_min..$stale_max],"=
 \
>                      " stale-recover delta $stale_delta "
> @@ -1309,7 +1314,7 @@ chk_add_nr()
>
>         # if the test configured a short timeout tolerate greater then ex=
pected
>         # add addrs options, due to retransmissions
> -       if [ "$count" !=3D "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" =
-lt "$add_nr" ]; then
> +       if [ "$count" !=3D "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$c=
ount" -lt "$add_nr" ]; }; then
>                 echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
>                 fail_test
>                 dump_stats=3D1
> @@ -1454,8 +1459,9 @@ chk_rm_nr()
>         count=3D$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSu=
bflow | awk '{print $2}')
>         [ -z "$count" ] && count=3D0
>         if [ -n "$simult" ]; then
> -               local cnt=3D$(ip netns exec $addr_ns nstat -as | grep MPT=
cpExtRmSubflow | awk '{print $2}')
> -               local suffix
> +               local cnt suffix
> +
> +               cnt=3D$(ip netns exec $addr_ns nstat -as | grep MPTcpExtR=
mSubflow | awk '{print $2}')
>
>                 # in case of simult flush, the subflow removal count on e=
ach side is
>                 # unreliable
> @@ -1526,13 +1532,13 @@ chk_link_usage()
>
>         local tx_link tx_total
>         tx_link=3D$(ip netns exec $ns cat /sys/class/net/$link/statistics=
/tx_bytes)
> -       tx_total=3D$(ls -l $out | awk '{print $5}')
> -       local tx_rate=3D$((tx_link * 100 / $tx_total))
> +       tx_total=3D$(stat --format=3D%s $out)
> +       local tx_rate=3D$((tx_link * 100 / tx_total))
>         local tolerance=3D5
>
>         printf "%-${nr_blank}s %-18s" " " "link usage"
> -       if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
> -            $tx_rate -gt $((expected_rate + $tolerance)) ]; then
> +       if [ $tx_rate -lt $((expected_rate - tolerance)) ] || \
> +          [ $tx_rate -gt $((expected_rate + tolerance)) ]; then
>                 echo "[fail] got $tx_rate% usage, expected $expected_rate=
%"
>                 fail_test
>         else
> --
> 2.34.1
>
>
