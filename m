Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891811372
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267084; cv=none; b=WlBIYF3nHGVw8QJqxiwBDQIMSROj4oxIq3phLaV6z9Jt8QRpF3GaFXcx9ExPTAyimCFXqVWmPcX+kuJYrZxgeM/oVI0wudSXOcGV/RtKdSPL2ZuS/rgm1G08XE9PPYQ483NrRp2PfRMDqttLXHQhhZOldmcydxRyjZjCQ+9G4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267084; c=relaxed/simple;
	bh=bzNNPkFP4ENoZzl269eMxDuM7Z6IeztYhd4NdkD3aTU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pUtM/6xAYdvRZk5+wjDbw1qgUokhBeC5ED10M9L7aT/zXqq+FApyAh1irQe2lzjc83ncVGU3eET+g4G8PO4eRu9CA7AmK7YpEICZLL8lWeRGTJki8uVIdjbPOH2ENKZirqq+chkMeDU8L+snuaOZ+bq/AOYpySMCtYOM8ECb9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxnFfSmH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxnFfSmH"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c0b4a038fso332187a34.0
        for <mptcp@lists.linux.dev>; Wed, 09 Apr 2025 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267081; x=1744871881; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjsmHCzjQCmjDox+PU60znu+G9fnchQRa5biQIO9Ex0=;
        b=CxnFfSmH+go7AM2be1/X52ac+PsueIBo4bjNaumTtPJsdv/lg2aHho/SCHnMqru6gj
         6he2LEv3sk9KHmUcul5WnWBGUHm/IoAqa4HSWxPbL24UGX8W/Eq6STDES9gx916A/hDc
         PHe/TaJFouj9Ur/8bBr4MB32WxhS9qbk4eIwEcLp5uwcSN8cHquNr8y4UpQ+3zXOxWyv
         OEkfXL10az6S+5UqdMfJcfM0Gs3lQgi36/l3mxM0Ig+WAdYSzFgLd7abXKXw5YjaEGxV
         pAR30ib3lTp0XK1y18wT0e956/xbpHubsMnWgf9UiprgtyImYk1gjp+KQv4uiBBX6neX
         RxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267081; x=1744871881;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjsmHCzjQCmjDox+PU60znu+G9fnchQRa5biQIO9Ex0=;
        b=XaHYPwhVXkwA98CBBteR9UtY5gMNpgPWMCeOz+WMuzMRNEDI4ElebxqCBaVXwn5Q9c
         3awH1aSr4gym8fE1YpqThgfgKCeTiJCbsIAVR1WTsZYgoNlroQ00RHvgKIjuYTP/MY8m
         +SaAY0KSn4hgyP+rAy8zs8X7Rss+nLB1yTbNEJGfN1Evke3LamU21z/E9nH3rNKU4Z+R
         nAxZncFzFl2XIFXspie1AmPHOUmYH+WuH3fOxPid+aCchdb4v6i9u4Z7fXi8NIps3qRN
         tlVKbh2KF0SpgTeYtEnW0OBPz5YOwt5SLe3oHDXf4OV6AA0QoAMcTTpTOYMNN9UF0qmY
         fdFQ==
X-Gm-Message-State: AOJu0YxCdD+tvn1ZYon3lCAXMT7qcLoZU759xwRc5a1/hRM1+bXdtyJn
	mOwhJEHtk+M+8N/V270ZU732iFXpkJJpqbmNyWY4BJVz5djl7ag=
X-Gm-Gg: ASbGncufEtAJBk/evytuOnGwMArmC0RE/PtndWQaXpz3zeZZIFSX7vkoxa1+tUxeF3u
	jdf87qW2hOUWIDtalb3C2pbtsByPmvq74z8rQzYtMgqWXjYDT8Xm7gnBgEP/M9IydrRAzYnTnK0
	dFE2p3XO2zqhmZ/OiQ8Uox6/4xihC4bzh2v6+/YTAjbvZSNu2rbvnHn85FArLR++Iwb5GrXSwVw
	x7+VRUji/X1u3gfxTlk7lb/SEErOOx1B+y4oDkVqDE9iTD0S8ljuX3+/eexo9+UGi6fjEL1cvSN
	k/bAyTIm8ZuzSWKjAbTZtrmaPb9fOb3L+7zrJsD3WV2P0P65MZJo
X-Google-Smtp-Source: AGHT+IGb1BoxGLMxpFB7xLBq2qJf6XPLF1Q2mbFl2UFPXvvapNFdkk9gNpaImBNp0c2qqgtSQgO8dA==
X-Received: by 2002:a05:6830:6285:b0:727:3303:7ea8 with SMTP id 46e09a7af769-72e7bb42c0dmr983522a34.25.1744267081437;
        Wed, 09 Apr 2025 23:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([23.98.189.92])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e67465sm470709a34.57.2025.04.09.23.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250410025931.1882967-1-martineau@kernel.org>
References: <20250410025931.1882967-1-martineau@kernel.org>
Subject: Re: [mptcp-net] mptcp: pm: Defer freeing of MPTCP userspace path
 manager entries
Message-ID: <c431e42e-8580-0e3b-876a-68e66405a3c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Apr 2025 06:37:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14371524037

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2ab62831ba7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D951816


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
