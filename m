Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C42D73BD
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027676; cv=none; b=WPD4/ujO11FkPBPH2TrM+sWxfTN/9pz2rRNZyuaHJzfXCxWVU8bNwRaDyLQiYMXfuuf8aAV0gdHfuncs/o7f4YGc4wDJEztYS0/7lOT/nSW5GnweUhK6KwgnTr71vq00bktg53lFAEuHWkg8KQyFtbQdJnjQWUZPkVEkWfan3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027676; c=relaxed/simple;
	bh=XttE7/KANqF8ZqOcn5wmv3FoG6I8adWr5vafd/xrx+E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hWNJhjtJMw2w6cCWbW/f6fU7sz7axT1Ux1xNPTB93LnjpCpJn41QEc6n50/NHOxEPlAk9qjA+WdMFSF6e7MZ+UURCDBQFFszUZ6CrOTyjQlYIgc9yief3MZBjXXEkMhpqVk8rc6iCY6GPSapUCWC6uYBFDe60EFVAe09TS6VcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UivXvN3o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UivXvN3o"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4661811b3a.2
        for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758027673; x=1758632473; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STh0KnRWEhvxrngJOr2RAFwrg2TJpFrOCtGhZcW/A/g=;
        b=UivXvN3okprwad+ha0qupT1SQuwa4WAj+D5TNVNlGeNvhCDD3t0CVcSjPEx3IliSBM
         4yMvZcKcClX6mTfwruIz88OWdJ/OKUzbUrqUISo6S2ivlwJqBzWCp7+kp0gC+e4OjF/a
         SBKhp3Bx9u1r9cwo0eLYxnFEVKPMJouZHzrMb5oMHGUKkPW0W3EIKGv6TflM2Pj3PhCH
         mzrMqGVLJKjWp9ud1chb3NWwCg4eXKlrjmJDiTDAlb22U8M4DYWb4+aAeAJZcnsP9akw
         cHb80DNgki45CJ2wjfhQfGknKEVybHJEGWyJf9vA9uPCY9Urc23FA7whmqFiiLkTu7XN
         Dkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027673; x=1758632473;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STh0KnRWEhvxrngJOr2RAFwrg2TJpFrOCtGhZcW/A/g=;
        b=K7vxhWlkq/jVB6xLcQhudVyHYoZhCv2jWyrhsfdLe+QegGZFLvugohFvx84yHa78mX
         Hbo3A506tU0vXmM8dlZB7L2bnvQ0fNNeTEGjUrYIlVI9//AGeVLMOXM3Eys7qLbj8/iU
         kBYZ5FO9DhPyHVthVwklWKPmOzTYn6YhBpXbbMf9oBKKVMEwvcXxijMG8102WDRG2IZV
         +bVmtt/iSVKlWD+ElCPDbMt5aK5/3X3x4e2yZfQj92Yh8LavW+XPOtWuNIaJM39gWwuT
         jrJxgI3oIYWqic/TvLYJuON5/GjS1n5iP367KCgLTyOcpp7M4sd6INIf0Y9/Syu4r+i9
         9bJA==
X-Gm-Message-State: AOJu0YxQnY9F34gwec/5lADcyc20lQ1tZbMS4S368EN2XoS06UgLaWvj
	aedcuhgJjpN5NFJnYxV+iu4FRXCKByOeF6mNR7uqAaSPmzRPNGgRsmM=
X-Gm-Gg: ASbGncvu3EQK8WyNxfsemzgomjNSqdNlkguZF3liQnH7ikelQ66MAAVpw+yC6L/Utxg
	RzYtmjeKCS9nmLHenvCsDpuC+y6XwYRJfpNeJvwgLm97c8vAFZOo2PzBS+b9WsVQFSRDnuaMSny
	35XRZuPdYkOqCeYYTG5nuVakjsicZLhL7cZgMUQLq/YPDaHbXXIYJvEbtYXUyZioPNlTc2Gwa5d
	qsiJZvM6XTnxkzTDybknNkG+q5WOVfaHsTpgFCFMX/aGb2eMKzTtPZ0eW7iRX6qkefQ/MQ5R/28
	1GPXJ+3ae02MHxLBWxJzLhI0FAtJTYDpoMYAGhGStPbwpZIObgPCxXZWHwYmSgY0HXiVV6rDb08
	+/nnZ/vBbbfPcNaOwqo9vLlMacCRK/Xtg4+HVhQ==
X-Google-Smtp-Source: AGHT+IFHEtBgrg09CP6TWRklIyeQvMgHG+xtGlT7Q3L8+ue6E9grKkpO+o/tlLSXRPkcj0G3dbqtEQ==
X-Received: by 2002:a17:902:d552:b0:260:df70:f753 with SMTP id d9443c01a7336-260df70fbdcmr167032275ad.38.1758027671729;
        Tue, 16 Sep 2025 06:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.213.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ec29c0acesm708915a91.10.2025.09.16.06.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:01:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
References:
 <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: usable client
 side with C-flag
Message-ID: <0694276c-70df-913e-cb74-ab9fd1dcae94@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Sep 2025 13:01:09 +0000
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
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/177641=
30273

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cbd9718b7233
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1002880


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
