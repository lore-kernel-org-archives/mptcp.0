Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCD22627
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 21:56:14 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-623802d9bfdso2067526d6.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684965373; x=1687557373;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+jelfPCUjVIEttxUet5gmo2YblovYR4pgF5VyxOWeE=;
        b=efDYdh3Z5Sn3GT38Cb5hDjpCeRIYUKDapUZ4uLB9BENAcj6OmcMXMAXYSX7/A1no07
         4bW/eciEItTWSp2fX2Hm+PGRILqO597q/3wKnL9k6B0KgQFH/173c3SMzCUF0xHssE6k
         GO9idqGdtma7Iz5XRHNkSP1Q69gQtjTiiySeIv1PnIWj+u2J80ExUwva3HYuD0YyB/57
         +yq68HwiE4B7+WGNgmiSVJeW1rmIR9x9kxmB5wbuVewExxgeNmI8Q1jeQH+TZVIUjimz
         L/ORKaD+iQV/waRORlexipTRxjf73zdUffPmRyWmeeLZjdSeWdRyhGEL9Mm+4xgM/CYv
         KpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965373; x=1687557373;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+jelfPCUjVIEttxUet5gmo2YblovYR4pgF5VyxOWeE=;
        b=bHdJ86XXxPbAjBuIgMhXeZxZQ3igsjtjVxlsisX+tTfDIRPQYlhungHh4g6/aZ8W4a
         XS1MEdYwE9DnQEEIZjOul8/zQIsY5RLpGeUNKBfLQQfNn4v3FoDjm8IW6Ko8Vzi0xXYc
         jvtKDs+hXLdMoDjePUWxyST3hkqM5nl6BFKGbzdBveq/TrZCtrE3E6XolBZF3YAQDfnw
         e7Qc1ewQPjuugejXiwsBBAH/f84IMNoQBV3EWUzpaAG3loNG6naiOeCziOCNsIFWIRm7
         v4VWUz85Cd+/19bx0Ej1xe3rdU56YWa46TTCWyj03Q3h5XLcCCWcoh2XLf9v3J8pfwj/
         7c7Q==
X-Gm-Message-State: AC+VfDxLrdMVdJQeqkJIXmpDNFhcvBozylpWVOGyTb6XksbZu5NLojiA
	5idMSg9zsZlUm5hfzHVewPmVxasMOlhy
X-Google-Smtp-Source: ACHHUZ76merMg3uZENqXq8i0iQUp3sncZrq31hRNwww0wIHRgfBkGdmK1GFHAC2iTUPk6qTQ6oaLlA==
X-Received: by 2002:a05:6214:21c9:b0:625:aa49:cead with SMTP id d9-20020a05621421c900b00625aa49ceadmr3613818qvh.54.1684965373567;
        Wed, 24 May 2023 14:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.188.83])
        by smtp.gmail.com with ESMTPSA id v16-20020a0ccd90000000b00604ee171d99sm3814469qvm.106.2023.05.24.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 14:56:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <803034fc4f174c8180befe1e859675f99784874e.1684962909.git.pabeni@redhat.com>
References:
 <803034fc4f174c8180befe1e859675f99784874e.1684962909.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Build Failure
Message-ID: <f7f02900-f7ca-dc61-e0e4-4cdb92058d39@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 21:56:12 +0000
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
org/project/mptcp/patch/803034fc4f174c8180befe1e859675f99784874e.1684962909=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5073733505

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d241aa733a=
df

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
