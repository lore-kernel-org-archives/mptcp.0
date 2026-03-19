Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E94C81
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922601; cv=none; b=CFted6JjIeTQ/ONqtjqjxrSZAeJ1wIi1+oTOtoZcytP2k7qNva6tfDph5ZEi11TGgseAw6yy999mW2B4B1sS3qk81CQ8FdFVPDjoZxbbuolSXBFpkeYKj4h/u7gkPJmTcEx0fpqL/BMO3gAP6SRpoUuqAMAa07LYN0NpBFokpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922601; c=relaxed/simple;
	bh=6fctG4PAuKU9c/+v1BnBYf9113a8PBY5QNOj7jHemYM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tz9jpXdrFCSDGPVIg2+VV8fVu539hfRk46IQV4n3+i9vlZgh4XFNJwFre5z+u5Ey8S0NFydqMajgIuihuYnpXZQGpb2OkFe6qtdsvDUIPDcwpJgdgmUHd/aSsmDAiA5npyOOY/3SYnfN58oA0v95QIvxxV8ZlSHMr81KbNIT7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhtJtsOG; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhtJtsOG"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-950b8021c5eso207564241.3
        for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773922599; x=1774527399; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHqOhtNHgQQolaqtfXyK7wfpbupklUo9fAedrE0gFxI=;
        b=mhtJtsOGX2zcGMFyVf8KqkpQWkfRbRWzkB7jnT//gIa2YKHlYslqN3iAo5+lceqE2I
         ehi7/9kn1hqcn4djswPCmYvCgaJF045zggKL+iJPcx1C86HtNrT797Mj3zfblDNg8tdb
         jdJeUxu4ibSMuHO4iM8xORjwEDWLRANdkS9UYD7MouUQm56ZxX9N5RSoFZgMqBvKJrIa
         E32AKQ/a6T6M4W7jLktoWRW1HHIqbe6naZCZo4D2z5BKRTINbBAlVvIWLm2YHwrtQ9s+
         /DI+aP4F41kMqtU+w6VTRTlCrhRex+sMzxEsi3trEkZORekK8XlUtAP1fAIajqCZdMms
         boEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773922599; x=1774527399;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHqOhtNHgQQolaqtfXyK7wfpbupklUo9fAedrE0gFxI=;
        b=caqmU2s8CKExfGMHK57KtPV4sdVe/EU0rHb5IDD/y0TA1KvpKmW7nbT5PvTCH4dEuP
         XfF/YSAYpEik0JaK/uye7j/Fj/7/E58b5yWy2M8MHlJHtjWtzVN9iGGdov2V5DlJquoy
         vYYcfhhtRNMQeEi66AbMgxrkgBa1LIQse4KJrOVxBNXjds4mSuRJiG02XTWUgkLKZYJN
         NJUAjLAMHzlUZNBfwZAuSlm8Oh9JYoQFj7f5V/DgX7gG2MhMmJ9FAjSxWJAgPh23RPdd
         Bqq8ms+18/PHqVljHlXNkCorPY6wij8fCqrr+i6Am+nQnJMfe30PwG1uOEceHhEnr8t+
         TCAQ==
X-Gm-Message-State: AOJu0YwZHxFFb3a0UHnFgZma+o11bYQ74tjgk2gCAIlAC9n4ynlKx36X
	p7oxtyR6NLZ2/4/fOavFpGbqK3Y106h/3Ck+9q5esMJyc3pWznMQeCI=
X-Gm-Gg: ATEYQzxsB+ipHASc+/mqIqY9uqXFpVEUxNHX0UOaseqMEMrzdJOFK2Kf+YIzEr4U1DR
	xLFSsHEo3oRNX5EKJEzXSx/T2IZK77Ww0w03z/f94iDi4HdpZLf4inz1ycwWct4g5rjAfReohPM
	kypuWw4Po8AkCaVjHlxIi9zxmxnXZ1XvtlGoDr0RlnG0VPnYkfaUUmaSgJl75kAfhi/Kl/1JbcC
	DCnBhHjR0gpTKulbvF0KJBwACPh+uLd+Byn3/GsM9/5emDQPIbYfWUYP6dzisyJXVaZhx6WU9MQ
	7CZgTg8QZpk6k0Pp9DNm57MmlHL9VTVbHZRYsXsEXBWws4+nKIYkc6UTMJ9Dw03o+mOa9ZlLUyL
	tyqp5GZZ/KphXdC0HCP5gPRANdC33OcTuYx1tmPZ2kXaGSZptnOX57YsR7mQeB4hMXQdDddKv/T
	lhLJCkZIUUqewd42nrHWwH1mFfvj02+4f2P4wh7GHYenwUnA==
X-Received: by 2002:a05:6102:6cd:b0:5ff:de16:36a7 with SMTP id ada2fe7eead31-6027d2ddfd9mr2733115137.23.1773922598999;
        Thu, 19 Mar 2026 05:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.161.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc3f8d2e6sm36538485a.40.2026.03.19.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:16:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260319112159.3118874-1-lixiasong1@huawei.com>
References: <20260319112159.3118874-1-lixiasong1@huawei.com>
Subject: Re: [PATCH net] MPTCP: fix lock class name family in
 pm_nl_create_listen_socket
Message-ID: <884e2f4e-767f-1d10-eb84-e9406035c743@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2026 12:16:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23292439480

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/41f128de64b6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1069207


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
