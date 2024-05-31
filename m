Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B44558A5
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149943; cv=none; b=DJgtschsHDwOE66aI9aRCX5a6pO02TpdTA8x7vaF+wxhScqsAUjyRviRYAkskvZ8smFzM28btGt6Lz2Omrq3MoDg2D5e9KB+Xn30mQ9TqsMOHtnRyZy8sEPUQ+VhSOkslhceDo6HjOS6o0CcisoE7nqopstEk5gQ12b4/ra3p0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149943; c=relaxed/simple;
	bh=PDI+6D7jNWW1uzZmU8bstbZUaMxLqfcGH8Eqb5T33uU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AwFNxifcDxnRIrbwYu+AtVkDq/ARc/8aJyCtCzmxQQJMLp81vPOg0qZHAXsYDDB7XYJW7v9L0j1pU36CH4juvT7aPvXxbz8DSvEYo6KdXh80SXMhBPg9H+WFlrwnJ1HbvF1lY9a5wEbvfOGpa+3HYGTgAuQGiltbUI3iXyaRbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4SbaFxc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4SbaFxc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f62fae8c3cso8719795ad.3
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717149941; x=1717754741; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8GPndOE083bFRd3P+hHCOq8JhzIBIOyGKR/JDKxmPw=;
        b=D4SbaFxc7o9R10kyXfoA0awSKAAMrsB505QjCGfjcHz7iAQ+/YdJ3sGbl9yk+uBQ0Z
         kbegZrFZRP4YeC1D7xq3I3q256IG8KfbbPScQZoaAYeBbftrtCplzCbuDFkeJxkoVsVr
         LXqiJSny+uf6j4LtxC4MXszW+VfXAdeP9+LBFxlqHI/MpNZ30XQ9KLu3W2vgQzXLUL73
         a+6JpDt1+JqKr5HiqO2oZLPV4znsZwWNe4kISHDJSH4MGU1DzJYf742mjAM53XKfmGxw
         zw3GbffTLLfU1g3eMNolFNyfTN/bxkTap3wPkEhGUihJEQaadxOYSer2CHLWIt3N1oJE
         mJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717149941; x=1717754741;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8GPndOE083bFRd3P+hHCOq8JhzIBIOyGKR/JDKxmPw=;
        b=SbM6rrRZfpMDZtBcJFUsBvZo3IQx6/tJ98PyLafsvTGk9Iu6avZedwlBy1IB/AYerJ
         ow1m3bmDfT7VQmhA9vUhvCcEayD+lyBoIjAubNQXlDvlCUWgOvdookYPs5zivdMgIl5E
         GuVnhTegsr7SquNWDls61AVaczDn+6c+OqagNg2yzTfhcD/SUl3peB2AMrcvwo35Ebb5
         WZ1hyhF2okU3UlZrG0ZmNjpw/RwpY9r5CH87OzPkQ7t/sWA5WV3ePJwqn3rSNQepOkSN
         alb38C3qSV1N3+vQMzTsejew9ZPH4twdl0fzH5n++i6I4SRgcPg+Ut2ShkK8moFWEnWR
         0Sqg==
X-Gm-Message-State: AOJu0Yx4PSG+oPKC8Uml5HAc0wR905Ot/OdIYUSqmQ1Cvr/0S+bjXMbI
	snkZKwd5z41hxEwc5QkA5fXug7Lknma1ZjQ9frA8E2Wu3OFHGss=
X-Google-Smtp-Source: AGHT+IFqraeI5x0BtD2Zq2NtpdcfAL5u77fFx9xsCBYhe6kc1+H5LczKbbx1jHdgnHtbgg+2VwzX5A==
X-Received: by 2002:a17:902:d50e:b0:1f4:5477:4bf2 with SMTP id d9443c01a7336-1f63709eba8mr13856055ad.42.1717149941313;
        Fri, 31 May 2024 03:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.46.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6342c6acfsm11978955ad.265.2024.05.31.03.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:05:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240531091753.75930-1-kerneljasonxing@gmail.com>
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v4 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Message-ID: <eb2626f8-8aac-b446-fd0c-7e1526d574c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 May 2024 10:05:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/931605=
3877

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d286b214d2f8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D857630


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
