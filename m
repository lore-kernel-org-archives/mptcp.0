Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C176ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:34:27 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so6572187pjq.0
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fWC3vVTSYkr8jlIxlheJ1okx95Deu65yMzksU6DSvbU=;
        b=k1HKs0+xNWwXIfw1s23i7X1mhtri2RXXRSPXU3xFAWxwUSShme7H35rzmxLxmBmWlI
         IQndKNRVYN272laed4pazENFMDDpTgGGoe5ZwdZI3IrGP5jN5pUBr3Kti/YrP/t8BAiC
         pVoG3ot9c8BqusvTiHq/nIlOZLiwxMWLG67kXJPdvo9mkcBgB0r3nPIPMsz2wd1jA5Br
         gkbPB5GdDoEGX0mzLGXAasYq4T1GHYkZBJ6WcTxgCIJonw80aAEaZ4jOmWJo0iWuyZhG
         AmmyjRzOgjLkyGxdl2kf6Txig0CTEmm5Zld5Y8wwUgqzMVqnzqPrucIV3qe72L0Ty1I3
         KLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fWC3vVTSYkr8jlIxlheJ1okx95Deu65yMzksU6DSvbU=;
        b=R3h7/M5lXkdtO+Is37MjE/0Ou9IQixdePJCdGVZ5juXjPedksW71iS4n5+LD227z5O
         nckkzTQqtNerMzjJOYyMD9DKKanAoK1EXO5kyrk0bZc+hQC6DiwzJ3cd27X5iUP0Sc05
         NfrcD3/iCstRehfMwtCd5ENUeZmE6dmUdi09HX9IvV452HTMrUm2dwqu/MNELkG321Rf
         zmKDUkn0QFWEu3eDcEZxwnkrFXcgp42qtiRXBUqxKe9jn+o7R72tSSUa4hiaXm2/YLkO
         RNFfp7dQ8wbaTOOI6OKTc4ZL/Po+2YSxUDh6iornkMkDDki3iUPWSF5irygh5PA9bX2E
         ejXg==
X-Gm-Message-State: AOAM533GnN4TE38RUgck7rIDY+mKLzw2cYx8EUWoT8vs1L6ObT6H982v
	DoY5f4N6jyZsoJNhNf4bU6dRGzHsUDBb1MvVN5M=
X-Google-Smtp-Source: ABdhPJxW3n3zsiF6HL33r0Y+HCaeXgEQI3q4HoNwPBWaDKGIeUfJNClrobgLAuSotNnMHki0uISCfbMamhCCZDJ0CIQ=
X-Received: by 2002:a17:902:c443:b0:14f:f74e:ebf0 with SMTP id
 m3-20020a170902c44300b0014ff74eebf0mr4862031plm.171.1645745666360; Thu, 24
 Feb 2022 15:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net> <20220224213406.3127061-8-matthieu.baerts@tessares.net>
In-Reply-To: <20220224213406.3127061-8-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Feb 2022 07:35:01 +0800
Message-ID: <CA+WQbwtO28PtF94xUkqhEymjTSSDa9N=w0=D4abtJWdP4QvOYQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 07/12] selftests: mptcp: join: alt. to exec
 specific tests
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

I just sent a patch named "selftests: mptcp: drop msg argument of
chk_csum_nr" to simplify chk_csum_nr(). It can make this patch easier
too.

