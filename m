Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A71292CE
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088491; cv=none; b=ZE5EqIgQ3oD1Nr1HaR0XdY9W6VZa/0svY81830yedHOosRcYAmEalYN9Hcc07x73W82uQ0BuKvBkqwbiyBAQKmhSqPo/f2gpvZf1EDRourxdyje1kQ6b6SEcGHSB2Blo3aHx+crAp4hyoymwmmUq7waBOV4/MexbeyF7TMRqyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088491; c=relaxed/simple;
	bh=BYvp3CittNllzlWWDj/pmk3iDeK8chXUZ+D7gU7jSEs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Wli7FGpUEw87DxzN6BPQY32yED/J/7m/NaL4uiLZ19b6GxZr4XNkcRbKr9Cc5VhWyzEwdptY9VKOGmrQxL5x+jeIHgdm1gWj4q5jsN6TM+NMs4xPszzDIhQZ/sNHB88pB2rWFj/YYxJjSVKHrV0OWgYu34/4/YnaYk7HZP7hvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B64Md+ja; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B64Md+ja"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c705e8e4bso11928791cf.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708088489; x=1708693289; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxXnOcfOx/fyo+bOydARmv6z33gVZSUWsnJqRNBWtzE=;
        b=B64Md+ja03ynzmn3UcKprKPxbhGBHtUOChZSVsK4dlvZ41wLjD/QHs0Ldto3j1ce8/
         DEzpr0DhX4QYhUV/cOzm8HAJXOQQXxL2L2Jh2eR0grda+o6elplDBR4jU5Oal5TmD8TE
         tg2uUVoXizeQ9/3UvvmNkTjLphruuQ/Ru1ieAkCQ9V8L3l4YNzKW3xdgpbBtuzoKbbvI
         IOyLcaLdHFgbM7H8FnbYIn0ck1LpvOtN7zC32yIigJdttVwGEK9gxE6E2Ghm7nx2acxq
         of25rJloYxE6GBNO2BBerbqBzqs3uyw5tmPFWCPnqgwV4ZYbj7S+MONRLDJiYPbU6jCE
         Y3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088489; x=1708693289;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxXnOcfOx/fyo+bOydARmv6z33gVZSUWsnJqRNBWtzE=;
        b=TknhENsQ06YoYIq3pRhGz0xMwpHKJOppf2+pZ9/T8nlIrKDtSX2nH6XmEx1oQE8vRS
         uSK60KQS4o9mOaATRID4GRltENcj6yukNx8p79tf8T1Jir2X0nALFz7TF91ENJafyYyt
         LwKmfSsG64/qEUFXRckVp0cbovWo+v1RbacjhWrk6cqufOvKA+IxiSZKLXBWrGeABAUh
         92LKUcdaRQqP998K0yxeTFuMyAb16qwbtVhaatl6zq863PvxH/e/MqYOT/0dXfl9TKgl
         ohfQX07sCHMOyfJhfd0C19T89leBcoRV8hRDWwtt4O1UmiytBFowJ3uMbwohSQBk/Qsj
         iOPA==
X-Gm-Message-State: AOJu0YxPjeRIJ+Nwx/jUQ7ykJh4dXSgWSVL6eBYfhPo2MinpF09wfG7w
	yX0hnKlM7ftAIkQ7W5RoRr0Tcv62kT2SrWPAz0CpDkzDFL+npAOAfuGLoow=
X-Google-Smtp-Source: AGHT+IHX/y4eNAKG2Xwa3bPKIl643e8DGED0QYFryOpY1Ktdd5VYYh4UGgNgPfkfDaL7hY1EWweiaQ==
X-Received: by 2002:a05:622a:ca:b0:42d:d913:d64d with SMTP id p10-20020a05622a00ca00b0042dd913d64dmr3664201qtw.65.1708088488874;
        Fri, 16 Feb 2024 05:01:28 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.26])
        by smtp.gmail.com with ESMTPSA id fp48-20020a05622a50b000b0042ddf651207sm491348qtb.76.2024.02.16.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:01:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
References:
 <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22DO-NOT-MERGE=3A_mptcp?=
 =?UTF-8?Q?=3A_improve_code_coverage_for_CI=22=3A_T?=
 =?UTF-8?Q?ests_Results?=
Message-ID: <eb25543c-0111-8b3e-cbf8-c9c7ff1b296e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 13:01:27 +0000
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
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7930497802

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ff4697aba2c5


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
