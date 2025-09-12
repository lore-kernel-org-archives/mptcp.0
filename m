Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205264207A
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655729; cv=none; b=NPQGEkxMba7YiaeaTCmOAq2lVW0GljyHVYxlXOOhhigBbAGvczhdVJFoIfujkteE3ATBD0pk7U9crC91OtQ1VPUTLkgTw96MqGWGATObhm0y/JZUEoh4OJdWGBtHrxIYNTPpKsddAE3b4ZuqJUvlQRl0jkiORFw6dhdAbI4K3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655729; c=relaxed/simple;
	bh=Zjzg0aQqAbH5pRLy0CwjxaIsVn/QCMkWtiNgwT2M7iQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YnIHYtjDlJiPOCH4ejGhW+Ky7yjICW9MKpjPAsArwggLqttNLfUjOV2jwq/hFNSzgdOaKuVlSVzGgYCUvmb+K6tfedvk3X+g+iHRPNvyPcymgeYAmdBDaMj7VwusdHN6Zi7iPxH7yjt8yVhmZhTpkjDU0sKh289QT02pvyvROl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahVjpL6x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahVjpL6x"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cb39fbd90so13454595ad.3
        for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655727; x=1758260527; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeTJU2oxbvbND45XEQJjwKbNPxE9ujibtcA+t7P9oG0=;
        b=ahVjpL6xumB7S7lLGLEof3G5OdjzFsBkQ0ti5dI0vjvD07MPomIngrl4/BYvftO4dN
         S5hEDj9K06XMl3S+Ci/DCXKbJv0Y3Dp7GTiPNBtJsOZgVaISo9oroQjfNOQ2Gbd7haXr
         f25V6ssyv53sCA0+BuWQCUghm5u8g2n5mXMWBbCb0UoM5P5gA+MSr+bsieCHECfS7rNs
         yg0wS6DC12pcElB+76qSciTNbUXCluhv2tcrAe/aMV9lnLsFLkNuH1pQZpM98AtQu1zl
         Y1Y9fnjz/135Cg2nH9KkSFeSnZ8v+nEgznkgs40CieqnnQwEi0Ihg6NSCxnirxbfN+pA
         4wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655727; x=1758260527;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VeTJU2oxbvbND45XEQJjwKbNPxE9ujibtcA+t7P9oG0=;
        b=BAjV2AxknKtzNQnbuAneLXXeIxfx19mX/Gqw3IUkHsIgWLqWDLtSPdzxJllt50xhYN
         rMRA+c7aaFEs0JeYo6s2+jcpldI9d+yFHGHZ22GRodSP684AEUEh2KGt4R0Ag9FyYxeH
         IXASvV3s1FD/aOBFQ+8idZrojkXLvduLE4bamGUlmn/ZfrotmWs17IAr38QDq+6M1n0f
         5VETtDHUNZWt37/1AEsskPUIHb+q8t91ohxlDGppuKCojYixgvAt3OEfH/rhu3JEL6J2
         ojTooxEPDZhfiYv/KeQ1m4hlKFsYx3Gt6FUiZn7oLllbCiBos8VVkCmyPFeHRO3bwKvM
         NcaA==
X-Gm-Message-State: AOJu0YwcrfFlYhFUzoBS4/7Do4aTpmuoEA1P9FBdeySHZnCHFz5LmDuO
	vwelKGm2PMRMd2YOUqfubpOFJEgpQUTm+QIdhifEEFdyFMnMS42/2RO3Pkxemwo=
X-Gm-Gg: ASbGncvsR5ObTIXixzq55oLP1pMnsOnQruNaam0IUbWFL95XuSCSHnf2tLgbi0SjCnG
	Tm1aGDxS2XqLdf2X7NGWv18ubd1U1lKZ6b7VD++NgqzslFw0Qs+S4s0Uec8Gxj3BdLQIUfYP6Qk
	rRAtfURl9w+YCcIs1rjjIi8vTIhY7LbCPJoslpukj3MDA6uQo5NNHGFQnHBdpTj7jWC1t9Q2BlK
	NeKv3HE/qWbGkPODG5wBuKUgzWxrrxtRPn/3HBOqP4nNGrsiXbpGGjmS+jqxpDBu8Fe2WTVyWcP
	oWhG/ZYhG5xTxjjTXVrPt8kixSxOrm52tGO/FdpfNSwERfpo2/RWJ5np7ulCBUdEqKMlH4rbane
	lzLzdWCjzPFvejYtnedGrsQKXC0k4SzRmezs=
X-Google-Smtp-Source: AGHT+IFsYz0OwzJLgrGwC3fJ9+v8wg3SNfWG6gbJ3ewMV3yWreCA+XqjmyAJ/4pGTy6y5mQOtqizxA==
X-Received: by 2002:a17:902:d490:b0:24b:15b3:224f with SMTP id d9443c01a7336-25d218e86camr20576765ad.0.1757655727197;
        Thu, 11 Sep 2025 22:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.58.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84e68csm37218065ad.82.2025.09.11.22.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:42:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1757647967.git.tanggeliang@kylinos.cn>
References: <cover.1757647967.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] misc fixes for sockopt selftests
Message-ID: <0a581df3-bd4c-a6c5-e7eb-0409a31e7e76@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 05:42:06 +0000
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
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/176641=
13196

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2ddd676d6f6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1001578


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
