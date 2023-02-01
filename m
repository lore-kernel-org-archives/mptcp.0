Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8C7F4
	for <mptcp@lists.linux.dev>; Wed,  1 Feb 2023 05:17:14 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id a3so9470280wrt.6
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 21:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftiaXmoYErwafsGsBGfH5K4Et+R/o/EHHuf5t8WiVss=;
        b=pHQ9BvmJiK8Nod/22/gudrzV6Ov9UlhQiCKAo1NwUhEueBqHr0gjS4X/WD+CHnC9UQ
         aMU9Aq5bhJCNBHzGtE/Sxu5Dwvvd/hV82+lkm8E1f7NQeh60o/tCZc+x9nKzXkHtbjr5
         3Acihemx51TmAa9TAGUauMsZo+S15nwiy856AbnGUV0Jo+UK9w60/oyNIjWqJc3sIoxf
         9jhXS6MxlrnGHkTAqWF/PkdxZFVLZX+bprQdfoD7IEwz/uKV8gUBeJAcNmZhgN8rhglT
         2g59gPWliLeeNimf1hF95P8krtMVNmAg6Aa+SKeV6HsX5nNj7lM9rVIXZFNwdjIvkSIB
         C1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftiaXmoYErwafsGsBGfH5K4Et+R/o/EHHuf5t8WiVss=;
        b=nwoNURgWuYIcxoH9xTCH7TYwPK9IqZ9LYfcAPsKfN2CUz9k3qwLg0xKxmTqJAKeDex
         +EX0vpuz7pkFh2jVx99qdsJgn0R8avsO3Ig8hK7X76e62n/0E/IbzNzIW2UDYEc0eEXn
         z0Yjc/o+K0TgDvKUQHb5yN3q/zstUXFY6vCo8fBb5HgCv/WZqb/aFZ5py63gqMBF+cZt
         dInDY/jZlLD/n3+650pX4tsz9LeC7bypQ+egH68rrkBx4MikgSdfxA6mJlVYRrPASjrW
         tafKo0+wIzq705GcQji6er/dbzT8ko3NSHrEIXKfYUB8JFZx1n3jNYVSO17b5i7RgG5L
         okpw==
X-Gm-Message-State: AO0yUKX5wJTEbQtGmu56kkFU0CR1IDeWVJmziLdpCEM0w6mvTLI4vsfC
	5TYC7EEXDsD7TCt2dPKu7BoUmS5aWu8FJghUmLc=
X-Google-Smtp-Source: AK7set/3ga2hdk+Mngfs+hwr2lwBnmcM+ABBz5lNTBQLgmc5cFuVIYbYKkDGGbeyyuMqJBUF7Pf2eX+l+R/1EgGjvDI=
X-Received: by 2002:a05:6000:1e04:b0:2bf:ae15:594f with SMTP id
 bj4-20020a0560001e0400b002bfae15594fmr34560wrb.248.1675228632893; Tue, 31 Jan
 2023 21:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
In-Reply-To: <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 1 Feb 2023 13:17:47 +0800
Message-ID: <CA+WQbwsOc66b+3a6RwCto4xa-JCoGt7gw_zGWadxMoWN=umWZw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: stop tests earlier
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 19:23=E5=86=99=E9=81=93=EF=BC=9A
>
> These 'endpoint' tests from 'mptcp_join.sh' selftest start a transfer in
> the background and check the status during this transfer.
>
> Once the expected events have been recorded, there is no reason to wait
> for the data transfer to finish. It can be stopped earlier to reduce the
> execution time by more than half.
>
> For these tests, the exchanged data were not verified. Errors, if any,
> were ignored but that's fine, plenty of other tests are looking at that.
> It is then OK to mute stderr now that we are sure errors will be printed
> (and still ignored) because the transfer is stopped before the end.
>
> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 52484a7c286a..42e3bd1a05f5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -498,6 +498,12 @@ kill_events_pids()
>         kill_wait $evts_ns2_pid
>  }
>
> +kill_tests_wait()
> +{
> +       kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
> +       wait
> +}

Can we use the existing function kill_wait() to do this?

Thanks,
-Geliang

> +
>  pm_nl_set_limits()
>  {
>         local ns=3D$1
> @@ -3089,7 +3095,7 @@ endpoint_tests()
>                 pm_nl_set_limits $ns1 2 2
>                 pm_nl_set_limits $ns2 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -               run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
> +               run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
>
>                 wait_mpj $ns1
>                 pm_nl_check_endpoint 1 "creation" \
> @@ -3102,14 +3108,14 @@ endpoint_tests()
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>                 pm_nl_check_endpoint 0 "modif is allowed" \
>                         $ns2 10.0.2.2 id 1 flags signal
> -               wait
> +               kill_tests_wait
>         fi
>
>         if reset "delete and re-add"; then
>                 pm_nl_set_limits $ns1 1 1
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags s=
ubflow
> -               run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 &
> +               run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
>
>                 wait_mpj $ns2
>                 pm_nl_del_endpoint $ns2 2 10.0.2.2
> @@ -3119,7 +3125,7 @@ endpoint_tests()
>                 pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflo=
w
>                 wait_mpj $ns2
>                 chk_subflow_nr "" "after re-add" 2
> -               wait
> +               kill_tests_wait
>         fi
>  }
>
>
> --
> 2.38.1
>
>
