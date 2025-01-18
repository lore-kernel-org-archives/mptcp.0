Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4013C809
	for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737226489; cv=none; b=iZUWZVBSTKd6ztDYJZNUaduBik4vyXepbXs0OfZiCKhZm+qXSbB2NAUjfzqahrkdgoCFxJbmgm0BerjOCnG2S63lot2kjsay2k0WfUBZSBs8hlsS3Igsj9X+d8ZE+go4bS2DkG4O3NqKtKPvAWxTvbjUGuRk2ryx3fuBUYfk7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737226489; c=relaxed/simple;
	bh=HIf0FfCze7fuB3lpSSF5vSO3DT40vvoNgB1WFktXNqU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OZ6fpJEswg5L0EHHhZVDlhjJwPVGixK5T7zQOlqwxxMzYPRDqwuVpb8zFCAKIOSFCi4fdvbShkbxYlJWrtNTMeEFjEE6m2dVuSmVt4ujQw9sRRvXMi/dIEruGfsVIfTZDWpAi9uPZfD2OnBnNeqYu10SgjFIvClWnRH2sesBViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx7F9n03; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx7F9n03"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6e9317a2aso378222485a.0
        for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737226487; x=1737831287; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcTgADzcOxcV97R4PZoFX+Rq3OmsbCClwAw/xIuK0Cc=;
        b=Gx7F9n03JwepOIWwuPzQk5bWqbDSt03CWjbYXGeDCdBgfaMMeoaCYyb6fKPc2qcH3D
         ZSbtqm9dUPi/JkkpqqBTjYFeaEPvyhxssi2bYtce35LjFQiWDkM1Zzjxfr6wYSsFA/hX
         7htn9r0GUv5XqB2/9kspJFs/GUyFNsBpSl1x0pGLf9KeytdcBzx5b2o4aMUU4XNK2qRE
         egMG2TpFNHT5a8lys75Q0PSG89xhkkU+WYn/BUDMirLcsz1sUQ2cYYi+KEoH7T2KiX2S
         tPHFWPOQcLpv9gBW81pBvLgGOTWGeaG+nnUxAZaCjWDTNUnDW5cRB4j8QFcG9rX+bJZx
         Chlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737226487; x=1737831287;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcTgADzcOxcV97R4PZoFX+Rq3OmsbCClwAw/xIuK0Cc=;
        b=PZdPjeTrdohMSAjhMIyjh8RCei0v/SXoT4QtQ2XP3fbKiUyg5QeRdKQEyc8I07rVRo
         wEIvS1prv8Tz/IjjVO0CotiRCsTy5ajpRKSI5MC/dr7GtaNjjpGeNt6flVQ5BAj99lWS
         JvOoorOIEq9SVJLuU+3gDzaVGDA6TRNA3UkH2OdYeV4whMNfwwv8KRSLyirv74nV691k
         ltx7lBcmVRtsyeRkl2eoXeuFghY4Gy5OVsIvigUz131Bhtp4WL/8ULMFhF6tZ6Q1u1Tp
         ztKkyCkLLmCo/BP3sWC4X/GcjGM6IasWDZ9OB0xgNkQX2GxUwFK5GJukapE5sngfsB4N
         pV8w==
X-Gm-Message-State: AOJu0YxqTrJHv40A01EMIfXVxxTt9Whj8HQtrKk55E+2FZKuCJ4U7Rkf
	8+0K7IS1A696+w+nclKZbainnjj2OARRkKlWeJwZgkL5Ep38X9Q=
X-Gm-Gg: ASbGnctlpO+uuGRLBWwDqe9+40Ai+k8highg+r+QU2PdxxYd5wBH/wtl6R35Iv4HBJf
	+cDZFtL7nSza65Olbg6zxLctK0xfcoEu90Sojax3by+0nwOSNcu6wrz3fY0aTd0zOKkCIzHfTPH
	7HZYYYpjWeAaCEqTGppVLQSX0t0n/iXWZoVdVlMeKr79v8ZxGqXeLI0xqT04ogtaSQscQZFrSrY
	xNOXAfguNv/euDkfufWuCVDaXhWCKTRi4TNkHt3w44O0K18RxvRvOkxDlRhbdU844ZO1bxwOTHT
	IKZp
X-Google-Smtp-Source: AGHT+IEXrlnaR+SiolkZTz8Cnq16xqVaPUHAI1j+bLjgjpkKPNeXp47mKLYZQ0o6ELBuDfOaRIZLRQ==
X-Received: by 2002:a05:620a:4116:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7be63a13159mr1077131585a.20.1737226487121;
        Sat, 18 Jan 2025 10:54:47 -0800 (PST)
Received: from [127.0.0.1] ([20.42.49.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147f3d5sm251445685a.37.2025.01.18.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 10:54:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com>
References:
 <e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: handle fastopen disconnect correctly
Message-ID: <3d1c44d6-f4a7-cfa6-0114-091e364a421c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jan 2025 18:54:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/12846236981

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de1825fac5c2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D926678


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
