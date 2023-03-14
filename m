Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5A2565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:49:58 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id v16so13454099wrn.0
        for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678780196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2twBbc3iciHckRmCHyYXR9VGfAtvvgrS++uiTKzu3Q=;
        b=EjzX6LHGQdHYBFvQ4tRUI6cg7X6NMDlN94sDyM8bYT3PQx+agjt4b1R2yDe30VH5d0
         oz8dkbHKmGwycyyKCFEBIYjAdvrB0lmvv+GG6OXDRDLTKz5nXUDftp8ikqmHH/m0UcQA
         ql/kMqrnEoQNVtFbdr5KQvgeCsjUCX+dzZ/5ckPnJUhe947viRlZSC9o1A848gFmL4l3
         W5iopjgMCSisbNk6Lb0Dcv7zXEVDmBneM++5GxGH3233MTs+mTzH7mkYClfbg0wmn04x
         RA1zwYk+9gdrwPOZZASJRAYV8BeUWWUZt2wGgJtzc6ujctYoMO2wOVZiEgmVGmXkue5u
         q7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2twBbc3iciHckRmCHyYXR9VGfAtvvgrS++uiTKzu3Q=;
        b=mfJ3SUUk3b1xj5GhS42S7agu6sC3FuI5IZl+agK0dGE0NdRsOv5Lg4Zd9vjAFcGHMx
         w/NO/WamHBtMSEn6q1AQQDF/IIN6U6PWb0up3WfzTNXdq3bHHkyiib5DdUFK6oosKtSB
         72yn2iavtFmMZgE87MCIPXX1uZfqqKhrTxg7LWaajbRkt6NUINCobzxXGEC9euvZ5axv
         l0qSVzaMGePNAmsdl8vgPIP9VxPHa25Ui/B8u1s1uq6rsFmajk1hM5Us+sCCamBbryw6
         YRFFNU+RoAsmtU16BW+7tKNiWBwu6pO8dBTRSZdOiHRcel1iXhfspGAzjO1W1IEmYOb7
         LI5Q==
X-Gm-Message-State: AO0yUKXtYOGYn4ipsk3+xVY3MhX0ywbiuvOZIBdcQ1+0jGfQDnxxOUAK
	hICqXm1GjTAkcImMSQ+YiJr/sX4Bh1aQ3IOKSs0=
X-Google-Smtp-Source: AK7set+u8uVhF5DhBO4SaN0s4+Pf5RZq5U5L+PysrY4yOtJW1HHvIfTNYyvpnxh1uxiaGLpCBue1VvXurn4RWGfxEBw=
X-Received: by 2002:adf:e34c:0:b0:2c7:195c:5b13 with SMTP id
 n12-20020adfe34c000000b002c7195c5b13mr6758461wrj.0.1678780196410; Tue, 14 Mar
 2023 00:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1678778977.git.geliang.tang@suse.com> <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
In-Reply-To: <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 14 Mar 2023 15:51:21 +0800
Message-ID: <CA+WQbwsQF8L0osGcmXZ8g3m-9E3wOT8O2zbxcjxZimFbqfOD8w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 7/7] selftests: mptcp: check userspace mptcp_info
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliang.tang@suse.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 506120401abe..8ca5accd5c82 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -842,8 +842,11 @@ do_transfer()
>                                 tk=3D$(grep "type:1," "$evts_ns1" |
>                                      sed -n 's/.*\(token:\)\([[:digit:]]*=
\).*$/\2/p;q')
>                                 ip netns exec ${listener_ns} ./pm_nl_ctl =
ann $addr token $tk id $id
> +                               chk_mptcp_info subflows_1
>                                 sleep 1
>                                 ip netns exec ${listener_ns} ./pm_nl_ctl =
rem token $tk id $id
> +                               sleep 1
> +                               chk_mptcp_info subflows_0
>                         fi
>
>                         counter=3D$((counter + 1))
> @@ -906,11 +909,14 @@ do_transfer()
>                                 dp=3D$(sed -n 's/.*\(dport:\)\([[:digit:]=
]*\).*$/\2/p;q' "$evts_ns2")
>                                 ip netns exec ${connector_ns} ./pm_nl_ctl=
 csf lip $addr lid $id \
>                                                                         r=
ip $da rport $dp token $tk
> +                               chk_mptcp_info subflows_1
>                                 sleep 1
>                                 sp=3D$(grep "type:10" "$evts_ns2" |
>                                      sed -n 's/.*\(sport:\)\([[:digit:]]*=
\).*$/\2/p;q')
>                                 ip netns exec ${connector_ns} ./pm_nl_ctl=
 dsf lip $addr lport $sp \
>                                                                         r=
ip $da rport $dp token $tk
> +                               sleep 1
> +                               chk_mptcp_info subflows_0
>                         fi
>                         counter=3D$((counter + 1))
>                         add_nr_ns2=3D$((add_nr_ns2 - 1))
> @@ -3148,6 +3154,10 @@ endpoint_tests()
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>                 pm_nl_check_endpoint 0 "modif is allowed" \
>                         $ns2 10.0.2.2 id 1 flags signal
> +
> +               chk_mptcp_info subflows_1
> +               pm_nl_del_endpoint $ns2 1 10.0.2.2
> +               chk_mptcp_info subflows_0

These lines should be squashed to "selftests: mptcp: add mptcp_info tests".

-Geliang

>                 kill_tests_wait
>         fi
>
> --
> 2.35.3
>
>
