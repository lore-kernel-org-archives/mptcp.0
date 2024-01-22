Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACC184D
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885359; cv=none; b=QEuxDP7wBLbHT76WxSDwl61ni6/A210a0Bz9CuYpYlBVbW/Zr5uIYcZnU2VSqrU4RADA5M02Mt8KmYrIdwjVehwAmvdhGcwUzOw2VF6rCTgkC0gMrIqltajs96q62yiV4994O9JDkMT+Qc6dgs5rMuFWyjz15l4WTXGWsEZnpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885359; c=relaxed/simple;
	bh=bHn4k31ETY7/fVjXSAFBj6oV/q3rQ+6fhx2fysW+zWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLiEMlHHSfPdhhlS1mozk8z0O2TZYOgAo79GAP0QxJy9CqUw09dFDUwPs3H7pzsMaQqBq2FJTvnUoMjWlV6PXIacOlFKaLAeW5ECrtIEQH9tXuoHFEo/c4IfA+apuSo/9IOZ4I8kp34trsTiuwiYRvj2uei++hcuyWKSkEvBLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHNaJN4w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHNaJN4w"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c375d2430so293480066b.1
        for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 17:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705885356; x=1706490156; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBDRbLk9AwXA16COeIf7kji0rjUWeRLw4C3XqzRxkC8=;
        b=hHNaJN4wTV6XwIzd3E7ftvfL+XjQhrbzYqKCB5RFiq89Ry8BeFZIPAv5GEVdQBEoHq
         jhEy665aHn5JtLPjNAhlxDDe5YN4kH5/4Xf3SVTvCQBE4NpBmySspJOR9wq2p2vBdUvG
         bruF6YYZLVkFwtNpX5Mt5G3F4Dcc7/5rvsIgzODQ0BsiAgTW6XZJyoHj2b8lSrZMMYQw
         ed9qVCU3KeEf6GgxzuC01rg/BAOWYq4xxhrCHChe/6Vy02qwScKp58nwqWpQImQaFvEd
         BZ4FW22vkHE9k5vDaZG8v6863VVUidAePWrnX9rBIge6CZktTN2cfmpviOGgV8JVuSqM
         QFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705885356; x=1706490156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBDRbLk9AwXA16COeIf7kji0rjUWeRLw4C3XqzRxkC8=;
        b=ScrYK0jzyMQjjrXiaRMWhGZM/yUVFAdAVsyh2uLC212/kodegsLNXY/i05GrphNix/
         N+o2moqn3mE3w5bOFDKIEHrcPKP83E+AsVSjqxFaIXKXSn9+Wwe+B8KssIpNw4FvKYSO
         8fjIPL1REQzhB4T2kjg9MnkGXTeaZU9V9LWuHAZ3WcdjRB18lGgy82TD71dSIRVC3fJr
         NqKnfK7vk+8OZ3Y36J37bau/QA7XFq8LR+zMFHQzM0F4p3t4fP0UAxTwgkdX0RQlNJIE
         v1rX1aJ3DiinQgHG189BA4WwBmzFTzicu7fVbSyISgJWn/+gDKHYbeTUe/xII4cPSI3P
         LquA==
X-Gm-Message-State: AOJu0Yydethlik8T6MBmfYkdx841h7ykaQUzhOrB8rzaG6//jLHhJxm/
	3H+B8ABDvBPTqIx0uK2E/Bkeyuzr5eDV/EwciwW783wJOhsgS8TzBM6FLu47qPGua1oZDwEOrRK
	bgmbWsD4Y9Ob4WQ/eKQxrfbgjL3vVo8gPs04=
X-Google-Smtp-Source: AGHT+IE/bd6Oppdt3N4jRvnfUyv+MvNl0pSP7tT8TgodgAYimzx5LjVwrDuK71LeEJ6LF/CnWYdmWom1vC5IkzbDN/0=
X-Received: by 2002:a17:907:7810:b0:a2d:4383:78c7 with SMTP id
 la16-20020a170907781000b00a2d438378c7mr1742449ejc.132.1705885355694; Sun, 21
 Jan 2024 17:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 22 Jan 2024 09:02:24 +0800
