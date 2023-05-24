Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B817ACE
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 14:17:08 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75b3645fb1fso82145585a.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684937827; x=1687529827;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCmCX0G+Y7KB6WWGLfK8Skyd/yt1Z38mYhE7mbM6G2o=;
        b=KE2h7/VVIi+o6vzQP3NjJ/hA9slZ44Y+I/fuFzerjZMjqpP80KApOIdD7RXJqTaOfj
         wDjWRta8jJFB0Ar4LDcdJ5QR+CikzF/pssuuhqeF8XMYa7Pd7eKGDJ8AF1F/whnlRHls
         2JcbG5F+xQiILRf53qzVUjidLQUeYYTdZG+3C3A02Pn0XyCe+vzlTYWVal7wE/N3IzKr
         eCLf2pVqPPxmRboXzqqHxG4pKca24euYeh27uHSo360bJrEq4YZtl4bYwcVR2y2mR85w
         +r0b55zmXSYoVJQekZIcqIomt+htaeItgTVTqNr+N4Pgix25AARKIAXbErHPC6dTSvTx
         J3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937827; x=1687529827;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCmCX0G+Y7KB6WWGLfK8Skyd/yt1Z38mYhE7mbM6G2o=;
        b=dQyZLmibJAoOFjjIAkG76soXgTsYOvW176k7mjCF4LoReAxVHoBKavlWh4F3LMNNZQ
         +6+tm5iSn8pDkdf17zwpwLxmy+641z6SCRC76DcksrBbeaLWo19JQohyERWNiD5OPoPL
         qVl9mvdStjfK296GDENnQ4HKOYQbozSzCFRv2awWydkH4Vz4dFpW389WLNAjT5jsHkDJ
         gPtA1JrBxVWP1c6q+xL0jyVNhavo4ao614qVEBX/1V/vYuC38OL4SlONgpDU9g0ajTVd
         6rO6P0xVMQDYUtlHPFa5lGcoL8si0YFi+JmlPzw7DywqOAmRAjJ+G9OpNb9x5xSKZBpF
         Ns4w==
X-Gm-Message-State: AC+VfDx63RJTHX6eBsd7QXMCGbdmpwtrQQUrxW6D04N05JON6Ets49Fi
	8lD8uHedovR7JemMANsY4A==
X-Google-Smtp-Source: ACHHUZ4cupWKFlbAI7MHEtU6FmJHtv/Iv6fjqSLkv/R+Zq4XopaAMkOOrfGqHyOcUR6nFs876xj3lg==
X-Received: by 2002:a05:620a:2b28:b0:75b:23a1:d860 with SMTP id do40-20020a05620a2b2800b0075b23a1d860mr9413320qkb.34.1684937827510;
        Wed, 24 May 2023 07:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.13.55])
        by smtp.gmail.com with ESMTPSA id c5-20020a0ce645000000b006238ac6c3f3sm3614942qvn.33.2023.05.24.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:17:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
References:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Build Failure
Message-ID: <c37731c9-6c19-8ec3-69e0-db770312a397@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 14:17:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/930270fbc3358d0c423357f770b679745f8dc4a8.1684935727=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5069697633

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/63022ec27b=
06

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
