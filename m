Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8535339E
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115707; cv=none; b=Z5wNCUS9bjpCXWaqGdboe6VlyJNWujD5wCyh0BSKwxw7ObvG5C2+GbuBUhi+ki84opjxjMOonrxxkZLHrsY2o3NFr6aE+iCt7jUMcS9w47okIaurkYoXUKVvliq6xlfQ7SJPkOPTQLHp83N6DVyDNF3MTRjyjTRdcBty24jttz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115707; c=relaxed/simple;
	bh=S73ELWdvloVLxDZ90ol8vCOLHs4dg9RKTGt5264XkaI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=G5rKA+u3qeEDSW2DKUo13iVCdu5ghrDOQScrhLSveWhd1zNT80VEMgtmTdbNBJmh+5NVyivWKMmY1krqYYEug6fOcwFcZL4zHVHu4yrMX+ClIu+GZ8lpWK5aC39CAf3TmVcC5xS7fsWdoXtGOcDmYrYEU64RoEwvs+IA6MlJjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acK+/aG4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acK+/aG4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e572dbbc5cso55241b3a.0
        for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709115705; x=1709720505; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSSWHD7rz6vePYhrf0SfyZfVBSzYuTzwhdyAO0b/zDU=;
        b=acK+/aG4KPYC18WysErkjGmkTnJIGlzZd1ZYOYqtjzk6hG4n6q26UXdVUdJ5vgjiwm
         5Z0hymztaITx5tqEmSvEGzHxRTRF+/CvFzF+LneOa71Ub8xu9h912T6Skwyjyzzl6T8E
         Z+IkhaDmKeVXNDRmMQbycaIjmBxk+Y9N1aMrdTEqT83Gf2mVj/v+HT0VOHbudDi50wdO
         UhiHU+vp7afakcfOPpAn0btg5HVyr/1DcxOztg3z059mNf1+XdiBalIqEJA1wxfePXWC
         EmK+4cqiIu8fQNA+4PHPSrP0r5a2Fn0gLY1nLXQiw8S1MAyuhykPqopBDFs44oHl5MU1
         VSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115705; x=1709720505;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSSWHD7rz6vePYhrf0SfyZfVBSzYuTzwhdyAO0b/zDU=;
        b=Y55ZlaBVCmBTwrCi3Z+x46DMFebyTMvTHd8A9pZT92rVcJ5LqSf9YCCKxKllQTNAVc
         JZRX2ydPOYrsx+kSQn1nBAz9wJId7DzYT3DgaHDzkrvPtFC3LLNyX4GQpGrbv1phr4uE
         sVtU/Qxol+1koEMG3r6t+TIoLE7ds92O2tTZyvu69WZhAw1zzOcDs+s5reSSy9o4sMMO
         /pTe9gN5gb/tiwdhlSQKryQIw46NifbyKO2Y5X4gbG0UKmQmrAozRg11X1ykevLgkRLD
         VwVAumT2+3VFHGN3IiE8Vvk5gcDJNM+InCHrFqhqcqEb3HwGXdMHvXa+SuP9NccWrLLX
         qy9A==
X-Gm-Message-State: AOJu0YwWW3v0lzVGhpY9dEZZT72G88wPkfV+2LPTf8igd0hNmV78nRPf
	LX0pG9Lj0yTgPIr4nnhAYI+UTCUmYJckW/VYaa4mETm1AF4T4jP4rBaz4YQ=
X-Google-Smtp-Source: AGHT+IEyGHEEpUtNMWszxR7ZISfEXr/Lr1C0iC7uon3weMO4ihpgtFd5KG6D+iEN+zcUaIzL3wL2Kg==
X-Received: by 2002:a05:6a20:9f98:b0:1a1:1563:4ceb with SMTP id mm24-20020a056a209f9800b001a115634cebmr2910840pzb.25.1709115705439;
        Wed, 28 Feb 2024 02:21:45 -0800 (PST)
Received: from [127.0.0.1] ([4.242.134.144])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b006e04553a4c5sm7407900pff.52.2024.02.28.02.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:21:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240228095858.4117568-2-matttbe@kernel.org>
References: <20240228095858.4117568-2-matttbe@kernel.org>
Subject: Re: mptcp: continue marking the first subflow as UNCONNECTED:
 Tests Results
Message-ID: <13cf43d2-4703-2d27-6e16-94396350baec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2024 10:21:44 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8078=
767442

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/405bf7b2a541


If there are some issues, you can reproduce them using the same environment=
 as
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
