Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9629CA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 06:51:12 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d18so5068252plg.2
        for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yyqC5hS/w2GbnWbl4RFGkeJW4+F3a+D4dfQMmx2Ceoo=;
        b=SS/gDTUfia9zhvmqUrwpapBSwi/BzXBKsSLTdagcUmOyHvm94pTcizwC0DY63sYluZ
         4pGYjWgPlk2cD+Ywut9LIjPEcD9S71jnfYyv/NFyTrENm+EJUuhkVHyhW2c4ULfX0MQ3
         U90vvpaAJzu8QOkzIHjWIEUfXJ01mZklZp8RO8eM8utC+CvJ4kAK/mDcDo9mMPrfge35
         wC6MavJiN8qyZ5Bviq9ijW4s358XZPmZOrRr+/ZYlQ+a1lczKs37JDfw89+wK7TXdEDr
         YFrdlQ7N/GpEmZDb8GmNlnavLJ6G4kvfLoxyWgZBWqtewKIFVt9CzNT8eyf8LR0/CEKK
         Mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yyqC5hS/w2GbnWbl4RFGkeJW4+F3a+D4dfQMmx2Ceoo=;
        b=UMR9fuDdihOTFLjKUmaxii69hbVfbn75BZzbVGN9d76iSVQetq85r90GcQ6UWZ4FGf
         uHvcthMyFO6ZNFj4MPao/DWO5eC/iki8djtld48Kt1Uk8U/3RepUOPf4g+RAyWlDrJ7m
         jNkJwHf2DClL9pGEIer+aNDmRgj64p1JYHdGJnecrVyD+QXUE1QUVFz7ZoywAUxdGa0R
         uvN/cVrPvrC4/S9M3haHI4N+fMcPpfGFZF7BbMrX9G/CcrR6lp9lq4W65kA3V+A63w3c
         cUA5mXtIF0Rxz024E2YQiXO/q++xF5D0t4yyWhAKjH9Bf0CV3gbhqxgb4Od9PuVEmBUl
         GHVA==
X-Gm-Message-State: AOAM533LQS7JMf6JqlwSUYXiyONwX6MCcETVvahTgEw26Ga8qoUMeULY
	hQEHJxTknrrG+hlnNaA7Acq21KDsG5eSWXS1p2zejUKbtON9fGPt
X-Google-Smtp-Source: ABdhPJwOzVuLR93of4NUHopB/V/3W8PNuNZ6pAjqUfrrLQ2XBumlEOQJUnSGyAj2c/IQR49KK2Tiv6XBJsQj+Fgbqp0=
X-Received: by 2002:a17:902:ab43:: with SMTP id ij3mr6990462plb.25.1643352672132;
 Thu, 27 Jan 2022 22:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220128003836.2732694-1-kishen.maloor@intel.com> <20220128003836.2732694-15-kishen.maloor@intel.com>
In-Reply-To: <20220128003836.2732694-15-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 28 Jan 2022 14:51:21 +0800
Message-ID: <CA+WQbwvJOa3iJ8BucsMUPho-=eBQziemvneM_Ld82gOC0f4Zwg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 14/14] selftests: mptcp: functional tests
 for the userspace PM type
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kishen,

This patch will get many checkpatch.pl warnings:

 WARNING: line length of 103 exceeds 100 columns

