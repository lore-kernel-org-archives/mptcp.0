Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797F36EAAA
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281814; cv=none; b=f9tuci2Xyj/OnUs+k0gAiZu16n2+TGKEa10e/Qm0gZc1EP3Ju/qdYTSAxaRfbhmpCfVZRtkJxpUIZU81s1g3MASIw6iCVojcaPotvTYG33AC/n/3vcu9Zeq8BrOv+h0iCOcoy9Q5b1cUzgowMJIMCYxP4agKdh71NkKQcy4quqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281814; c=relaxed/simple;
	bh=mvCmx6kNGOQ6wq8/ygFiSxDJIFbHNlNyAnurIF5K/As=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ug3ZNoG+C6U3u/DccR+uOL89rxaK/lHyMCC2DbJR03L1W2a9ZA9aRKuX3u3RBaUXCaCBt8vvh8tNlSrAWBY8Fiy1e4mGz09Qu6rwuE6s1VUs7xWVAfP3fjjd4kIYbdoPt6l6aEoXVBogUzwTKnqDN5oZ6FSRJBl9577oDN96exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEdOmA1p; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEdOmA1p"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124a1b4dd40so1776471c88.0
        for <mptcp@lists.linux.dev>; Thu, 05 Feb 2026 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281814; x=1770886614; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obIp/qTn1UPD5/xJfiEqJmlqRwpgNcqfRlh69E6Chfc=;
        b=OEdOmA1pN1PJ7aB+2XxwUlqc3EbSSTkH3pMp0mnkOcueYDD1fneaGBUSb4N38mSuKq
         A2GA01DYepQgneplKHCudVS05hnfqX4yHEPxacfE7rNMRMMhZY8xuzTtAwngTv3Kd58Z
         SsFjXHED5ZH9bxEZViJHTVhOZrB8JA85A5lcptf7IUCN1sR79lokWlg72Q/jOEA16C+y
         zpSl0T7Lb9Ox9ZLRqwKhHrBQiia0wAGd0hpLJTR1cMMbbv8teaEI2R2D6vApVlqyj++b
         8axvzDjTwZgXT8CjSgGYvEq+0VL2kXcD/P4FmQ1oMpyBu/2WmCH/4L4uWmuDo9V4jbfF
         c+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281814; x=1770886614;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obIp/qTn1UPD5/xJfiEqJmlqRwpgNcqfRlh69E6Chfc=;
        b=mP+ar80MnOM3cKoH+kXBmiXqARKmD5C30yCo+ZB+BDfo7sszFFno+pB5ijmmLby33V
         /7w3aAety+MtNX3cw58UV8WZkiBLbinWju26UZIU0ezsh8H97V1eomqIq6hWKxKxEeYJ
         THqxMDFlTMX4BOcFbgC5wPROzUVT1Q3P0TNhdESlXSz4cZRnOVy7YCXhTFmCDwtUpI1Z
         K7PUOl2G6HVvnt1KLXAGsGW+NRpkxC0isHjQ5uMd4EmlHhNrlOkE76lAAUqK1JaYl3c1
         y65fxVGU47+Tx7BPWmJgBK62yHniJ8+KwpmxEe+YN39Zjb/e6aJDdjGd6KsgsXS1omeo
         YWbg==
X-Gm-Message-State: AOJu0YzjZebxgZpvi3gW5zTak1PXJ/f6Amsw9zD77pMwrNpBRmaYXVVX
	AISdQ/z07LAzQoVfLl2Qt7v1LnQTC1L7Hj7Jo8wTLEJoeud3YJfvDAmiUgeKqUc=
X-Gm-Gg: AZuq6aJ0FwSgTUsJmIo6g4Rgp5JTplV2yYwiMyw0c4/nGy60d6/1WrnK/nsvnd32W+C
	Z+5TQvK4ja8LQ9+4mZeVJy+tYMKfV7nu1CbdFe9df61IRtnzROY0w10M73+WVwpDJwNXJR6yYBe
	vW4fi8k/7JtDiaeW/s73RmHLWuRZTQw8c5SsU4XyDdx1VtKCBpCuAaqc5L1yFeXONjOcPUtyvr1
	oNUVR1vcM9em9oLvff4FNUX7a0YRvz/9Fhr2OeQdjL3TP6uSztvnCYyFh8szDnLVP1Bb1mfwhIY
	o7w07wBksErcjbRt2OQJEQ47ty+ZF8VLW8qYifbJsgkMCswEPZQmdbTmkCVosZ3mlw+VJyT5e6u
	BvE/aAYR+veUnMs9Eq3yl1o8HTcMB+0xixcFzMFSz6WjkWmu5XJbW8ytYLd+3mp1ffJZDyy8ST1
	RTmkIfLJXc2BFFOUCahzeJKLMc60SH3i/yh3Bk
X-Received: by 2002:a05:7022:4383:b0:123:2d62:2e8d with SMTP id a92af1059eb24-126f4771587mr2744119c88.3.1770281813402;
        Thu, 05 Feb 2026 00:56:53 -0800 (PST)
Received: from [127.0.0.1] ([172.184.209.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e0f98asm4141731c88.5.2026.02.05.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:56:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f044ee2401fe23dbb0d917765ca07c1d8f601758.1770277185.git.tanggeliang@kylinos.cn>
References:
 <f044ee2401fe23dbb0d917765ca07c1d8f601758.1770277185.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_allow_overridden_write=5Fspa?=
 =?UTF-8?Q?ce_to_be_invoked=22?=
Message-ID: <358e64cc-c91a-ec18-7c84-6847cc7c8d53@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Feb 2026 08:56:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Critical: Call Traces at boot time =E2=9D=8C
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/217035=
67755

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e10213599f34
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1051035


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
