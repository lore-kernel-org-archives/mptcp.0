Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF516FF2B
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673566; cv=none; b=tLMVXba8vbJICQIgDA9kDV9O3lHzDOYMiM3LQoZP5Ed/C/HWZ6/8kMMe8An91annDIYndNIdOCrVGI7E3EM3uPilX/QzOaiGbp6cJAP8DmIO91wxDJk/Bhxwy8SbV2xs4vU3rZ4HjtAYYZg96nwjPOpp+o3s3ZGrxJBvisa49+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673566; c=relaxed/simple;
	bh=q2W5VUMKPRadzh2Zm7O5YaHV84pCtPoANyCTOK9//JA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fajforbBaI0+ctg+qSNalyk7jmf/FblXKUuKVS4rlWHKoZk042Iq9LGLYsz+UaR23CRh/eO5aY8t7Thu2s0ErBR1cYmvswn8uChz/Ooz6DBLhnOMC0qhrdM+HUMLQoZLv9nnYC2/sRUgFlfQ/fWLFTPVmvXqmK+JI7joaD56vGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GISJD5A5; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GISJD5A5"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ee3042cb98so2830735a34.0
        for <mptcp@lists.linux.dev>; Thu, 02 May 2024 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673564; x=1715278364; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7ZTRTRdnDGvhu2VeELeG7hpMVkLs5pPO9GtnmI/j3s=;
        b=GISJD5A53AAZBJWiOdJ2ptFtEBbLAPKlPEhMOdViEwLL7yMFO8F9OLmjAqODnvvULv
         XshTNRWC7TEGHCORQ7EXs2V3YqKylYjs2iREd7G6eta8KlIbXabuVWJMrhxXGSB+ukv/
         pxVnxHxMt1ZZoCpvf23nO2KxKYzuQ596exyZtcnSLukf7LEPXHXvvHp81peRksODeeyk
         0FSFECYPxEyPcQ7z0DXdT8Hw31xL1HxYWyglAOCuCFC44wKyTA/PzOxwUoTfsfBhOOsF
         LstHgW2AZKhpf6vBVCPknTTkOeW0jlH0yDsToEte0zbOFyijXdJhhZ3WU4B3r+hOxmjk
         EBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673564; x=1715278364;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7ZTRTRdnDGvhu2VeELeG7hpMVkLs5pPO9GtnmI/j3s=;
        b=Ptk8EUYKE/U0rfvPyhsTgSQ9FdahdKhJmb2zMzzW9VULOZwYt/fQ+u2u1Iywwo9Vtf
         ileDSE9gd4DIgQrPLfNR3zpRmvB8/PUN4hbc5DW1HhegB/WYa9227o3w6wXjd67PbsfL
         mo2tpCDBKI1OevIrTZsQ5TbW4dVYj7HklO5OyC0C26XHWzamFkq2TfwFJEzBY/rWGlPK
         NhkOClXNdL9bi/HnbyzzjFu72mLwW+6Y+0sZC+XzdJxdD6Wnwtaq8WfZwlqmFS5HG7Hl
         APfFjzacQYOfHprf+z5xfniX0I3bfWQ93JwyKURYlCJsHgab8MpQ1GGvGoiROG1lr/RW
         Tvlg==
X-Gm-Message-State: AOJu0YwJRbV7ZW7nUfhHa2z17anGs69EweWlZ4uAvM1gPeu5BTPHAi0+
	p62tMRLRPlL2ZIfLzBJjqaDTRXVkI1J3kqqZwLfalPeRuZch1tvlsDQz
X-Google-Smtp-Source: AGHT+IEZBlI6TJQ/ab4LKDZO0xj9Z7ZaEFMWSLLL38sRF7Zcpv4+eVoMRjfq33HmLeM5I9GgLVQWxA==
X-Received: by 2002:a05:6830:3a92:b0:6ee:50c2:6f9d with SMTP id dj18-20020a0568303a9200b006ee50c26f9dmr753758otb.29.1714673563668;
        Thu, 02 May 2024 11:12:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.63.243])
        by smtp.gmail.com with ESMTPSA id oq32-20020a05620a612000b007907d4bbeccsm552492qkn.43.2024.05.02.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:12:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
References:
 <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: Spring cleaning
Message-ID: <bd9436f2-c998-2339-b502-55ccb9af8b17@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2024 18:12:42 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8928081434

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/85cda034c68b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849979


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