Thanks,
-Geliang

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 08:39=E5=86=99=E9=81=93=EF=BC=9A
>
> This change adds a selftest script that performs a comprehensive
> behavioral/functional test of all userspace PM capabilities by exercising
> all the newly added APIs and changes to support said capabilities.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v3: configure net.mptcp.userspace_pm_local_addr_max via sysctl on
> the namespaces established for testing, read and verify the new
> "server_side" attribute from netlink events upon connection
> establishment, new test case for sysctl configured local_addr limit,
> added descriptive remarks throughout script
> ---
>  .../selftests/net/mptcp/userspace_pm.sh       | 656 ++++++++++++++++++
>  1 file changed, 656 insertions(+)
>  create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh
>
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/te=
sting/selftests/net/mptcp/userspace_pm.sh
> new file mode 100755
> index 000000000000..cc6c03626c21
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -0,0 +1,656 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ip -Version > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +       echo "SKIP: Cannot not run test without ip tool"
> +       exit 1
> +fi
> +
> +ANNOUNCED=3D6        # MPTCP_EVENT_ANNOUNCED
> +REMOVED=3D7          # MPTCP_EVENT_REMOVED
> +SUB_ESTABLISHED=3D10 # MPTCP_EVENT_SUB_ESTABLISHED
> +SUB_CLOSED=3D11      # MPTCP_EVENT_SUB_CLOSED
> +
> +AF_INET=3D2
> +AF_INET6=3D10
> +
> +evts_pid=3D0
> +client4_pid=3D0
> +server4_pid=3D0
> +client6_pid=3D0
> +server6_pid=3D0
> +client4_token=3D""
> +server4_token=3D""
> +client6_token=3D""
> +server6_token=3D""
> +client4_port=3D0;
> +client6_port=3D0;
> +app4_port=3D50002
> +new4_port=3D50003
> +app6_port=3D50004
> +client_addr_id=3D${RANDOM:0:2}
> +server_addr_id=3D${RANDOM:0:2}
> +
> +sec=3D$(date +%s)
> +rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
> +ns1=3D"ns1-$rndh"
> +ns2=3D"ns2-$rndh"
> +
> +cleanup()
> +{
> +       echo "cleanup"
> +
> +       # Terminate the MPTCP connection and related processes
> +       kill -SIGUSR1 $client4_pid > /dev/null 2>&1
> +       kill $server4_pid > /dev/null 2>&1
> +       kill -SIGUSR1 $client6_pid > /dev/null 2>&1
> +       kill $server6_pid > /dev/null 2>&1
> +
> +       kill $evts_pid > /dev/null 2>&1
> +
> +       local netns
> +       for netns in "$ns1" "$ns2" ;do
> +               ip netns del $netns
> +       done
> +}
> +
> +trap cleanup EXIT
> +
> +# Create and configure network namespaces for testing
> +for i in "$ns1" "$ns2" ;do
> +       ip netns add $i || exit 1
> +       ip -net $i link set lo up
> +       ip netns exec $i sysctl -q net.mptcp.enabled=3D1
> +       ip netns exec $i sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $i sysctl -q net.mptcp.userspace_pm_local_addr_max=
=3D2
> +done
> +
> +#  "$ns1"              ns2
> +#     ns1eth2    ns2eth1
> +
> +ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth1 netns "$ns2=
"
> +
> +# Add IPv4/v6 addresses to the namespaces
> +ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
> +ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
> +ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
> +ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
> +ip -net "$ns1" link set ns1eth2 up
> +
> +ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
> +ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth1
> +ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
> +ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
> +ip -net "$ns2" link set ns2eth1 up
> +
> +printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
> +
> +make_file()
> +{
> +       # Store a chunk of data in a file to transmit over an MPTCP conne=
ction
> +       local name=3D$1
> +       local who=3D$2
> +       local ksize=3D1
> +
> +       dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$ksize 2> /de=
v/null
> +       echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
> +}
> +
> +make_connection()
> +{
> +       local file=3D$(mktemp)
> +       make_file "$file" "client"
> +
> +       local is_v6=3D$1
> +       local app_port=3D$app4_port
> +       local connect_addr=3D"10.0.1.1"
> +       local listen_addr=3D"0.0.0.0"
> +       if [ "$is_v6" =3D "v6" ]
> +       then
> +               connect_addr=3D"dead:beef:1::1"
> +               listen_addr=3D"::"
> +               app_port=3D$app6_port
> +       else
> +               is_v6=3D"v4"
> +       fi
> +
> +       # Capture netlink events over the two network namespaces running
> +       # the MPTCP client and server
> +       local client_evts=3D$(mktemp)
> +       :>"$client_evts"
> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$client_evts" 2>&1 &
> +       local client_evts_pid=3D$!
> +       local server_evts=3D$(mktemp)
> +       :>"$server_evts"
> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$server_evts" 2>&1 &
> +       local server_evts_pid=3D$!
> +       sleep 0.1
> +
> +       # Run the server
> +       ip netns exec $ns1 \
> +                       ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $=
listen_addr 2>&1 > /dev/null &
> +       local server_pid=3D$!
> +       sleep 0.1
> +
> +       # Run the client, transfer $file and stay connected to the server
> +       # to conduct tests
> +       ip netns exec $ns2 \
> +                       ./mptcp_connect -s MPTCP -w 300 -m sendfile -p $a=
pp_port $connect_addr 2>&1 > /dev/null < $file &
> +       local client_pid=3D$!
> +       sleep 0.1
> +
> +       # Capture client/server attributes from MPTCP connection netlink =
events
> +       kill $client_evts_pid
> +       local client_token=3D$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/=
\2/p;q' "$client_evts")
> +       local client_port=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\=
2/p;q' "$client_evts")
> +       local client_serverside=3D$(sed -n 's/.*\(server_side:\)\([[:digi=
t:]]*\).*$/\2/p;q' "$client_evts")
> +
> +       kill $server_evts_pid
> +       local server_token=3D$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/=
\2/p;q' "$server_evts")
> +       local server_serverside=3D$(sed -n 's/.*\(server_side:\)\([[:digi=
t:]]*\).*$/\2/p;q' "$server_evts")
> +
> +       rm -f "$client_evts" "$server_evts" "$file"
> +
> +       if [ $client_token !=3D "" ] && [ $server_token !=3D "" ] && [ $c=
lient_serverside =3D 0 ] && [ $server_serverside =3D 1 ]
> +       then
> +               printf "Established IP%s MPTCP Connection ns2 =3D> ns1   =
 \t\t[OK]\n" $is_v6
