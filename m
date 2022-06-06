Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3F28F1
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 16:26:42 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id k4so4115963qth.8
        for <mptcp@lists.linux.dev>; Mon, 06 Jun 2022 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=68D3hiuYMckWuvjYF/pW82fpbGDeSpNDkfHdQ50hQkk=;
        b=PUh3ID8ZtElOhV8XObpHDuQvxrDdIUrKQsUXncm+doHIEEgNoMrk0Qp8UiEqgTw971
         FTF6bPeuLnTbx/l2sblbgR/J6NuQe2AB2K15eUmpKjlofqfGLCrvY+/MoZr7JBoxk+h7
         uEqPf8LyZQsdHMNpPmvHZvYzqltkV7SGm88tEnYbNG+5LxBRpz2K60v6pM8eQEXA0rkl
         xQqrBlrCGD4GlmTOAfcLJ24HIZ+w5iD/YbDN9oNVXoP9Fwa+2TguKT6QqDwzdmvZfLLE
         dmzFqRHAuYepgMzGtP6Vd4iDihwVigB0egH4dIdOjL/0FyDz2MFlY1Ht0wRy3nGtxfC2
         gIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=68D3hiuYMckWuvjYF/pW82fpbGDeSpNDkfHdQ50hQkk=;
        b=G5yDT/UWgYyBmGS6SP4WQJqf1ZbqlCUP8gnpsRbgvby4W60Q6LXL69HvEGpBHxNTJH
         0MbXuNu80KD+u7wZ3dlD+Bh0j1AU5tBihzlOhs5V4OLYYMgu18VknRmBNWo1TyZgRSK0
         BxeDBNWw/ufOvL9fj8PWujERP6j2+gd4EptnqEORlz1UsDO0bYB+5IsGGFQEbgJtlR39
         lW+y1cP3aTb1Qi0NW1/B4Fuwr77f+yPio6+WdcDC8aLdipvptpK7Ee+YZxesLdddZb5Q
         E6E2S197GzuzV4HcsCICvQtawRUPptRDcb/sk6ELcOR1RSw/zeyXlIvppUDFyAYJmms8
         F/7w==
X-Gm-Message-State: AOAM531Kxc+zwrUxpf6HmuAcGzlVKFJrRJxn1lroewu+JALlMWzo2LDL
	3+Tq6+2EKd1aJQACDZj0H5HhYktZ0a/Q0eo=
X-Google-Smtp-Source: ABdhPJwz9A1QnPW86pLIC5lCFrtlP+RAQdYwR4PgIaJN22Jr+rLCcFPcK4gLN0iE2ssm4lpkEG70wQ==
X-Received: by 2002:a05:622a:164c:b0:304:c605:4d34 with SMTP id y12-20020a05622a164c00b00304c6054d34mr18938324qtj.553.1654532799564;
        Mon, 06 Jun 2022 09:26:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.7.132])
        by smtp.gmail.com with ESMTPSA id az43-20020a05620a172b00b006a690e3a0e0sm2615067qkb.98.2022.06.06.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:26:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6a85c083498b77aa387de4e21c683b2230f0317f.1654526068.git.geliang.tang@suse.com>
References:
 <6a85c083498b77aa387de4e21c683b2230f0317f.1654526068.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <99f2d82d-633d-a263-41d4-203d74fccd64@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jun 2022 16:26:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join - Critical: 59 Call Trace(s) - Critical: Global Timeout=
 =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4759088235020288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4759088235020288/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 selftest_diag selftest_mptcp_join - Critical: 80 Call Trace(s) - Critical:=
 Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5884988141862912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5884988141862912/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e8e0daeb0d12


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
