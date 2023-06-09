Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E689819907
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:49:55 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d44b198baso1490900b3a.0
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686325795; x=1688917795;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxzWZAaWsrZfFCr7YO+1C9yKhk2JYAXn5UM+uaCfhVc=;
        b=oxRNXrCPdPrwkDq54vKnRzpvQVgPIrQzDShwbc3pNsCddG7ffqO9kZ+gqE1wRdzTpu
         rRR5hqP6xm8zab1YGsh08m3bqAj5qUGeE4X3k4nD/XRQai6S3t4T6QGzj9OEMHq8k0G/
         oMCnjiAaoNm67h01BEY/Wrbs2iaLYtF+bFS+CZYPL2SZjyizHdLiI2h8Y2RcuKnmReSF
         A43jJl8XNfUgYw9vzMjKxksit4wcXPcG3ZeeKTDGwZpzyR3oPaGwfX1K+PGlEz0snrSr
         zD9eIRjThAGtzOozw+XYvSGyS1X4gy0fcuIQIZ4oKt+UDCniKXysdlxfOvZn2FPGt1lJ
         iXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325795; x=1688917795;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxzWZAaWsrZfFCr7YO+1C9yKhk2JYAXn5UM+uaCfhVc=;
        b=fA85AlMXt96MRYJwlwky2gFaMQqQ/cKqLWT0KTXbt56YU7J1jmX1mAmWL1TgSHUCs3
         5ReO4qx58xH2g7qJ4jR8b0FHLOHFas4zAvtb1IGC2Hc+GVfiOfTUSHQ35xLKDCeu5YAr
         RmwIevjH4dsGmhqWQfw1FHhB3Oo3om1xUfYSA2g64AgSdVH4zU+Pg+KAdI88nJKX1AHT
         e+ZLtfTOGVbTlnscOgyUtgqnWgW5GdWWFr6i+6QxPWgNIKcB3lzQkcsdOA6Pr8q9S36G
         XcP5jJUbgZW4nOQ9TUUxt/zULGoel0LJ5o+XH/7rrG03UMWuwiaPgY/wJ/DROkuf/zX2
         uhjA==
X-Gm-Message-State: AC+VfDwWOZQutwAFlZsXDZLjEtx7dvOshNg4tRYF9Z/hpViKqXpPb0TP
	/SfPK5NNLliT0KxXMOSpNmCwIqgwMACW
X-Google-Smtp-Source: ACHHUZ6wpcWZKEnVTXY8CWn28/YkKSyq42UgcxP8h8pwjz3Ol0SnGScmuT8rKmHvsmpT0LtIhOJ5JA==
X-Received: by 2002:a05:6a21:6d84:b0:116:fc1b:fa38 with SMTP id wl4-20020a056a216d8400b00116fc1bfa38mr2520781pzb.7.1686325795190;
        Fri, 09 Jun 2023 08:49:55 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.75.128])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b00659b8313d08sm2846495pfa.78.2023.06.09.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:49:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c399069680ffbe40604e1227aba47779ef7b030d.1686324786.git.dcaratti@redhat.com>
References:
 <c399069680ffbe40604e1227aba47779ef7b030d.1686324786.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Build Failure
Message-ID: <97ff8a97-d737-8696-5ee6-1f16c1cac648@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Jun 2023 15:49:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/c399069680ffbe40604e1227aba47779ef7b030d.1686324786=
.git.dcaratti@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/5223646544

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f7bd261a39=
5f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
