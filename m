Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBF29A2
	for <mptcp@lists.linux.dev>; Wed,  4 Sep 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414782; cv=none; b=H4X89YfcsUsqkA2yBZjfFqu4rEEBevG6I4auOnZpYz5CjI+qlaeYridM3X3NubMGkCTd8PIwH4XRmVCgNCXN7uxSq3kHGtenHDSXlgfkk/Mo5n0ZhUfr2TDZ8Bk/dNxdHZ9yc8ad5V1VDlPISJSOMV0IzlGLYdlICI2ngYBOA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414782; c=relaxed/simple;
	bh=jgMRltvCoyI6GNoCTi94zxGrc8JS3bzBxyNnJy3STRo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PdcfnfjPwlWKEB/NE3JAe/NgqMDbXqCK37qUCQGIqASVzGmPB3rJbXp7RtDbZFoxN5BOa1CXdGXNIhObAPAkfP2Kas8Dbd5MDOyVi2WzSOar/s0R1xlAMcTN/TfyCnIw/+Qr2Ag9IGKZMd192voAtydI92QQ6lpiu+ej36akweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye2IcM3Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye2IcM3Z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2053616fa36so38605555ad.0
        for <mptcp@lists.linux.dev>; Tue, 03 Sep 2024 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725414781; x=1726019581; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoBCFjWDbcx/Oa+q6/rhvpwOnk8UEWm6s2FDKs8NtY8=;
        b=Ye2IcM3ZWDeCiOY1XpURoPnV4JgJTdFnf/pCINvB0lNhRrvfyXjud2d0xTGMwOuzeg
         0mwo1z5gK6fl4+8POPxZscjAOUlyuD/+IeqJeoRudpaLJHvt1JesQOr2956kPMkyDehw
         oq+EndeMzQ43qDi6tcJhVun4IBPxNsoRwG57U2ri1oQXHukbeImoSxCe1mMrlMM+eMqv
         VRWwmy3FJqc92Nut3JP1d/J93GIIt+jk0+x7aTEGewIAxR3fGl0qXhZtEmtQRqvGTupN
         qN2Cszg0dp5aQyFItwybOFc1fPBTX8e/XxEPP/FazDSdQdoQLB3yQ1FhXf0opAqc0+2o
         DzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725414781; x=1726019581;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoBCFjWDbcx/Oa+q6/rhvpwOnk8UEWm6s2FDKs8NtY8=;
        b=U4b6twsrj8rwBz7kJSLoqeo+HmjGNciuYMFqX5ydPC6ujr8w8qQbHkfjsAUgfM5UuU
         k20dMf87L9hz3GSkxGDYusscTY2XY8hfjYePy9avN9OgmZh1y1Dysviq9VUvXjSaKjE7
         gyYMzhH0sMW/E5dbqHWFcM+XqWcEWPvikTgepSPwhldMzXTBIpDOePAz/Sz+rjvi9CYJ
         xtxXQGeLqkNiFF3K93O5vHboevhc4crg4XQKRh909xhVQvlTMD8ap4xUMJVqFljRGnF0
         rSLCFERZW1A6yLSeYChx5WMH8xgJn05fLFwUfrkhdIGZXkwn8Bv5ttEDTKdBg8MGXphO
         cgvA==
X-Gm-Message-State: AOJu0YzYhJZTn8zphFmlG6BM5bDlPqkTQAdTT9MxAI9VOKKZckd1Krxm
	ORz7B0mfQqyI2pXMYqOr+phK6hLCDP/Yawd8PIVDItyh8jsZSRNUVd9X
X-Google-Smtp-Source: AGHT+IF9eBWA8lm2Flnq8XaXTk40GpmYnN5DgOqawSw5ZY/hBGtSDy4icE51wMmL7VxjB3kLo3NCGw==
X-Received: by 2002:a17:902:e5c5:b0:206:892c:b751 with SMTP id d9443c01a7336-206892cb7f9mr68923735ad.65.1725414780575;
        Tue, 03 Sep 2024 18:53:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.75.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae968f78sm4185305ad.119.2024.09.03.18.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 18:52:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_472581BA11BB2533E79EA21B964B2A1BC408@qq.com>
References: <tencent_472581BA11BB2533E79EA21B964B2A1BC408@qq.com>
Subject: Re: [PATCH V2] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <0407bf6c-6811-771d-1392-69d6f98d475d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Sep 2024 01:52:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10693305915

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/39f9be3b7f68
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D886515


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
