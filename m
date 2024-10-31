Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C84153836
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365092; cv=none; b=Ct/Uq/2PYb4YeYO5sD5y7X3nIRecHhOf8xcHYrrIGfJOdJqxy9CtMZ8hDsxXCRL172q/CLgLRD3yoQUCXzgpmQYrcx19gimQ30w2C8T91gglB1goDukcCJmU1pQQQcv/1tyKgjidHq0l2uC6PPzaWWhOCJiZR/a5RL4wllxrTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365092; c=relaxed/simple;
	bh=nRLJlRnDrBWmsKALtTY/rQqarHDAsDj6dD7j57gJnSw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OeNH6f+2NIik0/rbFg5zY79hT41je2BLh+C9h9ul6PHkqFGFaRo0Rr9iAgwTglgapRskL39jM58RVAk7L8QBPwDsBdIYQmIRfyq/+bDJHH26k1q1ZU5iAlMrahGfojgGFQQo1nrY+xRiiBoWXhj6dyUdKlzAfq92inIjDBnaJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaawnZ/y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaawnZ/y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e38fc62b9fso5838807b3.2
        for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730365090; x=1730969890; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU+p4Eyxgh9cooZbJ6Ak9d6BRMTNw33xPgshoUV7/bY=;
        b=NaawnZ/yygmb+00Uyi9KqXJ5uQbA5JeZYiBcxMPR7hC6sXq2FN4dJ05CW8+IbFz0ps
         sCcGfFe2tKvHiFYsqjjuY708gpjMfG+NpKQLcw8Xs3c5u0m42hdC9uCXe6FTW2T6Peee
         U9SA1Q8yULwSUZ0y0syDfBjlagJ8JBO1uFQaou3R7nKoMMjZ++48cb0y+13QTjFlisMZ
         paxiJLsVsJdpF8Z/nFvm16feqly0utIXO9YsVmhhUWQWn3aq8ZgjlB9fVn+ntxnL5MnX
         AU+1iMNn6eao7mYBhSAHe+6crLlrDcx8pK9bCHzB4qItbr6nrJs66svi8oiT7Qxo2yFg
         O46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365090; x=1730969890;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aU+p4Eyxgh9cooZbJ6Ak9d6BRMTNw33xPgshoUV7/bY=;
        b=tepnumIddGn1IE24kvHQ5nH74HW6RtGFAWkKtqz5P+XhzqJuBimaalfyecqCz4OQez
         cSDfvMjiA4O8ISTZC0/EiQS82xDYP15qEthSlnypDMaheDXjH+DuCX25zyPM7Wfg3qzb
         kpgVtqsqWBv8F9VZFWKVx3qChzairYU+1TOz82PD53LDdZLfU5xuAZ+t+5QNa+8Zj7hw
         3pDwBInzpK5En05ZHC+K+dx1I9duKF1vle5x7hYN6JZg5J99IGwfsuVi7giiMp2fTSHy
         6aIWGrFTt8MuXMZZjv3psGJDN6urCXMk5LPDr8cKkQYV9QimTOCQ/RYoKjfCrE0XazG0
         G6mQ==
X-Gm-Message-State: AOJu0YyfUtgQpaTkJ8keO93vDa41ys2JdrpteyK8TTsxAwYpg2waLxyc
	YK9iykjWSGt2SwQTS/nOSu6pRx9NEX4Cg2YXLEhmYvLFGW9uvw4RUSAC
X-Google-Smtp-Source: AGHT+IEyKOyYZ1+7mj6cj2NrVZYV2eK/a7jUzPnMSXr+WKdHggMsgi5XoqG9Dlmgw15UV2Gr1IYEdA==
X-Received: by 2002:a05:690c:60c1:b0:6e3:36cc:eb74 with SMTP id 00721157ae682-6e9d8afa635mr224295847b3.32.1730365089956;
        Thu, 31 Oct 2024 01:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a640sm5632796d6.89.2024.10.31.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:58:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6a3e3dd94642cf24f3d6f97fb869d77d7315d5af.1730360928.git.tanggeliang@kylinos.cn>
References:
 <6a3e3dd94642cf24f3d6f97fb869d77d7315d5af.1730360928.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: use sock_kfree_s instead of kfree
Message-ID: <628dca9c-3ac0-21ca-6d7a-696f7b1bd5f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2024 08:58:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): mptcp_connect_mmap =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/116082=
22124

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4bd443a6b319
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D904935


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
