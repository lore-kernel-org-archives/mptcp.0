Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FB1C62A1
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299034; cv=none; b=Pi3xQBPr+zQYs9ahtdhrbiXcbzFKx/s+gjCYepLb8QLWUWCcJDoNAyVThfOgkOLHrXjPHGIiDlk9oD3LZfoRxk/p5+v2sd5QeKta8GXFUNW+K9C0eFgVPd29Hs6imvec7iAZYH4EXsMgcPfJ9NIQIXrV48r2h1jfsCnIBujy8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299034; c=relaxed/simple;
	bh=EhTkdbC1pC5twC3n8UEyZwhL43kDM0TfOQcwTypttKg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CMMe6oJtEd2e7GCe6rHJqxe2hvZJgS/AjsRJP4t651Hppl1eA2cuTxnTZDCD5E2FPbIPfL9GDQRmkO3pTv/D0n6PmqxRy9ObObq4QV3XpJqhqtOv1OY6i3Is/V2lUF3GWYMDNlUxABAWbZOPCOQfbJI3GQLqyIWq6nLDKRHh534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gsm6yd3A; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsm6yd3A"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e04196b7603so4846580276.0
        for <mptcp@lists.linux.dev>; Mon, 02 Sep 2024 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299032; x=1725903832; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b08jSC3xLlaB9vjWt8zsPyRk0ojgxfVlTIgq3v4770=;
        b=Gsm6yd3AtDeU2ysM4WHzbemRnCUmhlhUyNLmwPVmx/jilir9A1G3uJ84CMVk0+Ge+u
         /TQ6beIh/6bWerQeC9cIhYvGq+oQDaO/AqGDccIDs2Usw7CGMkrG7N6//oB45tIci/A5
         8mZDVGP4pud8Mk7UMB5e6ZMeL6DAIthPT4YtRFbz4APntARK796vuG8uvlcKRPTpmdlm
         s9QC0zTuvggcPa+jV14B/uTpuZpMPjp/36ux/DIw8Tb+OQ1dEjkSxx0j1Z1qX4EoIIy7
         bU95K+9j0CroYw3oJQwacqxhkt5PEmqGD9oVLVc62zLF0MGfmUz7iaQKny535ZG172+z
         sVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299032; x=1725903832;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9b08jSC3xLlaB9vjWt8zsPyRk0ojgxfVlTIgq3v4770=;
        b=lZ+lMMGjk/5W9++Ey1wJVPCssrxOQdzZTAxdEJclT82YxHzjYUv+KkA1MyVpYl6TZh
         FVuKVi2QrNtEe/3ca3t11LVE+OcqPBNjGeJo5aYHbbOiNs5S8cHUQlNyF6U//zNRlA58
         GxF2zW8oNF4QR2YII4AqipEqjYatSZLn7agm2Ewg0Zx0D+fU8suXanulLzsrTAn2x/rN
         dogkKaWtuNaD7Wi4qqPSLOUjhCyskksQLlEl3/15B0iv1aIA8+1ydFfKPZnmMX/TeqPb
         lc3YBwehczwlh4nvc8B2ZMgoTh6G/9qPdxlKugw2U7KCpjNQ6/Y3h1vHtqZ9YmHmdNjo
         l+4Q==
X-Gm-Message-State: AOJu0Yw4OOttpRYjheIegkbHmRMBFm77wm24QS8K8OZraohDj83x225y
	RLxSdMvyGYNu9tPOLh1KREuirNcPrQsUyfsai5i0b0BtX9My5vzqMSFL
X-Google-Smtp-Source: AGHT+IHp7tpr3//GKHmkGiRzdFVpBJ4T0ZprF8G1glXmg+PaWSvNSFsiJJr7vaF+kf8m9WOnpqa5tQ==
X-Received: by 2002:a05:6902:1142:b0:e13:cd4c:25bd with SMTP id 3f1490d57ef6-e1a7a0018f8mr10718140276.16.1725299032030;
        Mon, 02 Sep 2024 10:43:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bf679csm440469885a.18.2024.09.02.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:43:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240830-mptcp-pm-minor-fixes-v1-1-89737b847a8d@kernel.org>
References: <20240830-mptcp-pm-minor-fixes-v1-1-89737b847a8d@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: do not remove closing subflows
Message-ID: <5ff6bac8-21df-505d-cd0e-b7b3003fa69b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Sep 2024 17:43:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10670883525

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5cf12ffb55bd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D885285


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
