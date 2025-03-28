Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204818DB2B
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743138564; cv=none; b=D9QEMvG7ZuucSRN8ZNjbjpIAaIA2RR6jLFkrPImDKIjpXBP3Rm9z8wzdZQIo0ZydB/aeOTkwAFsKKZkJCi+z2dekB/vrAKtZD1qONf5pQYCo8a69ekrR9NzJtJyr0+9H/4DUnERHwniWXSrsE9DjUBUWJFjX9tuWlaQjZhUQ6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743138564; c=relaxed/simple;
	bh=06m8ZLXls8wrPf+UttKjHYzrWKNJiKIHhj9wZRVrECM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cWXpduITit3klcP1skSS8edaBz1YJfiMyxqjhNFCe6qytIjwcpob1yVgH30h6YPvRaYSNWYoPCfpbL2SKxyJLnWNybM6B085LRfeUIm7EoPWv8nDvQh0WOT+bcma7w9D4xczeu6oh+KCcaEJlS9Zwfh/z7fBRgjdve+hOlYIhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkDczXCK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkDczXCK"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c560c55bc1so189915385a.1
        for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743138562; x=1743743362; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KPMG2gt8jETptnrI9UrSWYGZxD7lICCbFDxVOohqN0=;
        b=mkDczXCKuslW47sJWlR0z898zm5/Pg2PheUq55AwrbkFuW++GA0nqPDQjzMFSLUZwf
         p0wyYaVyLeFoH4LYhy3oFky0guqLUBQtNHbQ2A1jPEmC1/oo2q4Ez1o7bPnWEz30JMRZ
         LqoAkVxd/ACuOqwBNK5TcYbcBTcnyedg2vxrELoMiV22lmEqAXTUo2FkcP5bjiyPnmKG
         uS6b9Q6zFHJ72HZZIupG9tVHA5cl6JKOmcB6wJ1E7qENX5T5UBN4BBuM9DaG9Aig2Gax
         UltK8kgTSqTe+qENrOhQP/szY1uuJe86itydjhXunEctKHnfn+JCMysI6zPMcWTxZg8N
         SeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743138562; x=1743743362;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KPMG2gt8jETptnrI9UrSWYGZxD7lICCbFDxVOohqN0=;
        b=O9qWZTO0dB3cYr5o0ZqI1f+jthdm7TNtV9wcqk7C+KaBGfZ7nwpR7Ju+4/DY+fHsLb
         569t990WmzB45RBZo+DkVw1UMy89DCgh9+BN/TBwzyUzJbQnH6J4L9MTaHDJB5bBKCll
         wCvW4xhilSBOko/+RiJ/KM45nBERABMeR0g9umeXlHCGCk5O3yWQn+ZHesnCRhDdKblO
         IjzfkKTUDsP7ToEkw+7Z1eOM2j/8vlZBhmwhnqan2NeA4jYeDK64ktYrYlWfJlIuZMZa
         DopORD38MEyAvjFKxs/pggCGIS3r+C1VsHC5FqebfZ1sDj9chRRP2OgVvKtftdaHLNI5
         VKAA==
X-Gm-Message-State: AOJu0YyRgmatHBefKwT8t6iL4YxV63ali3f52wO8F2owyAxyA1LrE0nG
	XPKArg6gsRzRwGkIkgNIB+jR3BC/+l3P/jDZpGj3d8zfaSMyOVuvFQhS
X-Gm-Gg: ASbGncsxc3wT80Irm24WeOnt2hlRrE0Gl0zgDmKfBIpomSZ25QOlWtqDDq0woQzT6Oo
	OUbs1lmhosKaEgS04MRsGbIodwwtJUMzNO2FrHjBkBcHsWqVe0mOAwtK4s/PdQ76Hz+xRMPT4TV
	xpvPKCGXcQpNr8yi556PzBqkz7aG3Oj+o77ItElcfBEw+9esTT7vCVTK0QWpB4RIlvYbiI/TXWR
	xF5s6AFPQzuC1Gv2k7IYArcObJ7Xid2njvgeSr2vTnFFJ9djRUdlDI8sti4SumGcwAYorqpN0vx
	c7sbf6SzzOKI+GMbYJsvCDrgTK3SfEMHI3QgQHxYOu1GdxjgPzXdBYyE7yJ925si11E=
X-Google-Smtp-Source: AGHT+IEt7GzCQj1yTIesidwZ8p8TKgHNA4OPYdJ0numL2XjtoiPFMPVf4HHXmaomfLhEcNoXbIGY2Q==
X-Received: by 2002:ae9:f401:0:b0:7c5:6ba5:dd40 with SMTP id af79cd13be357-7c5ed9fd9e4mr714321585a.17.1743138561715;
        Thu, 27 Mar 2025 22:09:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.78.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76abdeesm73970285a.57.2025.03.27.22.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 22:09:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743133948.git.tanggeliang@kylinos.cn>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/5] BPF path manager, part 6
Message-ID: <86d79753-c4bd-7911-465e-1377a97ac01c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Mar 2025 05:09:19 +0000
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
uns/14121889205

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c19b176f03f3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D947940


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
