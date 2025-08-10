Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8A19047F
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847965; cv=none; b=T/yBR9qNbW/2XJpvjbUfC+dDToscKNQOWtjlsDpcYfBXYOf8TMMeT5iHduPpV/GpOR5gIA/xzsHVbSRIjKCHMQRUKwIASCT87ulXWJTN6FnjIxQuOXMfOM4m180Kt1mRqHxITA9M/+RAuT4Z4YMyIslAVklo/lw1oNiHDq86/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847965; c=relaxed/simple;
	bh=HuPcqqTwyMsfRKtVGEzs2AxaqA/shiZ/PJxoS0pnuFA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gmKeXeut66xkETVPQUBGAsu5MnlmgZtOQJjqc665/OuNJOXMaXgX+oGQ5+lvocgaFebbZhQpN/TD8z/oZD1f2OwgW+HSMYzO03fjK1lD5uvHr71zSNS9MBGqZiRIFXsnRZMOGmYWrywwFmAHOZQ3s1BTVL9r8HU/W7bZcumq3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0JpixpN; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0JpixpN"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7de159778d4so392674985a.1
        for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754847963; x=1755452763; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOpK0KGGnbuoXJxPWmGfVem+1aJGHIu5qkS83UCcrlo=;
        b=I0JpixpNAgETDcENbK1xJrxaQ1Rucrv+UWVfqdlQ7eaeS3Bj5VdiDmo6IuqyikvzC8
         lsH8jYJm88QB8Z7rkY/tNuK05GoVNmO95oOFNPphMrvia5jB8NodCuILKFxD0ooaUkvQ
         72GecEQDeR800aJ4Bi/2Bv8QX26/PuVf5TF/cRxWAI3Udq2qG8gFXVLO1dl+qDlJ/mFk
         1P2vz83anocd09VvGGcFxI/o2BdR7AJW4rrxi1ZdvOiAGhO5E62QZQBu+LXRVFLVx2Rr
         rQaWXTqa4mDRTL87s9qG4MNAPA5XnRTqiQMrawtMAJc57iBazIYSKi9Mj+XY/lnkxM1j
         FlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754847963; x=1755452763;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOpK0KGGnbuoXJxPWmGfVem+1aJGHIu5qkS83UCcrlo=;
        b=A9f6pFjUS8039ZMSfuga/Z/pKHmBBBWBu0PTyzIcJDcTl/ETSNRla/aPOmE1x33SSL
         VX+LYogW3YAtRUy+yFifpIhp9Nlfi0ZzT3Qx+++8r+/kNU+QypxRtgAG19Pr42B/DfKL
         aO5703hT/bm9gS9Wq05DO2vrSyOfWqEWaX6g/v2zi6Wca+mL7GvRTb3hV+xAtkXOE4QK
         B4oSWmDk3chN2QsvNT1QKqBME5uxgzMCkt+ZF+bjKRIUnqBLuOJrqz89/yNer867drew
         60v7fokPUc+LOCjY2uvwZi6DA2CrOfdUDz2H7+iCWyEBJ4XoM1kCgsk9/N9/PXsPli6l
         z08A==
X-Gm-Message-State: AOJu0YzMT7odYXurZ1b+pPID2uEx5xruwZo2nDC34SRV533p2GUSGmYb
	VNnDaf5O19zK14DgyD5DSGqpfybUgE0Ar7BAH5293vgO8Ism3trIGw0OcAZx
X-Gm-Gg: ASbGncs8nPX36a+jM/tGsGVpsAEwS1dW7nGcCIgdldAE5OSOidZXWYCs9KbX460KuO4
	+vPRkI0KmoNkUiZKR8f6fw6niQqoNmnmnUdO8S1HgNj1/79HZ3loQYfewMXjoHOXlV+fMWofDTw
	YUBcapPHbC1pu6CUfoSdeyKM1LN3+dYRqzaNAmxsCdmKTLuq+H7VoF79NoeI5UXt5cwuIVr/F1h
	c0G0sjrmxGrLRzADZrZD5b1+mS5G4ivsBw++XLMsWvqxUgpNQvdsiWPOY2WKRzmFZbzcY+/f73z
	ZmYIb1cs4XFMm/VBLHEGBJuS7kesyGjRtT9n9FuUhdye3c/YPnAJdT3+Jz8ACeQgqgd4f/Y95vF
	jvZ0kcnweUK6ThXWS98JdrDLkSE7NpUU56g==
X-Google-Smtp-Source: AGHT+IGLlQw0f0jgfrtyRy8xWCuDmPtOBYBA53PiboJto8vlty+yI009gt3us1ilxnFyzqHZSddErQ==
X-Received: by 2002:a05:620a:3903:b0:7e1:4bec:9769 with SMTP id af79cd13be357-7e82c68a03amr1242836485a.29.1754847962863;
        Sun, 10 Aug 2025 10:46:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f595525sm1412398085a.2.2025.08.10.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 10:46:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/8] mptcp: TCP_MD5SIG support
Message-ID: <4b626c15-75ec-23b9-9309-97bcf8078d4c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Aug 2025 17:46:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16863216520

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5e17ac2b0930
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D989716


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
