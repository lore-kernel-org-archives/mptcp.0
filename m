Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76F625
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 09:28:59 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id k67so5316301vsk.2
        for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTy2iCsL+D+D7XAcx9IT83DMj4cKRhMZCPVFvjhPvGw=;
        b=MjB8lQBZ47ZqwFxpiv1MaOpBZgRbFbrzw7QtAzEJDC1PU7pPohfD8v4IfGeWnni4tY
         z1BQ+eQ+pD+zhmzgiTqPcCWMBCddGFKRttH6diEn0NrL7Sz99zpYLbPbQ13s7g4r4SKb
         4VBfdnXp0BRwaWugA/0Hqqf5d8WGIBHnBRh79N8b4vaPk+qadUzUVYOn6pP1HY1WI4uW
         QEK9QpOEnBw77jtPfPQGZS2UJRN5ZsbogJMfbNtUGkjkjzlSymPs5rDQrf/Zm8yAb5xF
         b6M9tsy3OOPwumyP1z/nBGB35njUx7YOn1GIgdaDWr2WwpErepYBymUTCmBCLZ84NLFd
         4EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTy2iCsL+D+D7XAcx9IT83DMj4cKRhMZCPVFvjhPvGw=;
        b=p2ViUC5mv6RtWMQnVQ+dWetkA2IOFPn7Nwcl/hd5j4wZar6dUVqjXF70uWTE5rPoCC
         6+0dUQqJAXMI5wf5xgw9A0fT1GiKtrKU2UMWt6yzVsSBUHDBxO621YUFvxqkdTvb64mV
         +q0QuhhoAOvbp5cW3qqhRu13ZkNgxKUNIfWpJD/QunB8ozRsztjSm3H08vfwjohKTjKr
         tidD/Tmr7gY3moAHNu9icH0BFipzExQezP1+uWQGQguIKXZHjiMiHx8Z3cl0JXJzRcsC
         omS9qf0ISdhNki9hqWH3GthbTB/RDVNjeVlYQ4UMcpIREU5vJijh+tg7hAjmSlc1yGWd
         l69w==
X-Gm-Message-State: ACrzQf2ibVPBlVZhVM5wN6Ox3DXyFCL1W+1tuJ+tyW/hE0eXCunafJ5Q
	9NzEP43PUiuoarggrfg4V/5dYEo3hnJRGxBpyZ4hAKCJ+E0=
X-Google-Smtp-Source: AMsMyM48ZN3gLDAbw9JQZlXrd4w+g1LyOyidqKOUGsg6Eyvu5K7mNxUqD+mISDSzF9l23epSPCeoE5Z3Bla0ebDTBGs=
X-Received: by 2002:a67:df18:0:b0:3a9:f07f:876c with SMTP id
 s24-20020a67df18000000b003a9f07f876cmr11455364vsk.21.1666517338635; Sun, 23
 Oct 2022 02:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net> <20221019161940.3178393-2-matthieu.baerts@tessares.net>
In-Reply-To: <20221019161940.3178393-2-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sun, 23 Oct 2022 17:28:54 +0800
Message-ID: <CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 1/4] selftests: mptcp: run mptcp_sockopt from a
 new netns
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B410=E6=
=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B 00:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Not running it from a new netns causes issues if some MPTCP settings are
> modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
> addresses are available and added to the MPTCP path-manager, etc.
>
> In these cases, the created connection will not behave as expected, e.g.
> unable to create an MPTCP socket, more than one subflow is seen, etc.
>
> A new "sandbox" net namespace is now created and used to run
> mptcp_sockopt from this controlled environment.
>
> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_sockopt.sh
> index 0879da915014..80d36f7cfee8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -35,8 +35,9 @@ init()
>
>         ns1=3D"ns1-$rndh"
>         ns2=3D"ns2-$rndh"
> +       ns_sbox=3D"ns_sbox-$rndh"

Hi Matt, how about clearly defining ns_sbox (as well as ns1, ns2) as a
global variable at the beginning of this file, and then assign values
here, as the same as in mptcp_connect.sh and mptcp_join.sh?

Thanks,
-Geliang

>
> -       for netns in "$ns1" "$ns2";do
> +       for netns in "$ns1" "$ns2" "$ns_sbox";do
>                 ip netns add $netns || exit $ksft_skip
>                 ip -net $netns link set lo up
>                 ip netns exec $netns sysctl -q net.mptcp.enabled=3D1
> @@ -73,7 +74,7 @@ init()
>
>  cleanup()
>  {
> -       for netns in "$ns1" "$ns2"; do
> +       for netns in "$ns1" "$ns2" "$ns_sbox"; do
>                 ip netns del $netns
>         done
>         rm -f "$cin" "$cout"
> @@ -243,7 +244,7 @@ do_mptcp_sockopt_tests()
>  {
>         local lret=3D0
>
> -       ./mptcp_sockopt
> +       ip netns exec "$ns_sbox" ./mptcp_sockopt
>         lret=3D$?
>
>         if [ $lret -ne 0 ]; then
> @@ -252,7 +253,7 @@ do_mptcp_sockopt_tests()
>                 return
>         fi
>
> -       ./mptcp_sockopt -6
> +       ip netns exec "$ns_sbox" ./mptcp_sockopt -6
>         lret=3D$?
>
>         if [ $lret -ne 0 ]; then
> --
> 2.37.2
>
>
