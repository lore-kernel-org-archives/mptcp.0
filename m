Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759AC2D9
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 15:00:11 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3425eb6865eso2944725ab.1
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687964411; x=1690556411;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eetOjnTApp5cxTG5hklIs8E4NLcACpVvJJTtWvjdhSg=;
        b=Skd+I6RZ9cebaf8cSR/fOQYb5lHx39J1U6Xwxhj0sSc9smTFk0jhZhRoZoL3q68Iwe
         g4858NChmDrutwxET8U/kUsUllIfNsM0f8AIIQ3iLgiOmQi0yPU9AWz60oRJt4EyACYX
         ujfNy8ORJns5pmg2zPAhA9/J3M3O/mqzuZKFRo6kdB/uZzRoFDyMIgSNEJVrUMeLLpRb
         OoCn0uqZdXFEK1NuSxX7TaZd4EvFiWEHWIzqWQiN+WQmsgBrqXXQaNEvptIf+J+O3VSO
         38oQo2hCGfj6qCK9XkhYHpjz495vO3kqVBA699/Eka5TfAmSxq3qPfm20AyzWdd/f1ch
         z/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964411; x=1690556411;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eetOjnTApp5cxTG5hklIs8E4NLcACpVvJJTtWvjdhSg=;
        b=SloQsJWWIOn5gQzmJULaDdQ09TbudH3sQ7sLyHADe3FSBtL4RC08F6tkaGdAzIPrl0
         Y6hlUiqKaZ+wEcbx6FgNhBdy84qJwsJNghctsZZ3UFixidWV9aPVSuS72q5vvEdP+sm5
         YZQf3gWoCfPMrTKAUns5jmdJWOQpajIezAb6z86R22j7hB36ESdmH15EywIDsbhYY8Uh
         R/OWeClCLjHIpEQuujG1Z2IlEGXymHYTLyjAGqzVpwO6/rhyxpcr9zNPKmOfQHs5Yc82
         UJFobvW1BXJokygv/3cmN/5rHlTAnj0LquY15q8y0STMpWpyfgqvmrDWC6E6ZFInsVwj
         WyGA==
X-Gm-Message-State: AC+VfDz4w69BVBvk3HqIGetvohWgGDflMcK0CGT+at47vFPFpOZAHCeF
	Q3IG68tpUz0oQwJs4Ss5Hn+9Ue8p5w==
X-Google-Smtp-Source: ACHHUZ4WUIMD+b+M/Ho6ZEtXShmwfOAIm8YV6NFLitELggQzytKifDdEjBIokYcYrQe6oSgLkAFplQ==
X-Received: by 2002:a05:6e02:f42:b0:345:bc57:fd17 with SMTP id y2-20020a056e020f4200b00345bc57fd17mr1151748ilj.6.1687964410889;
        Wed, 28 Jun 2023 08:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.251])
        by smtp.gmail.com with ESMTPSA id h2-20020a0566380f8200b0042907798fbcsm2418801jal.161.2023.06.28.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:00:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <https://lore.kernel.org/r/20230628144927.828117-3-matthieu.baerts@tessares.net>
References:
 <https://lore.kernel.org/r/20230628144927.828117-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: colored results: Build Failure
Message-ID: <1a972c2f-9435-aecf-f0f2-a9c4563ec831@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Jun 2023 15:00:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/https://lore.kernel.org/r/20230628144927.=
828117-3-matthieu.baerts@tessares.net/
  https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/5402608063

Status: failure
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next=
/commits/0e5246c54f2c

Feel free to reply to this email if you cannot =
access logs, if you need
some support to fix the error, if this doesn't =
seem to be caused by your
modifications or if the error is a false positive=
 one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
