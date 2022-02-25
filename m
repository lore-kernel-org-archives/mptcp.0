Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613657A
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 10:13:39 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id q10so1972676qtw.4
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 02:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=gplx67nC+w7+iPw5Dr4rvLh6N3jYqt6SNWMTN47MyQ8=;
        b=dEDBx9fs+/MaUztS/RxcxiVsSbBoQlJjPyRhLzZ7M4xKsSpvo45J0aO3kO4vTGBv6x
         3wKVPVA9MWs3ZCI93N8CYwcmNB7vryk5zdpXUmBKFzEzKAPg8MzTyhsxcvyVHzCdMY0D
         7cHxWjvm2n+05R6nuXbKwWLgxoH/soRY4fQIA36ElOThRssN0nb0RYiFRkWTK9Yfn4ll
         1hPA8OzvnYAMmOac9E3OQIovqqb31MiaduRovW+gU1QRtsJ/j4AvrmF3i/0bfDWgAyRO
         aPkUih/VkxZ4/BDAK2aHNNF1BpBSCBICwuCI7xZgRwbTP82amZUHk1NYGw41OohwJAjz
         2vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=gplx67nC+w7+iPw5Dr4rvLh6N3jYqt6SNWMTN47MyQ8=;
        b=UHlCA9zm3KEZUrlNG3OAqYvPVJT7EGNrGZrFWJL/0uasVpyCmHV2iyI/zHIGtNegNw
         UOecqNTrE9b8IRlqogYh/SnCYKZpbG9RPJiM8+rTZLHlquy6vHDiPuoOt9K5/SoMqNxz
         juGdW3DPK93DKsyPjdWMXroNezUqCh6L/KXEprG6n28EX24fT+nzEjuVnEe0SEcZgbKj
         Y0nJDSkfNNlZa67pQKeYLUB7QeJvEAS2dAQlAuMj7dUcBIU07LogfkIsH1SV7BlytJVX
         vo7la6cUiZcQU7MTPJuPKJBQ92wQPiPaWYSL3cw9aBBpYqTT6e5u5av0yikfyAwDlDkQ
         KTzQ==
X-Gm-Message-State: AOAM532rLW84oF4Q05pbFV1MbBozHjaPvgz2ZpCIQJo+iC1k/a6/STB2
	+d9ERhWjI392tknuRBK9ZzaL2WNUQA==
X-Google-Smtp-Source: ABdhPJxG7FhbZfVBjBouJy9bMBpjGhSO0q+hBVj9Q12Z6dcVsFlJ3ZrtH+98WZY+8w9w/xWP90trUw==
X-Received: by 2002:a05:622a:1649:b0:2de:2dfd:8c89 with SMTP id y9-20020a05622a164900b002de2dfd8c89mr6078879qtj.267.1645784018253;
        Fri, 25 Feb 2022 02:13:38 -0800 (PST)
Received: from [127.0.0.1] ([20.122.189.114])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002de935a94c9sm1297347qtk.8.2022.02.25.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 02:13:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
Subject: Re: mptcp: send ADD_ADDR echo before create subflows: Tests
 Results
Message-ID: <fc8bd523-7ef3-1c8f-d5b1-6d7034b0d6aa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Feb 2022 10:13:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yonglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_mp_join packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4939098853998592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4939098853998592/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 packetdrill_mp_join packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6064998760841216
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6064998760841216/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/54cb4805b853

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
