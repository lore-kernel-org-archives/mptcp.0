Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CD1917F1
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026194; cv=none; b=TCsZgxWgC0y/TQNb+ijSbsuOMPXRYBgb9bQ82r2Y87LbX9ZH364edftuWkPPFP3lhgHuO4qN4+aB6cNCDCjh+SoyXe2emN4KGVbSW0I+dhAv2gJY+p82dZTDh43h8qnJB/dXCpMHyoyCLlLfgP9XFPAxDr/NEDSRTSG3IuhxM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026194; c=relaxed/simple;
	bh=sLyjGIY2nqzyND1HsPN2pX4wTLURIIkLFHdYnZLXxPQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r0P2I10fxin/EMQCCVNiByjsVS/GbF4gBZ9BdvtDJ0vouEvQWC1NAg8qy+0DtXJMKAzm0odIWuosSrvXNkNYN8PqGxTq8i/84Ljlwk8P98g0jEoot+KlaVqT6LoGIbArNMeNISzNwbTuReMrnob42f4S0zeYfx0khHdUdA4yYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3N0pWcR; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3N0pWcR"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so295535939f.0
        for <mptcp@lists.linux.dev>; Sat, 01 Nov 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762026192; x=1762630992; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgaMUctS4CE8NtKuhw5dU6eQVSP4IllaBxBPaMzwwIU=;
        b=B3N0pWcRkNgsX+Kz6oHKcmmXdCNZ365NigZLhAuj6hqy3nfkPjIVeoXBsyo5O3C6wk
         KId+wpzMSnn8OAE5cnJ5ijGIFa8cy7z3fo39WRB7ImRb6afYbJIxuK/Yt19LsnqEt4i0
         6hYwYdxSoB7fj9hGQsx5LmMwVEHbOw04ASvC0pLIatdYzEknPom3tMgKrDyXIHEtNrco
         gHHHJCPd7qrlqKifgcOGz7oiYBhDZjEJ7FBElKpTLiduqWEGgAC20gve2aYZosCp1y4n
         Lpg8i99DDizgC1up8TKAbNdbJEj/uKW6TfHTSkG1wcYtK7jSNJhsr/UmYws8Dsm0ilA/
         WUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762026192; x=1762630992;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgaMUctS4CE8NtKuhw5dU6eQVSP4IllaBxBPaMzwwIU=;
        b=KbyVzVXYwIywAwoCEAXkfQ6tVJxSnUlqntQmCThz+TZc6GsmYI24eIOxdA2xw+lSBF
         WQYJDGrgVPpr1nvUo2VVegxiJtQzhf4m1/BBgjVLSa5z01w5l7DcASSQA5XYq+yXM+j3
         RzxZfDtdlP9dcowR0GstuhtZIF8NVSXeGu5drbzBFr6iCzAM58kxI5uya7n2775s4q6X
         FURivdOYeq+j5oWW4FXXHtoBgzX7xKkGYWscld9YoithFXj96COuy0/+IkFBpm+TpDyU
         MtDOedLWdQr15KkGROh1aAZ4ttcpq8VVCZ6tAzLC4JOXLGNfR1r3tymrMXGjJqFAWERi
         qpIA==
X-Gm-Message-State: AOJu0YxUYa+f7nOWPwHA5nNnjC4Vwq5t3K8GDXLqwitwtveicq6pvseE
	FJVN7shFKNCSBM2JMdeqwaXLQ5gUjkdVvx3j463iIgHG8Ack2EiYJ/c=
X-Gm-Gg: ASbGnctUlLKBfUor/bK1eM9gh1BHegUsmIfIldVWZ+5+qdcnqaluSmFZ8a9SM8vbXYs
	p2nmz3KAvfL1GRWQ94Rv8kWPqMCQBbD0b9O6eQCXpFJ0N8TPyjh2lvBb6eunAlXfUxKvnghPKN3
	qTFOCHP07rHr6DHJcdK5giefxj3iQeXxy4r4ByH5RzmQUvgvjCguHWcXi+t8oyoMgBWblu5i7oG
	B+dJE3lfVkXUgPzFapOowrsh14r6pln1FpesoQ2PFKPpv7ZXfeZa0KwHAUH1sMrUq+PozELGolF
	ng5oASEljndKnt7BOkOWvfXkMxqUhYI4ENrhxBfdDP6LVFtJeqDIeQE9qPO/5D8ArK/4ei5PWiP
	S11meJ8BY4ThmK9gYFeDhf37w9MKVyyMhoW5EEkWMftZDMxq42u/iyHemL+pz7Vvl/LhY5awLBw
	CTg69UGNRqzqzqPQtG/H6WtRKT3w==
X-Google-Smtp-Source: AGHT+IGQfEB/joRqb2AuMFjBGoOX42SuTuV2g4rXu+Q1IYiFDX5wFEBk0OltpHn+x3ITI97hjxnAGg==
X-Received: by 2002:a05:6e02:12cb:b0:430:d371:d3bd with SMTP id e9e14a558f8ab-4330d1dbf00mr105048445ab.25.1762026191767;
        Sat, 01 Nov 2025 12:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.184.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a34b85e3sm2002973173.18.2025.11.01.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 12:43:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
Subject: Re: [PATCH mptcp-net 0/6] selftests: mptcp: join: fix flaky tests
Message-ID: <3bdf8ce7-2104-78c8-f04c-2f93f9e9e60f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Nov 2025 19:43:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19000566005

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6b0e1d6c4c13
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1018473


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
