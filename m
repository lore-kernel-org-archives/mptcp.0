Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA3101A7
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237843; cv=none; b=js6AAQvoGAo0DLPlNqy4z6vQSlcmmjDVMFwigtFKRBhnMLe8sVdeuDWnXsr97Ez+UmVARhrcrUs/MDFWTh3Lij4z1lYmtHDRQT5Fhn1OjwRg0VZhy4S1YzTkXtoXunZqHf4EUuWJ0y3EOQGMI36zQqGBheSNDDH5hrXnhTZWz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237843; c=relaxed/simple;
	bh=En9r38q9uuChCrYOMrdqfaXm90aP6N3Y1C6GPwvfWj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=S1k2g6Id8oaAEDDGL79agL/nglgHL3R+yNfRam9nxXxGon85WOI8H8XW9Wt2/yrIiXe1/8InoPYlVC5/Pz5ANed84Rics+8nvyqeFbMMonnd6N5LM0lGwIlvXZm/3xRvjcY2qBmVauMX3OEdKKGh1p6+YCoP7icQqmart2rHEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOMidAw5; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOMidAw5"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c1a170a50so2598883c88.0
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778237841; x=1778842641; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzIHACfyNoQuolCPw4h/GjZ/9Nl2oaDis+/+ZJJ2kt0=;
        b=aOMidAw5jJaXhHbMAiWbYOjw/Cg5KT7pJachxjN7Mnmp3rfTvp07gKM5OQi85tQHUT
         di4Gv5QauVrkGYsjmjfNa9bwUot+PGHbifqsqBcGjUjCyFIsilUOOnwVUXm+c1WIA/GA
         QhaxFE4C/QAScvu2KRHcprid8X5IXRlRVITlikLmBC42H4xpgAQw53pbiO4zFH1tZTpo
         1tpVSryK7kDAzUH+t7Zud7akTgVHErX1brGXu8YDGLhW66V+DpUa8JHV6jBptSg7z9y0
         5Eiol/5dIatbuHOxrcK7wN00J1XjgUaGV5G6PdH/FCpSPkiyD8BQD3qqkjjZv11t4BO/
         VKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778237841; x=1778842641;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzIHACfyNoQuolCPw4h/GjZ/9Nl2oaDis+/+ZJJ2kt0=;
        b=sA0L5Qit+yWutIbzPO5YWSxY7Ahw/TTS1Cvb+/V5p0QFk/9k2kE/ynRU5VPrUTTDPS
         Wn4TazqfcmNN3WjC6T+USAaHdUkocwPDlm/WZYfpHL28xe4ksolOuWTrY4qQCLexGPYK
         jv5F7PiFtpSvJ+ztiayGhqX2wX5/Y7M7LixrNA9LqRPM7aF9Zw+1iHiMICROOm7PBXbw
         elAawRtIJcNEGgiumMAqIGFvFvmRjnTbdLB3cjD/GmqjJJbstt0L82MzvpklG/N0PRNq
         UqzoINoZ/YMfZDrD6ACH8oDq3bxyhqA7riFAJGzxFs6JPbllnkS4ANwHRABF1jMlUDUX
         lAMw==
X-Gm-Message-State: AOJu0Yxl+Xa3YA5qRnVg2nK0NbB9NIbIk9uE9GhniJS1nGW8oN9cKGV9
	GRFZJgbKHGMc3Q3j6rBK4A1aR8m+uI3JAwffLIxgUgTOUkOPJ9o14IY=
X-Gm-Gg: AeBDiev2ygLzcUgMeDcYwEHdVyXesamNUdKsCeCMDXQdHblQPnkGj/6upb687yFk2Yk
	aGqtOLg5r+yNe1voACi0yAWNZ9E1dsQ4S6hfdBnYuDZwWii+2e5tAJKoPNe1FWNkkymOLR2gIVS
	8uSiQjSA3B1D6lshBXGdRfpjRjsg/Ce9smOpIRV5yBHI34iUpjYb9BnZXl7D2ZimA2jZL7lmynC
	KowPaSEACMb43zpjEI+isT4l4/9ffY4huTnf9o0BEKVgNo6siEbT1LTervt3V7bdQwOcIKo6QVD
	zi+Pu6qQ71067RN4FPjCY1hd9IBaxTtmVmBkezGVR0yk8/immswipx4gY7V76ko0ChJZkAXnF4V
	A0nlmy0mY3nDx7d6Eea5wXDa90lVsEDAU+hlryR8Ppv2669zhANMEmdz9cg602jysTMLYJ86mjR
	s31Iwj6XATPMtR7C+ofTy5ecPV4K3//IJS7JI=
X-Received: by 2002:a05:7022:f212:b0:128:bf5f:7073 with SMTP id a92af1059eb24-1319cf55d9dmr5556664c88.24.1778237840873;
        Fri, 08 May 2026 03:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.25.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm1752515c88.9.2026.05.08.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:57:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <71899029874998e8436cab708b41cbc029772ad9.1778233686.git.pabeni@redhat.com>
References:
 <71899029874998e8436cab708b41cbc029772ad9.1778233686.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: reset rcv wnd on disconnect
Message-ID: <ce96c6ba-7d5a-f1af-f7d2-bd8782798ed3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 10:57:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/255497=
67770

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0450a3ec6b58
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091536


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
