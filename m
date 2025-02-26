Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50538225419
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597472; cv=none; b=Tabxkolc8XcdqHR5sQeIHmLLtlmM5pi2YU/nSxdCHRieuVdC7Lc3VMx5T52TMdgmTrZzyfBrjDEhZCmFDaHcouy2YiRt23teR/UHrCBa+EtZfW+aHIMkwOc7yqV6EFMzSPhd/tNfCoppfDWa3VdNepS0i8+iCwZVAAzGQsKiSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597472; c=relaxed/simple;
	bh=wLCCzUmuRLWZhpQkFeyd6wAD192K4yqicv5lTQ7aOfg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hXtNihhqw+cm4t7oah48PbRDKNDBmcKm5FCxGMZOaObZyk5Vl/1gu9i+I0liihvF90bChAKnz8OCgklcyQ0LUvitC3Rqn4vFzLZRAjTvpUjaFWB/kK7MCGVdcE2b9WQtzZx1OWH29jzHCgVBN5lQen/f9Bo/xg4rHfAOB8RVq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5iQzfhP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5iQzfhP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471eb0e3536so2302591cf.3
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597470; x=1741202270; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6haH5euZT22p1Wmv21Xf6hoS2X7pcufqz9xTTluDdI0=;
        b=R5iQzfhPq65cHDUXZjXwWFaTZ6ozyudHiiB8PizAUttLL87omTr5P4zMrsFZAWAL/a
         hkFndDQHE0Dt9W5L001Fm0XkodGDbFp2jmpi59I8YWBDQZ/4sFL1NzPMJTq1xnKPw0D8
         /n3cqWd4oNB1Bz6JiL9EXo5bZtYxPEh5AUVWFRPKRkPjTitk3XihJWuagr+7KYhn6vLE
         YmNBzfprvgzlFxGF+9sI+miXH92DMMmt4pp1iXmEQnWJ/cHmy3jeu3Ch4XrMFC5bCs4t
         L2+BZ6qekUK0qBpEghtPo0d/jinT+NNhggB6AkHpAzgRY1MDxHvwl0G5jNC3aUBlbGX+
         tbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597470; x=1741202270;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6haH5euZT22p1Wmv21Xf6hoS2X7pcufqz9xTTluDdI0=;
        b=M2SkNJqW2R/frxkbty3KHDhjpzvT88yViEqlkCFVDHCW/alkrn08y2mwDMFN9IpjG/
         43vkMeoyFY+qDq1QKcQGk1yZjnRq4HwT3si3onGXmu/9GtG8wnz90UFBbTquLLghccrn
         JufaDW+/xGmRjUYqj2Vmn36gbdQH1RBSDbetUF1GX4Ph+R1V/7V7PVJtw7KD4lIzVlg+
         NTU/lZXfM+IXePq0RnRTNxf4158Bjp7lZXmVNaTgDkZlENMgSYdXvLZpJFvk98OlOhIa
         gMvSEdiy0NtVIFskRYTqjKkf0fF4GYXUCT65Zcq0ADqSUZB5iNYr1Uv0YCDeF+Jil734
         ++bw==
X-Gm-Message-State: AOJu0Yzf4prpCz9K+OGno3iVIlFH/lPUcN8zRxsv8MGf0iHz6QH0BJB6
	QWkvQpvHc8Hzx75lSaDi99hHJZrn/ttibOTW3C8JNbptiQIp7A0=
X-Gm-Gg: ASbGnctID+Hb7C9E5TizzaQ0ANPBOnxEvpT/8vnQa2f3shGm0DgKsH5xQgVGqdIXb0/
	AQZq0EDyvndyzxsGc1+hOP92dsBMdfiPGTyhDxDDCHI+3HB2VfxedJz/HvXInI4zPJ9QY4dBPz1
	3ejz7BEJ0nO1tOdeO5s8ZKduelxQBUl4OGAaYXMs0TM88KUVQ1L0tLiMnj8X8Pp7EM0waPWWwXc
	E/DYghP+aQYwOp59QYG9Rcej3BUwCbBXpdDAuZYB6cTbojj/2HwiATE97BKR9dTX0tz3D5BB8sh
	Q8+0tS+P234C9AaucrOEEKaxBSQp3yx7oUFWfQ==
X-Google-Smtp-Source: AGHT+IGz7WaBKB2wQNaHkHyjThmEroOaWt2++p35lBeSLAXpDLM1vUzXL/Mk2rjEp2RJJXmTkAVjeg==
X-Received: by 2002:a05:622a:210:b0:471:f98b:da9e with SMTP id d75a77b69052e-4737721c68emr117642811cf.22.1740597470129;
        Wed, 26 Feb 2025 11:17:50 -0800 (PST)
Received: from [127.0.0.1] ([20.25.193.12])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a818sm27930931cf.61.2025.02.26.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:17:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250226180727.2499531-2-matttbe@kernel.org>
References: <20250226180727.2499531-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22bpf=3A_Add_mptcp=5Fsubflow_bpf=5Fiter?= =?UTF-8?Q?=22?=
Message-ID: <3d345bfb-b69c-647c-741d-798f57232eae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 19:17:48 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13550710113

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c610b4dde837
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938175


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