Message-ID: <CA+WQbwsY3U-jAf83UsA-66EJv4yc766N-Jgrz_zEDzaezcWOzw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 7/7] selftests: mptcp: join: stop transfer when
 check is done
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> Since the mentioned commit, the "userspace pm" tests of mptcp_join
> selftests are launching the whole transfer in the background, do the
> required checks, then wait for the end of transfer.
>
> There is no need to wait longer, especially because the checks at the
> end of the transfer are ignored (which is fine). This saves quite a few
> seconds on slow environments.
>
> While at it, use 'mptcp_lib_kill_wait()' helper everywhere, instead of
> on a specific one with 'kill_tests_wait()'. Note that old versions will
> need commit bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
> as well.

Great! This patch looks good.

Reviewed-and-Tested-by: Geliang Tang <geliang@kernel.org>

>
> Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++---------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 3a5b63026191..c07386e21e0a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -643,13 +643,6 @@ kill_events_pids()
>         mptcp_lib_kill_wait $evts_ns2_pid
>  }
>
> -kill_tests_wait()
> -{
> -       #shellcheck disable=SC2046
> -       kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
> -       wait
> -}
> -
>  pm_nl_set_limits()
>  {
>         local ns=$1
> @@ -3453,7 +3446,7 @@ userspace_tests()
>                 chk_mptcp_info subflows 0 subflows 0
>                 chk_subflows_total 1 1
>                 kill_events_pids
> -               wait $tests_pid
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>
>         # userspace pm create destroy subflow
> @@ -3475,7 +3468,7 @@ userspace_tests()
>                 chk_mptcp_info subflows 0 subflows 0
>                 chk_subflows_total 1 1
>                 kill_events_pids
> -               wait $tests_pid
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>
>         # userspace pm create id 0 subflow
> @@ -3494,7 +3487,7 @@ userspace_tests()
>                 chk_mptcp_info subflows 1 subflows 1
>                 chk_subflows_total 2 2
>                 kill_events_pids
> -               wait $tests_pid
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>
>         # userspace pm remove initial subflow
> @@ -3518,7 +3511,7 @@ userspace_tests()
>                 chk_mptcp_info subflows 1 subflows 1
>                 chk_subflows_total 1 1
>                 kill_events_pids
> -               wait $tests_pid
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>
>         # userspace pm send RM_ADDR for ID 0
> @@ -3544,7 +3537,7 @@ userspace_tests()
>                 chk_mptcp_info subflows 1 subflows 1
>                 chk_subflows_total 1 1
>                 kill_events_pids
> -               wait $tests_pid
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>  }
>
> @@ -3558,7 +3551,8 @@ endpoint_tests()
>                 pm_nl_set_limits $ns2 2 2
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 speed=slow \
> -                       run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
> +                       run_tests $ns1 $ns2 10.0.1.1 &
> +               local tests_pid=$!
>
>                 wait_mpj $ns1
>                 pm_nl_check_endpoint "creation" \
> @@ -3573,7 +3567,7 @@ endpoint_tests()
>                 pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>                 pm_nl_check_endpoint "modif is allowed" \
>                         $ns2 10.0.2.2 id 1 flags signal
> -               kill_tests_wait
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>
>         if reset "delete and re-add" &&
> @@ -3582,7 +3576,8 @@ endpoint_tests()
>                 pm_nl_set_limits $ns2 1 1
>                 pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
>                 test_linkfail=4 speed=20 \
> -                       run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
> +                       run_tests $ns1 $ns2 10.0.1.1 &
> +               local tests_pid=$!
>
>                 wait_mpj $ns2
>                 chk_subflow_nr "before delete" 2
> @@ -3597,7 +3592,7 @@ endpoint_tests()
>                 wait_mpj $ns2
>                 chk_subflow_nr "after re-add" 2
>                 chk_mptcp_info subflows 1 subflows 1
> -               kill_tests_wait
> +               mptcp_lib_kill_wait $tests_pid
>         fi
>  }
>
>
> --
> 2.43.0
>
>
