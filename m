Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF479188A28
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965502; cv=none; b=A17fSb2V9W9V0OTgqMX+PJXWi3gPhkI4SLR2TvE/sIfZE1nYCvEGJObJpMf5Aev2IXUIPdm2ftSQ9TLCae/wJ9XMFw/apcDfIpoqrVSUg2V13wAdShxS7vmpLLLt50bqnlnJBMW1U+bmcse005r4yP2bRTZWq5w8M7vZSkU2cLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965502; c=relaxed/simple;
	bh=jVThcyvZtnfNi6YBU3EzmU53IJ+5/N2jQF2QySKxnSk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=D0nYIiEksRJiqqL269R0KpjYeWzpli/UXbS/IbhznHG4nUaR1tx5tg+ubwh7jAz1SyQsU2pTgnjb0fvXDU6BULqV4au8i/v1iHWbCdu7NxglFi5nRDLiYYrvSob933psIG0k2nhGulZL+8vnmmJm1hHvVN8KQi+R5jJy2GHZjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5dztmns; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5dztmns"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99d23e036so287613785a.1
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725965500; x=1726570300; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MicGijHVZPgZ1XPT1mEasRyZpuY+301A8GqfFXNYd68=;
        b=W5dztmnsxsVuAorSij6PXaDkFGtBgtJX8Wa2rvxOc//QOupf3TJeGv3NGOMifmBglv
         05e47aRxv7RgDNOZQSnblLx588TrkF9+iBOBEIfvhtuz7tKLH/+JQfA8WZ2FZYOe06C9
         pc45U34+ue5pKgF8gx9/oDKKKaoM0r4/fgS5oNBo8CuP0vdG2ndEVIkJ0eAhAlvAEHf6
         U+UCUMiBpo4uUnqO/2YYOTw4nzu6C2+Io1XGPmYEVP8wkC9wxTRQfHW04VrYF4qMSy2i
         yUFOBlf5EpHb+aPiE3PGQMg+HErKjkAJuv0BAgXq/E7ZekrwVspRzEtMIhH1p8m8gP5N
         aYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965500; x=1726570300;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MicGijHVZPgZ1XPT1mEasRyZpuY+301A8GqfFXNYd68=;
        b=HflsNyy36lXd+Q+TqtrmOp4h0S/XDPIwagV9MorB06kN6mWtfpEGrXzbmuC/h84qZF
         7D447KhglyQrlBYybHvqbJHf9INlRqFGeBregjOqJq/TEAUv6p9k7hz6ixuz/vabgZgv
         EhWqqwkfkvcZbGpI+HZ0RqgiR/OWMYgA4vdMZ34s//44QKVoAiC/qMsCzWuWo+jUb/ya
         lS1hNS5VPYmqqSv8U2oq08DoGunpCgeNs5DS7N0YPdJni5eC3b/nBeoSvusgzQ6tj1UA
         EXFcUSmwSnJzMwswnX2tgmv23U6CR7/fXeYT0OGO7cBRZwwPlCz+mrEdH/ZmBE5i2BcO
         y7lQ==
X-Gm-Message-State: AOJu0Yy1XogKmeGq2ovBFVzQu7q8g4/E6wEpFcI5/AfbIonSqLG+yThf
	f3NiU7lSSCBD+SXlXK96rmFUedgro1nA4WbrFqRUGkTEvXzZyAg=
X-Google-Smtp-Source: AGHT+IG/IVLQaX4f8wddDZllzpKRskYFN4VoFaW2PrgzKAA5JIEVyta2QaOgJedu+8cH1cf0p/YAPQ==
X-Received: by 2002:a05:620a:2684:b0:7a9:ae1e:1055 with SMTP id af79cd13be357-7a9ae1e152emr1314142585a.59.1725965499451;
        Tue, 10 Sep 2024 03:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.135.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a19a5esm295856685a.113.2024.09.10.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:51:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
References: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
Subject: Re: [PATCH net V4] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <fa363eca-90ea-171a-e1d5-9f489840dfad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 10:51:38 +0000
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
uns/10790383980

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/480c7ad533ba
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888806


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
