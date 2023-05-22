Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEA16414
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684777191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFQKO3nM2wwUDK9QO3xbaYpURAZp+MuHbSatS/YoOz4=;
	b=Z6fxgAI6oLjWJGAkgB4nIlJ7cj7deBSPZR0R2s6HFEbS3z4Yh1WiXSJHZ/ULs/D0KcK9Wh
	ibKP0zVQ4mGW67s7WOkanPoi6680zBuHOkxMcQn9J9a+O1xPy204uSrTGlWdytTsX7zg/6
	HtW9mGFb+lcDU8TjlrOYJC79q1L4eNE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-hRIqg8dIPgylaf2MPjubqA-1; Mon, 22 May 2023 13:39:50 -0400
X-MC-Unique: hRIqg8dIPgylaf2MPjubqA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-624a29df9feso2916466d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777189; x=1687369189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/7Iaw9/tpC7Y52guT3eWDy8F1ceLotuLtvUPUVOo08=;
        b=dqY4B7vQ7IYRtZn97JD4gYjQY3Dx+x2n6KTcHOB9nwEQjNf5A9ssm2ILZlNQzhLefv
         ppNDMbKAcSzT7XTYW0Uxy0w1Gd5DRCbLRiT7LYIDYp8EGOPtMxMyHG80X7QuQoiI9kmY
         luuDg6H205lAIxPH4xk8qdvfscYhsBNyaOfsdcsHqB5Oc3ABFMi8EFsmjzwh0cioyiv0
         /nnFboUKeVsf6zpgVyoNhq+xx+Zk/t9+xoiBzZpxEo64gVMafLzM9kf+3LHecPFboToP
         xKg2Eawvsq0oNoE0uSJRfnyP0X73jWBdCdAFwndJ16vMhxpbWMG+ZXazaLVv1TQSuevd
         RV4g==
X-Gm-Message-State: AC+VfDzslO5rT4C0I2hG1owJsAWoM9tOrmy9DoEDR73eccjeGmIFwiJb
	I+2bzHtvxunSmAx8g9lzsvju89YO+if7RcgU6zjez2UxnQMAp1V5n35EN7WDxGxURVyzEq9ohnW
	h8W2yIj90G8Y6SmoUbvDpkCk=
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id kd15-20020a056214400f00b0062586ed8ab4mr3846212qvb.3.1684777189501;
        Mon, 22 May 2023 10:39:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sgE1ggs7/VIcmHNP32LIWGsp2ZEmP4Ot79g31Lmubqj2xLo1Z3Ylw5UTVi8mza6mWEfYutQ==
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id kd15-20020a056214400f00b0062586ed8ab4mr3846193qvb.3.1684777189105;
        Mon, 22 May 2023 10:39:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id px23-20020a056214051700b0061b5ad0290asm2068431qvb.67.2023.05.22.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:39:48 -0700 (PDT)
Message-ID: <81b89eceb464bd67bca36ac8eccba3489883014e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 25/37] selftests: mptcp: join: skip check
 if MIB counter not supported
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:39:45 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-25-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-25-50313e4f83ab@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
>=20
> One of them is the MPTCP MIB counters introduced in commit fc518953bc9c
> ("mptcp: add and use MIB counter infrastructure") and more later. The
> MPTCP Join selftest heavily relies on these counters.
>=20
> If a counter is not supported by the kernel, it is not displayed when
> using 'nstat -z'. We can then detect that and skip the verification. A
> new helper (get_counter()) has been added to do the required checks and
> return an error if the counter is not available.
>=20
> Note that if we expect to have these features available and if
> SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
> will be marked as failed instead of skipped.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 251 ++++++++++++++----=
------
>  1 file changed, 142 insertions(+), 109 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 1a8f7c6fa988..73c513f1e808 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -505,11 +505,25 @@ wait_local_port_listen()
>  =09done
>  }
> =20
> +# $1: ns ; $2: counter
> +get_counter()
> +{
> +=09local ns=3D"${1}"
> +=09local counter=3D"${2}"
> +=09local count
> +
> +=09count=3D$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR=3D=3D=
1 {next} {print $2}')
> +=09if [ -z "${count}" ]; then
> +=09=09mptcp_lib_fail_if_expected_feature "${counter} counter"
> +=09=09return 1
> +=09fi
> +
> +=09echo "${count}"
> +}
> +
>  rm_addr_count()
>  {
> -=09local ns=3D${1}
> -
> -=09ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}=
'
> +=09get_counter "${1}" "MPTcpExtRmAddr"
>  }
> =20
>  # $1: ns, $2: old rm_addr counter in $ns
> @@ -532,11 +546,11 @@ wait_mpj()
>  =09local ns=3D"${1}"
>  =09local cnt old_cnt
> =20
> -=09old_cnt=3D$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{=
print $2}')
> +=09old_cnt=3D$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
> =20
>  =09local i
>  =09for i in $(seq 10); do
> -=09=09cnt=3D$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{p=
rint $2}')
> +=09=09cnt=3D$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
>  =09=09[ "$cnt" =3D "${old_cnt}" ] || break
>  =09=09sleep 0.1
>  =09done
> @@ -1185,12 +1199,13 @@ chk_csum_nr()
>  =09fi
> =20
>  =09printf "%-${nr_blank}s %s" " " "sum"
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | a=
wk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> +=09count=3D$(get_counter ${ns1} "MPTcpExtDataCsumErr")
>  =09if [ "$count" !=3D "$csum_ns1" ]; then
>  =09=09extra_msg=3D"$extra_msg ns1=3D$count"
>  =09fi
> -=09if { [ "$count" !=3D $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]=
; } ||
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif { [ "$count" !=3D $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0=
 ]; } ||
