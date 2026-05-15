Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE8315D33
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778815168; cv=none; b=bNaxMoypHQP/2iu8FJt6XL8QzfAOOMZmpMNnKb2U1v3rCyPMEEb9HJTf9f0Xbdhfypux+AD4gLMEhFwjlQIQ8n+G1HG22I26upCKdjXUO1kkIdr631fN15J8/P3K7RdPgbw9O+RLREebOczcJJyV8SREywBjVAlfcEiSJlLZW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778815168; c=relaxed/simple;
	bh=wybazaj4dCSjr2aau7sPwkfkbgc3FUbXVy7B68lBxs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=K0YiYi4BYVaIBiSrjvPBP5iVfryzF1Nnb5n+Llro2mMD5NPWQPfOIzslL42sapwmpQ/Zajxmf4/6Z0v3cdE8PGNO/PH53ftHqjsZZnuR8VYOhQl0RiLZQElNGc147JxEnl1TqlnwQZBmuZWEhbozcSVtNr5upAYLcdtuaU0LqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtLZ9TX1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtLZ9TX1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516389a9b70so20672041cf.3
        for <mptcp@lists.linux.dev>; Thu, 14 May 2026 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778815166; x=1779419966; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6C9qIXxL0jN7r/351r3EFDFbp2N7AURQzmOzfNcKYQ=;
        b=OtLZ9TX1sH2w468LGJzx5MNW4n+bcA7zTTJp5eNxWGxcY+CLkAnczvJ7Csip/+q7r9
         c8lLEj9O9T2sg3HXsZXhZcxqrv2lf0NJmDO2RsBUIEOps3+4dKEHe6Aa1FSw8Bmyllf6
         lqRWW7OZtmU5YL19PbrpsPP9coWhyXWQfvjGG+zroW2XJHWJefPS4nGlvxCBTL060who
         mij/HzEwH+lYj1dJ9pVlc/PaRylQ2PZJlajXBzLz/LNdtG7MifwPVGChMQPy5AiimUHS
         gfyzpn/XylFB4MFWZecGBxro5mfiWVAGIU5VTzFOWjpKRBWwwhw5w/8FQ9+IsRV0Nqqb
         46pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778815166; x=1779419966;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6C9qIXxL0jN7r/351r3EFDFbp2N7AURQzmOzfNcKYQ=;
        b=CnF+2cgK3uJdlmOfxFR/fQM/N5by3DJak7C81Uz/UCj0hLSUZ5j6Serz7l33akmJGp
         g4d3tJelFAt9NQ+8ARyrlM/nkxzCZU2RYVCfdHVdDc2Z2GHKNGYxyjl6Xc4qCRMMRraF
         ukfytWR3Y+aBjE93dca/0EH9TaSOrvUAtPO4kQZ/T497UtDcwaI04aaPVHBCLsJDJ5e0
         VOmYoJVWmUP0gzFTk1l3CyatYQQFO0kdGy5wU0OcyePaHWiq3kCNvpQvYp0eFdFWekEy
         D+lzQGbgU91pXt/EHsbLqivyi1+mHCZ+HHpFp8e+RARzI0q2ihvYA7HcSVynRmEUwEhm
         MfOw==
X-Gm-Message-State: AOJu0YzDQuqxBbgPdK/VVrLI+KE2yrI8DbFIhOTwG1Q3MD514PYYo2Jg
	FyXS8QYb6wNaHtDMDfdRzrF3SbCakOnOvvE0OBFcSt7ufKvO3cdYb5Y=
X-Gm-Gg: Acq92OEo5gfDqORVlmVZvsJ8hTHTD38cR5v2OoesMu3Cw6ZZ+6QE2MX898IkQbAub5Z
	pRUzmLqkE6EMz/++N8Zu+BtUp+O/Zzb2uLUbZX0cT7m/5nyQxzsO26e+kzkv3pBJ4wj2OoG2caC
	LhPdSeJuN0/VY2KUTZeXavJ3q/jAvtJaDvtPL5V6NDEQ/VVebYD1c63tDzGVJPBU6Se7LmeYaYo
	GeXGSw9wHQBTz3dUla7AXnBJkLyfQOoca5OpHVRQg5kmp+CxsI3Jp6dzfk8bqRUZJkaQwB/iUFk
	UQeB1C54HNlh1nIv9NVHhS66/jqP09CoM/OrHbDemPWnxU3wHAq13q54LpUVPkpbVESlhkQREvY
	RQFhNuutM0It1DZuzQw85Eu/4PXdWJs+OumB9pnIChHH3Oakwymxv8fyqnkp2kefNNNUzIa84+R
	0/JkXAyfpI9p3j8yJPVsyuO3WfgT8F6/Ab3pf0QSeXygOmfK8=
X-Received: by 2002:ac8:5ccc:0:b0:50f:b13e:b746 with SMTP id d75a77b69052e-5165a1e4662mr31305291cf.44.1778815166385;
        Thu, 14 May 2026 20:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.124.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm21946331cf.15.2026.05.14.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 20:19:26 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260515-mptcp-sft-uutils-0-8-0-v1-1-4801c8e16485@kernel.org>
References: <20260515-mptcp-sft-uutils-0-8-0-v1-1-4801c8e16485@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: drop nanoseconds width
 specifier
Message-ID: <84026157-ef1d-9137-5f58-1a765dca5f86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 03:19:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/258969=
10569

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/73e82c988ae5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1095088


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
