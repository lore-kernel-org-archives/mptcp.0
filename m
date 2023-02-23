Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129D1C27
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:54:16 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id bq17so11088982oib.8
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxjVGH/HUQAk1sr5YbWTMuSscjxLZvUrQT2Rzvya08s=;
        b=S8elDUsTCy2d/OQhkqtdNo5LhqtKvqztpkhkU5dQJs0GEkXQJQ/aLY6WgFo2A0Xhfb
         5A4JilCzQOQ+u0VHa6wlsFwbEn2HDK41T4uRQc2+0j5e97QdTmbheusl3Z7gbtlwoaOS
         KESTtjOxcj52vHTJYqzmqD7YfhtKhe06VWGt9gHbY4sJ39QIVCoG7mR2EidFiXNxxIg9
         iSUJ0wJPDUJI6BS6NhnE3W6B0t+qLyb4NDYLurVhOfBIdH4Te9Zpv2rYrly5ZaVddsDI
         OuXVIOEHBWBSmLtG8egMTGTDW17WXF3qQErpGIGj/oVOk7j6QRHP4smRYzJKALX1p8Of
         CDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxjVGH/HUQAk1sr5YbWTMuSscjxLZvUrQT2Rzvya08s=;
        b=ZxMYDY+bjgmDWMoN+uTNSvl7gBs5AYMYjomPjBAVx0ImMKc5KTZDGJwCLkqSsof5iT
         md2uTQEuz3dpnqzrAvKozBmMLTY8Dhc78yT7wwGMRRI8C/oAhOiglLJDQS3S37tAoYvS
         uZgitA18VLUaJUxBk4/QHpE0cFWEcdGSPT2yakrH9bjhfS5BF0oKhyP/JZASI81PPmit
         vCic6xAmhWSGB+qVORq8sF3CR+mCvWBPX2BxyomaS7f34RwBh6905bnstvZD335dgNH0
         OsmoOmtHBNyCJhYcbePYARDg2lIR0u0d+6MsksaQ0YT67MYNI1ewDVkeTRRlJ81Ao1iJ
         /9Eg==
X-Gm-Message-State: AO0yUKXRykVIRa9ACXBC2jDc6VsyMQ6QHaIk+KxyhDNuYz+Ryqajx6c0
	LmoGPCn7uZtr3TiiucPt6561WoP+BM98ighOV/m3slgW27M=
X-Google-Smtp-Source: AK7set+29gXRWce+fZ0LNoD7zYynfHmBBlRQRzIGx9XXIN+UTXWfU9zdEV+pt27iz3/IOVAfbDUipsQTgPSlMsLF2q8=
X-Received: by 2002:a05:6808:11ca:b0:383:b8d9:94f4 with SMTP id
 p10-20020a05680811ca00b00383b8d994f4mr788588oiv.9.1677131655931; Wed, 22 Feb
 2023 21:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
In-Reply-To: <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 23 Feb 2023 13:55:17 +0800
Message-ID: <CA+WQbwuNVam8nM-pbNupxznZECiKb43-0RgRiEddF92vPjEsDA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: userspace pm: fix printed values
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B42=E6=
=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B 18:23=E5=86=99=E9=81=93=EF=BC=9A
>
> In case of errors, the printed message had the expected and the seen
> value inverted.
>
> This patch simply correct the order: first the expected value, then the
> one that has been seen.
>

Matt, this patch looks good, please add my acked-by tag:

Acked-by: Geliang Tang <geliang.tang@suse.com>

Thanks,
-Geliang

> Fixes: 10d4273411be ("selftests: mptcp: userspace: print error details if=
 any")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/te=
sting/selftests/net/mptcp/userspace_pm.sh
> index 66c5be25c13d..48e52f995a98 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -240,7 +240,7 @@ check_expected_one()
>         fi
>
>         stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.=
\n" \
> -               "${var}" "${!var}" "${!exp}"
> +               "${var}" "${!exp}" "${!var}"
>         return 1
>  }
>
>
> ---
> base-commit: 744bdaf391bf58029612bec80f292805e349ae27
> change-id: 20230216-mptcp-selftests-userspace-pm-typo-expected-e8774a5563=
72
>
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
>
>
