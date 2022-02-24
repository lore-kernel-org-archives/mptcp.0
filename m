Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F647A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:38:51 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so2176157pjb.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WkKmqgapCHKtTQtYU7qKt7+JQ+RHGlEtAZRMv6zmRmw=;
        b=PSO8A9KY+zo2O0nNHLBytWZm8SUW8pSj09nn2t4fZVD00CJ7W+kIDDyODIOVMU/5sr
         iORDLUdBXQjgHxGzSLT7wEAPgdzUGcziMp51QwsqDWfmeo8wPQ75JClR13cA/+zXwBn5
         Rw4cO+jxIzuJrhQC+ZcpTTOvDGJ14Wyd41CUiL2uX6Rv4mkuWozcrQEqaCR6w9Hp2ixS
         wmbtdJ5P5092hKzpKKR+vEADkokwQ+nLE7HeBEOBFrhgN14nPOsDmram4mwsO6UJzEmp
         uIlSSc8jSnxLnttD145Ao2oXdAZem2jcxXeqlvF0SzPaNb9MN+8Uf0KBti2wlKOVBE2B
         qPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkKmqgapCHKtTQtYU7qKt7+JQ+RHGlEtAZRMv6zmRmw=;
        b=sweBmTl/5b6Acwf23xFsDXefnJvphOIAiRjN3KeLGs2eu//dHT6LWDeO1J1NRynmT+
         NuC3baYxJlLq4er8i+wrPtO/pADlELCFWweIdwr/aRclnQtX8HtmddqnnrfzBZVplhPd
         0YG9vJERAwatxP2cbNOF5iLGOtXeemaJ9DTouu3CQweRuZTCfSJrIdG1CWcxWg54o8TU
         5ezFR9LkpwDNz9fT5BbovswAXH3wkbDpzmEyLv8LX2RB9RexQStX18SvDfpDG5vBKqp+
         K8GEKciLc4TkBm+6ofr3aJagTV8mT066spd4WlTWTjFoqQ217HV7eBojCRsNilXEYwRd
         xPiA==
X-Gm-Message-State: AOAM533z7pC4aru4bjdtTyZnCQ/IyHVFMPwlylfsCahF7B5fpqlYgNyP
	QDZ+4ay/4/pa6GC59wiQ1vWCGMrnFEf8NgTGt0hUt0wgmexGNyIY
X-Google-Smtp-Source: ABdhPJzhThWu+uXdfjUd+We6t3gFFvRMrzFT2fmkSpz41ROTCWTMxxw5Z/InPUWixr1OhsgFIPud7qUngnIqN9paWDY=
X-Received: by 2002:a17:90a:ccd:b0:1bc:76eb:ea73 with SMTP id
 13-20020a17090a0ccd00b001bc76ebea73mr13396963pjt.178.1645713530787; Thu, 24
 Feb 2022 06:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net> <20220224135619.2523272-13-matthieu.baerts@tessares.net>
In-Reply-To: <20220224135619.2523272-13-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:39:25 +0800
Message-ID: <CA+WQbwvVkYTo6ARse6J8EvSZkJ=tpcUMipUFOLj+zFLBi0RKFA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 12/12] selftests: mptcp: join: helper to
 filter TCP
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 21:57=E5=86=99=E9=81=93=EF=BC=9A
>
> This is more readable and reduces duplicated commands.
>
> This might also be useful to add v6 support and switch to nftables.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 20ec31b05990..977e5eb28ba4 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -624,6 +624,15 @@ pm_nl_check_endpoint()
>         fi
>  }
>
> +filter_tcp_from()
> +{
> +       local ns=3D"${1}"
> +       local src=3D"${2}"
> +       local target=3D"${3}"
> +
> +       ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${=
target}"

How about being compatible with ip6tables too, like in
reset_with_add_addr_timeout().

> +}
> +
>  do_transfer()
>  {
>         local listener_ns=3D"$1"
> @@ -1653,7 +1662,7 @@ subflows_error_tests()
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -               ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -=
j REJECT
> +               filter_tcp_from $ns1 10.0.3.2 REJECT
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
>                 chk_join_nr 1 1 1
>         fi
> @@ -1664,7 +1673,7 @@ subflows_error_tests()
>                 pm_nl_set_limits $ns2 0 2
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -               ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -=
j DROP
> +               filter_tcp_from $ns1 10.0.3.2 DROP
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
>                 chk_join_nr 1 1 1
>         fi
> @@ -1676,7 +1685,7 @@ subflows_error_tests()
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -               ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -=
j REJECT
> +               filter_tcp_from $ns1 10.0.3.2 REJECT
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
>
>                 # mpj subflow will be in TW after the reset
> --
> 2.34.1
>
>
