Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C12900
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062897; cv=none; b=iIY8/2fu+uKVmqfA/nvDabvhMjWyShI7W5rngwM2CB4wNohhHYMZAmdmVPIe7txy8VoBrf2aWVLyIsNuRjg5Zcu1YTxoItrETwHwy34Q+wjaUh0/caxGHvaD9wiXXaQnKww0WksUiXfhnl46Cs7K4YHIzfsGo9a3s42txOTLrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062897; c=relaxed/simple;
	bh=lm80/J1+Sp53nVrsWirZIylP1JFEp+opojY7fBSpcto=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PruG+tyPsc5KWNSxsa9hFYx6cMeQK2a4FiQRJHBXJDwSOPnyjbCHtcq8o7U5cGzJr+ywzVEm6WIk7rkpHefY+P3fqoE17+bLETag91pH3Huuwe4xkwVfUlk8f6GVl3zzB6lem22lq32B45+9hEkh1cVZSlqHtrnDQQkBxF8CyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrgkYttc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrgkYttc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20223b5c1c0so7877095ad.2
        for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724062895; x=1724667695; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trm7qogxKNNuz6qeW9IlFMT/TvqlHoWCs4CY4b2SeRM=;
        b=IrgkYttcQRZh9ffp8fnYupcchJ9cnmLADTzwS23TTqPHmfdutWSc8d2i5LBPXIVn7K
         I/rgqnMXtR9IK0rI+tfQuCMvbgNWXd5MIszlm0eNl1PBGaRXRdaNGkJqcKpfJ7aJ7nOy
         xQVnoxm9zMxng856gXYQ9szuorLrLkhVxoDRlhYvWeCODLYxjNTOTsgzJuPRh7DdDZGp
         5oxim8CInnvOybvCWqr8/0iKNTzrVe3H3N8B1lr4mtaGQmEI5e0nwXO7UU6mTgkMmbLf
         VrqTYbomfvzuCrIHVCMiYP7GCiLeB5dpmAOFzAqDVL5MUsTWuWhvKztmxUHk3zH/S3FI
         afFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062895; x=1724667695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=trm7qogxKNNuz6qeW9IlFMT/TvqlHoWCs4CY4b2SeRM=;
        b=KaPi1NtDPRCX1DYa6xsINgEnDeYIJ6xh6x7HJCulr5s01seWQmu8lzsRBh+G2xAosD
         sUGdwhPh+EUepnZ+nHY9WV52bvFvpeiPe4SZ+Vz2SbFn43jR2ngaMxkuR3cjFSTBPP68
         UNdP56LShj2ajbVytB52PQ5zjAFbHKdInPgYkKACax5Y8OFBxabLfW3vHRFtz3GMEe3S
         vUvywRd2graZ1uqdRgQBLUY4AzcLIg8HdGrfiIeU3CKrY+ZO/2AtTepliGQhq5MWTwpg
         oLCQkHS/px8ikth31PfW5GOW1NDqM+eob/i8jViVa4xLnb5PNpcGc3xbZd855DOwqmmD
         iZwQ==
X-Gm-Message-State: AOJu0YwDgXK1iJn025RZq+RL7aClXBgE5N56QSjqbE9V1GKoZJkQKekR
	qi2EC1mxEkSrvvm4InYlylJDNOTX7d4nbIw3nLfrqZuP4oCXU4crI1aJ
X-Google-Smtp-Source: AGHT+IF0oVN7F+Hen0v/Fd+DhqztL0OwnW6tP7jdB6wzcfN+nkGv7O2G1GyfjTRKKyjHjzN5IqOspw==
X-Received: by 2002:a17:902:ce08:b0:202:18e9:f302 with SMTP id d9443c01a7336-20218e9f3ccmr81426815ad.6.1724062894893;
        Mon, 19 Aug 2024 03:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.58.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038d715sm60531375ad.198.2024.08.19.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:21:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org>
References: <20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: pr_debug: add missing \n at the
 end
Message-ID: <3efee297-4754-04f7-8ea3-1eb8dca55ac1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 10:21:33 +0000
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
uns/10449681118

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/41f8faae83b2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880801


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
