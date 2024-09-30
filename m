Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEF1E87B
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696747; cv=none; b=qgIaLiyk/UO0HIW9NldliLKdOSXML3qiuC+7WjNhYlFyTVqvpkyPGPpEeLcykC7Q09BO29r2+oTmlh22RwTJG5ryP455E4qZaWJ4Khi2UbIixrFotTlhqCI+6nKVXgthwNkopazVRh4dI1xkPwX2vTLx92nalGR5n+jnjTzmYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696747; c=relaxed/simple;
	bh=5xk1RpiH0iVmLEKENIJw/dRbvf6LRoatkFM202XUy/M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ez08sbViAlifWwZ2iiJ87wpjPMr5X0dhy/imFNjplytCCSFQsAH8qf7JhlBlLpP+XNNtCzcMK+rg+jQG4QpmuPoMmYKp1ukyxzBEsaDDoaeq+Tz4fhmnpaXTGB3MzAiSB2zmyfIT31D09dMJV4jmxOCzPbqD3NKd11jf89er1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9jOW3ho; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9jOW3ho"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so2501815a91.1
        for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696745; x=1728301545; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCLCIlY4qvRKxZzzeastj1Ev7B5fmJbsZd7Z331p3R8=;
        b=W9jOW3hoauK6Ke9Hqsr2rjMb83jqt+T29TzkWnATLmFECBif2AimJVaXU/Mux5DmEV
         uu2imbod6fyH0abJ8RjJkvBvVJ+rrBjrRgeTzBBxP2J+SGqaUzMychHbPopERlUHMSFd
         kCc3kg/Rt8njoOskS1TwFsS9/0N/s5Sl6ABOrlrRD+VUOOwpM5eBGiO+/s/bnbhtTcXA
         P49SWN3YdItTioa8s0L/sYPmjrNjxDQPKy1pv6OLXgfARN6GKyj5b7t1yVyJMJPZO47K
         sbM4KMXHtzjemy2Etd8di7lGTEY1hpetzitndOh0WjL+QSYdhCzG06NJGjpbG7Cy8u8E
         KnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696745; x=1728301545;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCLCIlY4qvRKxZzzeastj1Ev7B5fmJbsZd7Z331p3R8=;
        b=pb40cPQy7Xp2z0m2AWTntT+/8aaM0efYoog6vGy5Luu9pCap0s38E1GcL3Ccf1XU+8
         sDt5BIOueA9TJz0YjyujwpDAEoAyX3om/N6U1rQE0IclPLGH/V0Gnzl60KuCyo6yWfn/
         3mjhrIx1ji0/kNkXxbDk5JyC4m1WsYM4FIpzshgntya2ZZ5OmIYEUsX3nNx5HHMfB9la
         UaWgL3pOOv93/wI3nkcMJIb4DTelmeYnHjXogEEXjZTw4vDyJnOYxTk8jkBCACNQz2I1
         uKKxqAkN79xYwWK7pYYDS1OObQh5LFvIhh5DCoCU+TqIuz+udGOpPmyj0dazp0pJR8gt
         3ZYg==
X-Gm-Message-State: AOJu0YzOGB7uwc3ExQTHpjKjTEcWRYICiB0tzy1iMmW81qjOtRBbeSC6
	gG8PrUH/DKTNPm8UNwL9mMBxM/Q7w0Pr7qDtPVLKs9MKCeGb5g4SPvcd
X-Google-Smtp-Source: AGHT+IGUM/97oEi/W2CmVyW33Jg2xl5vUZujMKZt/CPcPqtzZK/CruXwY/d5e+QFJ921FEl9wS+DnA==
X-Received: by 2002:a17:90a:d3c1:b0:2d8:8175:38c9 with SMTP id 98e67ed59e1d1-2e0b8b41469mr14016249a91.20.1727696744882;
        Mon, 30 Sep 2024 04:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.69.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2d7ad0sm11214861a91.42.2024.09.30.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:45:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: tcp: fix mptcp DSS corruption due to large pmtu xmit.
Message-ID: <6f42c5d8-415b-39e1-a29c-655c06ef8930@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 11:45:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11104631227

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/31e222e2a2cf
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
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
