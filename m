Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798C68
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 08:38:06 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id r138so9719650pgr.13
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZsirzofDpIdgRzWb8lUoS8jV/215bG+1Jp6xRkSrgtk=;
        b=oaiKa7c2PpsnWlKm/Vf24oMvGjC0+0lFANwqUegp3GdH9OwQ/ZcC7kKQabaKAKqzHj
         CGW19c1u4S1Uk4XnqBAW1X7mUoZwcW9jZbJfAPw1CSjbuToNB0TocY7C9AdohguRHv4j
         o9PGM6RcqG/0PEdOkX1W6HguiyG7wXhdedTLI4F2YaY/naQYO4jhzQEIHr/GgdcPsMW8
         pQJDJZJAAaBlQMmCtAeG6OHqR9/qZP2DCiW8DCrJctNmVfHITzRqx/0F+g2jQC7jsIK6
         LzUwOCsY4Cr7S1MuM634OMgMtUNdot4NqtSlJX+lu/dWX4AQ2V9b9eUWxfbIFavjpKGP
         2qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZsirzofDpIdgRzWb8lUoS8jV/215bG+1Jp6xRkSrgtk=;
        b=YJbEg5LpTNbvuE9+ro4pUHoN9kdDWMuT20oTwDq8GSYciyYTsnz9uyuySov2EHe1RR
         v6t/7wjhtUtHtMeA2+sJDTH9EY3hljoHzrKuBHAepaD2+KfExDR7YZwb7WCPyNJi/Pmn
         pW6sUA4IDn1Lx8UjFixANtlHf077d6jvXaZDUBP5tsmzhHIETiwqNKRonOXgWWlyeW4z
         AVhkr/44vjd65dzqN0ic+xPvwEs2u8kYDfR2Ivrc7H0Wh5FvRNFpEt0UPNNhVccoMdaU
         3IfBvSSBsBlkgpea0rlu26h1Aby8wwjjmcNfBiEpPR/UMavVaU4blShIAQSt2zB/Eqwr
         TwTQ==
X-Gm-Message-State: AOAM532W2lhg8o0Ddbo6gn4D/F0kQeAvLOHf1CLfZDiuMBM1EyxchI/h
	BQw766F6MxwrCaMdph4YVca8k7y9dxG+8bCeGbfehqfFUH0=
X-Google-Smtp-Source: ABdhPJwvEpzhdsfJuDQKoIidylDnxL3ILpmPTFa4bZK3Tkbcu+riy6xqCxAXxvk2UUWE7lhDNycl5SMJC9uAPNGTFdc=
X-Received: by 2002:aa7:93ce:0:b0:4a8:19fc:f024 with SMTP id
 y14-20020aa793ce000000b004a819fcf024mr35659746pff.10.1638779885759; Mon, 06
 Dec 2021 00:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com> <20211202005216.154787-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211202005216.154787-7-mathew.j.martineau@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 6 Dec 2021 16:37:59 +0800
Message-ID: <CA+WQbwtN+RoDLQ=YhDYgczHAEN2SCe7gLYGOO_oBFNb6dyBR_A@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 6/6] selftests: mptcp: Add tests for
 userspace PM type
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B412=
=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B 08:52=E5=86=99=E9=81=93=EF=BC=9A
>
> These tests ensure that the in-kernel path manager is bypassed when
> the userspace path manager is configured. Kernel code is still
> responsible for ADD_ADDR echo, so also make sure that's working.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Tested-by: Geliang Tang <geliang.tang@suse.com>

> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..7df9ddb307a8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -50,6 +50,7 @@ init()
>                 ip netns add $netns || exit $ksft_skip
>                 ip -net $netns link set lo up
>                 ip netns exec $netns sysctl -q net.mptcp.enabled=3D1
> +               ip netns exec $netns sysctl -q net.mptcp.pm_type=3D0
>                 ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filte=
r=3D0
>                 ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_f=
ilter=3D0
>                 if [ $checksum -eq 1 ]; then
> @@ -1837,6 +1838,68 @@ fullmesh_tests()
>         chk_add_nr 1 1
>  }
>
> +userspace_tests()
> +{
> +       # userspace pm type prevents add_addr
> +       reset
> +       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +       run_tests $ns1 $ns2 10.0.1.1
> +       chk_join_nr "userspace pm type prevents add_addr" 0 0 0
> +       chk_add_nr 0 0
> +
> +       # userspace pm type echoes add_addr
> +       reset
> +       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +       run_tests $ns1 $ns2 10.0.1.1
> +       chk_join_nr "userspace pm type echoes add_addr" 0 0 0
> +       chk_add_nr 1 1
> +
> +       # userspace pm type rejects join
> +       reset
> +       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       run_tests $ns1 $ns2 10.0.1.1
> +       chk_join_nr "userspace pm type rejects join" 1 1 0
> +
> +       # userspace pm type does not send join
> +       reset
> +       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       run_tests $ns1 $ns2 10.0.1.1
> +       chk_join_nr "userspace pm type does not send join" 0 0 0
> +
> +       # userspace pm type prevents mp_prio
> +       reset
> +       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +       chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
> +       chk_prio_nr 0 0
> +
> +       # userspace pm type prevents rm_addr
> +       reset
> +       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> +       ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +       ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> +       chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
> +       chk_rm_nr 0 0
> +}
> +
>  all_tests()
>  {
>         subflows_tests
> @@ -1853,6 +1916,7 @@ all_tests()
>         checksum_tests
>         deny_join_id0_tests
>         fullmesh_tests
> +       userspace_tests
>  }
>
>  usage()
> @@ -1872,6 +1936,7 @@ usage()
>         echo "  -S checksum_tests"
>         echo "  -d deny_join_id0_tests"
>         echo "  -m fullmesh_tests"
> +       echo "  -u userspace_tests"
>         echo "  -c capture pcap files"
>         echo "  -C enable data checksum"
>         echo "  -h help"
> @@ -1907,7 +1972,7 @@ if [ $do_all_tests -eq 1 ]; then
>         exit $ret
>  fi
>
> -while getopts 'fsltra64bpkdmchCS' opt; do
> +while getopts 'fsltra64bpkdmuchCS' opt; do
>         case $opt in
>                 f)
>                         subflows_tests
> @@ -1951,6 +2016,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
>                 m)
>                         fullmesh_tests
>                         ;;
> +               u)
> +                       userspace_tests
> +                       ;;
>                 c)
>                         ;;
>                 C)
> --
> 2.34.1
>
>
