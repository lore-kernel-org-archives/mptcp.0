Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCC130AD9
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454783; cv=none; b=CTr5vF/qKoCjRom5sel/fR44MQwbey6bc7SCNFWnjQ9Y7iB/UShAKXh8I3ip57eqIzCOFnTIOHOVKza3EccKtaYo/0aCrUio8Apen4XtLrk5/RjzZkudiJEw3UPU2Dd/ta+a78ByaTgoABrVJvKt9krDsOethBVUJAKLRCj9tCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454783; c=relaxed/simple;
	bh=FRXaJHJIKPgjX3fEHWwP2wNbGceszx2ydjhKQRPhnRc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uw+LV9CNIBDHL3Dufq+6si3AiVTT4alQcP+6UyVK3RgVLdsEey1xcOrnXg+5j7qEx1B245cq2sihWsq7PozI3n/Jc4oinxEh4urMq5/v19STz1edd5NML5yEWEupG8rWwaK6S6KISF+AeKuSXhY+a62bs4vlCGcUsyVc084CkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2529gj5; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2529gj5"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e256505f7so3831980eaf.3
        for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454781; x=1709059581; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZEormaTtrTohSbif2cLJ/tBAqB22jAiVW80urx+DvM=;
        b=M2529gj5qCvGoqOnwYmCAwQa7NIvoXVPcevGwPBXDSVcNK/s5wLo7eZ+rvVAD0WNl7
         6F6EePp7x83qZ8ciB4zQKVTAHFCkqsw9sklHN4WPNp9JGLj7iQWMbUrMg/dVvi2aB8Yh
         YIJPnc+kma+XiFUbO2/WR+Ebaa131fFt8Xa9h3uPbmTcGw/BnfPJufwXMCnIpHEGqt0b
         X4Ez+C2NK19WTWIXH8c1UuKYiXJx2el6lvWA+a2MSguwYSyPgIpElKlVP+DC/52YVM3X
         0tR+55fKPxKF0BIdxYsbHV2M0hGWcnNJu8YBNm2LIMmxW7/dJSOP57QKkMkzkEV3qf7+
         retQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454781; x=1709059581;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZEormaTtrTohSbif2cLJ/tBAqB22jAiVW80urx+DvM=;
        b=cvsPT9hY90vq/dn334cch/OjBIOWFWjoflp/Wpio77a/8sjqfVF+Nkx6OuNyN0A7wT
         i3QwOser2UtDEt0/8uDgYLkjQYZ51W32xqj1qxV7N4S7eetV1h24J75A0KcFCcaFULMR
         4KHBYxHC30WOPlGStAkfT12UanC4BGx/1L5fklHJf9DfpBic5r2a2wfNppuxSMcMNZp4
         GMmHTgh+KKViHUzlEThBRDAoqgsXihmxSN2MbRkL340uMsKO3kyARNVsxMJuSSAAqJZI
         VL2/x8HK0mkpIjAXomSDeSohogWb94IUwvEmjhvXdiOJD54DMPM9is6jpUMn2tTwYGSB
         0uiw==
X-Gm-Message-State: AOJu0Yx3V+Nrx/AvXnXZ8/bqdIB3fpHB5jVNrzbpTEMSQ9y6ZWlVAmuM
	vEwGWS1ZTQ8JEvsdo9Sct9B928zjlJ6gR+xZL42UhXz3mVflPaYZf9+KHto=
X-Google-Smtp-Source: AGHT+IHQD0RXDkDF9ThYBRhPYFE+edsP3BEH/R3i9M+UVb1QgkTUfJ/N7maBxpDCFMNFn0Td7ll/Ng==
X-Received: by 2002:a05:6358:d090:b0:179:272e:54e9 with SMTP id jc16-20020a056358d09000b00179272e54e9mr15662603rwb.30.1708454780770;
        Tue, 20 Feb 2024 10:46:20 -0800 (PST)
Received: from [127.0.0.1] ([52.157.14.174])
        by smtp.gmail.com with ESMTPSA id l184-20020a6391c1000000b005dca5caed40sm6928023pge.81.2024.02.20.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:46:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
References:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <6ee17224-2993-8259-929d-2ab1eb49de13@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Feb 2024 18:46:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7977999805

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2ca83db7b919


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
