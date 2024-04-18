Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC0165FA9
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450727; cv=none; b=l8JvNEOC3Gumopm+krHM29Fi4qiHjyroa+zsnCFj8TJYwdC0rDtCj7v+WwJl19Sw75Zl/6XGVudfN2IfICWhmJMvuzVylYCZWzYr4nmruTn9oqbpZg+yPOSrvrSBPh1Yxw0uow06XS61ZUVuVg2f8SwdeRQttYYLco2CBkkQOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450727; c=relaxed/simple;
	bh=WZW5vFCLYVxoaK6feb6j/DLSGw/+d3k2XhK7CaMrIkg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Q5iAmVAZLhi4miHw8fXgCKP4oIAPdnD2KDTSHOyX0B7qzr06aXpQPlwuv7V9SNkZoboVg6tsovMSH0ED6EtqGzZVxwIeQtTi7st0Fgn37/Z+KXU1ckOUoCJMiLFZhRvr9DHNla6uo82Ku/EADMfgGE6XXnHFAkxgu7RW9BZhdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZX+LC2p; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZX+LC2p"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b6c2e9ed9so4173916d6.1
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450725; x=1714055525; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vomk2jErYn46luYsXeN2pTSNkUvQ0bShmmzF7jbN1qg=;
        b=IZX+LC2pa0PF/ggxCq+7E0qgvUMlkhurEISzleb3jcl6HCPm5AcelFdLMO2iTLJTo+
         o8D5/vQtzouX2TtmNj+MEUE3440M0RxcAjb5kIefksLRlfqH3bB8QdHU54HX8y453FOp
         6/S4BMTLIzkpo6ASteY/k+oM0EOU8jtbXWWoNC/OcFjG7MspUslB0C6TToNZ5g2cZrPb
         mNYgecvb2C+k6vXpLLfFpnPRRTvnLTIDDf5FvYYNfeeNeIys4LcxnwS3HlQKwAZjZ+BI
         JnbCnJB14+yGTkrs91U6VFazr0awJ4QGcLDJnGM6ohhxMPS4Q8W76E96hveDMXCDg19f
         6moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450725; x=1714055525;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vomk2jErYn46luYsXeN2pTSNkUvQ0bShmmzF7jbN1qg=;
        b=I1Q0KciP168nceEYCOJrA2lcUqJdOG3xWY3/3Tpuh3vNpf3CbV+e3gbLhKzAf39ap5
         5l9UXh11KIYyqhY8dBdu5D1jDIB53W4vcIZScfZ/YhTs9RKyHf4R1ud9l7vhoZXH+U+N
         wCCFuTKH6AHPvl0ttJCPVht96ixS7Xp2nCnpTQktmH6cy5QmY2wK+NLvYrhaWtQ6d1jM
         ar5UXaayKJVn9Hx37LbXtWGQA0nmkyNXmafgJEFJZ+kSoX351JOhSlPWpai/ic4bEMi2
         9zDfIR6MgtsoUKvwVLynflxVvDftWdam+uYXLtiF/rr6bpAxmqsIpACen1K2a//ZXIB9
         Ss5g==
X-Gm-Message-State: AOJu0Yz3TIX6ose1ZomUuyUEq1UwbTS4I9YE7eAOn9ywRJ8K77NJji6p
	m/gFGK3d+3xmR7X2uQwy6/0bA4aBa6qMW9AnBENH3++G6WDUiEZfU7La
X-Google-Smtp-Source: AGHT+IFpLIqfnQAD93rfdaZEq7SAE/wBumZBxOuM2XEzk/PGbe2t/ggiQSsYENReqhFz6dbaGFe4Ew==
X-Received: by 2002:a05:6214:88f:b0:699:2293:92ba with SMTP id cz15-20020a056214088f00b00699229392bamr3124708qvb.61.1713450725337;
        Thu, 18 Apr 2024 07:32:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.46.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a0cdd02000000b006a040850edcsm678330qvk.129.2024.04.18.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:31:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next RESEND v6 0/7] Implement reset reason
 mechanism to detect
Message-ID: <61d1f35a-617e-6cb1-0cb5-3b9814db08bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 14:31:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8739169189

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2e5b93dff34e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845801


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
