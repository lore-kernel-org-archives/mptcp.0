Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C69144D34
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321101; cv=none; b=T3LExElsb0xr0Lidc8pjt2UAvuEZzhbludG4smngrWmHROTiEkZZypeWDtUIf6xAdD9TpEH22tvOvOjVme2zTt0KQkzaX+p9pn9zTg+2Sl+eSMAipDNH1waG1v6Ow7s03WQfFQNQk+FZyg7F3HkF2dGrtEVTQMY0OjvOyPHHunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321101; c=relaxed/simple;
	bh=zLeJP5hIXCCpWFGPEuZsE0eBvDc+HEI/FK40wMzLMHQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CL7DEJ2SAgYFEzFM1EJsKgN9OjbHyVnhbnrIz6CJz2m8m8X+q3GOYcXajh/ZIvdOLCk3oIgxRPBitd2QHnUgrkQXctNZSR6OfO23hsMOqM2Y78D9tsPh2fakOYbA8ZzDyy/8WghqQjm3pci4OxDfLUmgZI2jX2Q/+Zt1sbEMrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqzlpm+4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqzlpm+4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b1808dee9so27017b3a.2
        for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321099; x=1721925899; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21dCJZuZxa+WNECz5+VQWWAJ/Wtc4+Xv1MW7BYDq7rs=;
        b=Mqzlpm+4gRrtp5bO4EMWNVxjFU4Lz/yEpDl80H3VtoUukIvX9VQTWjpakwuVqagU5P
         V0BjDTQAHbmQhqvW2o93uHUMU7vSClzm5pPLhOOryB6DjFyqbP8KwJsSHWRynA4KKCKB
         uMBfgDCinH3JRasNEkBA9J8R5nZW6NlzSdSxeyNTaPyPnlnP/QW0Eiwdli8vhYYdIe5g
         Kw71SF19zkpCCdTF0G6oVDPBrnnDuY+wj0TwczHGFYeBOepAS4r2gxDFk80S1UPvI/QU
         Ibo1t/S0ydvMR06YXe+PWPl8ny7SG/Z1q9lN7wEL7zJXzGvUGKIl9PXX7rMnHzfxmsGh
         IVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321099; x=1721925899;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21dCJZuZxa+WNECz5+VQWWAJ/Wtc4+Xv1MW7BYDq7rs=;
        b=kxciZT2ea5WjWOfDuwwgZTIBvsAmcFV07/czKbKVMsUFmMeoUPLnipnZob8xJ3pF5l
         2/QNfSZi3ph3U9KDLBdngAvghPqGwoDGrd+R07+4SZWiVAnOAzSpY4+ag4wOfMb9yT9s
         sejJtiQH2cuXdOYBfIWVjNt1poB2TqHt6/vaLjrI1F7FfVz1ZZ20oFCrymxkMwm5/BHS
         cm8TNUrySJVDrPt4HmCEoohR4p8g576ox6nYLztCvsNV3O6MpHeZRlEuaZ0IAlcChJ2s
         /WY2JYiVZxURzcbJ/xQaIKsC3LdVQK2hDGgkZUzBtuhLOqrPqIAHKUWHS6Ti/DO9QRxl
         z0Gw==
X-Gm-Message-State: AOJu0YzuIsRuD5o6TS7CDAMa/eJ0ukqrqQKLxwU3dtg4FLmZAD/UyVZg
	ePv+YX3cKK7fqeAHpWzBfawUM+SyeqiFEIapOCdY8Er0Q+9Mcbk=
X-Google-Smtp-Source: AGHT+IG4TEtO91w48CEAWvLgqtTcKVL8vGK3MrpPVEyaL+JfSfvC3Y/WIaSkI4CwuLwbiH8kGSQeyg==
X-Received: by 2002:a05:6a00:1d26:b0:704:2b6e:f10b with SMTP id d2e1a72fcca58-70ce500f2bcmr6950856b3a.15.1721321099047;
        Thu, 18 Jul 2024 09:44:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.43.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cfc7098b3sm36891b3a.62.2024.07.18.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:44:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/9] mptcp: fix inconsistent backup usage
Message-ID: <c5976c0a-206c-3a18-2888-de064fcbb252@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2024 16:44:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 4 failed test(s): packetdrill_mp_join =
packetdrill_mp_prio packetdrill_regressions packetdrill_syscalls =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 4 failed test(s): =
packetdrill_mp_join packetdrill_mp_prio packetdrill_regressions =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all):=
 Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/9994916304

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/962a6c85c5=
67
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D872303


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
