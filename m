Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730C210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:21:06 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id f7so2680515ilr.5
        for <mptcp@lists.linux.dev>; Tue, 31 May 2022 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=kRKfRzKw6tU/RBOHC/WvKryiB8yLx9j1uVCJtFrAZ1o=;
        b=ECMDNLS2sIqZG/+dx23ZbJ2/zs3C+47hzab4UCQG95jHx/ROQMO0FnpFtUl/RwRqP2
         3uxa17ucFLOX4siSFiduANCsdxDaWzXXCnFn7Hoaov7/eDtNZYgM5dxV4uLYlJQbIY5j
         M9eAN00fJrhUz7qweRIKG1r92pnIhNuuM23g2Oer6IdnSXOrUg7hHRjikdVbsXsmgZXz
         OHvA0y0xdByHTkMk3tUHJqnheE6AtXErvfhHvDBSMRZal6uUyQ3JXhOJCsweMDXaC2Bx
         fhD/xAtQMdLXFstgdx+Xd7BV3++ng3oqKK8SXR8ZBdqIsB/Vvl0lRdrSLFgsZMGb+tbf
         9d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=kRKfRzKw6tU/RBOHC/WvKryiB8yLx9j1uVCJtFrAZ1o=;
        b=aj/QiDNtNcs6MIC3/v7Yh1HlyCdQHyMYxlQA0XefkRBXmlFsmCXKseGYIvR2gxND1A
         duPdM396dsIqnS8sadbbe7mPo27QzvPt3Gq6l7K1Fm5Hc9s3X+8NZfB2YEA7BZh5zgSo
         v4A2pjSpa1t2dvLzZGsxH/Xj/bd5nwwFFF65RIwWnN1GXM97KX32U9Bc4qQj0OaUkFoB
         UFszd9xtVc3DhhT1XsDFu9ZFpox4AahYsnStUVhZIyZkOZ3Y6cH5qvarXT2LcV8jZttr
         /drWgp+Wm9jajQy7+fI9dyV46Swd2gGDXtTL3fBS5TYt9o+aalaCTd6jH7OnjhAwuXtN
         W1qA==
X-Gm-Message-State: AOAM531qFxChNVFjNTpit0geVaQwsXl4wrAONwuC/5t/zBqa0ky44CMY
	cZxrOErpfdE2VGOf+yipXg==
X-Google-Smtp-Source: ABdhPJyerUFpcxBhBKeyPDuoXz2qB5QXa4th+XkD2rXBOQwk6X8V20sWU4mKEBLjVa3fb+F5FLS8lw==
X-Received: by 2002:a05:6e02:1525:b0:2d1:e38d:a941 with SMTP id i5-20020a056e02152500b002d1e38da941mr15174878ilu.198.1653988865350;
        Tue, 31 May 2022 02:21:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.95.166])
        by smtp.gmail.com with ESMTPSA id j19-20020a056638053300b0032dd4094580sm3335700jar.49.2022.05.31.02.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 02:21:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929.git.geliang.tang@suse.com>
References:
 <31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Message-ID: <b3d0d091-f18b-9cae-9e89-09c69d203347@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 May 2022 09:21:04 +0000
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
org/project/mptcp/patch/31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2413917761

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c91606f830=
c4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
