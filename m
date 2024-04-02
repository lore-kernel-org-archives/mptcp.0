Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1033D1
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065621; cv=none; b=UdGxG9B8cfhAvuEXqvLL6eEqQt8PXSfpKgwBqHmfkh0GWT53dms2VvmyJfsKv0/cwv9/WEpO7nl2/0v3tuKybdriShfiFu9hC4JSLk2ILo40Xxhfwpn8l7uMPMAQ2oIlz59iHOzDIkIU02OAbMT21q5+QraAinNASP+M79/b/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065621; c=relaxed/simple;
	bh=qehtri8bbaCNI/VOh4j9Cffbzc74C02aqLJIv1ijJBw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=i4DXQo5TIcKqzQ6kVqfkyT3PauzoMIFH3CjhiJRVBWxwa0nVb+PMFQMV64wqNSSXivbWCYllLk6sPUw6QzOfgbdP/wlNTGKWeO840pllihydOY4pu666cWf3YeLiHoto/PGHGJcrpe0RUYWWSUwNbbh8mI6cvVHHoc4OFcEue6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJMJxDtL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJMJxDtL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0bec01232so40365695ad.3
        for <mptcp@lists.linux.dev>; Tue, 02 Apr 2024 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712065619; x=1712670419; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97rq4S57Y9iC7N5phqWuPY8uPKHY2amfw673RhYOZ1s=;
        b=bJMJxDtLFlkZQeX5npckWyI9WW57DdD4K+pZv2pDuBLGkp15Az4pqKN1o684jq+GCZ
         mOeioM5Zo4d1QDSFY7Vm8XaZJLJyWvXKzxlFZ2UHiaoC6UW7295aI4IxCy4d03MwhB0n
         mEfGzrm2vVGCUzpoxiYTFSxhFAnigEvDSZt2BJieyQ2gJN2lY1OmHA5sUiSZ73BEbgbj
         Ebsu1/ISDOkFNk8ddnNJotwmOgF2J81kbuk2HMMJo5FNjWAWXdRmpZ86R/xrjqMwm+sS
         drSzQ/Wv6g4Ae8OnGpbkgHT7wxeBvzCVVkeOgvchbRmQ39Sin3xL5BMw2uwG6rP5qzq9
         mJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065619; x=1712670419;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97rq4S57Y9iC7N5phqWuPY8uPKHY2amfw673RhYOZ1s=;
        b=qTsJrp02wq1tLXUyQSgn9CkU6zvRKtSlNxYNbxFBEb7BODsxwIxAp1evCQQXMER/+X
         2USoaq1brVS6PhZ6RvBxXwE2OBs7fbkcU83ee5MWnXX3okBFA3Uxld7I4eA/iHpmRmbs
         DT4nTwqMKJwu3URzB5Jag0bgPOb3LPQXZpH/hVztMsd1W/kP8cNalDZ9QtbpLsJlCTdo
         gBSA/I1p/6Ka9zicgaI5X2k0U2gGAclx9pPD896Mf4wXObfeKjLRPCAKQ20Kt57Dc9lu
         WOjrUfjh1/TchP62t0Z6WxobSN1b9IgQgKNtWDoQ0uV1uGEqIXn69tbU7jTsdQ5+/xz4
         9oMw==
X-Gm-Message-State: AOJu0YwvTHAY6ld2BFG0JjJbPAeP+dNqRwTNut93S4IJLJPzSaVfJ7yL
	qbKnmUwJMNVKQ/30g5DoLQMN0a6e6fCr9vwjP9hl5kX1p2GwWliStw4/SXs=
X-Google-Smtp-Source: AGHT+IHMnApqNKARhpwXAC6ezY2rKi8xlzAfQ8jZka9kr0++DH/IUOg/ergyDnXE1GnUM6bchwdJng==
X-Received: by 2002:a17:902:c408:b0:1e0:a4c9:84cd with SMTP id k8-20020a170902c40800b001e0a4c984cdmr12469856plk.60.1712065619343;
        Tue, 02 Apr 2024 06:46:59 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.29.203])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001e20587b552sm11278641pla.163.2024.04.02.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:46:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712062199.git.tanggeliang@kylinos.cn>
References: <cover.1712062199.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v5_0/2=5D_disp?=
 =?UTF-8?Q?lay_=22last_time=22_actions_info?=
Message-ID: <63e7a370-7b65-3676-55d4-ebd86477a763@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 13:46:57 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8523400120

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8821889c37c6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D840625


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
