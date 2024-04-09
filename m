Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A785924
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660477; cv=none; b=e8nnD2f/+vKowlX65lWnyS023blFDgqwpAIgrtn+GgAInlCqWSi45QK6mD63VRg/fy/icZPqkd17qpigsUlUGlqZw6ghBhyEwFRJIsuiI7B5IZWCXFuuPu4zkpDlgAI312wGpXogSwZhhtG2uYg1ThIH9Ux4Y596A6wZJ7NyB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660477; c=relaxed/simple;
	bh=HVdCMUhJ31/13AfwGBAKutA1QOcFfPbDtov+Geikwiw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K5j2hTyVHwFG29G6Kyg/6S8B81cfC2MpiBEdSnEoenIFV30578+N0WjIxU16HTn8Nat/JWVE+8D9zkjSnmBmrS6/a3J4jCMVNUmzIokfUyDpO7t9O9JSmU4G7JZBWcuieNPk0iGoyEQzYtOMo+Yd/N4sHOxZXKMXpxoBgi2zJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc23Km6A; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc23Km6A"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78d57b9f3caso214745885a.3
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712660475; x=1713265275; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qhIXUFB2UBBfhPDcH0Y+NqtPepwcmxDL3b6KHL5uc8=;
        b=Wc23Km6AnSR85QF/AYyoBRC0ZmtXxHzbjtYOnRb2hD0bMEtE7wizoE+1+6I3oaWnLa
         225c216e0jfIoW2q9VNo9Y4yJoZ09zrUShWR+q0n8b/evk8WrXB6Tn2njM7nHt7Bysfh
         aEtaDty8PPO12fxg5qOHBNPC4GesX3+Aayu5i0nzmntl5SR6vl3GJuRs+7k+HxOLkky0
         BhbacepXZpFML6ReQ48R2+uRjKE8WNx0LTK8R0e766AHxewOEkBteC0G6OLnE54oqcwX
         JBpwbYUmKIxnm8gMsjbszujxFwvza7K8xdthNmAsBbhqInnbJn2olhCHT0IKWjTsXnDC
         1Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660475; x=1713265275;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qhIXUFB2UBBfhPDcH0Y+NqtPepwcmxDL3b6KHL5uc8=;
        b=eR/O/pNHbysuH5D/oEkXibQm2dtXHLE+qmp5MDpZ1xy0E7gVJU/8VM5M9XrGE2I0Z8
         wCVzGj4CWmF3JoOcXtpuhzKjgTmHl8dPT+Fp066/+w9keQDAsQo6N69OgTwihEtrSVqY
         9HMErpLkc9BZ8mNVDsBhUs3u6nufYCPs9f4C4Du4Ypiodlj5e8fBkxh2zEWAkpLJEdwg
         TjvKI6/TGUqSssGTqRgl/N0xHAZfbbYroXbH+ryd0kfNnm8cUH29s9WRY+0L5GltBCt9
         Ts635PYl8yV0BM7Rp4o9e8eIKnErnM7wD6FSdBY/1FJQlJmokRzIWChOCKwqwzcsfSKH
         drkA==
X-Gm-Message-State: AOJu0YyvAWwiK5SCHNQSqe6A0mR3RJs9YgVTIuHggczOy/OBAznFKue7
	E1cjZf5g+JYYduO22VEkxf5SjM5HDlEs1CvF5AYynN2Pzc0uRVU=
X-Google-Smtp-Source: AGHT+IHN/TezLmQsS+4XSdd8UrIlyJIxClxYZWm42oGQaA0H363ngpz1t6dpI5Oh8rlHoPUwC7U4Zg==
X-Received: by 2002:a05:620a:2489:b0:78d:61fe:77c2 with SMTP id i9-20020a05620a248900b0078d61fe77c2mr8117467qkn.31.1712660474832;
        Tue, 09 Apr 2024 04:01:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.21])
        by smtp.gmail.com with ESMTPSA id qp12-20020a05620a388c00b0078d704f9867sm382756qkn.71.2024.04.09.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:01:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240409100934.37725-1-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Implement reset reason mechanism to
 detect
Message-ID: <7e3a4d1d-bdca-266a-7752-af7a3daccf9b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 11:01:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/861412=
9316

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a1b3417a8588
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842746


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
