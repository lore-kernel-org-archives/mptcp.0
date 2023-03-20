Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F8184C
	for <mptcp@lists.linux.dev>; Mon, 20 Mar 2023 11:39:34 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id y14so10021961wrq.4
        for <mptcp@lists.linux.dev>; Mon, 20 Mar 2023 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJGyYxtb1bQ6xHbNSxXvNeSr75P0UPbtnSBwbgHFsG8=;
        b=ZyBDUAn2rPwWGpRQOrRr3YeftHpm5s8T1Op2smHI3GFtv92uGs9VdS8q4JZ0ovp2Zd
         SJLqBidWOlmXi1gvWtZlx5DKRe5YTi1YS4LUhbm3fuf77I3fnsZtCITT86V4RM/a6c+0
         4R1+oLHuOB3pt+bf3O9NUOEA+gKfoG2Ac2FU0X2/0Aqrku/z42K0tpjgBhfCtMKzO3lc
         oTCcIKj+12uhYYcJ+V+Vm1Wh98X3s9DE8MMu9SoDRtplo3bOzaKsB5gpF8K9irFKsAoN
         i+aYbk0Bpn/55UEs3lElRwrhZ/2uiVlwmQZLR7/e2fzjkfNVUYjPSQKLcRbiUG11wrWb
         TVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJGyYxtb1bQ6xHbNSxXvNeSr75P0UPbtnSBwbgHFsG8=;
        b=kyhDaMergaXf5VSMIzwjhUOrSwf/7NiE1tMDx4UZU8/pJwQy+RY2mciVlo8uq8/RyY
         gx60alwppUblaEI+ykAAdslzzLsVudDxiIySl+gbsI/EE8ErexfGjPNQl12LcgsClgfK
         VuIlijiATYuNY/MIGY0SD63w/T3hQorUBohh+gGZU0A14EG+78dVUN3/EhBhiTa8zDOn
         b6dyWu9wUWXcN4TSFh8Os2U0iC1rouvm7GKlok1c1FkjTzr+7gXmYf7sSBnA7xKKZ/vA
         B324I7Vmh+2R4JFcjM5S/txrW3z/WhDoTYjA9GPG3/ZYEd80FWl5tWyLksz7aaikIpuF
         53DQ==
X-Gm-Message-State: AO0yUKU0r/c68rqIK0fYK6V5UlP1ahR1G2o8y3Evj0cSdzJHHy3v+jvd
	+L+tArTbgyjoZK2ZnRAOXmkUg8KAtq8GMN6WY0s=
X-Google-Smtp-Source: AK7set8SF9tLx6qGbGLmEAIsm8gU6frxkQ6HCNm65eUx+eevleeKEn8ypxNYEZJ9YEG5LisneCkZqG5quYPW9lYvw2I=
X-Received: by 2002:a5d:434a:0:b0:2cf:ea35:f8bc with SMTP id
 u10-20020a5d434a000000b002cfea35f8bcmr3108061wrr.6.1679312372214; Mon, 20 Mar
 2023 04:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1678778977.git.geliang.tang@suse.com> <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
 <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net>
In-Reply-To: <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 20 Mar 2023 19:41:03 +0800
Message-ID: <CA+WQbwv1gBROrXG-8Fb=T+p6rQNf5PF0gKB95mJzfQdsH8-mGg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when
 destroying it
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your reviews.

We always remove address together with subflow, see
mptcp_nl_remove_subflow_and_signal_addr() or
mptcp_pm_remove_addrs_and_subflows().

So we always get "chk_rm_nr 1 1" in these tests:

        # single subflow, remove
        if reset "remove single subflow"; then
                pm_nl_set_limits $ns1 0 1
                pm_nl_set_limits $ns2 0 1
                pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
                run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
                chk_join_nr 1 1 1
                chk_rm_nr 1 1
        fi

        # single address, remove
        if reset "remove single address"; then
                pm_nl_set_limits $ns1 0 1
                pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
                pm_nl_set_limits $ns2 1 1
                run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
                chk_join_nr 1 1 1
                chk_add_nr 1 1
                chk_rm_nr 1 1 invert
        fi

        # userspace pm add & remove address
        if reset_with_events "userspace pm add & remove address"; then
                set_userspace_pm $ns1
                pm_nl_set_limits $ns2 1 1
                run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
                chk_join_nr 1 1 1
                chk_add_nr 1 1
                chk_rm_nr 1 1 invert
                kill_events_pids
        fi

But the userspace remove subflow test got "chk_rm_nr 0 1":

        # userspace pm create destroy subflow
        if reset_with_events "userspace pm create destroy subflow"; then
                set_userspace_pm $ns2
                pm_nl_set_limits $ns1 0 1
                run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
                chk_join_nr 1 1 1
                chk_rm_nr 0 1
                kill_events_pids
        fi

"chk_rm_nr 0 1" means getting no rm_addr, but a rm_subflow.

This behavior is incorrect. This patch fix it. It looks through the
userspace_pm_local_addr_list to find the addr id, and send RM_ADDR
with this id.

So patch 2 is needed to add the address into
userspace_pm_local_addr_list, and patch 1 too, no clear the address
id.

Thanks,
-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 02:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 14/03/2023 08:31, Geliang Tang wrote:
> > Not only close the local subflow but also send RM_ADDR by invoking
> > mptcp_pm_remove_addr() to close the remote subflow when a subflow is
> > destroyed by userspace PM.
>
> Should it not be the responsibility of the userspace PM daemon to send
> this RM_ADDR?
>
> Do you maybe have a use case where it is interesting to force sending
> this RM_ADDR when asking for a destroy?
>
> Maybe we could do that only if the userspace PM asks for that by setting
> a new attribute or flag? (if there is an interest)
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
