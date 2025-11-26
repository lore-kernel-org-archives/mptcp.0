Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0223277AF
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160188; cv=none; b=sxin5WXxW8+6YrJobVHjDtScdft7Tn33880ynpb/OTvcQA7/QADmBgR0SufoFZoR4EIp8lhmWE7sn+CKx4kUquydFbxIv2WDG4jTGBpKE/wx6/OP5VgmW0dODIaXGMfJnFCLZeYN3Jeke80paiiJQ4t5KXJKlerLLgsAkY8K77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160188; c=relaxed/simple;
	bh=m2NqP+nkQ1cdyQLHhnLULCjvRbHOTPTUe/DDaLzbcv4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=o3s+q9/CMYzE2OqVpNn2KtdgSqTeYPZb8cLESacwIMtwmdVAN/1iIUby2cetYiJ8rdcl0EfesXxw17r0GVzeWlkUpzz6+koOTi1UqOArboKaEt4TIKiGo704EEWb3NxGbACJQ35GhgRbtwHD1eCzP7G+BVWKzk2xyTGefs4X62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1/JZ9UB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1/JZ9UB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso5890546a12.1
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160185; x=1764764985; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+10kIkbP1c1VnShf4EOFgpli2iwq+oHxH39xdADKIQ=;
        b=g1/JZ9UB011hfm9FZyycDe5HNBmv9rsIJNqspKiZVtLYiBbqpFBqlY1XjgXzO5CTW6
         cBvbkaKMRkrtx0WCvbWoEuAhjkBt2X85cCCZV9wj6owcph0KtzTsakjxC9pxojvnil88
         LDb5V4twz6W9yrC5h2fx6cVo50Oenzi5jkiJlieFBcFe0Oac2scIdhK3uoHbZ6/qYd9w
         +l2erygGnpdA3+vFlIHL2N60UqkjjRpu2fe0p/x3bIEHpbQBTj8L32I2dBMYD1FFkvW0
         JiylBELNrN9/HPhTx1BVa1frx0HxyAoe5Ux0gU8ZEXjvDHh6/TBRLejeTTNGqU17K7m3
         PmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160185; x=1764764985;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+10kIkbP1c1VnShf4EOFgpli2iwq+oHxH39xdADKIQ=;
        b=EzhmN7q2YthEaUIHCZuVqQzrPEDBMPt1hQakkRbtPn1kRNUT3v3gGjjMNP/LPc7OC5
         qXduxR9ZTVGSz8S9YDVcgZ135xK5ycsBUqDdsw7plkiSLs730F3PByjASC2zPOaCE8jT
         zpmliC+RHlEFYYOvaLvWH16oYk/G+FUpEtE9E1tkbvGIAZfCm28j82bkoY3t50pxtz6L
         SVvGv1CsA9c0TtSiei1WwgPSqKgbYe1qUnjxCDJU1I2+rqJ0tmU+7N+yiXUAIlMrKYrt
         6eHdVIUKNie4aZ+v5R8XBbnUDsZLT3NWBqMymWT5lp7XQwHhAC/cGucfnDAExu0wYUJO
         8k7w==
X-Gm-Message-State: AOJu0YzZe2kTNEcRJ/p+zUnKd2Ww8T4naCUJGXpjHOySxGvty8VKtrqD
	MQdh4ovL/f+5hXBONTcJWATS531Qw0xXxt4x2hVTbM3lV1/7ov1PHCiGntU8
X-Gm-Gg: ASbGncv+YUE8du43f9wQ3+zkuotAY7mgWr7jqdbHkDqZ/5GcMvHhGQUixC+pwlFmCsu
	ojihyKkZ4jNtVdAVWrbzJmpcPM/rQDgt7599lHiRqC9Lg03fb/Bmq6ikaGqwPn+D2vMcs3UQM/X
	OYuKPISzD79MKMS4GOllBneHS7Oe/ZrH9K60N1DO3CSA59BcyzJxVuxMCR+EqZyXhl/GbH15hRv
	FwyC07s4GjhcVmTVU1yWso/yC92Bkaw5y48+3YRG4SAEfrGNb0vudZY0GlIZ2qnD00uOQC5JDUu
	TgJfMvjcLzmGwFWD5cI7ni4gb7mgMuOTOepc2ZipCzVXxX8ZbS/hZ8DDTWEWSUnDiW6rXSV0zKb
	xmbMXyZiPNqlPMRYeYcoafRApis3Cmbj9kyVh7UKrtBUs0xoey9f/oKV/dEvYsjBHjGGfgxnvnT
	YIFzDJTx+j5QsPSFm+TaJ/EVdQ
X-Google-Smtp-Source: AGHT+IEs/tbuWUK6bZsHM3irBct4HBRsjuQ+ryuEzAZAS71SIO6j3s+n6usoZN5QwD2rVHPcSF7Xsg==
X-Received: by 2002:a05:7301:1caa:b0:2a7:1863:b162 with SMTP id 5a478bee46e88-2a7192b8b3amr8629688eec.28.1764160185072;
        Wed, 26 Nov 2025 04:29:45 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm21390961eec.3.2025.11.26.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:29:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v2 0/7] NVME over MPTCP
Message-ID: <4bd65248-1fde-acc9-34bb-7878acd14e1b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Nov 2025 12:29:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19701453448

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/018aa03d0c20
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1027779


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
