Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A828214808
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427546; cv=none; b=tlQFbiDNt8KBaijLT8dmkzBzh7/GIQQbMxRMDjhxHjhMGBQuF3cj7JAYQNNlgXDbiNBpXK/mrXhdQydM4V9K0hL2JlzWLefxkuAcEXwEmFar6XCx43HX+Fk/NciYxwLxBPWdON1ptrVxMDpEsM0cEpaR4V0hPUzCzWwrIxD53Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427546; c=relaxed/simple;
	bh=OsvcvC2Q7/XxdNDnEbY73HBvJqoRAQ8Mz/pkIC5aphk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Jtw2c1peHYXDwUOabtawlhsKdXlgKXc8s7Fo6J6T5rgfU74YG+kEuJZCxR3K+NclPXWlHXDKzTbi+31/SqT8OehwdgKkrqqETYSnFeW+YTvadZLpwM4odzdu3KWJftH4Lbp74mwIZwEe5wSHrmaTEoqdHDcFepbq5cCdYRM/ofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeARh4tv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeARh4tv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f44353649aso7157001a91.0
        for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740427544; x=1741032344; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqjJ9uFpyKpyPaQiUZB6H11wL5vn8Li+gScNsLE8ftI=;
        b=ZeARh4tv+umBegX0mt/vCGgLqqBdDXl6K+k2D0/1IKEBOwLNpVdHB7G5HMFKzfqYII
         nGYp3vLI7pTeBv2y2ufW54DKdQKniwjHe7ZK2K6fCL/f9OimAYMaz3Pk1CdvlgBFaEhk
         fExDCbAMKtSGRERR7j2ktJxW15TpgBh8rLoYVEPmxQPjfoSsG3ek0cXwVYtZbau/3Yud
         59FwYO7L0CV+bCWzIXUzzDtwBVpxobEPozCHvbJrgBkeb58juON4kBYGx75NL0CJLMyi
         Q1ZgDWuzjS59TFt51dX9cmme7XiPRzVyB/Q/JXQ8xUB1YcPMD8i05VQPYqfVoz+LWQGb
         AM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427544; x=1741032344;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqjJ9uFpyKpyPaQiUZB6H11wL5vn8Li+gScNsLE8ftI=;
        b=NQM9NcSkH9ofmDYaRUNcfgyIgIwze7IlyQ+ggeEw00G5scfpWKMKf9691H45TTDtPB
         DVNTHpmZVih9AGoo41+lu8dX3aSUIdrKDP8DhhpidQkPh5NutwV8QxJ0cI9/sB9ilccB
         RdxUwo43dNHF7Zo30MrGtCMJDdyVST8DQH853JCTsPmX+fHBa3BPVOx6eFbQyG4vnGS+
         uGqd/2BWJdnsMMIFDAvfFqYeS95kEkw5fhXkvWH0ZUNyZpLWcNNGgBeRcKG6t5JTcgHH
         e/Pv1x8Y9X58fZWJJmpJqWp008p6qn4BdkkOI4m4q+NYgW30GrdYyyoqHjlBgTdvwr1I
         orHg==
X-Gm-Message-State: AOJu0YwUck/yuos8ribHaIWHrsTpRHMqzRKH8FCL0VbM7TxPu0ZLK7Xb
	MN8x75WzYUnb+7pIDJrYKtw/D50l6X++nVrpVHqnq4YpB1UVtto=
X-Gm-Gg: ASbGncu2k3k34Mt5Gi2iYy2q18aWXXJfmqNVVznLD6BHCqKamdtSgUuNN51gUkYokID
	fx33YPIfNH6MzzsDCcVSmjAVhSAy79/hPr7lxZSxPYEvrSL3gBLcKPCH/CHLykc8IQGktDxkFW0
	YC+8dtd7TnLCiBTMlUQXHF7ncohEy4zUCw52nt98VHPzRicHj4dd4IyUTd8zgf5oQ2Tyu6bGBCS
	lMR5t2aQgc0kDPpSX2UG7Zw7pPmayUNFeUoT6ijIiIzGyDi0C7sdzBDYj3hlIMURzkSKbXbkO3/
	LVIU5H5CedM9HZOiHxMZlSLuuEwFdR/ARK1YDNhy
X-Google-Smtp-Source: AGHT+IF1Y3vctfYAigV4FRHP7ihqz6JwG2X5f0z4czkB5TShUSDSC4RCsPRAoNHg03c+ZfAvqiQuwQ==
X-Received: by 2002:a17:90b:2fcb:b0:2fa:1f1b:3db9 with SMTP id 98e67ed59e1d1-2fce7b0478fmr20812555a91.26.1740427544416;
        Mon, 24 Feb 2025 12:05:44 -0800 (PST)
Received: from [127.0.0.1] ([52.160.165.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cdfbsm60070a91.33.2025.02.24.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:05:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
References:
 <20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: userspace: avoid scheduling
 in-kernel PM worker
Message-ID: <8d909585-20d5-45e4-eec6-3722675149e4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2025 20:05:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13505941194

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c3c9a58d9080
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D937225


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
