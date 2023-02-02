Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8367F
	for <mptcp@lists.linux.dev>; Thu,  2 Feb 2023 07:55:59 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id y1so892761wru.2
        for <mptcp@lists.linux.dev>; Wed, 01 Feb 2023 23:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZaRLWGKt3SAujksEsSJFqPjUsyQ/D3Ki1Z/FfvRqdo=;
        b=km1DeMQBYZ+WQWrV/Zsde8CxN6TGegSq9KOMLusK7oPSsYgnOaOkuAj8cIZIVkmxuB
         MHcmYjTcK3YxiXmtAnhECr3Qo13SpnOq1CTS05FPKYOWMD6FJUnS1edTx6igeFGI6iJt
         e2m9tJL6NumFWRxA4m1NEDN8zZ2jqLNdoqxGsMU1qjK8vbiDs8QEUzrqH1nVgy+ONuqE
         n/nHft7udgoEDMj0P80KFZIyTHbphp5dq1ORskKbro9HTWz0uiJUwwjYBaVdCPQu4WQH
         sS1lzauGwxdVT/Y1sRa1eMvKF2bGiLtSUrnBG1Al624sApFMNjfI6GoGkZ2Rnj43pOli
         DkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZaRLWGKt3SAujksEsSJFqPjUsyQ/D3Ki1Z/FfvRqdo=;
        b=N5TSTz+nFo+P1i/rdPEaI8Y1U0Rziw//ozJw1oHtLRUygEt9xggXrzqne5QGxvR5/h
         Y3t5aORoul6S3o6gx6htbhhQmaDvHFJurehCFajW6hOzwFWm8ziir/aSaLWhHS1mKaRq
         LUgbOnvQ1TqeHRuGKmnvuKeq6e6+MLXdADq25dL3f9MEalLkYcPDJAFho5UwX+hJqZ09
         YRurFhETP8riOTCOHqf/a9B/PXU8VSNAWL/UsafG/DjOklkzEsQ4J3/6dTzWCKl3hnC8
         AplT9ywJUnJG/NdSW47oi44osLZiweMzAbwMp0yYdUdBiz7Zv9AwhgAi8KjK9N5ZOZd1
         f4+Q==
X-Gm-Message-State: AO0yUKXPbxIuS2zaaOOsRltH4ZKEVC6E+enR0+IVdqNsiory7e07y+0V
	3Xe0A4BZ/KTvN9CzgvqC8VkjXmos/KmCeNnbVsQ80v/Q
X-Google-Smtp-Source: AK7set8Y2bqFPNScx3oGG7xZsFTM3feHcHW03i3m7DXFEN8SdaMztuk3hbfWJkTF9Exbnr+HOEq8mWtLfreOD2aGNI4=
X-Received: by 2002:a05:6000:15ce:b0:2bf:e778:41ae with SMTP id
 y14-20020a05600015ce00b002bfe77841aemr268379wry.227.1675324557997; Wed, 01
 Feb 2023 23:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
 <CA+WQbwsOc66b+3a6RwCto4xa-JCoGt7gw_zGWadxMoWN=umWZw@mail.gmail.com> <d6d7bac0-fd4e-1417-8b02-d81314c2f744@tessares.net>
In-Reply-To: <d6d7bac0-fd4e-1417-8b02-d81314c2f744@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 2 Feb 2023 15:56:34 +0800
Message-ID: <CA+WQbwtJMpvCTo+h-HBUohT16Cwxg9ViysDRHLQrqo7dqUorTg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: stop tests earlier
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B42=E6=
=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 18:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 01/02/2023 06:17, Geliang Tang wrote:
> > Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B41=
=E6=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 19:23=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> These 'endpoint' tests from 'mptcp_join.sh' selftest start a transfer =
in
> >> the background and check the status during this transfer.
> >>
> >> Once the expected events have been recorded, there is no reason to wai=
t
> >> for the data transfer to finish. It can be stopped earlier to reduce t=
he
> >> execution time by more than half.
> >>
> >> For these tests, the exchanged data were not verified. Errors, if any,
> >> were ignored but that's fine, plenty of other tests are looking at tha=
t.
> >> It is then OK to mute stderr now that we are sure errors will be print=
ed
> >> (and still ignored) because the transfer is stopped before the end.
> >>
> >> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases"=
)
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> ---
> >>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_join.sh
> >> index 52484a7c286a..42e3bd1a05f5 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -498,6 +498,12 @@ kill_events_pids()
> >>         kill_wait $evts_ns2_pid
> >>  }
> >>
> >> +kill_tests_wait()
> >> +{
> >> +       kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
> >> +       wait
> >> +}
> >
> > Can we use the existing function kill_wait() to do this?
>
> Not easily: here, the best is to send SIGUSR1 to mptcp_connect process
> to do a graceful stop. We could probably do a SIGTERM but still, in
> endpoint_tests(), we don't have the process IDs, we would need to look
> for them.
>
> Also, we want to wait for the whole "run_tests" -- launched in the
> background -- to finish, not just mptcp_connect but also the validation
> part with the different "sleep" before executing the next test.
>
> So I think we should use this new kill_tests_wait() as it is, no?

I agree.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
