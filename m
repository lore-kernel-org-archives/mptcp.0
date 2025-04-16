Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561E18FDD5
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792789; cv=none; b=rA1oBTRr8dCPnTFCjSi3fBvccA+rSQQk+XE5KejpjZNCaU39ootTB8b+e4zON6X0hLPNAXrtQq5j9bdryr2fQfMQffzThFOn+hFeAv2ZjODckvr0JtDaCAoFCxj+ZL6QlVx+p2EJwyM3fHJsV3PHlPYjDFawZpee3a4uS9EBKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792789; c=relaxed/simple;
	bh=0jS6M7dJCLYQHa7ZoxVNQ6OdZ1WnIYTZdIsPsoD3ueE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J05OPMl26S3ucVutMYMfCSDX4vZkSZSfIX2oph8Dzqg9CusyhcfT4mrpyvhB6HlYm7trhcCe2oMxO4jIWG2f+xVnz7NM4K1YU779jKdFk/HUtFj6VKrb+QUuWNXwx+yx8ppmq8yP+0NdSW6bEkVf7EKc2lE4VTQ5995/C6ErcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArZt+e21; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArZt+e21"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c542ffec37so653569285a.2
        for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744792786; x=1745397586; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRF81AWp5WXxpOVQoN58GQNfB92gXufDqGytNLe8oeU=;
        b=ArZt+e21wp5uW4YlcZ92MkQ/vNs0C/DTjkXt5kf/Kskck5tEDHnUAQhvthJ8GJkIl9
         L2vB0YboVAywxQ8VYJLb3QMsBODdnORAiC5aq4r2BD9FPZqZTqrCMDeWpSjI+odvvP+9
         PXTJoMHUqAC6+ZOEXZ9nH9KSw7V6d7qv4dY29nkks7A99ZEq3zcU8TQrVYyOJMrHt06e
         6l59GQ7aT1F2FgBYlN4jKWajHlMcMAbYB3we1pWOKDuifdfMpngorO20sSd5VtkOhYXb
         M4xstGQ41aWwYz50tVxBSd06tTC+yAKNs+ZwET7OmF+3C9bebu5N8pdxJdmjX8onO8au
         HU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792786; x=1745397586;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRF81AWp5WXxpOVQoN58GQNfB92gXufDqGytNLe8oeU=;
        b=l7Ys16Dvy13EzYBes5DjinzR0fSNYG4FapOaem0ndq0f+FGz7xxcKiXfnjwMvvcZ4Q
         knG0ad/MhaGqiOBCafPeWrmYO9MF7swobFyvOSBBOtJQOD3oC/UfBbIWVjC4KPAGaVpE
         WOaCWb6ti984yobyUktdYMWEf5h3X2PPYPwcyJOLiNiC9XhIE13ZQxi2+4tkCqe6eV7J
         3bEhcra2isRdccHVtKq8bP7KDO+6c1q3w+/VB11mSptdajQ/So2iVmIP5zxChdHg+XrD
         tpx7S/LRh79DhsoMf8/LKFZMmUKBuw5OBhp1ayo9h9qpWTZUBEKJ+yINfYONn9ETaQsh
         Lf3A==
X-Gm-Message-State: AOJu0Yzh5DIUuH1fJcbncfT9zp9iFShgCTrirXqBQozQZrjAB5I7YxGz
	B6h4dH1lgm1qLWs323+2RgZpwHPO3yJaqAx1+AOnZ1rmo++JkQHv8YMQ
X-Gm-Gg: ASbGncuiZQolZHNhgYX52F55eEc24WHd0F1An3AktdSQZKVFhd14GthW0qJxvgOop1u
	0zQf512tYWoaQ3A9yZTC8ZY9VK6jFcvlm9X9Hv1eEPs1JLLIbHUQzfwK3i/Dt/NyXYfbLp9byUm
	xPlEjonkFcTmRzO0sIZmF1je/w9mMp6RBwO3m9mhV3Lo+r9uZn+wcPinsgRK4TSWRLDFJLh4QTn
	qyq4rL9KnCIAxxegHk7FMMjcjcntzhRPv5nX7KrWc4S7Tz5ITXYuFR14mbzRDMhmAfaOp2ee1Xr
	YOx98N7TboQatkiE0UtW2+RUaNwLSMwVK9MulgmzFSGxsxXneTAuCg==
X-Google-Smtp-Source: AGHT+IGzIsl+hJxqSCzwVNOO7jz+BzUEy4HKAE+J5j7dFEbRLi1yuTcagYITYn4qN16rOwwzphr4IQ==
X-Received: by 2002:a05:6214:20a2:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6f2b2f3e4ffmr13013566d6.11.1744792786371;
        Wed, 16 Apr 2025 01:39:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.193.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de973230sm113083286d6.41.2025.04.16.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:39:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] only remove entry from
 local_addr_list when sending a REMOVE_ADDR
Message-ID: <9efb17a9-767b-8b6f-97a2-abed01686672@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Apr 2025 08:39:44 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/144872=
69508

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/56310471b2fd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D953862


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
