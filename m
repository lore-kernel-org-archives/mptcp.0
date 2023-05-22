Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECED16414
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684777379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEYM/F+MKoLE377B3Dp21mumUF5NwM1xz/j9fqtuvxg=;
	b=jULQUJyXUx5GUmY3RhV0z09mdHok2p5mvINOrE1qMnHlKrhI1oU1BW3nQObPffO4geyz1E
	oJnLn+Xy2SCsk8geOoLPua55zyUlohuhoqrs3wp0GYFMKxeWsGjMHQ4bFT1icqDtk8mo7S
	vIFu1JydeWmyCb+eYf5RznrApDR6i2I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-oLu_6B2iNoORN9eySfKSXw-1; Mon, 22 May 2023 13:42:58 -0400
X-MC-Unique: oLu_6B2iNoORN9eySfKSXw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75b096df575so16769485a.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777378; x=1687369378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFvDMJtO/Hgb+2zKl/90YUnGj7ZGWEYUlwm32YOreKw=;
        b=YKn8v9DfTFvUjcTyIQ6u00qvznlZI9QW/JeD5CkUUxsL06M0kBlACn1J4KD+4hDBDR
         teCCAxanz8KawdMZQhZnBJS7lKbUQOPEWO+whu2/mfYAI1daEDKIeqyy0aeXPjIUf6pG
         X1CMARVoG+XoDmQrns8Uvw0cnOIoZgj6a+6M/Ltgoy4FsnCiLz4Hud4aVaD3Gn8oJS+w
         qV/QTvhGaofGlEBqcpMN7QmE84UAo7+wikwu5txHfWA6vYv36aWUoSeVkqPSGniWAu8W
         xdSz1lznvM1yH9/iptR7hUILPEU5rZOdsbqTojhWoGIAJPRzpAAxLmjp4K3FUUc2gs6r
         zI4A==
X-Gm-Message-State: AC+VfDzygaZk0ABC1NglEg2Xm8ci6o19THspLhxmjpVjTBx5Iu9HKkyc
	XXLRxp6Rob1/oDqpRlzjae1S3nriJgWYVisWjcBRrWPk7KEojI/8MTbVTI5AxMyE+aTO7Uqfkq2
	PAUgBPYxUgSRJMQmVN7mAtJM=
X-Received: by 2002:a05:620a:3f46:b0:75b:23a1:69e1 with SMTP id ty6-20020a05620a3f4600b0075b23a169e1mr1545389qkn.1.1684777378063;
        Mon, 22 May 2023 10:42:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4EPFcFIcUiLY4Y/4o2jTXLNTteHQ+v68C00Dh7xjf87gahgl2vvuFTqMZyhQTzGksoYgjuIw==
X-Received: by 2002:a05:620a:3f46:b0:75b:23a1:69e1 with SMTP id ty6-20020a05620a3f4600b0075b23a169e1mr1545380qkn.1.1684777377782;
        Mon, 22 May 2023 10:42:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id g21-20020ae9e115000000b0075b13a89c30sm872382qkm.3.2023.05.22.10.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:42:57 -0700 (PDT)
Message-ID: <e530b465c8aaabc0f85297ee484af62e571b1906.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 26/37] selftests: mptcp: join: skip test if
 iptables/tc cmds fail
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:42:55 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-26-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-26-50313e4f83ab@tessares.net>
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
> Some tests are using IPTables and/or TC commands to force some
> behaviours. If one of these commands fails -- likely because some
> features are not available -- we should intercept the error and skip the
> tests requiring these features.
>=20
> Note that if we expect to have these features available and if
> SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
> will be marked as failed instead of skipped.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++++++++++---=
------
>  1 file changed, 57 insertions(+), 31 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 73c513f1e808..2ae6d99f3eb9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -288,11 +288,15 @@ reset_with_add_addr_timeout()
>  =09fi
> =20
>  =09ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
> -=09ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> -=09=09-m tcp --tcp-option 30 \
> -=09=09-m bpf --bytecode \
> -=09=09"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
> -=09=09-j DROP
> +
> +=09if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> +=09=09=09-m tcp --tcp-option 30 \
> +=09=09=09-m bpf --bytecode \
> +=09=09=09"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
> +=09=09=09-j DROP; then
> +=09=09mark_as_skipped "unable to set the 'add addr' rule"
> +=09=09return 1
> +=09fi
>  }
> =20
>  # $1: test name
> @@ -336,17 +340,12 @@ reset_with_allow_join_id0()
>  #     tc action pedit offset 162 out of bounds
>  #
>  # Netfilter is used to mark packets with enough data.
> -reset_with_fail()
> +setup_fail_rules()
>  {
> -=09reset "${1}" || return 1
> -
> -=09ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
> -=09ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
> -
>  =09check_invert=3D1
>  =09validate_checksum=3D1
> -=09local i=3D"$2"
> -=09local ip=3D"${3:-4}"
> +=09local i=3D"$1"
> +=09local ip=3D"${2:-4}"
>  =09local tables
> =20
>  =09tables=3D"${iptables}"
> @@ -361,15 +360,32 @@ reset_with_fail()
>  =09=09-p tcp \
>  =09=09-m length --length 150:9999 \
>  =09=09-m statistic --mode nth --packet 1 --every 99999 \
> -=09=09-j MARK --set-mark 42 || exit 1
> +=09=09-j MARK --set-mark 42 || return ${ksft_skip}
> =20
> -=09tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
> +=09tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
>  =09tc -n $ns2 filter add dev ns2eth$i egress \
>  =09=09protocol ip prio 1000 \
>  =09=09handle 42 fw \
>  =09=09action pedit munge offset 148 u8 invert \
>  =09=09pipe csum tcp \
> -=09=09index 100 || exit 1
> +=09=09index 100 || return ${ksft_skip}
> +}
> +
> +reset_with_fail()
> +{
> +=09reset "${1}" || return 1
> +=09shift
> +
> +=09ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=3D1
> +=09ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=3D1
> +
> +=09local rc=3D0
> +=09setup_fail_rules "${@}" || rc=3D$?
> +
> +=09if [ ${rc} -eq ${ksft_skip} ]; then
> +=09=09mark_as_skipped "unable to set the 'fail' rules"
> +=09=09return 1
> +=09fi
>  }
> =20
>  reset_with_events()
> @@ -384,6 +400,25 @@ reset_with_events()
>  =09evts_ns2_pid=3D$!
>  }
> =20
> +reset_with_tcp_filter()
> +{
> +=09reset "${1}" || return 1
> +=09shift
> +
> +=09local ns=3D"${!1}"
> +=09local src=3D"${2}"
> +=09local target=3D"${3}"
> +
> +=09if ! ip netns exec "${ns}" ${iptables} \
> +=09=09=09-A INPUT \
> +=09=09=09-s "${src}" \
> +=09=09=09-p tcp \
> +=09=09=09-j "${target}"; then
> +=09=09mark_as_skipped "unable to set the filter rules"
> +=09=09return 1
> +=09fi
> +}

All the above tc/nf features look quite old. I thought even older them
mptcp itself. Do we really need to check for them?!?

/P

