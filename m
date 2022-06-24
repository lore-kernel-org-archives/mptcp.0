Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D27C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:49:39 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so4479984fac.13
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=WwEQ68KiJ5hjziORIVhqwJv+nET5h14vCzqyNodQ5CA=;
        b=n+VlLwij5RPZeU19c60HFoQrHqmeHpD3kvhdKZHpykoiEAnDAQa0XYWPzd7h12EGee
         eLtAcSLfuePxckkYcszQXY3BZOV7eSTw24bhoYJlxLRKeXyLsHbDPKj9cttFlhY552TW
         0RvjhbRsLb+gYy0C7X258Sx94xAEplEG3Uxrrb+zLKIofW2SQRi0QITaeDInuHhwFcxE
         EYuQ4Br7ECOLHvhOeob47LGU87R8B2g5BjU2rC/RvacuK6s2XBG597UImuqkzllizF3X
         LpVNeeJSWjLi1Dh24KVQBVkNC1Aot3THXnPpJXg5O/SabGvR5NFJ/eMa0d7DPF4XWQzJ
         1rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=WwEQ68KiJ5hjziORIVhqwJv+nET5h14vCzqyNodQ5CA=;
        b=ZuLWk4SDKXTzNo851O9WY0KoTzhqHIm7bPCqTZtphmckN1LgYxtestFsGcvHAC9PPQ
         L13ELT4ztI5gqoOshFyZAfWC1MpIozGOluiQQgC1ItmAN/xbP9dixEtNae3Nl/odAflf
         yOXJ9mtok/TbHS0sUzhDxJwElI0XwxJjBrA1vDqKKys07reZVMunXDC35mCtgBffr3ZS
         KKqPZMBiHWlhqIsOZRPkD2xTJQJXfN4H/emN7rNGuZB9F869kpomjLCuQWeyEZ8tpsFE
         9fJ2McWL8w7eT/9H+Pvrj8vp9lAZN2XycZIgk5l5/RQAFAkdEE+lAVLzTCy3cdS+vWAZ
         KOyw==
X-Gm-Message-State: AJIora/4oOax6CBJIxYn/jW1CAZFao6nTFVMZ9BxC1c1sBWLQV9vNTuR
	9DDcIgArYjvKnJWfnL5KFw==
X-Google-Smtp-Source: AGRyM1urdu4kOpTF+0A1wLuyMIJ38XpjEZwIyRD4XuaQXiaGEqAGtdXv44FE1pteTGQX7pYsIEkKqA==
X-Received: by 2002:a05:6871:80e:b0:101:fa85:8519 with SMTP id q14-20020a056871080e00b00101fa858519mr2618341oap.254.1656089378989;
        Fri, 24 Jun 2022 09:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([104.214.107.219])
        by smtp.gmail.com with ESMTPSA id h20-20020a4adcd4000000b004258ce7a111sm269067oou.24.2022.06.24.09.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:49:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406.git.pabeni@redhat.com>
References:
 <25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406.git.pabeni@redhat.com>
Subject: Re: mptcp: more accurate MPC endpoint tracking: Build Failure
Message-ID: <ee2ec742-07e3-1b26-90f1-129c1360fd5a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jun 2022 16:49:38 +0000
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
org/project/mptcp/patch/25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2556986908

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e01f9f5a36=
95

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
