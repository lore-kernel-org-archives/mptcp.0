Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDB259489
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945482; cv=none; b=jAWIm3EodjSQQ0Wst5Enafitebhhj4w28KtTnwXaagrXPnY+uqxgMuhbtGrWWOtZf7uA88AxfI2xbxr71bgTnpxtHQ+Nai8oEUQFHM2EEcFjCqviNSBqXAsXhRRVdR2vJqifFncmonVagR8OwDekcym5ydeOM+9Mo3b7Qphkkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945482; c=relaxed/simple;
	bh=r8XIoVFdl1cMvaLqN9p/8rg2mc29MYEaxnHeVUhEPco=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZLVoKTkuN+PNrWSJMinXM/zqmPXci3lBVov4k3MF+GdJRdHSeUeX/dN6wGDeB/3JLbVoIgT1W+j1CUvuydnKhetNexk1H9ahBm2RjKu+sepIRp20dMKUy0/suvMYqDGvFldcXgLRHyWYUNlwx19gtktSbvReJSPWbN1XIky6LtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEUUW5w9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEUUW5w9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b1f05caso35136615ad.3
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734945480; x=1735550280; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbsPqJiJy6F/868+tbjSkFybZVJtZWN02//Z/wCUvwI=;
        b=cEUUW5w9Z6d3AW4Y4T1dknDHKf/dZQYP4KXKRuoHad0+yH/p6Dx/kAwt6IkRjG7+L8
         tdNd29EjvBWtQEWXAPawQVn+GvQEpa6JYqWBBUaZpvbVV5oOcQGjwJ3Dy6MHXjgISUwy
         Xk/iQ1/4HDJwC1H6ST8W6NDPCsOVlWtbu8ysCwzrirEzmPOI2da36p7XjFmrPaFrCsI9
         D7RDe/CsVTsxCkUXCLWBhsbYxfBGBDzL366NAtL0cqst8r3pLdOvohk8GUOVhB3/RQGN
         1mV1+tyjQUmizQkMUJggp013jpqTlVHs3LqZP7y+bT/TZ4z7XWKCzSzRqY9WS9Zs4sB9
         avnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734945480; x=1735550280;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbsPqJiJy6F/868+tbjSkFybZVJtZWN02//Z/wCUvwI=;
        b=Ex3YMEdM0KtCTJUF2Hlr/bYBYxyckvjDyV9wlXqtfVrK2OG5bHoWHmo06ThcGZ/6RJ
         Djemll1J3OkmMsEq3IvDQ9OgBYuXbsWLqFY3ADpLBQzYz43g+6uo41sTbfghNAsnpmYw
         Yhyg2PUdST9Vp+dnsWt2h1ykShsW3brerHDN4IqqMivv6t5VO4E9bGgF2HrbZBuwTdjD
         RSPzk7uuC4pxD0R1v7ptCJi7GJ+GN2ADLgdL8bzvldjS1XrFPj4AVy5b+dxc/DDrmwD3
         FDfTV/LIK3hP7M9DbHken0Zyvu5j878eLl2EfdltGxTauv14Oy26FAYmYcz3tQoTlj4o
         SxEA==
X-Gm-Message-State: AOJu0YyG4mWUIQXROs2ZIJAKPojlFujvx0GmFts/Tln/+vHgpLiSHwKu
	yIp0vE6s65LhVqaU3Q7wKG2EqKFK9wKR8BTPIIIMHE99zEzpTw7KuobV
X-Gm-Gg: ASbGncvSdvng0TbUZu8RKRIQmDL3JVv3i1zlC6Kxle96kYPvzSorBxJe0t3Y+2o1IMl
	ksDyJrrRJJVNx8OQXt+1xAjF4jr0QKZ2+8XgEAq+D8fyb7JMoyXlSdnEXQir7vDHaUjYDr0oYgd
	dk96OctbGNlHaxL6U0Fcx64r9vECdWsZh6k7e4JHTLLV7/FvZKvD0VDssPIOPc1DPVNwJP39GxI
	4WFcAsbis/rckFeeDSUulkzxzjZCAZW3gfA1mSNOATK0mkEczOGrIL587MKx68PjWxNpw==
X-Google-Smtp-Source: AGHT+IFNr27OAf4dRIndSPNIuH1zad79YV+m03PVJ+SdXr84hqgY7DRTdiDOIcdC7/4GBWk/svVfkw==
X-Received: by 2002:a17:90a:c106:b0:2ee:7538:be70 with SMTP id 98e67ed59e1d1-2f452dfd3c1mr19162479a91.5.1734945479804;
        Mon, 23 Dec 2024 01:17:59 -0800 (PST)
Received: from [127.0.0.1] ([52.234.38.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06d9besm9872993a91.40.2024.12.23.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:17:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
References:
 <ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Message-ID: <74587f46-ca0b-fa56-9034-454b94ed534f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2024 09:17:58 +0000
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
Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/124638=
08898

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf380dbcb13b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D920347


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