>  =09   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ];=
 }; then
>  =09=09echo "[fail] got $count data checksum error[s] expected $csum_ns1"
>  =09=09fail_test
> @@ -1198,12 +1213,13 @@ chk_csum_nr()
>  =09=09echo -n "[ ok ]"
>  =09fi
>  =09echo -n " - csum  "
> -=09count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | a=
wk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> +=09count=3D$(get_counter ${ns2} "MPTcpExtDataCsumErr")
>  =09if [ "$count" !=3D "$csum_ns2" ]; then
>  =09=09extra_msg=3D"$extra_msg ns2=3D$count"
>  =09fi
> -=09if { [ "$count" !=3D $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]=
; } ||
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif { [ "$count" !=3D $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0=
 ]; } ||
>  =09   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ];=
 }; then
>  =09=09echo "[fail] got $count data checksum error[s] expected $csum_ns2"
>  =09=09fail_test
> @@ -1242,12 +1258,13 @@ chk_fail_nr()
>  =09fi
> =20
>  =09printf "%-${nr_blank}s %s" " " "ftx"
> -=09count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | aw=
k '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> +=09count=3D$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
>  =09if [ "$count" !=3D "$fail_tx" ]; then
>  =09=09extra_msg=3D"$extra_msg,tx=3D$count"
>  =09fi
> -=09if { [ "$count" !=3D "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif { [ "$count" !=3D "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
>  =09   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
>  =09=09echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
>  =09=09fail_test
> @@ -1256,12 +1273,13 @@ chk_fail_nr()
>  =09fi
> =20
>  =09echo -n " - failrx"
> -=09count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | aw=
k '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> +=09count=3D$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
>  =09if [ "$count" !=3D "$fail_rx" ]; then
>  =09=09extra_msg=3D"$extra_msg,rx=3D$count"
>  =09fi
> -=09if { [ "$count" !=3D "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif { [ "$count" !=3D "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
>  =09   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
>  =09=09echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
>  =09=09fail_test
> @@ -1289,10 +1307,11 @@ chk_fclose_nr()
>  =09fi
> =20
>  =09printf "%-${nr_blank}s %s" " " "ctx"
> -=09count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx=
 | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09[ "$count" !=3D "$fclose_tx" ] && extra_msg=3D"$extra_msg,tx=3D$count=
"
> -=09if [ "$count" !=3D "$fclose_tx" ]; then
> +=09count=3D$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$fclose_tx" ]; then
> +=09=09extra_msg=3D"$extra_msg,tx=3D$count"
>  =09=09echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
>  =09=09fail_test
>  =09else
> @@ -1300,10 +1319,11 @@ chk_fclose_nr()
>  =09fi
> =20
>  =09echo -n " - fclzrx"
> -=09count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFastcloseRx=
 | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09[ "$count" !=3D "$fclose_rx" ] && extra_msg=3D"$extra_msg,rx=3D$count=
"
> -=09if [ "$count" !=3D "$fclose_rx" ]; then
> +=09count=3D$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$fclose_rx" ]; then
> +=09=09extra_msg=3D"$extra_msg,rx=3D$count"
>  =09=09echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
>  =09=09fail_test
>  =09else
> @@ -1330,9 +1350,10 @@ chk_rst_nr()
>  =09fi
> =20
>  =09printf "%-${nr_blank}s %s" " " "rtx"
> -=09count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk=
 '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ $count -lt $rst_tx ]; then
> +=09count=3D$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ $count -lt $rst_tx ]; then
>  =09=09echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
>  =09=09fail_test
>  =09else
> @@ -1340,9 +1361,10 @@ chk_rst_nr()
>  =09fi
> =20
>  =09echo -n " - rstrx "
> -=09count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk=
 '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" -lt "$rst_rx" ]; then
> +=09count=3D$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" -lt "$rst_rx" ]; then
>  =09=09echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
>  =09=09fail_test
>  =09else
> @@ -1359,9 +1381,10 @@ chk_infi_nr()
>  =09local count
> =20
>  =09printf "%-${nr_blank}s %s" " " "itx"
> -=09count=3D$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{p=
rint $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$infi_tx" ]; then
> +=09count=3D$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$infi_tx" ]; then
>  =09=09echo "[fail] got $count infinite map[s] TX expected $infi_tx"
>  =09=09fail_test
>  =09else
> @@ -1369,9 +1392,10 @@ chk_infi_nr()
>  =09fi
> =20
>  =09echo -n " - infirx"
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{p=
rint $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$infi_rx" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo "[skip]"
> +=09elif [ "$count" !=3D "$infi_rx" ]; then
>  =09=09echo "[fail] got $count infinite map[s] RX expected $infi_rx"
>  =09=09fail_test
>  =09else
> @@ -1399,9 +1423,10 @@ chk_join_nr()
>  =09fi
> =20
>  =09printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | a=
wk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$syn_nr" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$syn_nr" ]; then
>  =09=09echo "[fail] got $count JOIN[s] syn expected $syn_nr"
>  =09=09fail_test
>  =09else
> @@ -1410,9 +1435,10 @@ chk_join_nr()
> =20
>  =09echo -n " - synack"
>  =09with_cookie=3D$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
> -=09count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx =
| awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$syn_ack_nr" ]; then
> +=09count=3D$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$syn_ack_nr" ]; then
>  =09=09# simult connections exceeding the limit with cookie enabled could=
 go up to
>  =09=09# synack validation as the conn limit can be enforced reliably onl=
y after
>  =09=09# the subflow creation
> @@ -1427,9 +1453,10 @@ chk_join_nr()
>  =09fi
> =20
>  =09echo -n " - ack"
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | a=
wk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$ack_nr" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo "[skip]"
> +=09elif [ "$count" !=3D "$ack_nr" ]; then
>  =09=09echo "[fail] got $count JOIN[s] ack expected $ack_nr"
>  =09=09fail_test
>  =09else
> @@ -1459,12 +1486,12 @@ chk_stale_nr()
>  =09local recover_nr
> =20
>  =09printf "%-${nr_blank}s %-18s" " " "stale"
> -=09stale_nr=3D$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale =
| awk '{print $2}')
> -=09[ -z "$stale_nr" ] && stale_nr=3D0
> -=09recover_nr=3D$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowReco=
ver | awk '{print $2}')
> -=09[ -z "$recover_nr" ] && recover_nr=3D0
> =20
> -=09if [ $stale_nr -lt $stale_min ] ||
> +=09stale_nr=3D$(get_counter ${ns} "MPTcpExtSubflowStale")
> +=09recover_nr=3D$(get_counter ${ns} "MPTcpExtSubflowRecover")
> +=09if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
> +=09=09echo "[skip]"
> +=09elif [ $stale_nr -lt $stale_min ] ||
>  =09   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
>  =09   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
>  =09=09echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
> @@ -1499,12 +1526,12 @@ chk_add_nr()
>  =09timeout=3D$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
> =20
>  =09printf "%-${nr_blank}s %s" " " "add"
> -=09count=3D$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpEx=
tAddAddr | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -
> +=09count=3D$(get_counter ${ns2} "MPTcpExtAddAddr")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
>  =09# if the test configured a short timeout tolerate greater then expect=
ed
>  =09# add addrs options, due to retransmissions
> -=09if [ "$count" !=3D "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count=
" -lt "$add_nr" ]; }; then
> +=09elif [ "$count" !=3D "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$cou=
nt" -lt "$add_nr" ]; }; then
>  =09=09echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
>  =09=09fail_test
>  =09else
> @@ -1512,9 +1539,10 @@ chk_add_nr()
>  =09fi
> =20
>  =09echo -n " - echo  "
> -=09count=3D$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPTcpEx=
tEchoAdd | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$echo_nr" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtEchoAdd")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$echo_nr" ]; then
>  =09=09echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
>  =09=09fail_test
>  =09else
> @@ -1523,9 +1551,10 @@ chk_add_nr()
> =20
>  =09if [ $port_nr -gt 0 ]; then
>  =09=09echo -n " - pt "
> -=09=09count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | aw=
k '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$port_nr" ]; then
> +=09=09count=3D$(get_counter ${ns2} "MPTcpExtPortAdd")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo "[skip]"
> +=09=09elif [ "$count" !=3D "$port_nr" ]; then
>  =09=09=09echo "[fail] got $count ADD_ADDR[s] with a port-number expected=
 $port_nr"
>  =09=09=09fail_test
>  =09=09else
> @@ -1533,10 +1562,10 @@ chk_add_nr()
>  =09=09fi
> =20
>  =09=09printf "%-${nr_blank}s %s" " " "syn"
> -=09=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSy=
nRx |
> -=09=09=09awk '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$syn_nr" ]; then
> +=09=09count=3D$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo -n "[skip]"
> +=09=09elif [ "$count" !=3D "$syn_nr" ]; then
>  =09=09=09echo "[fail] got $count JOIN[s] syn with a different \
>  =09=09=09=09port-number expected $syn_nr"
>  =09=09=09fail_test
> @@ -1545,10 +1574,10 @@ chk_add_nr()
>  =09=09fi
> =20
>  =09=09echo -n " - synack"
> -=09=09count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSy=
nAckRx |
> -=09=09=09awk '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$syn_ack_nr" ]; then
> +=09=09count=3D$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo -n "[skip]"
> +=09=09elif [ "$count" !=3D "$syn_ack_nr" ]; then
>  =09=09=09echo "[fail] got $count JOIN[s] synack with a different \
>  =09=09=09=09port-number expected $syn_ack_nr"
>  =09=09=09fail_test
> @@ -1557,10 +1586,10 @@ chk_add_nr()
>  =09=09fi
> =20
>  =09=09echo -n " - ack"
> -=09=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAc=
kRx |
> -=09=09=09awk '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$ack_nr" ]; then
> +=09=09count=3D$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo "[skip]"
> +=09=09elif [ "$count" !=3D "$ack_nr" ]; then
>  =09=09=09echo "[fail] got $count JOIN[s] ack with a different \
>  =09=09=09=09port-number expected $ack_nr"
>  =09=09=09fail_test
> @@ -1569,10 +1598,10 @@ chk_add_nr()
>  =09=09fi
> =20
>  =09=09printf "%-${nr_blank}s %s" " " "syn"
> -=09=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPort=
SynRx |
> -=09=09=09awk '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$mis_syn_nr" ]; then
> +=09=09count=3D$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo -n "[skip]"
> +=09=09elif [ "$count" !=3D "$mis_syn_nr" ]; then
>  =09=09=09echo "[fail] got $count JOIN[s] syn with a mismatched \
>  =09=09=09=09port-number expected $mis_syn_nr"
>  =09=09=09fail_test
> @@ -1581,10 +1610,10 @@ chk_add_nr()
>  =09=09fi
> =20
>  =09=09echo -n " - ack   "
> -=09=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPort=
AckRx |
> -=09=09=09awk '{print $2}')
> -=09=09[ -z "$count" ] && count=3D0
> -=09=09if [ "$count" !=3D "$mis_ack_nr" ]; then
> +=09=09count=3D$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
> +=09=09if [ -z "$count" ]; then
> +=09=09=09echo "[skip]"
> +=09=09elif [ "$count" !=3D "$mis_ack_nr" ]; then
>  =09=09=09echo "[fail] got $count JOIN[s] ack with a mismatched \
>  =09=09=09=09port-number expected $mis_ack_nr"
>  =09=09=09fail_test
> @@ -1606,12 +1635,12 @@ chk_add_tx_nr()
>  =09timeout=3D$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
> =20
>  =09printf "%-${nr_blank}s %s" " " "add TX"
> -=09count=3D$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcp=
ExtAddAddrTx | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -
> +=09count=3D$(get_counter ${ns1} "MPTcpExtAddAddrTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
>  =09# if the test configured a short timeout tolerate greater then expect=
ed
>  =09# add addrs options, due to retransmissions
> -=09if [ "$count" !=3D "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$co=
unt" -lt "$add_tx_nr" ]; }; then
> +=09elif [ "$count" !=3D "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$=
count" -lt "$add_tx_nr" ]; }; then
>  =09=09echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
>  =09=09fail_test
>  =09else
> @@ -1619,9 +1648,10 @@ chk_add_tx_nr()
>  =09fi
> =20
>  =09echo -n " - echo TX "
> -=09count=3D$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcp=
ExtEchoAddTx | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$echo_tx_nr" ]; then
> +=09count=3D$(get_counter ${ns2} "MPTcpExtEchoAddTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo "[skip]"
> +=09elif [ "$count" !=3D "$echo_tx_nr" ]; then
>  =09=09echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
>  =09=09fail_test
>  =09else
> @@ -1695,9 +1725,10 @@ chk_rm_nr()
>  =09fi
> =20
>  =09printf "%-${nr_blank}s %s" " " "rm "
> -=09count=3D$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTc=
pExtRmAddr | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$rm_addr_nr" ]; then
> +=09count=3D$(get_counter ${addr_ns} "MPTcpExtRmAddr")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$rm_addr_nr" ]; then
>  =09=09echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
>  =09=09fail_test
>  =09else
> @@ -1705,12 +1736,13 @@ chk_rm_nr()
>  =09fi
> =20
>  =09echo -n " - rmsf  "
> -=09count=3D$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflo=
w | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ -n "$simult" ]; then
> +=09count=3D$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ -n "$simult" ]; then
>  =09=09local cnt suffix
> =20
> -=09=09cnt=3D$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow =
| awk '{print $2}')
> +=09=09cnt=3D$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
> =20
>  =09=09# in case of simult flush, the subflow removal count on each side =
is
>  =09=09# unreliable
> @@ -1719,14 +1751,12 @@ chk_rm_nr()
>  =09=09[ "$count" !=3D "$rm_subflow_nr" ] && suffix=3D"$count in [$rm_sub=
flow_nr:$((rm_subflow_nr*2))]"
>  =09=09if [ $count -ge "$rm_subflow_nr" ] && \
>  =09=09   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
> -=09=09=09echo "[ ok ] $suffix"
> +=09=09=09echo -n "[ ok ] $suffix"
>  =09=09else
>  =09=09=09echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_su=
bflow_nr:$((rm_subflow_nr*2))]"
>  =09=09=09fail_test
>  =09=09fi
> -=09=09return
> -=09fi
> -=09if [ "$count" !=3D "$rm_subflow_nr" ]; then
> +=09elif [ "$count" !=3D "$rm_subflow_nr" ]; then
>  =09=09echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
>  =09=09fail_test
>  =09else
> @@ -1741,9 +1771,10 @@ chk_rm_tx_nr()
>  =09local rm_addr_tx_nr=3D$1
> =20
>  =09printf "%-${nr_blank}s %s" " " "rm TX "
> -=09count=3D$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpE=
xtRmAddrTx | awk '{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$rm_addr_tx_nr" ]; then
> +=09count=3D$(get_counter ${ns2} "MPTcpExtRmAddrTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$rm_addr_tx_nr" ]; then
>  =09=09echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
>  =09=09fail_test
>  =09else
> @@ -1780,9 +1811,10 @@ chk_prio_nr()
>  =09local count
> =20
>  =09printf "%-${nr_blank}s %s" " " "ptx"
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk =
'{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtMPPrioTx")
> +=09if [ -z "$count" ]; then
> +=09=09echo -n "[skip]"
> +=09elif [ "$count" !=3D "$mp_prio_nr_tx" ]; then
>  =09=09echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
>  =09=09fail_test
>  =09else
> @@ -1790,9 +1822,10 @@ chk_prio_nr()
>  =09fi
> =20
>  =09echo -n " - prx   "
> -=09count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk =
'{print $2}')
> -=09[ -z "$count" ] && count=3D0
> -=09if [ "$count" !=3D "$mp_prio_nr_rx" ]; then
> +=09count=3D$(get_counter ${ns1} "MPTcpExtMPPrioRx")
> +=09if [ -z "$count" ]; then
> +=09=09echo "[skip]"
> +=09elif [ "$count" !=3D "$mp_prio_nr_rx" ]; then
>  =09=09echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
>  =09=09fail_test
>  =09else
> @@ -1903,7 +1936,7 @@ wait_attempt_fail()
>  =09while [ $time -lt $timeout_ms ]; do
>  =09=09local cnt
> =20
> -=09=09cnt=3D$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAtte=
mptFails | awk '{print $2}')
> +=09=09cnt=3D$(get_counter ${ns} "TcpAttemptFails")
> =20
>  =09=09[ "$cnt" =3D 1 ] && return 1
>  =09=09time=3D$((time + 100))
>=20

This looks quite invasive. I would instead skip the whole mp_join tests
if any of the basic counters are not available - to there will be a
single hook/check.

/P

