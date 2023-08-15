Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7182185D
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:41:45 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso20239745ad.3
        for <mptcp@lists.linux.dev>; Mon, 14 Aug 2023 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692081705; x=1692686505;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixvNHT8ceRBtjaNrIrZu2dwmXA0TfBuQD9C7y11R560=;
        b=ZakNAYxevrRV0B9qV4j/CbcLFXP7lSPWHUNgVGOnkw1KnWBtsO6sp8FnPDu3+lbu0G
         K+GSKB6y6hD65BkEiwfNpUBQOVjpf+Ne1vi8b6XOvadGRx5cHLEHSrdznMltrmDWULZw
         8d3EJcSR4PqGsQHm8GZURtFefoXM4VQ8Qne9LLHduCCWQMMNx5saUOlQSTurLA/d3YWC
         3WpNykkCQ7ZVDs655ySSWbFiOVtzL2Qp5q1iIiJrW5V7jZcNMay9u9ZykUdwj2Kn3JKr
         4dJQ+PBxz/rqtsH6v7olRlo/zFyRXuEzuh7On3RAdXpVr1HqyFQ3Hjo4a7Sr/Uqu/UtI
         A48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081705; x=1692686505;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ixvNHT8ceRBtjaNrIrZu2dwmXA0TfBuQD9C7y11R560=;
        b=YczGjEiUYT7tZQS9rFsw/gMPP5wqr9x2PZSupuDNbvTHSSdYYMYvSK+juZtD9oszZH
         RpMAmVL9Gm/LCrW0/H/rSQQQ/Yb7uqugFIuLF21WO1/5MZjJLkjuosjeUcuhAOoNSGTp
         Rnmucn+m2TW8QCrdUOzNATsi2j3FpL4cEIZXLECHygLMTnFwGkR4hLi8yymo3Y+OXzFV
         NeZvWV/z/r0guSIZIy0K0CWmoVivNzcX0zrplw8wQheRNEXfZhxeAxtv/e5Z50soczpw
         ut+BsB1et/CA05QrH6HxuRv9ZZQFgJv8ASPdPrk+/vhtBXTR6OFHer3UXctwPRbGDelT
         NjRw==
X-Gm-Message-State: AOJu0YyNQslemwIoq8IJYrYFqlh3g6oNeCEs0vLB8Jazm7xtNNcfqNwg
	riC6bbPFFHdioExsDuy/1A==
X-Google-Smtp-Source: AGHT+IFBAKM0vlxm5OIeueZWIrWnmEH17SHRlXZDMoj3lY1+31eRYZlslpDC4zYKwthl++j0kWUCTQ==
X-Received: by 2002:a17:902:d715:b0:1b8:c1f:fd2c with SMTP id w21-20020a170902d71500b001b80c1ffd2cmr10400656ply.33.1692081704731;
        Mon, 14 Aug 2023 23:41:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.160.241])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b001b5656b0bf9sm10549041pll.286.2023.08.14.23.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:41:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803.git.geliang.tang@suse.com>
References:
 <6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Build_Failur?= =?UTF-8?Q?e?=
Message-ID: <9fc8d79d-dd15-db46-9edc-2ca23b74a626@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Aug 2023 06:41:43 +0000
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
org/project/mptcp/patch/6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5864337382

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/538d21adcc=
61

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
