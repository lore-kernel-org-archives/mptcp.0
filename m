Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB71AA1F6
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319178; cv=none; b=V7Dhq8kShpj3Es4m3HU9IO1vgLnstkPFwxl/9VZfHNucBkK+h0PM+9jtYKEFUB5ifFGxD1n9DF3bajMSupzRF9t4gtgTIrOi7NlD8EmlQcHc9UmlHUwHqf7Am0fY4Nmfvsf0FS2AB0EduSR5GvJswYSxbV57g2pi/JMYFE8ApMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319178; c=relaxed/simple;
	bh=gU/B+HEVWaJY+KiCpGoBqRzPaaWs/DKge47FW7GKuRk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hAO1FptQI3E9jCbyk3hC65F6Mh+vU3p9sH0rOF3YCxVqs5BmMD1IxNCCykTAoARQwyaTnoj/EwOSIOFQl7arHZtSZBCtwHUAcmZZrqVv1zrkhF+m98VovYmTcK873XqBNEF9HkDHvIBPGabcAsm9pq5MKvfrLnNIogXQkiB4198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRh61XNC; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRh61XNC"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c759bf1b2eso2268574fac.1
        for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745319176; x=1745923976; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQzPwd8JyffdQKBQyYwUWdTQbAYPJg3UnNOXGbrKkrs=;
        b=RRh61XNCM1evR8afj5GmbYrnyEAc5F9haCE96f4vIntlgKA41YV0M98ko6CHqzmFaY
         cTsNIOgqEru9MdM9HJ6WUlJWff5M0VHyDUTZQ4Z51tquWuvDYHZuy7+buBhBv3fjdSfH
         m86QN/njBMWdYbtXqXUCqt+15Xn+aQpwHgDm7ux1qMfBK8fbk5yRVScKFO4ChXkqhKwA
         WzQ0mkNvhvyz5Fz3Du+m4w94kVKUEQzUOmtWyPt7xJiHknAwEiBej3N84rcNa+WcAt8H
         iy8ZjvKbfC8kUYJfcpOdWWXPHvAmG/GPr6kiXts2Ty/5cZND19EtssV4CL+Q9c15Ng7S
         eKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745319176; x=1745923976;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQzPwd8JyffdQKBQyYwUWdTQbAYPJg3UnNOXGbrKkrs=;
        b=ZsL4uPSGx2J47KwDXKj4Fgn2BPbAntN/mV/yGdAXDKnPn/6yCFr1W/FOZnxqM34suq
         FjDSFtv5fNUnS2Tl1WrDrf4PkPfR/IPENVUwxwtAGTw7Kp7HEeuILuk31vyXM9Rt1I63
         X+h3MGfSoaVSLOYZxbBrUMkKf1IbLPgahMtsMRBnkF7dgp8cfjWZ9ZdF1YTF02HlNuxB
         VYfRbPCtB1qwCJ90dMqtSqodY3QEAAL39bcjVsaDVAzLp9GjP1mfVV2NMS2LtbAirCGR
         f8CYXEeaz9r/mWo/zTW4aR2+YDg16MGa93MKoLfOrBK9E5LqGV93O9m6YSD/HP7OBISu
         Evkw==
X-Gm-Message-State: AOJu0Yx8hngyggJcTQWKORHZusIusBoG8PIkWqIG/qxeR2jXFgD/K681
	wI0gtXxwwJgla2ESyVwUcqaiJlZpfL53CIUzjKahiwLox2H/s0vHfMbn
X-Gm-Gg: ASbGncuuGf8UOd8RAzFlrGLASuijiDzgctMHALFFrs3VYlaffO/8hjBEktVR+JgDs6u
	QBcIHq8Y2DDUT6JDg81LE6+e+9blv30pGZ7PCiJoAabqnIbcgcRNWgvL0HoFPcxZbn3bq9bb8GY
	Ysz7IQ1I3NYsOMb+WbTPADx7TeVX+pdsTl5qN4jECR7aKxh9QrULPVNcOfNaczPAV+L5wLmdsVT
	WMBB/Ajo9usgwyHCJCQrghIAYYwNR4CZwvuPvTVEeKXwfxPrbFw3A4y65SXT6eVNk8ywGgt54wz
	q3CQe31LcVO3jf+apdUCtTR2zBEekBvS8PZDe+Td2tPwSWnDJC8=
X-Google-Smtp-Source: AGHT+IGWdHT0PcAFQxaVO2RJNxlXtXTAASOl58+l/z8JBwHDfsjXUffU1a50bBxGrsQWPY+beIKSkg==
X-Received: by 2002:a05:6871:bd81:b0:2d5:4f51:37fa with SMTP id 586e51a60fabf-2d54f5147famr6772541fac.31.1745319175644;
        Tue, 22 Apr 2025 03:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([23.98.188.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300488495asm1875505a34.43.2025.04.22.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:52:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1745314165.git.tanggeliang@kylinos.cn>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/2] Add TCP_MAXSEG socket option support
Message-ID: <b1218dd9-351f-6977-d9a4-b40f8da86716@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Apr 2025 10:52:53 +0000
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
uns/14591855995

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a917e8ca4810
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D955617


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
