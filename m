Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CD58103
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834542; cv=none; b=n0bvKPJxFL+HttgBL0tD1hdM1b6kH95qSUybB5kJjuqLf7zBazn3SPO/vgei0s7Tw9U8sotU5CVpL3bU6NrKC+goVT4+CC0u9291K58P8tGrooq6A4dhN6c2iWKoQC9hDl12FJKFXU2EHDNS+s3nZMDO2BepB/km6NRpprpi8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834542; c=relaxed/simple;
	bh=zBrl0RBAjp86nbQW7J9i8Z0vubrKrkgSaCICVQusV94=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r3paIljzy24qZiuZKZm4B+TCVz7xZGqPou7qZuIWh8jg/AmmHNUuM1EYs+i7pN9WCLHbodRqaaCM7SICjkIoKT9+xPPmTglK9e3EfPwYpQD8/+CvGFOAbEJzcGBLMDOrUgEjejqIXpvMbw6hV95ujjdNhSB15aJwYodS1UlQ3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X41Dw4EG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X41Dw4EG"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-785d954b236so87344785a.0
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834539; x=1708439339; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcQ/cLwCmB2B3n83g134By1pvj0g11tb6WtM2vyOx+c=;
        b=X41Dw4EG5w56FKFqoWseWBgJBtjk+wZscJMQBY6XLt+aeF4RS46M6hDgN6iJUEBili
         2lqtO1FJIoQwhA1jZguPHSKLY3vtCI0DHDNTlunvdKfH03fmZuHVcvKLjdudKPBvuPso
         WlDHpxNp8y1hPEyBL2G7i1s3HRMNmkPaep9pYj1v+IbeKmslW2y7eSp0k7R8Dq/Eblcu
         /uG8CvXWNJcsf70RMEVQ8cjGNa7xb4DfvGwa4zmQi+nXsN6p16j1h0+T3Fj2HaJDXT5f
         ANiqLRos2yGe0Fpfvls2LGQu1lZzzI7Nho/EEFssTzwfpBFTlHbdqzCkn8I2ZlM8lZ3U
         73ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834539; x=1708439339;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcQ/cLwCmB2B3n83g134By1pvj0g11tb6WtM2vyOx+c=;
        b=tGqa/D27xeKrT+HDG+893R2cTS0p4QRNPJtkJnSWiGKJ4mnS/n9OluuqX+TSZq0KQD
         1+ZqGEmG+LlP/bzUKfxYbyIoCeegdmrhmhN/dk+kfZuetFrnfUNQcbhKH8K+W3S/ZYBu
         rraIlSJhXWuVGZbhj59IdQOSy8X+M/VX4cO3g21fVldj7rlaPn8xAefIEGFGYXQov1QD
         yauYkxhLEO85CSnfqPDhOg6XnKKw1nGSmIDgGs8iS8SVY3sSM6E4Ie8pZMNg4tV7YI+5
         0O327dHqbE+5FceD6RE6TWydkteFrKZmUknbZ2yN7CYOv9yqxbe9bjwXetlhSkTNXmT8
         tJAA==
X-Gm-Message-State: AOJu0YzIkkLI8OPo0R0pFFjBqQDvZzXQFX3fsYj83+rgTpNFYuGbNOoQ
	J4GGMbChELp9DLxzUUTGMo3lXbiTbrxIW3pUurxLLENZJMMChOg=
X-Google-Smtp-Source: AGHT+IEFaJCCL1MiKhNkxHO07JXOEQhoCKlV51Km08akL/2/mzjtPF4eHCMSlOOzo0YJ8QW747FdnA==
X-Received: by 2002:a05:6214:27e4:b0:68c:7c27:fc83 with SMTP id jt4-20020a05621427e400b0068c7c27fc83mr6864576qvb.18.1707834539612;
        Tue, 13 Feb 2024 06:28:59 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.99])
        by smtp.gmail.com with ESMTPSA id nz9-20020a0562143a8900b0068ef3d21eacsm302343qvb.52.2024.02.13.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:28:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
References:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
Subject: Re: selftests: mptcp: lib: catch duplicated subtest entries: Tests
 Results
Message-ID: <bf992c82-a329-1343-6353-67a4b1198bd2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 14:28:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7887527303

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0c1cb32e0aaa


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
