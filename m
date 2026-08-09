Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B733BD63C
	for <mptcp@lists.linux.dev>; Sun,  9 Aug 2026 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786271087; cv=none; b=mfLu5GiiQyPsN+Tl6Gk86N51e1TQGmgUZIo43rE8puBrDbUnTTZE9u0X/ilv/hhd1v6jwQfD2u/YplPK3OJwzv8xWcafwPtI6F3WjbPwK5i0tdkuWFYTjI33xwZlN/0REI0VP3mz+lsF8bIYF/5k/96b8hsYnDJ5v0RhGnLFdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786271087; c=relaxed/simple;
	bh=AuMnaGdwgDUunu+YHJxk8GyKYHg3yr6c/U0tacURExk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XHxeIrFtYbZPq4cs32OVPXH5VuzKSKkU2IsyWuGb9PQ373Ql40Np5uyjqVLgUbnWoLH27C2m34dFUX3OeFKrsrnCsd4/JFtf+AnBYzKc2Mb1G0+r/oMqIFLiL7At8csggEqekOECSEMAu/FlpvWAkAKUdvo/jtFFV/3MW8e976w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz/Z7zuC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz/Z7zuC"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517dc520840so7656741cf.3
        for <mptcp@lists.linux.dev>; Sun, 09 Aug 2026 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786271085; x=1786875885; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kG9d3XfdDWRQEqHE5czAIKzGB+pmay3BwklnIjJ8FOE=;
        b=Uz/Z7zuCn6xJ4mJRPYQ09Ui02QYlgV7GKVy60yeXBGkB9Tmex7vHcxTJ137W71L/WP
         gqAv6nVJ14jMbaEgvN1gcWb0xKffh3yFCxgfSnsnPZgsw/ZgEHq130LggWRo4c2OGmpH
         7PvLFlgGhbyQ+y1CC/3fap3omAY/cMxNMES40TzmJU2Ja+dVqI9nNlnV3aLGhM2mOCf0
         0SGuyoskUQjpKVXgNzr8WL92xUXMdvOg1z+j7pW6mTmHzMAwIbZiaDzoM/Hnn8Y2nHg/
         fFMD0zYzG4L+jSPim2b7edvWLQEQofpNVDccimcdnjqZZWI7g6kXHk8yJPAQOjSwIuBK
         DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786271085; x=1786875885;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kG9d3XfdDWRQEqHE5czAIKzGB+pmay3BwklnIjJ8FOE=;
        b=MpeXBc6Uo3DKOZx8r6UjWyFYrEC4ADlAp+HzwL8M+VfifLLL7UOPZ+sbdxmrREUCqd
         g+tkVgv1pqBEEOW31mMDISoCD8BF+naHLhlKhCc2GfX8Mtmiu9JRU4T2S01RKP44X0NW
         PbGZyPiYVHkGZepc3PITszMeMYH2yCd0xqumcmGrb7zWMC8TbiGPf7AKD5MN2xlVtboR
         5fVz6pUrriJUE7xDAyxgdV+2Yf2I4IxtB0DX+tSsNoX8Yq2ex8mPCM4hGcZOqrz7sthn
         4NSp121a4DT0Yc12pwwXkwhURb9W5CZN2epGWycBROmcSthyGejY2tjS1o31YIf7aan5
         4PwA==
X-Gm-Message-State: AOJu0YwLcDa9wS72MBmJS+YDk9Y9M0lOJZzDUNlPKiuNsD0a/1bDt06z
	AFsbQuZ31WoQiF49hZao9yE4rr6c1sOlxSmS3Ni6G4TNmZzN3Msf4ls=
X-Gm-Gg: AR+sD107mXZc9puwRTbekDAPUBQKhehzMnJWkSMKOaExK5voPNVuOENfGFyYy8F8LLI
	WmDAW+6dHPllVQpOwSls/ff4c2qsBzT84Oo8TWoxsjqYwATCf4MuOw6YRKUuhlJH2Jt4LuAwlbA
	ekpRNx2FtzE0g6zm3XsfdIqDKBxkHn0QsCFaPH/X9cevz8aNh7l0zPXdn+byyCM7q8F1J8+3eEK
	GWLZzysHLSvgpZWcNTcTgCDkb4vmVtEfX38sjtU1z3m+9WFAXF0ibeZ2KRzshOjBop2XChR806m
	AzXBZ9scckNJtE6h9pqOqO+SCEiyPr4fqVMcgujEB+zcu0nzbjHAxIjX5rnCqk6oEtdN/MqRIyi
	tDD8+V/VujZIeShgmnKA6OZtgrxZpULJECxzoCrQpBvdxjj4LafSPNz3V/CcbPG5dhUx2g0iKBT
	clAxA+MnfrVVen/ozCAzegGJmHu0nWCaYhovT+pL+X5Ve1E5/tlfnu7cdyBRcgg5DPkytJ1YW7r
	A==
X-Received: by 2002:a05:622a:4c16:b0:517:a9ef:ce30 with SMTP id d75a77b69052e-52d2095eb8fmr143070991cf.17.1786271084580;
        Sun, 09 Aug 2026 03:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.126.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165e9353sm48670461cf.23.2026.08.09.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 03:24:43 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
References: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH net] mptcp: upgrade network refcount before socket lock
Message-ID: <2077ce2a-dd5c-20d2-8bc6-7b4723f5b1ae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 10:24:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Runyu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/313064=
13386

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/08ac228c62fe
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142867


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
