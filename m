Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FB33FE36
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974439; cv=none; b=p949CTbuHDgOl11/k/qNWcowO/R7EzfbLuOfTOqv3HxyCdJ+Dl+Gqjpv8Jzq6BJlWuQlfqkY5anqpdoCJ0a8kn/3SmBvOyvhLRb04nk0zvLx9KMHpaXgpZEtftWhkGDKcCahNGCWnMwGIUTlGGrGmhWb7xckVqYuH+b2oNH8NkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974439; c=relaxed/simple;
	bh=EnZmxGQ9x7U0ex2tLI2BfC7Txj5Axukxf2fgvhAmgqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=M5pQ+xMrqYNqpV2BKiiC0Am0pDkaINgU58HsaHMceVWDhn4nCb4qhWjKHXiLpLxMSM+Ne5hlTyfUZ3szUAX24Wuo2sAMQhWkzMdCmvCKAOVaslPE3D9y8Ayo6TpcZ57PkNWWnDoDwKO2x1kdREupTfZXQqU6qaCjAeGBQYXvWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLLJDAM3; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLLJDAM3"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3074adb8fcaso8496533eec.0
        for <mptcp@lists.linux.dev>; Mon, 08 Jun 2026 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780974437; x=1781579237; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SC4DMmNYar4bUOFsm+SOuKWOglgHWBEuXqpNZWvwTc=;
        b=fLLJDAM3iuZcynLExL+xhnAeoSdQKsEJMsL6e3Q4iEsTmYz4A6pdU0Sm/vF0uYAXKs
         5rvMc825FMt2V6dZqRAK6K45EoiByBYvXNk29qxxmbX/E6wVIsJxKFsL8TnderW7U+Cx
         HqH4/9h/iJnv42ORhfK2JXvTDQTPXIXr+V9teVxd9myp+8k9kMbn7nC+SOnhDM5cTmd8
         HggrqFzR21gt/N4OXFfBmoFmIoOaHN7DHQh85jxbIJ2x/2vT5O0ockMXPsa4VXAP51Ge
         ZH28kWX8QrOh7RfEY5wsFii4SKjW87kFlGQulF4m9LXWIemhY9nVX35nDj4jpvaoF5Ry
         Dr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780974437; x=1781579237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SC4DMmNYar4bUOFsm+SOuKWOglgHWBEuXqpNZWvwTc=;
        b=sWZGZWaAJysKEessLd5oJOi1rrPCZI94zyfGK7zf/PP2bAbNqBi4cKHOU4DbQFb/2e
         khszo6TRE5s4GEjVlWBo3zztvTg1dVAJ0qrNuQOheNSrc13jVU+csZ7qhazou2etsK34
         DTOIn2SLQWYvw5PTWvQlhsT/DXjaLiqRb/3L9vnwCNpQG2WLyU69QTQkjRTPRQnEJFXA
         OpjS2TlpTptbETBxDYR1bVxdPuhHVRiatA0HkAZ5YkIj+rH8SWlVzcwjnjIQTnBITpac
         2y0npmWc3gzBbguyDAG4oKEHDYN/IoXU2fQXEDTojmRDAXARP6YJCQ5OD4xga2VO/T4e
         3Ahg==
X-Gm-Message-State: AOJu0Yy0DkZ9aC0boPCfpDdD9X4dsNtq1e+N+EXkBCA3EojOZ2TtG0ae
	isD8rcjnMzQw5/5PRZG4vCO6pjEXodIsK5AxoIVcgDDmGzuym+lP43nZmjxJ
X-Gm-Gg: Acq92OEuE3a3jy4HJyRFZRGqDOMpx7DPc3qEmLbx2N9e32trPf5suj0OVErF8z79fg8
	vrvKbFfhvx1ApwtgU/3REkloo4csRxEZ9hfFfz0/+FZVqpVSQR0gdgd1t22C16S9/g2b2b0qGq0
	WDubht4hod6Mo0DzRNsBC5ACGyEprOo8q1Jj0J1BB1A50rbXLxg7GZo2Qfa9Mc1NyWmrh54of81
	tANeF5uYk6kRGGLI0Du90PpvM0BMUfGor/hBV+Tk7iXp/F5HR9xwk0VgpMte6SnTa7cMHLNe+Af
	fwlAZL2YZ6GaPSR6g3bsGczvn5MHvgNkDClqRDXhAqRotSZc3Zbx5mIPjq/2h8NgfKxV5GTlL9z
	L6HAQLrEIBVhdsi8E+AcbXAnpu/+EyeRPuFdK5cWhximO4oFZ2hvCAuujtDCnEIKcchaMtgoozR
	UbVKPn4uvL3WxQnUsQKQ1UP0tcf91hNKH0IsEbwFsdGX7iDtHns+7nvhIAlQ==
X-Received: by 2002:a05:7300:bc06:b0:304:dfae:68a with SMTP id 5a478bee46e88-3077b29b6c7mr9891857eec.28.1780974436916;
        Mon, 08 Jun 2026 20:07:16 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm27829087eec.11.2026.06.08.20.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 20:07:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780968872.git.tanggeliang@kylinos.cn>
References: <cover.1780968872.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/2] implement .splice_eof
Message-ID: <40192d99-9e89-3356-494e-b1193985ca88@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:07:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/271789=
65576

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4b0197466c9f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1108212


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
