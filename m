Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0320FB
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:34:25 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6259c242c96so39468356d6.3
        for <mptcp@lists.linux.dev>; Mon, 05 Jun 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685961264; x=1688553264;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elZFVrueljKR1g/+SWb8fYIY95SSKtRet6QaR4B0APA=;
        b=O/i9OdwELMp8lZDeRzGLznkj8FFP4dIOSqzsWgyxxQ3w4OH4tlHCgksj1Hyir7UUp6
         bGfBKpJVmn1odw8c1cWTgXGdZGDE8E3K84wOUseu/0upSjn0lqpw1YaCnLEz3ZrInGx1
         ArQUQ7EHSpsLw3Xo5EPMbw0oAo2WYa5NZbXrqOGr39c2sAjn20AJDyVcY6AdmwT6P2Wz
         6eWeD/MBArtifsmO5u2RwEWhelKDJIXqaeWcPCrbPw81Z1J2Ts5pWFmtnePRRfRUTHwb
         pzOPvGdZopdqkaeOJJp1plTSy9BZXB8afy+s1mf8AnR4Ago87HUVm9CSRdo+21gQi1k5
         FdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685961264; x=1688553264;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elZFVrueljKR1g/+SWb8fYIY95SSKtRet6QaR4B0APA=;
        b=QcZBbKFCMHY1GxlIWJrfPmDtn1eEf/lQ0YyyxO+ae2I7w+yKQ2dla1xJZMvzfbDuj5
         TzSIsCY+3JnAJWV4brl4UQUBXDNj3CYBkNmZmCaqwJBmIc9wjzZrnregcGAP3INa6KsG
         knxqLj6FMfryG/AcZUJ3qhE4ruYgtsiC35ib7NkK4hDJQXJxypCNKbc/qAf2Fqal04uH
         nd0S31HPcb1Qu/xgQjRzioRS8rt+g7Z2wbIsocmV6PrsjEPeUuPjRnwISybKrX5XZBBf
         8npSQUEPT/W93q6z6a+d49aaeTPEQXGj4SGzl5njUA+F9UOCXNrIg+7NGj37ne7GbDps
         cPaQ==
X-Gm-Message-State: AC+VfDzrxFazAr6bDmt+lASAbD6lwPtNHih7TElGuSQ+BWDFC7IWlSy7
	lZ3g1U5waeb3yqpn8mRRLfJ4Ry7QCg==
X-Google-Smtp-Source: ACHHUZ5lHYHCPSmd1S74vEzN4pbDfIUUwWC+KncGa+8v0jm37PwTRPtO1KbvlTy8Z4bmpeyonyQ76Q==
X-Received: by 2002:ad4:5c43:0:b0:625:aa1a:b6d8 with SMTP id a3-20020ad45c43000000b00625aa1ab6d8mr8300761qva.58.1685961264014;
        Mon, 05 Jun 2023 03:34:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.188.82])
        by smtp.gmail.com with ESMTPSA id f7-20020ac81347000000b003b9b8ec742csm4590829qtj.14.2023.06.05.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:34:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315.git.geliang.tang@suse.com>
References:
 <cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Build Failure
Message-ID: <9cbb83d5-ee12-db3e-771c-352118812f5b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Jun 2023 10:34:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5175972267

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/03eb102a4f=
4b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
