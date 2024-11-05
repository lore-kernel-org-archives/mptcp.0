Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216882488
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821222; cv=none; b=COyE3TfToA98AH8dPVubCtdZ5gaXgHxzjgpxkNHA+yA0zIJOBJHuAbwhxzVm9MpwV1FsKDB6m47NhiFyTpYVrFdjo2gvVZlD+iwk0wBronbPFnO1ZW6rxn97xUiyeor5p6rwk6VY0bSIQgP4vCfXITE/22izL+dtrWdg418rG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821222; c=relaxed/simple;
	bh=1pNLDjYzpTc8sMewscHSCRpK57lCMljeZdu0/ZZkz3Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kH1DpB6ejKdwHyaGgBIMq+3j92l2UFjMUG870QC1LWQyvGEIjtjmIedhpPeunXWC7e3gPIJdoQMjk1wPkZLTPtsEWS9OLWmUgN7Minizo0yVZ98t4siQ33kqIIYf2ddI/lWEjLhdTWS4EdoRSOi5bCgb41uQ1DBgy45lIFa6qdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFv9Ay3E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFv9Ay3E"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca1b6a80aso58347365ad.2
        for <mptcp@lists.linux.dev>; Tue, 05 Nov 2024 07:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730821220; x=1731426020; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GFZNUBXrgocN3s7tx262BEuKFLF8HsQ1lF3B3U3e9M=;
        b=VFv9Ay3EeFa8Bipm6nsqxZLyJaeB2joBysWJq/XG58M/7y8Wtg278hHECEoGqmuoI8
         6hmDcKXbcYIUi2ZGmCfIwh78l0UI2uh95Oje/mmj1uYeAelO/5m0Uvo5jB9CCuXzCZIL
         VzNhS01NhpGwzaycQXQpU3EcRqIMalVSCRvR4g0V168zZkOKwlPY9nFr8DDwf343FIEM
         2eHxxefgr9LVa2Z3ffHpJFbdUCVEv+daw0JfI2TN5xn7RdxsQHRwLIi1O5TtSQazMNKe
         DKgafD4Cs1pjQfrhuSbgIXGeCVcs+YNSIMDTNEXepV0WwXZtYqQW4TGOVg1sYy6kYXY8
         sfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821220; x=1731426020;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4GFZNUBXrgocN3s7tx262BEuKFLF8HsQ1lF3B3U3e9M=;
        b=cF5G9lagD3lxQW3RWjPXMWh6f/WPmM4SvhSZjq4rYs5aEj+AHVHNvbIwtVQWbcIEw1
         a2b3/3Jr1BuZbEoT3VfqcsLecjpAA/piU6fLv0Zb3lhW0Io9vWqosiRSzi2zd5BFypgZ
         uZ9N9Glb77DO36XhrmEcNm/KfdAvQdV+dzGYof40fWL+w7NAYjnlzmKKDGVS26tvQbrr
         DFrBtOasQBj7XqKqm9i9qDTAExHxfHu3oYO5yGldarfRNBU1nGZtME3zDVoeiNpCjO3C
         Vn2ccbmfzhOYqf8cp7fgYXwz8oh8J2WP5Kqi5/TVAUvKGpeU2JJM3EQBusoQea/lcN+q
         9YhQ==
X-Gm-Message-State: AOJu0Yw20KNSPHM1HvW+78NMtFBCrPDx3c3i8EQlCyjHnA6VFlZlxa8R
	O7nHWcc07vq/PzVFyNIC/Ym4Ht/T8hefUtao0Sk6fDUYjtGUjbzUZzUm
X-Google-Smtp-Source: AGHT+IEtl/GNWgEPfcW1ipE3iKHYrTTeE/J9EyXw45Hv4zkH90emzagqK9hIB8kZIHY6CbIGjPimzA==
X-Received: by 2002:a17:902:cf0a:b0:20b:61ec:7d3c with SMTP id d9443c01a7336-2111b00131amr224808805ad.49.1730821220255;
        Tue, 05 Nov 2024 07:40:20 -0800 (PST)
Received: from [127.0.0.1] ([52.159.142.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2b90sm78775445ad.151.2024.11.05.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:40:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730799589.git.tanggeliang@kylinos.cn>
References: <cover.1730799589.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 0/3] fixes for userspace pm
Message-ID: <d3eabab6-85ab-cf43-bea0-5bef3376129c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Nov 2024 15:40:19 +0000
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
uns/11681780257

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e594c42ba8aa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D906422


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
