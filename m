Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD528472
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 08:02:12 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-64ab0347caeso21470096d6.3
        for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692691331; x=1693296131;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8mbOtlkq1RwuVdbpJQvxUg1XyFPu3bsHITvEIV3KLQ=;
        b=NIt9n+ElTlmiUpBVDH1UBqCHti7Xqr2lcYMQW2yPrabTu2+OE9tgQPJQVzLChsszJp
         2gpvMCppNTUIps8z3LbAa37Q7wSS4qvdX2uiVj5hxpMikJwG+eAmS6I8a1jVrDu/FJcU
         CdMro+UXAZJe/Z93/GzEvcHUdQIDFRnTsTgyidhqNMjlbZliS8IBDOo5Qcfo28ToLIUN
         Reg8V3VE0/4uLB7BHxXx0Lg1E1YsRd7llnImw9HRt075TFEY0evD/TyGxWikiQcM1d2j
         TVhcL027VhTVGIDY+kQ0TIpetqI/MNJG86azn/Q8SBz9/JGaRSLiih3k88Tg/oQ1VAbC
         tS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691331; x=1693296131;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8mbOtlkq1RwuVdbpJQvxUg1XyFPu3bsHITvEIV3KLQ=;
        b=Rej3g/JTIzYQive7qOBcksiN4+tq8vEY8lgYuza4yksumRigiDJbIjWrGb+KkZjbJl
         Uh919TiIyN0PERx2MqILOuqKKCspBK8KRC/Yb2mFxIKHHnn4LrUH/hLf+StiglHpLQPC
         ZCs5/txzNv1UbelsgiJU4pnqSvrMBnfoPBWchVqJ7GujKEooh1On5T3QDoCjpdnlLYp5
         U9G2RMrDDVTAKAkXRzK/6WSTCDwgteLs/AjEdfvMYc6+Euv12qoKWOwYWkSLRzkEuiGp
         cXrOWBK1wOkuCISuS8TNL34K2CSjWfOw7uCWItJmyGxTpDFx5VkFBWxGnYT7IfCXw14o
         K/Rg==
X-Gm-Message-State: AOJu0YwjLiTr+uCO/hX+ShxpRUa+KZbHcCCU03GX+kDIWamrDPhvywnn
	vn9L217jUjEtfQyVa7nKYKiMM7y0xQ==
X-Google-Smtp-Source: AGHT+IFgBfK00J02IKlwUBHfThiBC0SBxENcpuyA5ZW0gTBosiNTA3KCxYAHTbqHH+IHfBIYasyNXA==
X-Received: by 2002:a05:6214:a09:b0:647:1bae:a37b with SMTP id dw9-20020a0562140a0900b006471baea37bmr7972072qvb.60.1692691331069;
        Tue, 22 Aug 2023 01:02:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.16.113])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b0064f4f14aecesm372065qvl.24.2023.08.22.01.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:02:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>
References:
 <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>
Subject: Re: mptcp: process pending subflow error on close: Build Failure
Message-ID: <28b69989-eb61-42a5-de8c-250c53532ce2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2023 08:02:10 +0000
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
org/project/mptcp/patch/065ed2c95b4ceef822232e4d0641427af6e27092.1692690157=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5936024982

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/dffd1aea5f=
08

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