Thanks,
-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8825=E6=97=A5=E5=91=A8=E4=BA=94 05:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Running a specific test by giving the ID is often what we want: the CI
> reports an issue with the Nth test, it is reproducible with:
>
>   ./mptcp_join.sh N
>
> But this might not work when there is a need to find which commit has
> introduced a regression making a test unstable: failing from time to
> time. Indeed, a specific test is not attached to one ID: the ID is in
> fact a counter. It means the same test can have a different ID if other
> tests have been added/removed before this unstable one.
>
> Remembering the current test can also help listing failed tests at the
> end.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 491 +++++++++---------
>  1 file changed, 254 insertions(+), 237 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 0ece39f306d2..cd21170fa33e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -20,8 +20,10 @@ validate_checksum=3D0
>  init=3D0
>
>  declare -A all_tests
> -declare -a only_tests
> +declare -a only_tests_ids
> +declare -a only_tests_names
>  TEST_COUNT=3D0
> +TEST_NAME=3D""
>  nr_blank=3D40
>
>  export FAILING_LINKS=3D""
> @@ -153,22 +155,30 @@ cleanup()
>
>  skip_test()
>  {
> -       if [ "${#only_tests[@]}" -eq 0 ]; then
> +       if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]=
}" -eq 0 ]; then
>                 return 1
>         fi
>
>         local i
> -       for i in "${only_tests[@]}"; do
> +       for i in "${only_tests_ids[@]}"; do
>                 if [ "${TEST_COUNT}" -eq "${i}" ]; then
>                         return 1
>                 fi
>         done
> +       for i in "${only_tests_names[@]}"; do
> +               if [ "${TEST_NAME}" =3D "${i}" ]; then
> +                       return 1
> +               fi
> +       done
>
>         return 0
>  }
>
> +# $1: test name
>  reset()
>  {
> +       TEST_NAME=3D"${1}"
> +
>         TEST_COUNT=3D$((TEST_COUNT+1))
>
>         if skip_test; then
> @@ -186,27 +196,29 @@ reset()
>         return 0
>  }
>
> +# $1: test name
>  reset_with_cookies()
>  {
> -       reset || return 1
> +       reset "${1}" || return 1
>
>         for netns in "$ns1" "$ns2";do
>                 ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=3D=
2
>         done
>  }
>
> +# $1: test name
>  reset_with_add_addr_timeout()
>  {
> -       local ip=3D"${1:-4}"
> +       local ip=3D"${2:-4}"
>         local tables
>
> +       reset "${1}" || return 1
> +
>         tables=3D"iptables"
>         if [ $ip -eq 6 ]; then
>                 tables=3D"ip6tables"
>         fi
>
> -       reset || return 1
> -
>         ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
>         ip netns exec $ns2 $tables -A OUTPUT -p tcp \
>                 -m tcp --tcp-option 30 \
> @@ -215,12 +227,13 @@ reset_with_add_addr_timeout()
>                 -j DROP
>  }
>
> +# $1: test name
>  reset_with_checksum()
>  {
>         local ns1_enable=3D$1
>         local ns2_enable=3D$2
>
> -       reset || return 1
> +       reset "checksum test ${1} ${2}" || return 1
>
>         ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D$ns1_en=
able
>         ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D$ns2_en=
able
> @@ -228,10 +241,10 @@ reset_with_checksum()
>
>  reset_with_allow_join_id0()
>  {
> -       local ns1_enable=3D$1
> -       local ns2_enable=3D$2
> +       local ns1_enable=3D$2
> +       local ns2_enable=3D$3
>
> -       reset || return 1
> +       reset "${1}" || return 1
>
>         ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_po=
rt=3D$ns1_enable
>         ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_po=
rt=3D$ns2_enable
> @@ -255,15 +268,15 @@ reset_with_allow_join_id0()
>  # Netfilter is used to mark packets with enough data.
>  reset_with_fail()
>  {
> -       reset || return 1
> +       reset "${1}" || return 1
>
>         ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
>         ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
>
>         check_invert=3D1
>         validate_checksum=3D1
> -       local i=3D"$1"
> -       local ip=3D"${2:-4}"
> +       local i=3D"$2"
> +       local ip=3D"${3:-4}"
>         local tables
>
>         tables=3D"iptables"
> @@ -512,7 +525,7 @@ pm_nl_change_endpoint()
>  pm_nl_check_endpoint()
>  {
>         local line expected_line
> -       local title=3D"$1"
> +       local need_title=3D$1
>         local msg=3D"$2"
>         local ns=3D$3
>         local addr=3D$4
> @@ -524,8 +537,8 @@ pm_nl_check_endpoint()
>         local _id
>         local id
>
> -       if [ -n "${title}" ]; then
> -               printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "${msg}=
"
> +       if [ "${need_title}" =3D 1 ]; then
> +               printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${=
msg}"
>         else
>                 printf "%-${nr_blank}s %s" " " "${msg}"
>         fi
> @@ -953,8 +966,9 @@ chk_csum_nr()
>                 csum_ns2=3D${csum_ns2:1}
>         fi
>
> -       if [ ! -z "$msg" ]; then
> +       if [ "${msg}" =3D 1 ]; then
>                 printf "%03u" "$TEST_COUNT"
> +               msg=3D"${TEST_NAME}"
>         else
>                 echo -n "   "
>         fi
> @@ -1125,20 +1139,25 @@ chk_infi_nr()
>
>  chk_join_nr()
>  {
> -       local msg=3D"$1"
> -       local syn_nr=3D$2
> -       local syn_ack_nr=3D$3
> -       local ack_nr=3D$4
> -       local csum_ns1=3D${5:-0}
> -       local csum_ns2=3D${6:-0}
> -       local fail_nr=3D${7:-0}
> -       local rst_nr=3D${8:-0}
> -       local infi_nr=3D${9:-0}
> +       local syn_nr=3D$1
> +       local syn_ack_nr=3D$2
> +       local ack_nr=3D$3
> +       local csum_ns1=3D${4:-0}
> +       local csum_ns2=3D${5:-0}
> +       local fail_nr=3D${6:-0}
> +       local rst_nr=3D${7:-0}
> +       local infi_nr=3D${8:-0}
> +       local corrupted_pkts=3D${9:-0}
>         local count
>         local dump_stats
>         local with_cookie
> +       local title=3D"${TEST_NAME}"
> +
> +       if [ "${corrupted_pkts}" -gt 0 ]; then
> +               title+=3D": ${corrupted_pkts} corrupted pkts"
> +       fi
>
> -       printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
> +       printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
>         count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx =
| awk '{print $2}'`
>         [ -z "$count" ] && count=3D0
>         if [ "$count" !=3D "$syn_nr" ]; then
> @@ -1503,65 +1522,65 @@ set_userspace_pm()
>
>  subflows_tests()
>  {
> -       if reset; then
> +       if reset "no JOIN"; then
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "no JOIN" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # subflow limited by client
> -       if reset; then
> +       if reset "single subflow, limited by client"; then
>                 pm_nl_set_limits $ns1 0 0
>                 pm_nl_set_limits $ns2 0 0
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow, limited by client" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # subflow limited by server
> -       if reset; then
> +       if reset "single subflow, limited by server"; then
>                 pm_nl_set_limits $ns1 0 0
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow, limited by server" 1 1 0
> +               chk_join_nr 1 1 0
>         fi
>
>         # subflow
> -       if reset; then
> +       if reset "single subflow"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # multiple subflows
> -       if reset; then
> +       if reset "multiple subflows"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple subflows" 2 2 2
> +               chk_join_nr 2 2 2
>         fi
>
>         # multiple subflows limited by server
> -       if reset; then
> +       if reset "multiple subflows, limited by server"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple subflows, limited by server" 2 2 1
> +               chk_join_nr 2 2 1
>         fi
>
>         # single subflow, dev
> -       if reset; then
> +       if reset "single subflow, dev"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth=
3
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow, dev" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>  }
>
> @@ -1569,40 +1588,40 @@ subflows_error_tests()
>  {
>         # If a single subflow is configured, and matches the MPC src
>         # address, no additional subflow should be created
> -       if reset; then
> +       if reset "no MPC reuse with single endpoint"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -               chk_join_nr "no MPC reuse with single endpoint" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # multiple subflows, with subflow creation error
> -       if reset; then
> +       if reset "multi subflows, with failing subflow"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -=
j REJECT
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -               chk_join_nr "multi subflows, with failing subflow" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # multiple subflows, with subflow timeout on MPJ
> -       if reset; then
> +       if reset "multi subflows, with subflow timeout"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -=
j DROP
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -               chk_join_nr "multi subflows, with subflow timeout" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # multiple subflows, check that the endpoint corresponding to
>         # closed subflow (due to reset) is not reused if additional
>         # subflows are added later
> -       if reset; then
> +       if reset "multi subflows, fair usage on close"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> @@ -1616,27 +1635,27 @@ subflows_error_tests()
>
>                 # additional subflow could be created only if the PM sele=
ct
>                 # the later endpoint, skipping the already used one
> -               chk_join_nr "multi subflows, fair usage on close" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>  }
>
>  signal_address_tests()
>  {
>         # add_address, unused
> -       if reset; then
> +       if reset "unused signal address"; then
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "unused signal address" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_add_nr 1 1
>         fi
>
>         # accept and use add_addr
> -       if reset; then
> +       if reset "signal address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
> @@ -1644,54 +1663,54 @@ signal_address_tests()
>         # note: signal address in server ns and local addresses in client=
 ns must
>         # belong to different subnets or one of the listed local address =
could be
>         # used for 'add_addr' subflow
> -       if reset; then
> +       if reset "subflow and signal"; then
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflow and signal" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>         fi
>
>         # accept and use add_addr with additional subflows
> -       if reset; then
> +       if reset "multiple subflows and signal"; then
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple subflows and signal" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>         fi
>
>         # signal addresses
> -       if reset; then
> +       if reset "signal addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal addresses" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 3 3
>         fi
>
>         # signal invalid addresses
> -       if reset; then
> +       if reset "signal invalid addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal invalid addresses" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 3 3
>         fi
>
>         # signal addresses race test
> -       if reset; then
> +       if reset "signal addresses race test"; then
>                 pm_nl_set_limits $ns1 4 4
>                 pm_nl_set_limits $ns2 4 4
>                 pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> @@ -1706,7 +1725,7 @@ signal_address_tests()
>                 # the peer could possibly miss some addr notification, al=
low retransmission
>                 ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=
=3D1
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -               chk_join_nr "signal addresses race test" 3 3 3
> +               chk_join_nr 3 3 3
>
>                 # the server will not signal the address terminating
>                 # the MPC subflow
> @@ -1717,7 +1736,7 @@ signal_address_tests()
>  link_failure_tests()
>  {
>         # accept and use add_addr with additional subflows and link loss
> -       if reset; then
> +       if reset "multiple flows, signal, link failure"; then
>                 # without any b/w limit each veth could spool the packets=
 and get
>                 # them acked at xmit time, so that the corresponding subf=
low will
>                 # have almost always no outstanding pkts, the scheduler w=
ill pick
> @@ -1731,14 +1750,14 @@ link_failure_tests()
>                 pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w
>                 pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflo=
w
>                 run_tests $ns1 $ns2 10.0.1.1 1
> -               chk_join_nr "multiple flows, signal, link failure" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>                 chk_stale_nr $ns2 1 5 1
>         fi
>
>         # accept and use add_addr with additional subflows and link loss
>         # for bidirectional transfer
> -       if reset; then
> +       if reset "multi flows, signal, bidi, link fail"; then
>                 init_shapers
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> @@ -1746,14 +1765,14 @@ link_failure_tests()
>                 pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w
>                 pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflo=
w
>                 run_tests $ns1 $ns2 10.0.1.1 2
> -               chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>                 chk_stale_nr $ns2 1 -1 1
>         fi
>
>         # 2 subflows plus 1 backup subflow with a lossy link, backup
>         # will never be used
> -       if reset; then
> +       if reset "backup subflow unused, link failure"; then
>                 init_shapers
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> @@ -1761,14 +1780,14 @@ link_failure_tests()
>                 FAILING_LINKS=3D"1"
>                 pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w,backup
>                 run_tests $ns1 $ns2 10.0.1.1 1
> -               chk_join_nr "backup subflow unused, link failure" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>                 chk_link_usage $ns2 ns2eth3 $cinsent 0
>         fi
>
>         # 2 lossy links after half transfer, backup will get half of
>         # the traffic
> -       if reset; then
> +       if reset "backup flow used, multi links fail"; then
>                 init_shapers
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> @@ -1776,7 +1795,7 @@ link_failure_tests()
>                 pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w,backup
>                 FAILING_LINKS=3D"1 2"
>                 run_tests $ns1 $ns2 10.0.1.1 1
> -               chk_join_nr "backup flow used, multi links fail" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>                 chk_stale_nr $ns2 2 4 2
>                 chk_link_usage $ns2 ns2eth3 $cinsent 50
> @@ -1784,7 +1803,7 @@ link_failure_tests()
>
>         # use a backup subflow with the first subflow on a lossy link
>         # for bidirectional transfer
> -       if reset; then
> +       if reset "backup flow used, bidi, link failure"; then
>                 init_shapers
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> @@ -1792,7 +1811,7 @@ link_failure_tests()
>                 pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w,backup
>                 FAILING_LINKS=3D"1 2"
>                 run_tests $ns1 $ns2 10.0.1.1 2
> -               chk_join_nr "backup flow used, bidi, link failure" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>                 chk_stale_nr $ns2 1 -1 2
>                 chk_link_usage $ns2 ns2eth3 $cinsent 50
> @@ -1802,44 +1821,44 @@ link_failure_tests()
>  add_addr_timeout_tests()
>  {
>         # add_addr timeout
> -       if reset_with_add_addr_timeout; then
> +       if reset_with_add_addr_timeout "signal address, ADD_ADDR timeout"=
; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -               chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 4 0
>         fi
>
>         # add_addr timeout IPv6
> -       if reset_with_add_addr_timeout 6; then
> +       if reset_with_add_addr_timeout "signal address, ADD_ADDR6 timeout=
" 6; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -               chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 4 0
>         fi
>
>         # signal addresses timeout
> -       if reset_with_add_addr_timeout; then
> +       if reset_with_add_addr_timeout "signal addresses, ADD_ADDR timeou=
t"; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_set_limits $ns2 2 2
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
> -               chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 8 0
>         fi
>
>         # signal invalid addresses timeout
> -       if reset_with_add_addr_timeout; then
> +       if reset_with_add_addr_timeout "invalid address, ADD_ADDR timeout=
"; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_set_limits $ns2 2 2
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
> -               chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 8 0
>         fi
>  }
> @@ -1847,156 +1866,156 @@ add_addr_timeout_tests()
>  remove_tests()
>  {
>         # single subflow, remove
> -       if reset; then
> +       if reset "remove single subflow"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> -               chk_join_nr "remove single subflow" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_rm_nr 1 1
>         fi
>
>         # multiple subflows, remove
> -       if reset; then
> +       if reset "remove multiple subflows"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> -               chk_join_nr "remove multiple subflows" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_rm_nr 2 2
>         fi
>
>         # single address, remove
> -       if reset; then
> +       if reset "remove single address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> -               chk_join_nr "remove single address" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
>         fi
>
>         # subflow and signal, remove
> -       if reset; then
> +       if reset "remove subflow and signal"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> -               chk_join_nr "remove subflow and signal" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1
>         fi
>
>         # subflows and signal, remove
> -       if reset; then
> +       if reset "remove subflows and signal"; then
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> -               chk_join_nr "remove subflows and signal" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>                 chk_rm_nr 2 2
>         fi
>
>         # addresses remove
> -       if reset; then
> +       if reset "remove addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> -               chk_join_nr "remove addresses" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 3 3
>                 chk_rm_nr 3 3 invert
>         fi
>
>         # invalid addresses remove
> -       if reset; then
> +       if reset "remove invalid addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> -               chk_join_nr "remove invalid addresses" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 3 3
>                 chk_rm_nr 3 1 invert
>         fi
>
>         # subflows and signal, flush
> -       if reset; then
> +       if reset "flush subflows and signal"; then
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -               chk_join_nr "flush subflows and signal" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 3 invert simult
>         fi
>
>         # subflows flush
> -       if reset; then
> +       if reset "flush subflows"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_set_limits $ns2 3 3
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -               chk_join_nr "flush subflows" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_rm_nr 0 3 simult
>         fi
>
>         # addresses flush
> -       if reset; then
> +       if reset "flush addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -               chk_join_nr "flush addresses" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 3 3
>                 chk_rm_nr 3 3 invert simult
>         fi
>
>         # invalid addresses flush
> -       if reset; then
> +       if reset "flush invalid addresses"; then
>                 pm_nl_set_limits $ns1 3 3
>                 pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                 pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>                 pm_nl_set_limits $ns2 3 3
>                 run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
> -               chk_join_nr "flush invalid addresses" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 3 3
>                 chk_rm_nr 3 1 invert
>         fi
>
>         # remove id 0 subflow
> -       if reset; then
> +       if reset "remove id 0 subflow"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
> -               chk_join_nr "remove id 0 subflow" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_rm_nr 1 1
>         fi
>
>         # remove id 0 address
> -       if reset; then
> +       if reset "remove id 0 address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
> -               chk_join_nr "remove id 0 address" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
>         fi
> @@ -2005,44 +2024,44 @@ remove_tests()
>  add_tests()
>  {
>         # add single subflow
> -       if reset; then
> +       if reset "add single subflow"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> -               chk_join_nr "add single subflow" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # add signal address
> -       if reset; then
> +       if reset "add signal address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> -               chk_join_nr "add signal address" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # add multiple subflows
> -       if reset; then
> +       if reset "add multiple subflows"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> -               chk_join_nr "add multiple subflows" 2 2 2
> +               chk_join_nr 2 2 2
>         fi
>
>         # add multiple subflows IPv6
> -       if reset; then
> +       if reset "add multiple subflows IPv6"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> -               chk_join_nr "add multiple subflows IPv6" 2 2 2
> +               chk_join_nr 2 2 2
>         fi
>
>         # add multiple addresses IPv6
> -       if reset; then
> +       if reset "add multiple addresses IPv6"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 2 2
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> -               chk_join_nr "add multiple addresses IPv6" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 2 2
>         fi
>  }
> @@ -2050,51 +2069,51 @@ add_tests()
>  ipv6_tests()
>  {
>         # subflow IPv6
> -       if reset; then
> +       if reset "single subflow IPv6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags =
subflow
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -               chk_join_nr "single subflow IPv6" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # add_address, unused IPv6
> -       if reset; then
> +       if reset "unused signal address IPv6"; then
>                 pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -               chk_join_nr "unused signal address IPv6" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_add_nr 1 1
>         fi
>
>         # signal address IPv6
> -       if reset; then
> +       if reset "single address IPv6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -               chk_join_nr "single address IPv6" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # single address IPv6, remove
> -       if reset; then
> +       if reset "remove single address IPv6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> -               chk_join_nr "remove single address IPv6" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
>         fi
>
>         # subflow and signal IPv6, remove
> -       if reset; then
> +       if reset "remove subflow and signal IPv6"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags =
subflow
>                 run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> -               chk_join_nr "remove subflow and signal IPv6" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1
>         fi
> @@ -2103,120 +2122,120 @@ ipv6_tests()
>  v4mapped_tests()
>  {
>         # subflow IPv4-mapped to IPv4-mapped
> -       if reset; then
> +       if reset "single subflow IPv4-mapped"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
>                 run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -               chk_join_nr "single subflow IPv4-mapped" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # signal address IPv4-mapped with IPv4-mapped sk
> -       if reset; then
> +       if reset "signal address IPv4-mapped"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
>                 run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -               chk_join_nr "signal address IPv4-mapped" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # subflow v4-map-v6
> -       if reset; then
> +       if reset "single subflow v4-map-v6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -               chk_join_nr "single subflow v4-map-v6" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # signal address v4-map-v6
> -       if reset; then
> +       if reset "signal address v4-map-v6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -               chk_join_nr "signal address v4-map-v6" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # subflow v6-map-v4
> -       if reset; then
> +       if reset "single subflow v6-map-v4"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow v6-map-v4" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # signal address v6-map-v4
> -       if reset; then
> +       if reset "signal address v6-map-v4"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address v6-map-v4" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # no subflow IPv6 to v4 address
> -       if reset; then
> +       if reset "no JOIN with diff families v4-v6"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # no subflow IPv6 to v4 address even if v6 has a valid v4 at the =
end
> -       if reset; then
> +       if reset "no JOIN with diff families v4-v6-2"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subfl=
ow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # no subflow IPv4 to v6 address, no need to slow down too then
> -       if reset; then
> +       if reset "no JOIN with diff families v6-v4"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 dead:beef:1::1
> -               chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>  }
>
>  backup_tests()
>  {
>         # single subflow, backup
> -       if reset; then
> +       if reset "single subflow, backup"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> -               chk_join_nr "single subflow, backup" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_prio_nr 0 1
>         fi
>
>         # single address, backup
> -       if reset; then
> +       if reset "single address, backup"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -               chk_join_nr "single address, backup" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_prio_nr 1 1
>         fi
>
>         # single address with port, backup
> -       if reset; then
> +       if reset "single address with port, backup"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -               chk_join_nr "single address with port, backup" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_prio_nr 1 1
>         fi
> @@ -2225,81 +2244,81 @@ backup_tests()
>  add_addr_ports_tests()
>  {
>         # signal address with port
> -       if reset; then
> +       if reset "signal address with port"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address with port" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1 1
>         fi
>
>         # subflow and signal with port
> -       if reset; then
> +       if reset "subflow and signal with port"; then
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflow and signal with port" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1 1
>         fi
>
>         # single address with port, remove
> -       if reset; then
> +       if reset "remove single address with port"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> -               chk_join_nr "remove single address with port" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1 1
>                 chk_rm_nr 1 1 invert
>         fi
>
>         # subflow and signal with port, remove
> -       if reset; then
> +       if reset "remove subflow and signal with port"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> -               chk_join_nr "remove subflow and signal with port" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1 1
>                 chk_rm_nr 1 1
>         fi
>
>         # subflows and signal with port, flush
> -       if reset; then
> +       if reset "flush subflows and signal with port"; then
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
> -               chk_join_nr "flush subflows and signal with port" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 3 invert simult
>         fi
>
>         # multiple addresses with port
> -       if reset; then
> +       if reset "multiple addresses with port"; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
>                 pm_nl_set_limits $ns2 2 2
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple addresses with port" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 2 2 2
>         fi
>
>         # multiple addresses with ports
> -       if reset; then
> +       if reset "multiple addresses with ports"; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>                 pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
>                 pm_nl_set_limits $ns2 2 2
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple addresses with ports" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 2 2 2
>         fi
>  }
> @@ -2307,64 +2326,64 @@ add_addr_ports_tests()
>  syncookies_tests()
>  {
>         # single subflow, syncookies
> -       if reset_with_cookies; then
> +       if reset_with_cookies "single subflow with syn cookies"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow with syn cookies" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # multiple subflows with syn cookies
> -       if reset_with_cookies; then
> +       if reset_with_cookies "multiple subflows with syn cookies"; then
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "multiple subflows with syn cookies" 2 2 2
> +               chk_join_nr 2 2 2
>         fi
>
>         # multiple subflows limited by server
> -       if reset_with_cookies; then
> +       if reset_with_cookies "subflows limited by server w cookies"; the=
n
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflows limited by server w cookies" 2 1 1
> +               chk_join_nr 2 1 1
>         fi
>
>         # test signal address with cookies
> -       if reset_with_cookies; then
> +       if reset_with_cookies "signal address with syn cookies"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address with syn cookies" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # test cookie with subflow and signal
> -       if reset_with_cookies; then
> +       if reset_with_cookies "subflow and signal w cookies"; then
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 1 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflow and signal w cookies" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_add_nr 1 1
>         fi
>
>         # accept and use add_addr with additional subflows
> -       if reset_with_cookies; then
> +       if reset_with_cookies "subflows and signal w. cookies"; then
>                 pm_nl_set_limits $ns1 0 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflows and signal w. cookies" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>         fi
>  }
> @@ -2376,7 +2395,7 @@ checksum_tests()
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_csum_nr "checksum test 0 0"
> +               chk_csum_nr 1
>         fi
>
>         # checksum test 1 1
> @@ -2384,7 +2403,7 @@ checksum_tests()
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_csum_nr "checksum test 1 1"
> +               chk_csum_nr 1
>         fi
>
>         # checksum test 0 1
> @@ -2392,7 +2411,7 @@ checksum_tests()
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_csum_nr "checksum test 0 1"
> +               chk_csum_nr 1
>         fi
>
>         # checksum test 1 0
> @@ -2400,70 +2419,70 @@ checksum_tests()
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_csum_nr "checksum test 1 0"
> +               chk_csum_nr 1
>         fi
>  }
>
>  deny_join_id0_tests()
>  {
>         # subflow allow join id0 ns1
> -       if reset_with_allow_join_id0 1 0; then
> +       if reset_with_allow_join_id0 "single subflow allow join id0 ns1" =
1 0; then
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow allow join id0 ns1" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>
>         # subflow allow join id0 ns2
> -       if reset_with_allow_join_id0 0 1; then
> +       if reset_with_allow_join_id0 "single subflow allow join id0 ns2" =
0 1; then
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "single subflow allow join id0 ns2" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # signal address allow join id0 ns1
>         # ADD_ADDRs are not affected by allow_join_id0 value.
> -       if reset_with_allow_join_id0 1 0; then
> +       if reset_with_allow_join_id0 "signal address allow join id0 ns1" =
1 0; then
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address allow join id0 ns1" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # signal address allow join id0 ns2
>         # ADD_ADDRs are not affected by allow_join_id0 value.
> -       if reset_with_allow_join_id0 0 1; then
> +       if reset_with_allow_join_id0 "signal address allow join id0 ns2" =
0 1; then
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "signal address allow join id0 ns2" 1 1 1
> +               chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>         fi
>
>         # subflow and address allow join id0 ns1
> -       if reset_with_allow_join_id0 1 0; then
> +       if reset_with_allow_join_id0 "subflow and address allow join id0 =
1" 1 0; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_set_limits $ns2 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflow and address allow join id0 1" 2 2 2
> +               chk_join_nr 2 2 2
>         fi
>
>         # subflow and address allow join id0 ns2
> -       if reset_with_allow_join_id0 0 1; then
> +       if reset_with_allow_join_id0 "subflow and address allow join id0 =
2" 0 1; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_set_limits $ns2 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "subflow and address allow join id0 2" 1 1 1
> +               chk_join_nr 1 1 1
>         fi
>  }
>
> @@ -2472,37 +2491,37 @@ fullmesh_tests()
>         # fullmesh 1
>         # 2 fullmesh addrs in ns2, added before the connection,
>         # 1 non-fullmesh addr in ns1, added during the connection.
> -       if reset; then
> +       if reset "fullmesh test 2x1"; then
>                 pm_nl_set_limits $ns1 0 4
>                 pm_nl_set_limits $ns2 1 4
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
>                 run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> -               chk_join_nr "fullmesh test 2x1" 4 4 4
> +               chk_join_nr 4 4 4
>                 chk_add_nr 1 1
>         fi
>
>         # fullmesh 2
>         # 1 non-fullmesh addr in ns1, added before the connection,
>         # 1 fullmesh addr in ns2, added during the connection.
> -       if reset; then
> +       if reset "fullmesh test 1x1"; then
>                 pm_nl_set_limits $ns1 1 3
>                 pm_nl_set_limits $ns2 1 3
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
> -               chk_join_nr "fullmesh test 1x1" 3 3 3
> +               chk_join_nr 3 3 3
>                 chk_add_nr 1 1
>         fi
>
>         # fullmesh 3
>         # 1 non-fullmesh addr in ns1, added before the connection,
>         # 2 fullmesh addrs in ns2, added during the connection.
> -       if reset; then
> +       if reset "fullmesh test 1x2"; then
>                 pm_nl_set_limits $ns1 2 5
>                 pm_nl_set_limits $ns2 1 5
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> -               chk_join_nr "fullmesh test 1x2" 5 5 5
> +               chk_join_nr 5 5 5
>                 chk_add_nr 1 1
>         fi
>
> @@ -2510,53 +2529,53 @@ fullmesh_tests()
>         # 1 non-fullmesh addr in ns1, added before the connection,
>         # 2 fullmesh addrs in ns2, added during the connection,
>         # limit max_subflows to 4.
> -       if reset; then
> +       if reset "fullmesh test 1x2, limited"; then
>                 pm_nl_set_limits $ns1 2 4
>                 pm_nl_set_limits $ns2 1 4
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> -               chk_join_nr "fullmesh test 1x2, limited" 4 4 4
> +               chk_join_nr 4 4 4
>                 chk_add_nr 1 1
>         fi
>
>         # set fullmesh flag
> -       if reset; then
> +       if reset "set fullmesh flag test"; then
>                 pm_nl_set_limits $ns1 4 4
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
>                 pm_nl_set_limits $ns2 4 4
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
> -               chk_join_nr "set fullmesh flag test" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_rm_nr 0 1
>         fi
>
>         # set nofullmesh flag
> -       if reset; then
> +       if reset "set nofullmesh flag test"; then
>                 pm_nl_set_limits $ns1 4 4
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
>                 pm_nl_set_limits $ns2 4 4
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullme=
sh
> -               chk_join_nr "set nofullmesh flag test" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_rm_nr 0 1
>         fi
>
>         # set backup,fullmesh flags
> -       if reset; then
> +       if reset "set backup,fullmesh flags test"; then
>                 pm_nl_set_limits $ns1 4 4
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
>                 pm_nl_set_limits $ns2 4 4
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
> -               chk_join_nr "set backup,fullmesh flags test" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_prio_nr 0 1
>                 chk_rm_nr 0 1
>         fi
>
>         # set nobackup,nofullmesh flags
> -       if reset; then
> +       if reset "set nobackup,nofullmesh flags test"; then
>                 pm_nl_set_limits $ns1 4 4
>                 pm_nl_set_limits $ns2 4 4
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,ful=
lmesh
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullme=
sh
> -               chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
> +               chk_join_nr 2 2 2
>                 chk_prio_nr 0 1
>                 chk_rm_nr 0 1
>         fi
> @@ -2564,9 +2583,9 @@ fullmesh_tests()
>
>  fastclose_tests()
>  {
> -       if reset; then
> +       if reset "fastclose test"; then
>                 run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
> -               chk_join_nr "fastclose test" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_fclose_nr 1 1
>                 chk_rst_nr 1 1 invert
>         fi
> @@ -2581,88 +2600,86 @@ pedit_action_pkts()
>  fail_tests()
>  {
>         # multiple subflows
> -       if reset_with_fail 2; then
> +       if reset_with_fail "MP_FAIL MP_RST" 2; then
>                 tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit d=
elay 1
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflo=
w
>                 run_tests $ns1 $ns2 10.0.1.1 1024
> -               chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupt=
ed pkts" \
> -                       1 1 1 +1 +0 1 1
> +               chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
>         fi
>
>         # single subflow
> -       if reset_with_fail 1; then
> +       if reset_with_fail "Infinite map" 1; then
>                 run_tests $ns1 $ns2 10.0.1.1 128
> -               chk_join_nr "Infinite map: $(pedit_action_pkts) corrupted=
 pkts" \
> -                       0 0 0 +1 +0 1 0 1
> +               chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
>         fi
>  }
>
>  userspace_tests()
>  {
>         # userspace pm type prevents add_addr
> -       if reset; then
> +       if reset "userspace pm type prevents add_addr"; then
>                 set_userspace_pm $ns1
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "userspace pm type prevents add_addr" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_add_nr 0 0
>         fi
>
>         # userspace pm type echoes add_addr
> -       if reset; then
> +       if reset "userspace pm type echoes add_addr"; then
>                 set_userspace_pm $ns2
>                 pm_nl_set_limits $ns1 0 2
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "userspace pm type echoes add_addr" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_add_nr 1 1
>         fi
>
>         # userspace pm type rejects join
> -       if reset; then
> +       if reset "userspace pm type rejects join"; then
>                 set_userspace_pm $ns1
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "userspace pm type rejects join" 1 1 0
> +               chk_join_nr 1 1 0
>         fi
>
>         # userspace pm type does not send join
> -       if reset; then
> +       if reset "userspace pm type does not send join"; then
>                 set_userspace_pm $ns2
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1
> -               chk_join_nr "userspace pm type does not send join" 0 0 0
> +               chk_join_nr 0 0 0
>         fi
>
>         # userspace pm type prevents mp_prio
> -       if reset; then
> +       if reset "userspace pm type prevents mp_prio"; then
>                 set_userspace_pm $ns1
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -               chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
> +               chk_join_nr 1 1 0
>                 chk_prio_nr 0 0
>         fi
>
>         # userspace pm type prevents rm_addr
> -       if reset; then
> +       if reset "userspace pm type prevents rm_addr"; then
>                 set_userspace_pm $ns1
>                 set_userspace_pm $ns2
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> -               chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
> +               chk_join_nr 0 0 0
>                 chk_rm_nr 0 0
>         fi
>  }
> @@ -2670,22 +2687,22 @@ userspace_tests()
>  implicit_tests()
>  {
>         # userspace pm type prevents add_addr
> -       if reset; then
> +       if reset "implicit EP"; then
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_set_limits $ns2 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
>
>                 wait_mpj $ns1
> -               pm_nl_check_endpoint "implicit EP" "creation" \
> +               pm_nl_check_endpoint 1 "creation" \
>                         $ns2 10.0.2.2 id 1 flags implicit
>
>                 pm_nl_add_endpoint $ns2 10.0.2.2 id 33
> -               pm_nl_check_endpoint "" "ID change is prevented" \
> +               pm_nl_check_endpoint 0 "ID change is prevented" \
>                         $ns2 10.0.2.2 id 1 flags implicit
>
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
> -               pm_nl_check_endpoint "" "modif is allowed" \
> +               pm_nl_check_endpoint 0 "modif is allowed" \
>                         $ns2 10.0.2.2 id 1 flags signal
>                 wait
>         fi
> @@ -2711,7 +2728,7 @@ usage()
>         echo "  -i use ip mptcp"
>         echo "  -h help"
>
> -       echo "[test ids]"
> +       echo "[test ids|names]"
>
>         exit ${ret}
>  }
> @@ -2779,9 +2796,9 @@ shift $((OPTIND - 1))
>
>  for arg in "${@}"; do
>         if [[ "${arg}" =3D~ ^[0-9]+$ ]]; then
> -               only_tests+=3D("${arg}")
> +               only_tests_ids+=3D("${arg}")
>         else
> -               usage "Unknown argument: ${arg}"
> +               only_tests_names+=3D("${arg}")
>         fi
>  done
>
> --
> 2.34.1
>
>
