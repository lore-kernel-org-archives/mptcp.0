Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117417F4
	for <mptcp@lists.linux.dev>; Wed,  1 Feb 2023 05:13:32 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so484990wms.1
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 21:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLz6EV1X0vXisToyUMWqzckhriRfZluCyfdyeL83a5U=;
        b=bow9NFd9rSyK3H7zM+9OY58sWmgv5CPveClt7dW92Qu6J5WzZhVWVCIjXb0tBUpjFr
         jlI9V2fy6+7XgixXXRnOKOk3VjmaCMS8EwYWC3TXVsKdtkqo6cKC1wE3mgXl0TUEmoGH
         +n2dRP5VcKuGF8J0XdtCrcKjOiig1BuQnvnLp7bZpFyV3OUvCQYle6XHi3LmYZYgPbjz
         zIArn2gNiT5KmzY3e5PwQ3fgy7SNbEs6I1Ks8kWof9wQocsLEHec6HH2CfekoiCVN5z9
         N4Mzv8qjd3gaYCydnF+ZZuBX6Std8dFG8rgnrNnczS/YiWSo6NRKgjYzLcfFBR4Hmn6r
         ZQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLz6EV1X0vXisToyUMWqzckhriRfZluCyfdyeL83a5U=;
        b=UwZT/C819YO1znHM2myObYadIxwQmOvw8+BD59PB22yG4VgoXJ7CmvAS+7y9LiJKAr
         xlbXY7qyEtHZVNgND4ww4+KobvKG6qekH64lYn3V0TwdwFDV2Y9c8TjFJW4lqgYv6UyM
         lEecPTkIAGNWTfYBKQEUVq4rk75ICM85nowpr3Wd8TcrN9lckGHEcCEnS1CJRzJFKy1E
         ArLVj2Uc59WxH3iKmuVRQhn2ZC6wx/BWNNKnnonaJsQmK8uuYq0jvw87caSnTMmjiFWb
         tAtRk5Q0kXHk/ERvptAbrDtHWO7FTvnfEZciJ7vICYb90YNsq6huh4zPyJX87ehBbc+N
         /AeQ==
X-Gm-Message-State: AO0yUKVsKsqGRnHW/5pedR4l7EI6kpf/U43oX6fBdq7X39A972bwq6tj
	wan52XqzvTteIV59anO9PLalaEoqU+IK/vcPHE4CVQ8biKw=
X-Google-Smtp-Source: AK7set9KXrqu8UQ90LW5xOYQMtjtCXVWq53bZJA4ZcOoRBK86YsjpFzOUSMYb6WLxgkSfucdvMHkpMV7KRk+72bUOG8=
X-Received: by 2002:a05:600c:1d8f:b0:3dc:5a15:ade9 with SMTP id
 p15-20020a05600c1d8f00b003dc5a15ade9mr32339wms.111.1675228411101; Tue, 31 Jan
 2023 21:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-1-8de2421163c9@tessares.net>
In-Reply-To: <20230131-mptcp-issue-323-join-delete-re-add-v2-1-8de2421163c9@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 1 Feb 2023 13:14:05 +0800
Message-ID: <CA+WQbwuB9jMnbnPKT8z0KeWT56upWOG9tKhOCPCU1f4uAkTwqA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2 1/2] selftests: mptcp: allow more slack for
 slow test-case
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 19:23=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> A test-case is frequently failing on some extremelly slow VMs.
> The mptcp transfer completes before the script is able to do
> all the required PM manipulation.
>
> Address the issue in the simplest possible way, making the
> transfer even more slow.
>
> Additionally dump more info in case of failures, to help debugging
> similar problems in the future.
>
> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/323
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 387abdcec011..52484a7c286a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1687,6 +1687,7 @@ chk_subflow_nr()
>         local subflow_nr=3D$3
>         local cnt1
>         local cnt2
> +       local dump_stats
>
>         if [ -n "${need_title}" ]; then
>                 printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${=
msg}"
> @@ -1704,7 +1705,12 @@ chk_subflow_nr()
>                 echo "[ ok ]"
>         fi
>
> -       [ "${dump_stats}" =3D 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOn=
i | grep token; ip -n $ns1 mptcp endpoint )
> +       if [ "${dump_stats}" =3D 1 ]; then
> +               ss -N $ns1 -tOni
> +               ss -N $ns1 -tOni | grep token
> +               ip -n $ns1 mptcp endpoint
> +               dump_stats
> +       fi

Hi Matt,

Does this work:

[ "${dump_stats}" =3D 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni |
grep token; ip -n $ns1 mptcp endpoint; dump_stats )

This is more like the original code.

Thanks,
-Geliang

>  }
>
>  chk_link_usage()
> @@ -3103,7 +3109,7 @@ endpoint_tests()
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags s=
ubflow
> -               run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
> +               run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 &
>
>                 wait_mpj $ns2
>                 pm_nl_del_endpoint $ns2 2 10.0.2.2
>
> --
> 2.38.1
>
>
