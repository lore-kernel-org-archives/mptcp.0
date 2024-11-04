Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBF6FC5
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712925; cv=none; b=X7Z7QzWSQIy6yWvPiRsElbSs6G1NEfEVVfvK4GkAUXTY9QrKbVXL/1Dwc/HgFI8g5O9ICMmD2xUTB/UK2KSiTJ8iqtKyaMzynYhxbq8KDNndbLRVxrrus5qapqO03g1YbiXbyr4SYc6xSrf9fnOJiu2ZfQOfMI4bqU2VE542dWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712925; c=relaxed/simple;
	bh=LFs53pcLJVDTEoKKnd8vPNKo/TqXB4lWnKvjS7aAx/0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aXfWoGNpibdloJb9bwj1u50q5Ek76lgxc5sUN+TvIn1iZy6r/TNb20LRyoulp9fm6EnXpesdbsev07/oAWWl9TUiOQ6b03oGrMdDpPKWz6zVBFcuFWs0SDRGcRI2ZvJSegOAlGL3fnPzyLmzT3HeUHaX0oz8ZrzNU22cFM98BBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8d9zHIn; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8d9zHIn"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b15d7b7a32so341706985a.1
        for <mptcp@lists.linux.dev>; Mon, 04 Nov 2024 01:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730712923; x=1731317723; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=012OBVaPqTFXnkwCMIHEF+OncKD4xj98UWSi7cz7wIM=;
        b=V8d9zHInE3BtSVn0chbYq13HfiMZbysHVbWLugNj3d8Xe3tGMuAwhUELajf0cyDi2i
         V+w3LnG5w9dUg3uZzE0oLk1EVsG9SftXKbGZ9jczIi3H+cNYnfr2sqoH4Ccdq2FFNem5
         xzBl9DENjGlay3C/D+BIH0EYfL/iGyzjQKga8zP/Kfwm9xSuB0u8v0Ps3EApYTnFsYms
         GSV8PeArZ5MQee/aYSE2qP6iTeOGyRKzdElQYUKTWqS6D1X6A71LGgrcflZsqweqdGPF
         XfU4YK27X88X/7euqJbE57dBqEJGjr/JHBh76gzQN7ji2nY/g2/0yw/VjMFcAwZIQ661
         BTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712923; x=1731317723;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=012OBVaPqTFXnkwCMIHEF+OncKD4xj98UWSi7cz7wIM=;
        b=F1HXwjo/eRz7GR0dqQ5iq2uMXDRIeghWisa4DCYXZNsKtN+D7G7Mvww/0AoOtORATa
         EHtGtA1C38HAlQOXz7Jt5Gd+702DDBAZ96JsCLuEyNziGGQCZIs+YrOv5e3/2byeCQpR
         kBxjpqDPUcyLWNHm38n8MfyHvGxwiKXvOanegO3QNNJhSouY36g+L8oYHIbHfO4nNLCn
         xAYMnwblf+V4DOYf3gr3BXPWqu3PPNQ4Nw0MnUyyNlsLGaMp3GLH6Y/WYTO4JRlk5/IY
         0wl1Xb9xboJTvzwpMlz/v7OmMQBjvJ1OhCmMTbTKKaGyQTGmhFUlP4tqn1KCH0lg7Hnx
         ahhA==
X-Gm-Message-State: AOJu0Yw4qySO/JgBBJ1XCGE1LNSO8rr7Dj2q9YGsfaAcF2uKiu2hVT49
	7JWfv301XUs43KRrwd82YtLug17UFhnRSuCXldSR1fJ1Q5X6o50=
X-Google-Smtp-Source: AGHT+IHG+pfX9o+xeCM+A6uxjGr/j238AsSRE1YzoJzxoiYj/2HpHhhC0+c6vxNfmLxaCnD9XWMGYw==
X-Received: by 2002:a05:620a:284b:b0:7a9:acd0:c8c4 with SMTP id af79cd13be357-7b193f4d8femr4334520385a.52.1730712922862;
        Mon, 04 Nov 2024 01:35:22 -0800 (PST)
Received: from [127.0.0.1] ([172.183.39.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a82ddcsm403866985a.111.2024.11.04.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:35:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org>
References:
 <ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22DO-NOT-MERGE=3A_mptcp=3A_improve_code?=
 =?UTF-8?Q?_coverage_for_CI=22?=
Message-ID: <6c885849-3f5a-60bc-1c0b-98cad79665f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Nov 2024 09:35:20 +0000
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
uns/11660745489

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7c468c5ee032
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D905930


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
