Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA49225A3C
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793942; cv=none; b=ZtnVttnDSWjr1o6xwNvKikFPHFBwC2B9/ly4I0WqGTueW8HBC2d5lsJHMTHVthVuNyQftQ5lBpXRIoDWmT1TVpQGhdu73+gq6y2KHxx5LqTz9JMGvlBW23K/z/5UQetadWaVL6xYLR2K3q0ONornu9edOsQnY1kM0+ulzIvM+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793942; c=relaxed/simple;
	bh=0faahkZS26U9KZtfu2NtXEMTIlwaTfi79RHvcs0HDaw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PeIiu32vl/+yeoFZWWRVsP27p7m8z0M6AfImpF+Q2G7xUB1S1PnFHe1H3r2NTqXHOTW2bH7um+S4sHofxyiWuOtMQ1EmPI90o750Vmdbg1CFxFM8f6Lh4P9xoyeGSlvVDfDlkFCNdWmc4MwnppTpj7c1TadTPHIlhi1LL1/k0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C73FTsDe; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C73FTsDe"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47698757053so74344451cf.0
        for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744793939; x=1745398739; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bczPegmqibxH4CrslJ2widDT16ZbihjrKK4cAUUIE/4=;
        b=C73FTsDeX2p3yhd08pob9XPUmx9Otc+xmEJ8n3aUFSAGKJXO219SSgyqmDA4laDE+g
         jXYCHrT7i2piBknq4TcLnpVQ720KVBhnm2N6jLsq7zMsJezqjJbuAVPl95lws7SOg0fH
         FVO18WJNUnV0OE/W6emyra02OmZTtbbTyT5Sf68a1nR/LOTi0GRzjInYtQe5MjXOVhZP
         ArTWkH0iI0g2Uqb/44C4AXlVfvUBoFpdnZnNtO5dLMlMF+dB09Duiegy9810yuA1SKL3
         1wPwg4M9GEaTDurGuNHh9Wx+6Z8B3OFL+W204G/0XNzhzTd7Aw3gAFnW5XjNeT3ssHhw
         zLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744793939; x=1745398739;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bczPegmqibxH4CrslJ2widDT16ZbihjrKK4cAUUIE/4=;
        b=BWtIe6l5qECo+6tBGcWvJSQyPius448DRVu4SFmdN0UsQBxwFiy7RT3Wv4z0lQWAdo
         L5lXlwCTIpDgITvmYK6XiE8KFKNYRutJVK/jSCN/JT/27FCYNSy4afAlLMsJ4Vkm9Mop
         1n1guyOy+LxneySnw7VejbaEPUf53XqF+EaGOxixbn2n7opPjdmmJKUJ9p8r5VbnS6Rl
         Lpn5HTVxbLYLDhgrGQEQ3CkFPyMDdEBjg0U2H7dBLae+FH4dQPvUlv+8njK/qVVpbRnk
         LuEZ9gG9TcF9Evd6lHLewzQnAgIkB9Q/9lFLcoOVeFFbq7MnrI8RCQNCc2c7bJ1tgzPp
         WpDw==
X-Gm-Message-State: AOJu0YwRhlf58dxxemx84LswjVDFxjhZcqkUls9/bdRGHXI1jqQ+p+3i
	uQVAXwZZfvayBBRznnetqw0Y+1qJcHMTxoYc/F+GjYIe+FkZUwu5pU2X
X-Gm-Gg: ASbGnctQfmBJR0GPffByJyferTKXYF+Zgx5ubY9wmxNbl5nEMjmydBHJdK4GyZ61liE
	4SYdLSD7WpeLPnTD6hT2ff78PWcKY2IUVcyvMy0SR6TxuMZNX9sjP1tKfDd3O4hm5ydHI7bwKwo
	+HaNLGk26qBONMINbuRO7AiEpqot1aqY/ZVv6B1J4pJkTT0KOINnCcIrHKc0P1JKS1zSpDooWZg
	DMpqcLj93+/9rjK0IbL15+gDr8/Y3WVCMfrpIlG55SOMHva47yPSU8Tszw/mOd30saPD1/iKW8P
	Wn6VwGZyi243KwyoPUloePQpYT3XsgS+LLj8QpTgFyPNtRMZInPm
X-Google-Smtp-Source: AGHT+IE/dRC6aBKt4bM5wRe2bqNPB4MK/ShYUumn6UHza5zzYNWA0TBamPX6RmSGhl9UwRl18mYaIw==
X-Received: by 2002:a05:622a:18aa:b0:476:8412:9275 with SMTP id d75a77b69052e-47ad81149b5mr10436121cf.35.1744793939027;
        Wed, 16 Apr 2025 01:58:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.16.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2bd8dsm106083231cf.35.2025.04.16.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:58:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1744788247.git.yangang@kylinos.cn>
References: <cover.1744788247.git.yangang@kylinos.cn>
Subject: Re: [mptcp-next 0/7] Add 'dump_subflow' test in selftests
Message-ID: <0c7196b0-21da-bde0-caf8-6c0f828482d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Apr 2025 08:58:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/14487604832

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/93155e61a025
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D953866


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
