Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7C70
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 15:48:38 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id f8so2990663edd.11
        for <mptcp@lists.linux.dev>; Thu, 08 Apr 2021 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3rI0oy2y/b2xG5cJ3yyuD1zAiQRc+JfIWOE0fw0RJ2w=;
        b=J4dx6m7fXgO5h5Ns35sqYS9qwJz2PL1DyU10K5vwf6j5RIpNNgj8ikcdw2UJJRL+5l
         bU8yiJ4M47sDixRuBDZAUJc50ZG69DdHT53AY10hEsIoh7MlWx2Ly9rAtAP9varQ5XRD
         5c5s3wXwuPBss0xkZASYqjpSAcIWeDCIr57YeoPYdxi+tMqBpQ9pM2PzJlFLCP+1W/50
         MT3mroNCQ8wkluj5aDaZ/voZeudRFppM3dOq7HMfum58Xk0N53BsmcSgqKWnai8gAF9F
         70a1cZL1FTLpoDX8FBKoCJsJwnnh1ycuSRO98dPdHoKF1/QUlZDs3Rh2F8sDxCQ2LWSo
         S7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3rI0oy2y/b2xG5cJ3yyuD1zAiQRc+JfIWOE0fw0RJ2w=;
        b=DZjwMY52P8HTtVRpW38qEs3TJlBmuie1M6znnQvWbQkzJ6HlW6da9zujZi1AcXRr8P
         KNm9gkrP0ToS+PMi0NHo1moMfX8oCTQzIq7hXk1yE8RAz6vvoD/tpY51v4qf+UE7cnga
         8ZcfjXOcHYtRY04QOFW36SxE2ZTzthYcAPNj8ezUSiQDBxjb29fwmZrPjfYRguqpc3pd
         QtcoJFxJeZHQU0wRJgAt2WAxcUMZjo8Qlh8O1OW5u/JJhbj/B9lhDXFI8b9UM9IvyYdG
         lKP1zhfdqxEWCvbbVP+pFioVqnYO/Ul/h0kJWkgGD7Hnsn2ojlK9zBQw58wxCoTbA7ny
         JHpQ==
X-Gm-Message-State: AOAM530pf6HZNdw4LvZZ7/Cy7UrADirlGb2S1LZRnVjFT4AeK+Z/YMch
	Tb3KzC1O8xnr9jsSP/dDyNo8Y1+Af3h1TrW1O3Ak/4+3
X-Google-Smtp-Source: ABdhPJwxXNVz4g1YldvlLBaCy4PR2MlyjV+MyV4GvbW9s3zZxo3v+nimtUxvzHChGIAnImbl6iJdArpR0Xbvl5fp9NY=
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr12234779ede.225.1617896917370;
 Thu, 08 Apr 2021 08:48:37 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1617703144.git.geliangtang@gmail.com> <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
 <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
In-Reply-To: <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 8 Apr 2021 23:48:26 +0800
Message-ID: <CA+WQbwv7mtB1Fdp0AWsTjLdK8qMs5yiQnESYHQoNUR-xOL3U3A@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next 2/2] mptcp: use mptcp_for_each_subflow
 in mptcp_close
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

I think this cleanup patch is still valid, isn't it?

Thanks.

-Geliang

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:03=E5=86=99=E9=81=93=EF=BC=9A

>
> This patch used the macro helper mptcp_for_each_subflow() instead of
> list_for_each_entry() in mptcp_close.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d895c3c8746..3b7d1df8d019 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2581,7 +2581,7 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
>  cleanup:
>         /* orphan all the subflows */
>         inet_csk(sk)->icsk_mtup.probe_timestamp =3D tcp_jiffies32;
> -       list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
> +       mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
>                 struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>                 bool slow =3D lock_sock_fast(ssk);
>
> --
> 2.30.2
>
