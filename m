Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C065289361
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141385; cv=none; b=WIMVsRq/xt5UmSRPma8+syam9T6hsAs7svRSsSz44XmMw1b19zf71ZYU5awsxphG/2IuOeNSCe5/pKIkvljCPcbDDZ9yYm4wtpJQFVr5d9rcLMPYyXJL159ZBEFwcKm01qjQHedHiS9tPRsVjPZWBy3Nu9vli8ZU+PKwznRfvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141385; c=relaxed/simple;
	bh=dr8BIspSOH24OeCN02gWC71PivXWKqI6WpKVaUOE0W4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PxRlFqshSODynIpXinlpj/RTAyV2dxO70Z7hb1Fl5j4UbeCVrnqjBdAcKrT3u1mW8aSrwFua9vQPgcx9OX2gLIYL+prACG57NcWrIgJ+oaKgViMQ7ekrEMxCVk4uP17yzWMPGWiDSa7sf0g+FbWkrfKxdWDhkGx+M2wvwUpI8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpzTry2r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpzTry2r"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235ef62066eso12958995ad.3
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752141383; x=1752746183; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if4lS6AtzRADMiWooAToHFLVletDOxdEGCTvL271pW8=;
        b=kpzTry2rEFVPGtNl+kOaShqP5z+oE3NdRLDlRvs6y3CFjM7jtzr1Bd/c7nXrTdnB52
         iGuaaq9TyKePwiGUUsvGdBwgG67D0WoAqgvJfwAaRcTrUBvVKwJMUZm6XIEDFIFMq+Md
         YzissL4POcUrHejAYz68xEUGiD6FrIza8qtp3m5VYI5UZlAVtUji9+aC2PLbfoPAWocn
         b14WR3q0aFFybGHIyDKi2KMu75RON9e7/h4156tsuTN5LsCpFUUYFo2gButEPeUEAF6h
         68/nywmzdVYD5590O6GETssZ3I6NG+0JuK3iWMEhc2OniesvRSDJN4ALRtT0GUfcGs/b
         3v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752141383; x=1752746183;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=if4lS6AtzRADMiWooAToHFLVletDOxdEGCTvL271pW8=;
        b=feFXGiBkkf4M82yvpDXD6dZmoiI3uQx7NzZ3ooDYBvH/555XlT4ud9k5vMBpdLlY7T
         b6zkPuXPRqn/fCExmhO/WfwVVLXQhnDOKVGcWjNPG5FfY+L6ZSJe4uhmPJCrWgZiSUwe
         nY9nPyJEGfML5I01syV2hasj2hdQNt5Ci/U5h+xB2Wf8myiXcMzSmzACK1sS3MdVmihE
         O8sN4WFdwc/W2fLU9SeH/dUEqDYdc88BTvi/Vb3Q5zP9SGJLrJH9fhluYrNs+1ahNeqW
         QoXSgVZclS3Wxbk15xlBQRvgHGLODaIeEXd+N2ILjQQjTXg/yJZGetoQkS//BRH+YrNw
         g24A==
X-Gm-Message-State: AOJu0Yw5GFmpOWg5ikshAnISsf9JEuEtAGZbvawZKCmGq18J7lXyqiJQ
	th9DAhgzExmQ4DNNB3siu/BQH7Vv4hNTEjpgdfD0WFhzUW1UCQ+U+geqgbMo
X-Gm-Gg: ASbGnctnemdytWZiC8v2n8iZcqdvp686OuVDuDj4pV7BBm8hyaLg6YrLrm0ZnPczXJh
	IQfsOzXupIuGpR6DBKsNJluGg2HRNyKV+PjQmacFQQc1NYtjBvs5AT4vhFKYK4HAxgQCu1F8q9X
	fRAHKd0p2C0XINyKRQE7NP2q6n8umardoKm6iUvD6DFvcp9lvTk5r9M6WJnsxKD6IcF5C1qrw7w
	eLvqVeV/j3nqEHs3iJY2lTI/aFHlwfbMsCROhj1DGCVSh+zvp5N8cquNGzKfC3WTpANgKBW8I1h
	l3nSA3gA+K6Hw68/pqgneMWeI9Qvlku/j/b2OQy6PlodRwO4qsD1NvkVHV2W+ie7yf8vnlDqSw=
	=
X-Google-Smtp-Source: AGHT+IEfvQ4PVrwRlg0FV+5UIpV2dC2RvXJaPOZKjqfuZJ2kUAsun9QkHowNP9APD5Gubk5bJQ2iRw==
X-Received: by 2002:a17:903:2443:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23ddb3137cbmr80555735ad.45.1752141383407;
        Thu, 10 Jul 2025 02:56:23 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.232.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436ee28sm15729455ad.257.2025.07.10.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:56:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752135065.git.tanggeliang@kylinos.cn>
References: <cover.1752135065.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <4588483b-3cd7-5a1e-de9b-9ebd0e1ff7a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 09:56:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16190147099

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b9f1f8861133
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980902


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
