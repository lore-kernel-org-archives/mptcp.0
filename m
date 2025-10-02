Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88E2C15B6
	for <mptcp@lists.linux.dev>; Thu,  2 Oct 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376695; cv=none; b=u8F+VpS0x9nfcXFHkxdOXQjux+2lQx6xGKQar3qIY+XeXZNE93J9uIS65dU4g7SFWO4FISkdVC6rIhQcKpQP592uCVn0UdLb38uQmAd/CLjLbJaZN5UHtPGV2vZtsUa3GfkiyIed8rp4BkAzpU3K6y+sqD2HaGS2Jx5chJkX/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376695; c=relaxed/simple;
	bh=Koqladri82qPdCkxouAGx+Lm2RHOCnuAn4O3inNNAT4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V3I8SgpJIPseMQi3OeJ95i5ZjAT+upMPnsAlOH/VYMUPySfgrqYbX/jIRLlcoaAi0+oXSh62TE/iRpSoaoBNW7RrmzGI+29kKo1VKJSFxGWnFUEvlbnatbJojT4VmiTpyHUyVs3HP8YTXvL/EYDGD2ltUmkMXv5YEQGyIRJKSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcusdBRq; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcusdBRq"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9335a918867so44431639f.2
        for <mptcp@lists.linux.dev>; Wed, 01 Oct 2025 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759376693; x=1759981493; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAINzx8lz9ZU2EiHhZgVI1qerYm/Xe3y7IL/QXBzYbI=;
        b=HcusdBRqYtm0uLAGp9WTvt6gdxG2mUDP9tGKmU3IXJpOJKh2ifRL6m1owbY7aZgTbt
         0znwHfBB4OYnWrROUPXG4gi1nwDgZ1MrLBZ7tsB+xd0bp8vfnfLPldxomZBte8syPdga
         zNUI5EW3WvcpfA27KaelE8cYHta+VjcEv1VZ8k7pvryUeDl92jB5jYiOsJyY+wdRM7o6
         FTJJZljGLgOwkAWwYVBQDIcnbEd7mAEhw9ZPyd8IgCpCzG+k8+0P758qsA4u8CW79cbR
         xsLYk4+fA9Y1tilx43Zw3V/bw5RxVudXyERBJIM70K/x0rUy+3zqN8buoba5kEvKb/0J
         K0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759376693; x=1759981493;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAINzx8lz9ZU2EiHhZgVI1qerYm/Xe3y7IL/QXBzYbI=;
        b=ccLMXjNzB/VxaE6ehfUMQLRQOoMRc/kmFFwyPv4O7+6U3tyB6UjIVJjjUDxNtc+KGV
         vef6Pc6LRnzyxBVPrQ1sAzuTfidDRUiqQx8DpxbB3YFCdY0c42EB+I6cALFk73B35xXR
         Wgwk9BBqNAisZ8tkgsqd7xn+K3b1nN0/D2pJO9eXSxqPWJ0+RkRCIeW1oAYxSZhl0Fsf
         0/qD9AXq0Hvv9Y/k+HdWXADxsM3Cq8NdZ7p7+blUhlsIZeHSlDox7BGWXvBaiM46yhwi
         xFPil9UUiTzamXQCj10wsqpXJg+quNuur0B/MPElS7WfaXYfS+N/uKk2Mi8Ip94a+Rk3
         qy2Q==
X-Gm-Message-State: AOJu0Yx1pY8RZPhBrW8OYH/NugSFu3qMVOdbIC+cq59O7lwXsntehFFx
	B/ATJVwVgBUgRrovdpnGFdJWkzxHgusmqA8QIR8ltCSnBw7cRwTHqAltwz10
X-Gm-Gg: ASbGncsSPhomWKCaFGfTjv+ODuAScfDyfzAxtqkQe3VB8ZoUkFJUeHsjlk753ZXRVIE
	OkT+32cFDI7BDM3plUxqUiQhSj627t86AbGrFQ+zql6R5whEFpPSd0BOxfXCfn8/ygD1Q7U3HDz
	WtHBYSsyoO6TmaeCBafGEpxftgAWrYjn7OFFoPenvMs65iOQVGFNM8YXsnNswGnYGjew6VJ0OwU
	+Swc0YsPQxYDKTL1ZtfqL0P//sunSRSYhxWDMToW1DVm9xHIGkw830FQYHOrhLwbNAya+iJEORT
	Kp+8EKEqkuT7lFAm9wvyJklKXG8wnjWXu3LR/N1J4eKUfjBeggYHKhRhb3nwjb70HDultq9Rhhy
	4b1xRhYX4MYfp79aEcw1V3Gp4/wXXyJrKyegc1p6r4LOpi4bT6q+fZSciTyXt
X-Google-Smtp-Source: AGHT+IEJ6DPLgQEuqLpdY9P4kC/n1msPJv7n4cyClQ7BDIPG05Mkzca0j+p5GU2WpgC1NVQaTfve2g==
X-Received: by 2002:a05:6602:3787:b0:92b:f56f:abc0 with SMTP id ca18e2360f4ac-937adb61dc2mr827421339f.14.1759376692888;
        Wed, 01 Oct 2025 20:44:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.225])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7e3a6ab7sm47810439f.12.2025.10.01.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 20:44:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251002015245.3209033-1-kuba@kernel.org>
References: <20251002015245.3209033-1-kuba@kernel.org>
Subject: Re: [PATCH net] selftests: net: sort configs
Message-ID: <fc1b5efc-b8e9-4114-caa1-86c16494ec1a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Oct 2025 03:44:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jakub,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/181811=
66519

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0f6fb241692d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1007865


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
