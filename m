Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD67478
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:08:14 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id e13so1811582plh.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ygGnJTjhZR+c3OnHCyt//FujFTzCg6YLH4IayAJJ+Q=;
        b=KkShAI9nO5+SCdtFxZPz5+lsLCpgTpd3C0iwC/+hHYndm7GWp50slwukCWSt7j+w4W
         Lm/KOtyjqyB/dPOo1uvHha0HKhbUzRgMiBKruIKRV6fgO1Tz9Mon0BGnadA8H1RtQCXY
         sVd8G1Nf2YbDmMsuOtrVMjBnpd7lD38JJobBKK18c56CaMWG8xxCaX6+Pr3PItPmYCBO
         3wbpLk5kNYSo6mSNmsplRDFBDPGRbXyZf5d3zaTF2iUSWHl6Ctsf0RQH5FvpDUFx4lG1
         L7tpfwckumqopJ5q/eGWZhNQezefARLFc06g/9GmRuYTxlnYwH4LC8PoHuIqPK0noy9S
         ewDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ygGnJTjhZR+c3OnHCyt//FujFTzCg6YLH4IayAJJ+Q=;
        b=ewfsX7QrGwG8z9unpVAfVuprTVEZLtvLTYhdmGq9ynGxoDHRFZJU8trTDZvgMQhVnq
         JrYQNA+JQBEQAoC3O+fptMg9xtkpgs3NlkKt8jmPlp1cOh0tCJgTKmhx9mr7110EUnjK
         HSNev7exErcm25cwHXdBMXGqeamPEOBHPAO29iqkJEt9sSzB8pJQwBhNV5lRqxMZOku+
         1WAQonox5pbsyrOdNW66am8tZohdbSx24mfc2c6T4fTchv87uC0lNP3NJah94T83DpTD
         o2Tu6qa2MsIympZo8J7T4mVkHPQ98u7dzav0+S0dSbiELFb0J3OAPch7udVOXmGlUkp5
         qdDg==
X-Gm-Message-State: AOAM531VVS6mPAANTl9a+F3W6kpiNUZi4UBVtjy/7q/ZUeZnZf3geidi
	BHHuRVq9+848zfh7etOwa2TOjNVScHJhzEXnUhcBfsU2wGrJBCbW
X-Google-Smtp-Source: ABdhPJxcQLSHXdXTGerHW/mKOefWaj/0oCnToyhf8AfGeVKgp0UurIkLeviI+kkGyjaCvBB0kDW3ROhcBYRSyAmwEs8=
X-Received: by 2002:a17:902:d345:b0:14f:ee29:5ee6 with SMTP id
 l5-20020a170902d34500b0014fee295ee6mr2645260plk.102.1645711693532; Thu, 24
 Feb 2022 06:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net> <20220224135619.2523272-2-matthieu.baerts@tessares.net>
In-Reply-To: <20220224135619.2523272-2-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:08:46 +0800
Message-ID: <CA+WQbwv4AaBPc6a+mav2QdfmvAprr7cDh+PgZXfAyPdp+hvcSQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 01/12] Squash to "selftests: mptcp: Add
 tests for userspace PM type"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 21:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers") has been
> applied in net-next before this other patch.
>
> It is then needed to do the same modifications in the userspace tests as
> well.
>
> While at it, a new helper has been added to avoid long 'ip netns exec'
> commands as suggested by Paolo.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Geliang Tang <geliang.tang@suse.com>

> ---
>
> Notes:
>     to be squashed in "selftests: mptcp: Add tests for userspace PM type"
>
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 +++++++++++--------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index ef57a28cf722..e2d56a5bcaf4 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1448,6 +1448,13 @@ wait_attempt_fail()
>         return 1
>  }
>
> +set_userspace_pm()
> +{
> +       local ns=3D$1
> +
> +       ip netns exec $ns sysctl -q net.mptcp.pm_type=3D1
> +}
> +
>  subflows_tests()
>  {
>         reset
> @@ -2468,59 +2475,59 @@ userspace_tests()
>  {
>         # userspace pm type prevents add_addr
>         reset
> -       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> -       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> -       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +       set_userspace_pm $ns1
> +       pm_nl_set_limits $ns1 0 2
> +       pm_nl_set_limits $ns2 0 2
> +       pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>         run_tests $ns1 $ns2 10.0.1.1
>         chk_join_nr "userspace pm type prevents add_addr" 0 0 0
>         chk_add_nr 0 0
>
>         # userspace pm type echoes add_addr
>         reset
> -       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> -       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> -       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +       set_userspace_pm $ns2
> +       pm_nl_set_limits $ns1 0 2
> +       pm_nl_set_limits $ns2 0 2
> +       pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>         run_tests $ns1 $ns2 10.0.1.1
>         chk_join_nr "userspace pm type echoes add_addr" 0 0 0
>         chk_add_nr 1 1
>
>         # userspace pm type rejects join
>         reset
> -       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       set_userspace_pm $ns1
> +       pm_nl_set_limits $ns1 1 1
> +       pm_nl_set_limits $ns2 1 1
> +       pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>         run_tests $ns1 $ns2 10.0.1.1
>         chk_join_nr "userspace pm type rejects join" 1 1 0
>
>         # userspace pm type does not send join
>         reset
> -       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       set_userspace_pm $ns2
> +       pm_nl_set_limits $ns1 1 1
> +       pm_nl_set_limits $ns2 1 1
> +       pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>         run_tests $ns1 $ns2 10.0.1.1
>         chk_join_nr "userspace pm type does not send join" 0 0 0
>
>         # userspace pm type prevents mp_prio
>         reset
> -       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       set_userspace_pm $ns1
> +       pm_nl_set_limits $ns1 1 1
> +       pm_nl_set_limits $ns2 1 1
> +       pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>         run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
>         chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
>         chk_prio_nr 0 0
>
>         # userspace pm type prevents rm_addr
>         reset
> -       ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
> -       ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> -       ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> -       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +       set_userspace_pm $ns1
> +       set_userspace_pm $ns2
> +       pm_nl_set_limits $ns1 0 1
> +       pm_nl_set_limits $ns2 0 1
> +       pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>         run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
>         chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
>         chk_rm_nr 0 0
> --
> 2.34.1
>
>
