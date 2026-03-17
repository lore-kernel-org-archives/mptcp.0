Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B33A7F61
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746020; cv=none; b=EJNKqFn2yUks2Te3bkfNyToaXiEK3/WXfqa0xvqHr7nBfC2/GWpUeQMiLjrWkQbTCTwL9jGwGZcCflgmRFCqKfZpQjtsym+kqQ/NiTBFwQhC/jFI7mIbzSEtjl0/SkRIABRiIz8D/ZD1PbO1nxUnxMmmpooe9K4HuI7x/I5NhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746020; c=relaxed/simple;
	bh=+8xiqGU4gz7IaD0blSIiKfkKw0Sx4dWN48Y33+1KPUE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=S5sWqWJi8XuCACrKAmiHu2uw9h10KzgZBnIanhzQQW+v1DLJCkCAN/J3c87QOlqHtFeCQlwtNCZLtsxoiN4uiDnJC5BOUIt0n96bOe29qUzmL3GM8PnCEQ8kCDWNRT6joh6ekCR/IQIspxL8faJTCggoaFkcLhdwlN7mEkdmin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9jL4Jou; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9jL4Jou"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0b7eda342so2232080eec.1
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746018; x=1774350818; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDtN5s8QSbG2xFwrwONTG0yBkmL4IRVqNIzYC0Qhl7Y=;
        b=l9jL4JouT388S+4L5LvG794RXVy6LjwOgqWeCAVmTHInLeVI6CzkdJruPFNbSdrduH
         GcfgnWoMTaxDaQI1ngejDLZUvLShhaplD43kDH1whpBkw55IKSX24MrBFUncKwbo3WTd
         uXhlU1kyNvHFwnIl3fE8T992IEV7Y94aginwY++xwBtyC9RXFHTwYiXGAgyLIMazLbas
         tGprvl+S1sLPOxkYYXOXv+zaFK8KaZ+e6t1bwQAqV1EL60UUMxZ75n4ejLoHYpNXUvix
         fXvV651B9Y//WSewto23f//qgygr59HvNRLEnTrhAXTPmdPAXcYisfEz1VPFbOyZRBvO
         kQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746018; x=1774350818;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDtN5s8QSbG2xFwrwONTG0yBkmL4IRVqNIzYC0Qhl7Y=;
        b=EIoJjCwyB6DSGDKvC28ocbF7jUeDRbCMsWpUgim/92QogzdUC9JNNSJKhw/a4ywk2P
         a12kqlpKDtkF/KkzBKgfXtmSYaT6yUsidHXCKT8eMKya1xjW+6xjWQxiMzNadUDH1Pul
         opcEEATmK/aMPEzmZUCifRPJieD8JPLClvHiuKDY6zf19dQ+IoRoGhD1xNzgSsNzzd1F
         3e/0EWpYtUIO647VxZrEcz0alVW+syr2c9GuaUxBLHYCXAnxdPQpZLhgj/SpZxBrPohx
         Lmn+M4YnZHlTu06Q6dScSoFMBmIx+srfEtqfXuKjX/rcbpj9uf+DzyXZllw9rtBs4jDf
         4DoA==
X-Gm-Message-State: AOJu0YxE3hiXn8Zns5ztFxwO7ebvAtLlAY722V0ortgtng7JJ/nA2stV
	wDnpECfaymPgawIC188odW1yI/uLXhNI5IKV4prVEQEHo8PUIHVp9Km7n+QV
X-Gm-Gg: ATEYQzzaT1VbzblzRK5ZwaJWGAGSgO/zgCj02AZV9o54WFu22AwbdFJ4Ploq97tBVZt
	rEEky8dVH8qWi+MbvyWKz74SEsKrIhztpm6EeXkAP++kQCR3bMqWO69R+bjtM/UXhEra38O/A2+
	avCTyhxbL5JmWt0Ohtuls+ZvS3EXEFc8A2U8FET3CwZsfPIqTyIMj6oB1hOtz7RnS4WFb1s+PKm
	8N4QyhNnneLKK7ePRud7/79COTBf3PIBHCOqoIWdq178wckCyr5RpxKY22JF8eiFND0UKTH2MEW
	jBa0acSxVtyFKgN5e9oxUQWdvrWyuG/qEyMzBvxMOYWzGnJxPKrHz3b/pvlmflMvdhYt4sj07CD
	Jcw908PV9OfUfDyocpZhU+TF7HFSnkHdIsEH20lxUXblutY91yUZj59IMjVWb3Tt+pMWMjPBN+D
	DAXaKRWrsMKKfRJak65p2HtACLN+e0+hDs8tb4Kg==
X-Received: by 2002:a05:7301:19a9:b0:2be:80c4:2c89 with SMTP id 5a478bee46e88-2bea54361a0mr6772466eec.6.1773746017904;
        Tue, 17 Mar 2026 04:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm22168369eec.28.2026.03.17.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:13:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773740635.git.tanggeliang@kylinos.cn>
References: <cover.1773740635.git.tanggeliang@kylinos.cn>
Subject: Re: [RESEND mptcp-next v2 0/2] add tcp_recv_should_stop helper
Message-ID: <08603262-1fd9-173e-8bcb-d8cfb3a7c195@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 11:13:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/231891=
52154

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/10891a8a1061
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1067876


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
