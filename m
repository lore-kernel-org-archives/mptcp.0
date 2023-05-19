Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979F5692
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:58:17 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so29358285e9.1
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490295; x=1687082295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd/p8n9RSZjWlk3pQKOmIXdZV/SDUv0LWR6imOpJHKI=;
        b=FkSJvX6Tr7rHnprlk73j+g8WwRP9WVtCV4qhbpGQoMsSQwQBzSPN9avg8SEq8MaLtR
         QIQaK7qYEiaugE8jKsEv7sKLEx0K8McIH+HvJHsDYQ0ltXNjV8y/unlcjFCeaanTXN+2
         YTx+2CvQ2sP1T8VFnHvdkbLTP9pCQLiBs9F3HTImHYaZ/fdCw+Rfjtw9iJ+wXGdXV6Xl
         wLdJ7nbze1+p3SX2q8rJJ2YnKhmHCqJQovrT0Bz/nkaVmnJ80zYLn35I08U/NlYgXORN
         nhsEz1mBe6uIzqsHfWZjR2XrU1yGmlQphF3I5P6MufXR0wDXKW8zwTd9bHyBApCNn0zX
         M/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490295; x=1687082295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd/p8n9RSZjWlk3pQKOmIXdZV/SDUv0LWR6imOpJHKI=;
        b=lF6Cxxw2XQIehgdOcpkaYMc9Q8MNbG+xUsmLlyVX0NniJ4KlNY58axw0hwLjvRRBFv
         rWKx862N72n/xsWHmHlXMCc/i3p2oO4UvCTaQeqAsxJEOKZvgQtJjOKWa+bCVZomk4P3
         WmgXa/RN2iux7oVaM+YvhrL3WsY8sidgy0ixkd69T3fQk4sJ/gUIboASPf8pQUAkln4Y
         /TuAoJyC2irVvO0B7ZXy5r/MpbGehvtYnAkEVScAQlNDeZ+bWdz7+oc7HFTb+MDTqQrx
         xFZWaFOkgfbZHcFID2ELYSwL9FsLG43bXspxdD5AwvCGjSN9wM9LBwQ+09X12QP02yKQ
         eF4w==
X-Gm-Message-State: AC+VfDzgU9m89CDQlLBDHT9NxI9wmPhNlyBo7rR4wjvvoNWDHru65Jv8
	LJGSlObWSzf5tQQnZHHkjpUrn8kAcAGn4qfr/3E=
X-Google-Smtp-Source: ACHHUZ71bBs2NLzgZnNEAyyQHQaR4/Z9z7VEOtx0gFavFq1OtyfTopOGwU4IG04nezOzRFUSragV4573KkCK5ileY4Y=
X-Received: by 2002:a1c:f709:0:b0:3f4:16bc:bd19 with SMTP id
 v9-20020a1cf709000000b003f416bcbd19mr896956wmh.23.1684490294882; Fri, 19 May
 2023 02:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1684362296.git.geliang.tang@suse.com> <8f268175-128a-d015-af04-defe4785bdd6@tessares.net>
In-Reply-To: <8f268175-128a-d015-af04-defe4785bdd6@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 19 May 2023 17:58:06 +0800
Message-ID: <CA+WQbwu_kCmYw94WnY_+4mYE_pE04T4NfUKBs=y=81rwcrY2+Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/6] run sched tests in a dedicated ns
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B45=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=BA=94 17:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 18/05/2023 00:29, Geliang Tang wrote:
> > v4:
> >  - patch #1 could be merged before "mptcp: refactor push_pending logic"
> >    as a single fix.
> >  - patch #2 should be merged between "selftests/bpf: Add mptcp sched
> >    structs" and "selftests/bpf: Add bpf_first scheduler".
>
> Thank you for the new version and for the explanations!
>
> I suggest to apply the first patch also between "selftests/bpf: Add
> mptcp sched structs" and "selftests/bpf: Add bpf_first scheduler" as it
> seems not needed before (see my comment on this patch).

I agree. Please update the commit logs for me when merging them.

Thanks,
-Geliang

>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
