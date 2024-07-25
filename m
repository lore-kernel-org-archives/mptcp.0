Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F595139B
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875646; cv=none; b=FvsEMlvkK0QyqBjgCq1jRoEauHycWHdPH2fwFzJBq/5rGqrIk/PLWEh1m58a7NaihdUDaYSzuI6LyysrM0fFYV209S8e3aDMu8inTCF9JfAZN04s4BGjjutHgWHE/pkhVjk92m2J+/oMo4CKVRHtNU2ro+RGwd9gieLWgjawIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875646; c=relaxed/simple;
	bh=zPsNEfVyjRO1WL6nN8hGjLEid2aPHhjIp2cfVGeG49M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ihEo+OUwizJufl5fzEP/apHvA2OXBrTOxwYDsPKrzOoU11b7Av7M+5qi2Kodws9oFHPR4Kady/oxFxoOSOczpFlAkRYcaudmoswpxnC+tIL1sa7mXmQUWvmdtRXJB3zOBkfjiorHGpjvepQOQQElpYvLh/BSjBjgrXL7gxEqrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy74fiDv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy74fiDv"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79293a858so2275266d6.3
        for <mptcp@lists.linux.dev>; Wed, 24 Jul 2024 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721875643; x=1722480443; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jpla2JFjarLaU49gSnHuxOnywiXVkdy2zjLo4z8tpDg=;
        b=Zy74fiDvZ0sfDyqncmCQv9xneM/tCOkQvGEwRWh8P97zXcfAlJ1feiu7YwF8O7B5XY
         2q9WpMQQRJrlqKbOHGrR4X7Z7uJyk6CnNi7XFDLCKDA5OPzB7dY+8mwa2AwfG11rcW2N
         XeK3oqDhj5q0wl7PEjEEbBGUpnYjObhPNl3Cvt93Z1xDent3MUIF7sdkAfndQeRbJg6V
         TutTSrF3MsjrTLVeTVGaoXR4X6F6RvMzbPJu5nIhs1BHyarPlrOvSng7AnR2g/ZaVPQl
         063GCMTPtlJsGJmh2Jsyf5trtY7GqgQTJhixSgyvzmbB+onfG/GuOdFZwz279xefj9YM
         OsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721875643; x=1722480443;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jpla2JFjarLaU49gSnHuxOnywiXVkdy2zjLo4z8tpDg=;
        b=vPdCpSbUw6c+K2hn+H21Yj1BKGZg1AFvOBJ+gOKUnOdrulBbbz92zZNJR2LZPIjxCW
         Z72dUlt6IIRawUXEQOeW057Imtln087GJ4EPyhHy82a149QLTsQMv/N4QAv+XfPnjpbJ
         6vr16sxsXgAx4SE8LWFBwGeWHXm8LUwxWltri8PUH4VS/w+oLUIhokXLUbsw3Dq7S/Q0
         y3EZcI7Uj2mS04Yoh0WKxCEEfnznbHF3ZZVfFT3UOLize29IqOHlYDX6SHApSY7ugA3z
         ZJ2KyT2UYfVAwyp+WhVXLuysYlmqpDqC381CVX5jh3Knp92pzjfudAvc53U4JdJMmVe1
         XRzg==
X-Gm-Message-State: AOJu0Yw5K2W7hxto0luXxVbN8T5MEAM6Yahj4Lr2lkEdfq06ptFlFl+h
	Z4z5jTv/pqaTTbtDY9Cv2fBopNdIqeeJNEBIBRwIUimQACge6dvHtUNT
X-Google-Smtp-Source: AGHT+IEVaCc/hsefyVzfamdhUMu62VaHXldmw4EOqm3xWHLDoolf45k4103pzKUXa5ynWsTn0sbh5g==
X-Received: by 2002:a05:6214:f04:b0:6b7:9dc9:af28 with SMTP id 6a1803df08f44-6bb3cb16fb7mr18784636d6.57.1721875642965;
        Wed, 24 Jul 2024 19:47:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.84.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f9122c0sm2315256d6.56.2024.07.24.19.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:47:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn>
References:
 <fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp_subflow_su?= =?UTF-8?Q?btest=22?=
Message-ID: <0e5c45b2-7c96-92b8-a5a4-12e666b8d4b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jul 2024 02:47:21 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10086967692

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4340d56e5f7c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D873699


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
