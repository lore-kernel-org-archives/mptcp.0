Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2891A0BD6
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633646; cv=none; b=GWAoHq9mfx1wXGZfExWezWY40QelnH/fMxyXgnfUDXDeWW4ytWslAF7ACmnjCJ2AZqFKGod0Mmil/g9eYhztxMmGj2D1FexooeuAgejm/XWIl7sMFjpYGlQ+YHVoARJrb10xikrFMTVAzBNzMXbqC8t8/zo8NxHud4bdVxEzwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633646; c=relaxed/simple;
	bh=27MtPMqGjg8eTrOvqJuVwf+ibAnO4Rbz2SK4KOIjc/E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kMfp1VABdpOfnTcAXHo6Eo7sGT7C1O1+LKGObxCrjQgICSKwaDNjsH02XpcXGYGONs4axaHWkor9LV6oHT+AtUMGEzIaG1mPpC829U7aBL4T6s1W8c1l32JTzqdB34d8d2cNO/SH+XSv8eKYzVmPeiDFgmIGkcXopna5wesTI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCYhyfIX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCYhyfIX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b474e8d6d04so1656765a12.0
        for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755633644; x=1756238444; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdRi35cJlfnovJYbqyIKaz0TvaqR9mmTILBFLkEMgYU=;
        b=HCYhyfIXJbXIkDOzVZCxkK2bloUO26BuaY1/nfHi6dIe1k7Y1g7d6Ra0E4iXdKOzBP
         J2GxtCMKgV1zGzqEuzsp1S+hMaXBGdIOrSW1Qpcq0Dxtk06TITbWt1xED4e8L9/eqgYX
         6Ioh6a7FdlEKp+Wtl1CBHF0PbMkkW2/QfBz9HtZn3XkkKLIEkyaCKIeeosrOatBFsZCu
         iDeaiul/mGbNggWYyGDjBmLOxFSeU+RUvI4f+ZGqdmmDOZGgIPIEklX1bQlh6/Gm8vey
         kL6fUPm/ieM++E1bjVlKq0EQXCFIxe9ioa8UAyJbMrl6nBYZCf/uRoz5xYZl7zz4D0wY
         C8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633644; x=1756238444;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdRi35cJlfnovJYbqyIKaz0TvaqR9mmTILBFLkEMgYU=;
        b=GiYRhU6qC7VjQvXta0nxDfWAjbVsT0iBhxFCxBIPF5Guu/aUtwhH2fDJYhpFxUK3UJ
         gJ5omJWuLjc9j8jOHURDExV2zJ8rad6TWO3UbtFDLS1mXYrTVDTztjEPFE1rjcCGwv7w
         NgGLa1EhCjS8QPhOGa0aukfoV1IM+Dji8uy4r7SUw6W+JDM0rkIjqxwIVjZ1xrwaLXrX
         e41cFOWe9xAINGN074DYiMRLNRA2v7DyYitSk2mEFQJtT1oyoqduEUmjQo7hgpp0l6nX
         Lv0Fba1VYQM4mZv7iqHhJwFDm0rntHhopKmbD7nl+jZDvZHdTBfFDczBj1INsgY2MuK5
         cFkA==
X-Gm-Message-State: AOJu0YyCNsEdzhU1eU8zc5ZMhtU3xjS5lGYHoJmbjz8+4AhXhqSK5AfO
	NzVqwCAU2qWnMq9O+3kKnUlN2hQLNpLTwHmy9ysML4cd/ZSc8Lrnr6c=
X-Gm-Gg: ASbGncs/5w+reiOSz6vRrVHQdsgkaVQdYWRnQYiphFmjs7H32YCObLmqxKWlQhTKx3D
	hUfCJZtq147oRtksACoM9JdexWnCpMXBQaok/vbtJ9OZIcsOnGPRczHXEx0w7AnfNfnTNikjnEw
	jggKOSH1YRyec0u/uo1eiUvYBvkTc3FRnJnynbAU7l9FqZmPlPsnXJZkNr8+8vUN9Kxt2FspLQm
	R7tKfDLO/d8rnnwrf12mnsqp5z+KwYdLlKKc4eJMMX7/P+ntkmoQKng1V3AA/Ka6dtw5X7+xlN8
	kPCaXvQ5b5ugCe/rhdTkXppENAx6VzZvR4wu91kLfbU+q8QPRQfc/wCpx2yAToJqG1mzMGD4ZIO
	9KZAWG2NRvlOhVzHc5KfXo0LgZTZZqeqrocE=
X-Google-Smtp-Source: AGHT+IHnNGk1n6LIS0c29PUKFBEVe+L8/mlqIRwH4feuwHm+OYU+nymsBFoplaLJgxR4kwOW5xPo0g==
X-Received: by 2002:a17:903:41ca:b0:240:79d5:8dc7 with SMTP id d9443c01a7336-245ef25bd6amr3138185ad.46.1755633643601;
        Tue, 19 Aug 2025 13:00:43 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51aa14sm5040375ad.145.2025.08.19.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:00:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Message-ID: <96437f27-6338-2bd0-f11e-2d122a11c3a7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Aug 2025 20:00:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_fastopen =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/170782=
72848

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3c178d4c6234
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D993167


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
