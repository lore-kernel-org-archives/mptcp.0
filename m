Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60329C339
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665497; cv=none; b=X/1ICoHxtM1rcbC4XPnR3aNNznitM/iZ4KPhFj5F/ffyNSonCKWZ22DK7gyyry7dY4QxUDMGPZXyxK791f5a8j/i6S4Vfd6AvImQxsZn4rrSyqP/F2jXgI50DkcCmfedeGVFCYsbOJwvjoMXbcfr7rVYUoEisr2lFmvKNw/VGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665497; c=relaxed/simple;
	bh=nokNYwwhN2itNbWf0JbrwIC8rHHyPipJA/upl04UVZU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VfIxNraOMswsoPhjAv3BtWYk41XE+iQ0f4OkEDJ0HhxqX58lcZlURIMh9towFxkWEc1CFhfHMiAl2SxhywUBrLl5Fk6M8ptSKLEQXtNkFNr7Mi9a3aWmS50MVJnrXVEhaafXXQDybzvlo1kCWu3BAuBDwthK4ZD/tLNjVzGeQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp0K58N+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp0K58N+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89c55a0a470so7502736d6.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773665495; x=1774270295; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHV+gRpy5dGY+k8fXBzvqjMn8K6GGo6lBdZFRcafge4=;
        b=Zp0K58N+H7ShAJWhC1cjqJsUxj3BUS3md4haVXHkIeiBWRAN6+4d04NDErH1Y2oOlW
         IL/YuWMqhAIDQtR9arEVc3M7nCYOG4+OLlP3nqga0G6IQ4QmnJznD/RS2guxscl7nGsB
         3aI8KknYGRiaGla1TytAuiJd/s8Sh/Eomuzy6USz4Fv1xZD2P+NsnLVtYNr1lVPmCzaI
         cLMJiyR1vmGzB8Ec6MDd4hdRZ3dQDYzLaWRgX87TlLGcayBmuGBCu2wHeQDaV6U2J33F
         VV+/AHUaie1GkJg588uGM8GgU88ccxn1J/26YQjrFzwHdJhc60RI9xf4BNMilBjJEpHA
         XZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773665495; x=1774270295;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHV+gRpy5dGY+k8fXBzvqjMn8K6GGo6lBdZFRcafge4=;
        b=o1FB5wAMdd6SVIAYwV62BZM0VFcuaRFFjbqdhR6EzcOJ6ia7asJi779cgV3F6VMFmy
         sQFnLCbrWYg2gzf0zS/+rRxwnlmNwLvjS7vjMlJZQ1Ldrqo67cBLbAEDA/BPra2el2gq
         1IJIvna9obgZo91GwCdNdZlR8aq9zYxeEQPzUPQJJOKJ0KzDepiMP4cM2X9KdEtJzpnZ
         HlSbF4D021W6oPMbAuAemlw6L/O7YGYFa8xuHs+KKS3etcHIdT1gLUNw/xMWmczptfKY
         Dxc9ggGc03gY4Hf+woMHnuHVoKIAKfht4ybn7rifnJP1higwP6S0DFWQTGpjowCD5Cdy
         cY4A==
X-Gm-Message-State: AOJu0Yxl7BmC3TUGDUBjJUBn/p6uFGb8aiWqrMgQTaR0PTbQLX+fDfuR
	nfu/O0eaVa8ml3YqzCIPNH/F+fZU8XqwBCeylk5eVpEybI3/IwWxWZIVDY7pBbw=
X-Gm-Gg: ATEYQzzTyAKA7DisIBA1emh0+bmi4fRvPfuqAqGYwxWrT2ksLP+69ABm6Mt0D1aYL0l
	+Dz6Eno+Kui88YbdNFGR5VOnUjK3sGgZevlLa+NAE9zlF8HW4yj4Llj4uHqI28o4Yx8EWEWZJN1
	Q524Z/e/P4koth8USGTZ5uVs6AUQfHoANYiErPFgDxUC7VthRnD3RJtRjsI+I6w370jM1BSyCfi
	11grMffoJMUrKK4WXDO2a/Vsw9VMzzksxLaixPh+eeauuvFWJVcJbfRPYxeVpFYvubSM+iev+3P
	7sw3HVM+jpJM/Uipyef5+L6mA6Us5lipnETM8XM4J8eEsiM3pRlUFbie0rCRpqbXNK0fi5SICmt
	XVaEd7X/6GYaRaOkSti9Rhq5edDdq+G5XTboyv5VqjY0diXYTvrVKfvHQ4A/7zFd4v4JaFINTm5
	bp5Ja+noegg5/zNQfImX3f1J2Ui9NOhU0M3fiVTg==
X-Received: by 2002:a05:6214:2468:b0:89a:9f9:246e with SMTP id 6a1803df08f44-89a81fd029cmr194964066d6.45.1773665495059;
        Mon, 16 Mar 2026 05:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.211.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c5471fc7asm17482966d6.12.2026.03.16.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:51:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org>
References: <20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
Message-ID: <be3d197b-bd37-222e-b6ab-57d21736f345@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Mar 2026 12:51:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/231426=
53077

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4970fe554d4b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1067275


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