> +       else
> +               exit 1
> +       fi
> +
> +       if [ "$is_v6" =3D "v6" ]
> +       then
> +               client6_token=3D$client_token
> +               server6_token=3D$server_token
> +               client6_port=3D$client_port
> +               client6_pid=3D$client_pid
> +               server6_pid=3D$server_pid
> +       else
> +               client4_token=3D$client_token
> +               server4_token=3D$server_token
> +               client4_port=3D$client_port
> +               client4_pid=3D$client_pid
> +               server4_pid=3D$server_pid
> +       fi
> +}
> +
> +verify_announce_event()
> +{
> +       local evt=3D$1
> +       local e_type=3D$2
> +       local e_token=3D$3
> +       local e_addr=3D$4
> +       local e_id=3D$5
> +       local e_dport=3D$6
> +       local e_af=3D$7
> +
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evt")
> +       local token=3D$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evt")
> +       local addr=3D""
> +       if [ "$e_af" =3D "v6" ]
> +       then
> +               addr=3D$(sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q=
' "$evt")
> +       else
> +               addr=3D$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$=
evt")
> +       fi
> +       local dport=3D$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evt")
> +       local id=3D$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evt")
> +        if [ "$type" =3D "$e_type" ] && [ "$token" =3D "$e_token" ] && [=
 "$addr" =3D "$e_addr" ] && [ "$dport" =3D "$e_dport" ] && [ "$id" =3D "$e_=
id" ]
> +       then
> +               printf "[OK]\n"
> +               return 0
> +       fi
> +       printf "[FAIL]\n"
> +       exit 1
> +}
> +
> +test_announce()
> +{
> +       local evts=3D$(mktemp)
> +       # Capture events on the network namespace running the server
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # ADD_ADDR using an invalid token should result in no action
> +       local invalid_token=3D$(( $client4_token - 1))
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $invalid_token =
id $client_addr_id dev ns2eth1 2>&1 > /dev/null
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evts")
> +       printf "ADD_ADDR 10.0.2.2 (ns2) =3D> ns1, invalid token    \t\t"
> +        if [ "$type" =3D "" ]
> +       then
> +               printf "[OK]\n"
> +       else
> +               printf "[FAIL]\n"
> +               exit 1
> +       fi
> +
> +       # ADD_ADDR from the client to server machine reusing the subflow =
port
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id dev ns2eth1 2>&1 > /dev/null
> +       printf "ADD_ADDR id:%d 10.0.2.2 (ns2) =3D> ns1, reuse port \t\t" =
$client_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0=
.2.2" "$client_addr_id" "$client4_port"
> +
> +       # ADD_ADDR6 from the client to server machine reusing the subflow=
 port
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl ann dead:beef:2::2 token $client6_=
token id $client_addr_id dev ns2eth1 2>&1 > /dev/null
> +       printf "ADD_ADDR6 id:%d dead:beef:2::2 (ns2) =3D> ns1, reuse port=
\t\t" $client_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$server6_token" "dead=
:beef:2::2" "$client_addr_id" "$client6_port" "v6"
> +
> +       # ADD_ADDR from the client to server machine using a new port
> +       :>"$evts"
> +       client_addr_id=3D$((client_addr_id+1))
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id dev ns2eth1 port $new4_port 2>&1 > /dev/null
> +       printf "ADD_ADDR id:%d 10.0.2.2 (ns2) =3D> ns1, new port \t\t\t" =
$client_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0=
.2.2" "$client_addr_id" "$new4_port"
> +
> +       kill $evts_pid
> +
> +       # Capture events on the network namespace running the client
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # ADD_ADDR from the server to client machine reusing the subflow =
port
> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token =
id $server_addr_id dev ns1eth2 2>&1 > /dev/null
> +       printf "ADD_ADDR id:%d 10.0.2.1 (ns1) =3D> ns2, reuse port \t\t" =
$server_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0=
.2.1" "$server_addr_id" "$app4_port"
> +
> +       # ADD_ADDR6 from the server to client machine reusing the subflow=
 port
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl ann dead:beef:2::1 token $server6_=
token id $server_addr_id dev ns1eth2 2>&1 > /dev/null
> +       printf "ADD_ADDR6 id:%d dead:beef:2::1 (ns1) =3D> ns2, reuse port=
\t\t" $server_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$client6_token" "dead=
:beef:2::1" "$server_addr_id" "$app6_port" "v6"
> +
> +       # ADD_ADDR from the server to client machine using a new port
> +       :>"$evts"
> +       server_addr_id=3D$((server_addr_id+1))
> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token =
id $server_addr_id dev ns1eth2 port $new4_port 2>&1 > /dev/null
> +       printf "ADD_ADDR id:%d 10.0.2.1 (ns1) =3D> ns2, new port \t\t\t" =
$server_addr_id
> +       sleep 0.1
> +       verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0=
.2.1" "$server_addr_id" "$new4_port"
> +
> +       kill $evts_pid
> +       rm -f "$evts"
> +}
> +
> +verify_remove_event()
> +{
> +       local evt=3D$1
> +       local e_type=3D$2
> +       local e_token=3D$3
> +       local e_id=3D$4
> +
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evt")
> +       local token=3D$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evt")
> +       local id=3D$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evt")
> +        if [ "$type" =3D "$e_type" ] && [ "$token" =3D "$e_token" ] && [=
 "$id" =3D "$e_id" ]
> +       then
> +               printf "[OK]\n"
> +               return 0
> +       fi
> +       printf "[FAIL]\n"
> +       exit 1
> +}
> +
> +test_remove()
> +{
> +       local evts=3D$(mktemp)
> +
> +       # Capture events on the network namespace running the server
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # RM_ADDR using an invalid token should result in no action
> +       local invalid_token=3D$(( $client4_token - 1 ))
> +       ip netns exec $ns2 ./pm_nl_ctl rem token $invalid_token id $clien=
t_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns2 =3D> ns1, invalid token                =
    \t" $client_addr_id
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evts")
> +       if [ "$type" =3D "" ]
> +       then
> +               printf "[OK]\n"
> +       else
> +               printf "[FAIL]\n"
> +       fi
> +
> +       # RM_ADDR using an invalid addr id should result in no action
> +       local invalid_id=3D$(( $client_addr_id + 1 ))
> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $inval=
id_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns2 =3D> ns1, invalid id                   =
 \t" $invalid_id
> +       type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts"=
)
> +       if [ "$type" =3D "" ]
> +       then
> +               printf "[OK]\n"
> +       else
> +               printf "[FAIL]\n"
> +       fi
> +
> +       # RM_ADDR from the client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $clien=
t_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns2 =3D> ns1                               =
 \t" $client_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_=
addr_id"
> +
> +       # RM_ADDR from the client to server machine
> +       :>"$evts"
> +       client_addr_id=3D$(( $client_addr_id - 1 ))
> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $clien=
t_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns2 =3D> ns1                               =
 \t" $client_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_=
addr_id"
> +
> +       # RM_ADDR6 from the client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client6_token id $clien=
t_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR6 id:%d ns2 =3D> ns1                              =
 \t" $client_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_=
addr_id"
> +
> +       kill $evts_pid
> +
> +       # Capture events on the network namespace running the client
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # RM_ADDR from the server to client machine
> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server4_token id $serve=
r_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns1 =3D> ns2                               =
 \t" $server_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_=
addr_id"
> +
> +       # RM_ADDR from the server to client machine
> +       :>"$evts"
> +       server_addr_id=3D$(( $server_addr_id - 1 ))
> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server4_token id $serve=
r_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR id:%d ns1 =3D> ns2                               =
 \t" $server_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_=
addr_id"
> +
> +       # RM_ADDR6 from the server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server6_token id $serve=
r_addr_id 2>&1 > /dev/null
> +       printf "RM_ADDR6 id:%d ns1 =3D> ns2                              =
 \t" $server_addr_id
> +       sleep 0.1
> +       verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_=
addr_id"
> +
> +       kill $evts_pid
> +       rm -f "$evts"
> +}
> +
> +verify_subflow_events()
> +{
> +       local evt=3D$1
> +       local e_type=3D$2
> +       local e_token=3D$3
> +       local e_family=3D$4
> +       local e_saddr=3D$5
> +       local e_daddr=3D$6
> +       local e_dport=3D$7
> +       local e_locid=3D$8
> +       local e_remid=3D$9
> +       shift 2
> +       local e_from=3D$8
> +       local e_to=3D$9
> +
> +       if [ "$e_type" =3D "$SUB_ESTABLISHED" ]
> +       then
> +               if [ "$e_family" =3D "$AF_INET6" ]
> +               then
> +                       printf "CREATE_SUBFLOW6 %s (%s) =3D> %s (%s)    "=
 $e_saddr $e_from $e_daddr $e_to
> +               else
> +                       printf "CREATE_SUBFLOW %s (%s) =3D> %s (%s)      =
   \t" $e_saddr $e_from $e_daddr $e_to
> +               fi
> +       else
> +               if [ "$e_family" =3D "$AF_INET6" ]
> +               then
> +                       printf "DESTROY_SUBFLOW6 %s (%s) =3D> %s (%s)   "=
 $e_saddr $e_from $e_daddr $e_to
> +               else
> +                       printf "DESTROY_SUBFLOW %s (%s) =3D> %s (%s)     =
    \t" $e_saddr $e_from $e_daddr $e_to
> +               fi
> +       fi
> +
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evt")
> +       local token=3D$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evt")
> +       local family=3D$(sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;=
q' "$evt")
> +       local dport=3D$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evt")
> +       local locid=3D$(sed -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q=
' "$evt")
> +       local remid=3D$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q=
' "$evt")
> +       local saddr=3D""
> +       local daddr=3D""
> +       if [ "$family" =3D "$AF_INET6" ]
> +       then
> +               saddr=3D$(sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;=
q' "$evt")
> +               daddr=3D$(sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;=
q' "$evt")
> +       else
> +               saddr=3D$(sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "=
$evt")
> +               daddr=3D$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "=
$evt")
> +       fi
> +
> +        if [ "$type" =3D "$e_type" ] && [ "$token" =3D "$e_token" ] && [=
 "$daddr" =3D "$e_daddr" ] && [ "$e_dport" =3D "$dport" ] && [ "$family" =
=3D "$e_family" ] && [ "$saddr" =3D "$e_saddr" ] && [ "$e_locid" =3D "$loci=
d" ] && [ "$e_remid" =3D "$remid" ]
> +       then
> +               printf "[OK]\n"
> +               return 0
> +       fi
> +       printf "[FAIL]\n"
> +       exit 1
> +}
> +
> +test_subflows()
> +{
> +       local evts=3D$(mktemp)
> +       # Capture events on the network namespace running the server
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # ADD_ADDR from client to server machine reusing the subflow port
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2=
.2 rport $client4_port token $server4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token"=
 "$AF_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" "$client_addr_id" "n=
s1" "ns2"
> +
> +       local sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evts")
> +
> +       # DESTROY_SUBFLOW from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip 10.0.2.1 lport $sport rip =
10.0.2.2 rport $client4_port token $server4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF=
_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "=
ns2"
> +
> +       # RM_ADDR from client to server machine
> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $clie=
nt4_token 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # ADD_ADDR6 from client to server machine reusing the subflow por=
t
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl ann dead:beef:2::2 token $client6_=
token id $client_addr_id 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW6 from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip =
dead:beef:2::2 rport $client6_port token $server6_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server6_token"=
 "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23" "$clien=
t_addr_id" "ns1" "ns2"
> +
> +       local sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evts")
> +
> +       # DESTROY_SUBFLOW6 from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip dead:beef:2::1 lport $spor=
t rip dead:beef:2::2 rport $client6_port token $server6_token 2>&1 > /dev/n=
ull
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server6_token" "$AF=
_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23" "$client_add=
r_id" "ns1" "ns2"
> +
> +       # RM_ADDR from client to server machine
> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $clie=
nt6_token 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # ADD_ADDR from client to server machine using a new port
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id port $new4_port 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2=
.2 rport $new4_port token $server4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token"=
 "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1"=
 "ns2"
> +
> +        sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$ev=
ts")
> +
> +       # DESTROY_SUBFLOW from server to client machine
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip 10.0.2.1 lport $sport rip =
10.0.2.2 rport $new4_port token $server4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF=
_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2=
"
> +
> +       # RM_ADDR from client to server machine
> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $clie=
nt4_token 2>&1 > /dev/null
> +
> +       kill $evts_pid
> +
> +       # Capture events on the network namespace running the client
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       # ADD_ADDR from server to client machine reusing the subflow port
> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token =
id $server_addr_id 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2=
.1 rport $app4_port token $client4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token"=
 "$AF_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2"=
 "ns1"
> +
> +        sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$ev=
ts")
> +
> +       # DESTROY_SUBFLOW from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.2.2 lport $sport rip =
10.0.2.1 rport $app4_port token $client4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF=
_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1=
"
> +
> +       # RM_ADDR from server to client machine
> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $serv=
er4_token 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # ADD_ADDR6 from server to client machine reusing the subflow por=
t
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl ann dead:beef:2::1 token $server6_=
token id $server_addr_id 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW6 from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip =
dead:beef:2::1 rport $app6_port token $client6_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client6_token"=
 "$AF_INET6" "dead:beef:2::2" "dead:beef:2::1" "$app6_port" "23" "$server_a=
ddr_id" "ns2" "ns1"
> +
> +       local sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q'=
 "$evts")
> +
> +       # DESTROY_SUBFLOW6 from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip dead:beef:2::2 lport $spor=
t rip dead:beef:2::1 rport $app6_port token $client6_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client6_token" "$AF=
_INET6" "dead:beef:2::2" "dead:beef:2::1" "$app6_port" "23" "$server_addr_i=
d" "ns2" "ns1"
> +
> +       # RM_ADDR6 from server to client machine
> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $serv=
er6_token 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # ADD_ADDR from client to server machine using a new port
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token =
id $server_addr_id port $new4_port 2>&1 > /dev/null
> +       sleep 0.1
> +
> +       # CREATE_SUBFLOW from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2=
.1 rport $new4_port token $client4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token"=
 "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2"=
 "ns1"
> +
> +        sport=3D$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$ev=
ts")
> +
> +       # DESTROY_SUBFLOW from client to server machine
> +       :>"$evts"
> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.2.2 lport $sport rip =
10.0.2.1 rport $new4_port token $client4_token 2>&1 > /dev/null
> +       sleep 0.1
> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF=
_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1=
"
> +
> +       # RM_ADDR from server to client machine
> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $serv=
er4_token 2>&1 > /dev/null
> +
> +       kill $evts_pid
> +       rm -f "$evts"
> +}
> +
> +test_local_addr_limit()
> +{
> +       printf "Test sysctl: net.mptcp.userspace_pm_local_addr_max=3D1\t\=
t"
> +       # Limit the # of local addrs for both namespaces to 1
> +       for i in "$ns1" "$ns2" ;do
> +               ip netns exec $i sysctl -q net.mptcp.userspace_pm_local_a=
ddr_max=3D1
> +       done
> +
> +       local evts=3D$(mktemp)
> +       # Capture events from the network namespace running the server
> +       :>"$evts"
> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
> +       evts_pid=3D$!
> +       sleep 0.1
> +
> +       :>"$evts"
> +       # ADD_ADDR from the client to server machine -> success
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id dev ns2eth1 2>&1 > /dev/nulls
> +       sleep 0.1
> +       local type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "=
$evts")
> +        if [ "$type" =3D "" ]
> +       then
> +               printf "[FAIL]\n"
> +               exit 1
> +       fi
> +
> +       :>"$evts"
> +       # ADD_ADDR from the client to server machine -> fail (limit alrea=
dy met)
> +       client_addr_id=3D$((client_addr_id+1))
> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token =
id $client_addr_id dev ns2eth1 port $new4_port 2>&1 > /dev/null
> +       sleep 0.1
> +       type=3D$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts"=
)
> +        if [ "$type" =3D "" ]
> +       then
> +               printf "[OK]\n"
> +       else
> +               printf "[FAIL]\n"
> +               exit 1
> +       fi
> +
> +       kill $evts_pid
> +       rm -f "$evts"
> +}
> +
> +make_connection
> +make_connection "v6"
> +test_announce
> +test_remove
> +test_subflows
> +test_local_addr_limit
> +exit 0
> --
> 2.31.1
>
>
